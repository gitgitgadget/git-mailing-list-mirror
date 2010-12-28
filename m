From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry-pick / pre-commit hook?
Date: Tue, 28 Dec 2010 10:16:54 -0800
Message-ID: <7vy679wynd.fsf@alter.siamese.dyndns.org>
References: <m2wrnktcl2.wl%dave@boostpro.com>
 <20101208175324.GB5687@burratino> <m2oc8wt0xc.wl%dave@boostpro.com>
 <20101208220514.GA8865@burratino> <m2d3oo9cwr.wl%dave@boostpro.com>
 <20101227093729.GB1201@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 28 19:17:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXe6k-0007Jw-MS
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 19:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498Ab0L1SRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 13:17:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387Ab0L1SRH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 13:17:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5E6143CA6;
	Tue, 28 Dec 2010 13:17:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q0w1LUge8yZOJjW30quXJG/YWxc=; b=QRwpf4
	SKWbeRHtOUtihXUg34ffJ5HUTtVG9ThM7Ar9kO73l1juCVtIWAnKNP5HKJwV1Sih
	kjeitFW4g95kO4EbqElLoShIrwB8mfrW8YY0e9ePO842QQvwN6R3RZHzUqC7E/zJ
	rhS1h7ow5tkissTN12ym8bNTLhcCG91BQGDwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aTQ57fzUDgwaOHcCaebR2kceh9DTpOG8
	Wm/80zRAt7W2a/BCHG5gOO+H2WfpSSpAWcbzuQ5yaFaHmC83LR0Wz95MXNSy8h6W
	wCCZcOIlA2TKXfFLnvF9DLxG5g4M4cEt/DP2dmg+zNb4skQlBcXCdK9aB/c5Ne6T
	hWfmKdfv6JQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 12E093CA0;
	Tue, 28 Dec 2010 13:17:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B45F03C9B; Tue, 28 Dec 2010
 13:17:27 -0500 (EST)
In-Reply-To: <20101227093729.GB1201@burratino> (Jonathan Nieder's message of
 "Mon\, 27 Dec 2010 03\:37\:29 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BCB014B8-12AE-11E0-A990-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164284>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Dave Abrahams wrote:
>
>> if you're going to have a "pre-commit hook" concept,
>> but not run that hook for some kinds of commits, then that fact needs
>> to be documented.
>
> True, and thanks for a reminder.  Suggested wording?
>
> The current githooks(5) says
>
>  pre-commit
> 	This hook is invoked by git commit, and can be bypassed with
> 	--no-verify option.
>
> and leaves the question of whether it is invoked by git cherry-pick
> unanswered.

Yeah, but do we want to answer it in this section, or in git-cherry-pick's
manual page?

After all "pre-commit" was _not_ about "before doing anything that creates
a commit", but was about "before git-commit creates a commit".  Changing
that definition is fine as long as we have a good way to explain it to the
users and more importantly a simple rule that the users can understand,
and that rule _could_ be "anything that creates a new commit".

In reality "anything that creates a new commit" cannot be that simple
rule, however.  For example, "git pull" does attempt to create a new merge
commit, but failing it because the work done by the other person you are
pulling from does not conform _your_ standard defined by your hook is not
a sane default.

I think the basic direction could be (I haven't thought things through,
just a strawman):

 - Allow --verify/--no-verify to all commands that possibly create a new
   commit, and run pre-commit hook where an updated index is about to be
   made into a commit (for some commands this may not be very easy);

 - The guideline of picking the default would probably look like this:

   (1) for existing commands, keep the current behaviour;

   (2) for a new command, --verify should be the default if the command is
       primarily about letting the user do what s/he would/could/should
       have done as "git commit" in the first place (e.g. cherry-picking
       one's own commit from a separate branch or rebasing one's own
       unpublished branch on top of updated upstream), and --no-verify
       otherwise (i.e. taking other's work and using it in a context
       different from the original).
