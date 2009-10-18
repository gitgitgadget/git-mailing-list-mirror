From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Generalized "string function" syntax
Date: Sun, 18 Oct 2009 15:47:27 -0700
Message-ID: <7vr5t0nwu8.fsf@alter.siamese.dyndns.org>
References: <1255681702-5215-1-git-send-email-gitster@pobox.com>
 <4ADA3153.7070606@lsrfire.ath.cx> <7v63ad5o8p.fsf@alter.siamese.dyndns.org>
 <4ADAD0D2.504@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Oct 19 00:47:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzeXW-0007tZ-Rm
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 00:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755347AbZJRWra convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Oct 2009 18:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754259AbZJRWra
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 18:47:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53183 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbZJRWr3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Oct 2009 18:47:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 494EA5E9E3;
	Sun, 18 Oct 2009 18:47:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=snUTxHGZZIfWBbDwICjc6HuaV
	tk=; b=j8bG0yRPPUiPZIs6Z+j1Dpz7Pn+03gkdzMycqYTfI/UaJWOfRuyo9CBQ9
	zt0rKM8Z54CDEhBQ3b+PmEhCHN86OeLr+R1LxC3cZcAL/86N1B5BLBmhh/tiCRiq
	CFzJbtEnATcPJH3FyhU9rY3pYy0SW0RuLVDZzVmMWOPZQa/GoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=F4wCqKXucY7q76cgmxg
	UbOFAyzpEGHI+bTF8egODWnHNkuHoePW0kc8DSTI7FEywI1R2dzLkIBJQpzuP9Tx
	l4K/VbLoSLqkv/+EgQ9QxQ9VrlHBJL9jR+U2QAySR2aSV7QqVEbuxcHrsBg+MiDQ
	e5J7mPagtNI4lxkGqueMUScU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 285795E9E2;
	Sun, 18 Oct 2009 18:47:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82C365E9E1; Sun, 18 Oct
 2009 18:47:28 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 37FE0748-BC38-11DE-8095-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130614>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Which other text functions are we going to add which would break this
> model?  The only thing I can think of right now is nesting such
> functions themselves, e.g. when indenting a list in an indented
> sub-paragraph in an indented paragraph.  Useful?

I was more worried about painting ourselves now in a corner we cannot g=
et
out of easily later.  Even if my answer to question "what are we going =
to
add" may be "nothing I can think of right now", it does not make me hap=
py.

Something off the top of my head are combinations like these.

    %[toupper()%cD%] =3D> 'SUN, 18 OCT 2009 12:34:56 -0700'
    %[substr(7,3)%[toupper()%cD%]] =3D> 'OCT'

    %[sanitize()%s%] =3D=3D=3D %f (i.e. format-patch filename)
    %[sanitize()%[substr(0,7)%[toupper()%aN%]%]%s] (with upcased author=
 name)

By the way, I think that date formatting can be helped by introducing a
strftime() function that takes %ct/%at as input, e.g. %aD would become

    %[strftime(%a, %d %b %Y %H:%M:%S %z)%at]

and we do not have to worry about keep adding random %[ac]X formats and
running out of X.  Right now we use d/D/r/i and there were talks of add=
ing
a shortened 8601 format without time or something we did not implement.

Also, if we had this %[func() any string%] mechanism, we probably would=
n't
have had to add distinction between n/N and e/E after %a and %c.
