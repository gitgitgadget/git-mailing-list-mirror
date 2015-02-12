From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Keep original author with git merge --squash?
Date: Thu, 12 Feb 2015 15:32:37 -0800
Message-ID: <xmqqwq3mogdm.fsf@gitster.dls.corp.google.com>
References: <CAN7QDoKQAZKUt_MHWjgt1k3PvXQv6XTcjdijh8KRodO3=VD47A@mail.gmail.com>
	<20150212092824.GA19626@peff.net>
	<xmqqpp9erihg.fsf@gitster.dls.corp.google.com>
	<CAN7QDoLKFBCJpFa+QL8dPQtwyAyDNt-ck_sNJ3fS+vTrK_Lg9w@mail.gmail.com>
	<xmqq8ug2rfi2.fsf@gitster.dls.corp.google.com>
	<CAN7QDoJ+hOFqoc54sAbLeSxvj8TQKQRSVKbNQXZYfPv1uOy=WA@mail.gmail.com>
	<xmqq4mqqrc70.fsf@gitster.dls.corp.google.com>
	<20150212225003.GA20763@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 13 00:32:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM3FV-00055m-1a
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 00:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbbBLXck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 18:32:40 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54580 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751325AbbBLXck (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 18:32:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B2393857D;
	Thu, 12 Feb 2015 18:32:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A94WTUPp8REw1iliy5/vQM33JUs=; b=ajViwY
	5RmNfiaMtNu01c6UbAk3Xlxf8ZjvUMlo4gzk+gtxP0ue7kP8sntFgZw3oYcnva1x
	LTSVb2KIHapxAvqxdYn/B9wXGAyl90EvN1b9QIVQzYh1X/+1JheDxHA1izzB0lqc
	VuFw3D/wTzMN6UknPOF2ElNrGRPRkJ0/sfYLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NHTFZyxEwkBly+IqudvW+yjhWwwlt1cN
	IW6RCtG7IT7ZW2SNkDympNCokamXBG+fC5Tv8ekGBjdJgcc7O4lQqjsG1wBO79+q
	07pB1yqL5OMJYUJcYtMXWmZ4jBUTrzjwzE8HSBxRuoy+Eh7Gf72ATCtOyQ8SjaT8
	0fYRWhkU2E8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91F3B3857B;
	Thu, 12 Feb 2015 18:32:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0EB663857A;
	Thu, 12 Feb 2015 18:32:38 -0500 (EST)
In-Reply-To: <20150212225003.GA20763@peff.net> (Jeff King's message of "Thu,
	12 Feb 2015 17:50:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6EAD7476-B30F-11E4-931D-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263788>

Jeff King <peff@peff.net> writes:

> What happens if there is no "Author:" line in the output?

I've been assuming that we would do what the current code does.
"git commit --amend" for example internally remembers who the
original author was and uses that, without paying any attention to
the result from the editor.  If there is no "Author:", that would
not change.

And I do not think we need to be able to say "Oops, I forgot to pass
the --reset-author option from the command line", personally, so...

> So probably a saner thing is that a missing "Author:" line does nothing,

yes and

> and using "Author: " (with no text) does a reset.

no (I do not think it is wrong per-se, but I do not think such a
good idea).

> Also, on the topic of "merge --squash". I never use it myself, but
> having experimented with it due to this thread, I found the template it
> sticks into COMMIT_EDITMSG to be horribly unfriendly for munging. For
> example, with two simple commits, I get:
>
>     Squashed commit of the following:
>     
>     commit 6821a8ac920ed00675e4aec10dcef705211105cd
>     Author: Jeff King <peff@peff.net>
>     Date:   Thu Feb 12 17:39:28 2015 -0500
>     
>         commit subject 2
>     
>         commit body 2
>     
>     commit b0840bb4bbfe00b6ed8c7c4d483f11d126fa2d69
>     Author: Jeff King <peff@peff.net>
>     Date:   Thu Feb 12 17:39:28 2015 -0500
>     
>         commit subject 1
>     
>         commit body 1
>
> I guess that is helpful if you want to keep a complete log of what got
> squashed, but I doubt that is the common case (if you did, then doing a
> real merge would probably be in order).

I think it should show exactly the same thing as "rebase -i" squash
insn would give you.  People already know how to munge that, right?

> It also raises a question for the proposal in this thread: if there are
> multiple "Author:" lines, which one do we take? The first, or the last?

I was siding with David's "pay attention to in-buffer Author: only
when all of them agree".  When squash-merging a branch with two or
more authors, we would attribute the authorship silently and
automatically to you if you do not do anything special otherwise.

Possible alternatives when multiple "Author:"s do not agree are:

 - use you who is playing the integrator;

 - use the tip;

 - use the one that most often appears; or

 - error out and ask the user to leave only one (or zero--if you
   want to take the authorship) by re-attempting "git commit".
