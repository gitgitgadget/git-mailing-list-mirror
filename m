From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/2] gitweb: change format_diff_line() to remove
 leading SP from $diff_class
Date: Mon, 17 Oct 2011 16:20:14 -0700
Message-ID: <7vehybjjdd.fsf@alter.siamese.dyndns.org>
References: <CAFo4x0LP4fXgSNAnss_WRLo-TH_qe=esYn7P+=iS6t87tdzcbw@mail.gmail.com>
 <m38voj72xy.fsf@localhost.localdomain>
 <7v62jnl3ef.fsf@alter.siamese.dyndns.org>
 <201110180007.31008.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 01:20:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFwTn-0007Gz-F1
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 01:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756689Ab1JQXUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 19:20:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40559 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754390Ab1JQXUR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 19:20:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD3F4521F;
	Mon, 17 Oct 2011 19:20:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6I9GvPOsWJqro2FpwYLKUwWhnXY=; b=JFsH/J
	e92yTDVq8cp4HTTuFTbvG39Yx5F6bjLJIQ+xgnAKgrKGD4GH/UxLWrOZT9SkdylT
	FuUJQdmJOGrcqeaL3IXD7pspebogxlQWNqqpjyjcPYG9Rs1pzKabwZeejArsYPHs
	1AK7l591E67bwjgfXz1f7rBGfsxkB9cQ1/vpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wWe/Sm5FzVBxppFKZJrsFQKnia+QCQHz
	T8UVvjigppEC1L85f5B/HUnq2aoCwA53Yaw5UQqHVNFz/o50dYjX63tTgM2sfoA4
	rjC0pM+cNHQ+0MqsBY9dmdNbbuPZZNHsBtvSTgV/u0dujNjNRiA9GCrHDfxRGbMf
	ijCRf1T8uJY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4779521E;
	Mon, 17 Oct 2011 19:20:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A768521D; Mon, 17 Oct 2011
 19:20:16 -0400 (EDT)
In-Reply-To: <201110180007.31008.jnareb@gmail.com> (Jakub Narebski's message
 of "Tue, 18 Oct 2011 00:07:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9283CE7E-F916-11E0-9CCC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183842>

Jakub Narebski <jnareb@gmail.com> writes:

> O.K.
>
>>                 [" {$num_sign}", ""],
>
> O.K.
>
>>                 ["[+ ]{$num_sign}", "add"],
>>                 ["[- ]{$num_sign}", "rem"],
>
> It would be slightly different to what current code does.

> Current code for combined diff uses "add" if there is at least one '+',
> "rem" if there are no '+' and at least one '-', and context otherwise.

The only possible difference would be for a line with all blank, but
because there is an additional explicit rule for context, the behaviour is
the same.  In a combined diff, you will never see + and - together on the
same line.

> I wonder if with sufficiently evil merge we can have a line that is
> added (changed) in some children, and removed in other, i.e. pluses
> and minuses combined.

The logic in combine-diff.c::dump_sline() was written in such a way to
avoid such a confusing output.

> Nb. we can put regexp here, not only stringification of regexp.
> i.e.
>
>                   [qr/[+ ]{$num_sign}/, "add"],
>                   [qr/[- ]{$num_sign}/, "rem"],

That would be a good change.

>> Also don't we want to use "context" or something for the css class for the
>> context lines, instead of assuming that we won't want to paint it in any
>> special color?
>
> Right.  We use "diff" class without anything else for context, but probably
> it would be better to state this explicitly.
