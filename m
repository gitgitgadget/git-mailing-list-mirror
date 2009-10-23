From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] describe: when failing, tell the user about options that
 work
Date: Fri, 23 Oct 2009 11:57:44 -0700
Message-ID: <7vmy3iaqfr.fsf@alter.siamese.dyndns.org>
References: <76c5b8580910220810n389d065di349339ab38909ef7@mail.gmail.com>
 <f1e86b9095d63c6541d0a8df6a1cf8eadfe247bb.1256226187.git.trast@student.ethz.ch> <7vljj3dkid.fsf@alter.siamese.dyndns.org> <200910231034.09747.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eugene Sajine <euguess@gmail.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 23 20:58:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1PKs-00007q-DG
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 20:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbZJWS5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 14:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbZJWS5t
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 14:57:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbZJWS5s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 14:57:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C343F64046;
	Fri, 23 Oct 2009 14:57:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=LQh4Ze9uBlGLcf5K/62tg/JSjn0=; b=ncfCepCh0sgGRsfUkPtjjKa
	/MKMV4CxIPibKvbWP7BlSUjwDcgMVNTWJusM5EIBbONDXPNA51l+NiiXLjq1oDYW
	xpQ1+yLDSkRp5d3X7L+tpqVNInRvegqOx/UHKR1pcAkDqbBn3DmVG0SZI1Oy4tEP
	I0Pcjgnpy8d+wWfJVsH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=q8gKRJnrOfmQGBrLtLbDS8+xyvhkSIYOWvWMZvycOfqwdXhGR
	Jqe6Mi7sk8IaPJ7Q9bbOoFZz1vAye34mKH63NBQ1Hteev1t5V4YZrWbEc9hUMdi4
	6reOJ7m+9Ylr+zD0gWphHuUWDy6C90rEljZoa0WcGVmzNivPCGZ8CWSdxM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 89BA964043;
	Fri, 23 Oct 2009 14:57:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B08B764042; Fri, 23 Oct
 2009 14:57:45 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F5955862-C005-11DE-A3EF-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131117>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano wrote:
>> Thomas Rast <trast@student.ethz.ch> writes:
>> 
>> > @@ -259,7 +260,14 @@ static void describe(const char *arg, int last_one)
>> >  			printf("%s\n", find_unique_abbrev(sha1, abbrev));
>> >  			return;
>> >  		}
>> > -		die("cannot describe '%s'", sha1_to_hex(sha1));
>> > +		if (unannotated_cnt)
>> > +			die("cannot describe '%s'"
>> > +			    " with only\nannotated tags. Try --tags.",
>> 
>> Did you mean UNannotated tags here?
>
> No, but I think I see where the misunderstanding came from.
>
> This code path means that we did not find a tag to describe with, but
> we counted some unannotated tags (and because of how the counting
> logic is wrapped, this only triggers when neither --all nor --tags are
> in effect).

I think I read the code right ;-).

> So I wanted it to say "it is impossible to describe this with the tags
> you told me to use", which in this case are the annotated ones.

The way I read it was "it is impossible to describe it in the way you told
me to, when the tags you have are only unannotated kind."

> However, it could be written e.g.
>
>   No annotated tags can describe '%s'.  However, there were
>   unannotated tags: try --tags.

Sounds better.
