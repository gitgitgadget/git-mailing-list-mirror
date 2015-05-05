From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: remove credential helpers from porcelain commands
Date: Tue, 05 May 2015 14:36:44 -0700
Message-ID: <xmqqzj5id7v7.fsf@gitster.dls.corp.google.com>
References: <1430831972-6788-1-git-send-email-szeder@ira.uka.de>
	<20150505200607.GB12067@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 05 23:37:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpkWc-0005ZO-Gu
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 23:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992594AbbEEVgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 17:36:49 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59010 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S2992584AbbEEVgr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 17:36:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BE404D1CD;
	Tue,  5 May 2015 17:36:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xZM7Oj1YsoiQpP173dOjPPXC1Kk=; b=OlySpL
	Rd0Ein6GG4QBF9sc4iQ0eGYAdzOTrEF8hKHshHc5JpSRS+HGxthooj4w/RLYjCKn
	R7wYiboB7w2w2zi5rUiV9fGoT+xWAcrqEkrwoo3udeHzgpnVOltZiqGZdyqjcjHt
	3hT+HDBra42nHL0unb/XWapUcVSBcUs5jj0ns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ws8LfJAIoUpB2yO/bOPDBHPTM+FZERoy
	O9BuRc8IVeWf7vMiB+pwmPljJQ6rXeecfuGvFQ2DUfjnPiB6izRTwuESw5Vz/2b4
	8JCADHb0Kc6mrs0f+DoBfDU9gLumVUZGLyW1hJt9woK7l2xibY0t6Gv9W1xmSmmG
	fyW7IUBEKD0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 643044D1CB;
	Tue,  5 May 2015 17:36:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D0C764D1C7;
	Tue,  5 May 2015 17:36:45 -0400 (EDT)
In-Reply-To: <20150505200607.GB12067@peff.net> (Jeff King's message of "Tue, 5
	May 2015 16:06:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D41E78A6-F36E-11E4-AC28-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268425>

Jeff King <peff@peff.net> writes:

>> However, if you think filtering out 'credential-*' is the way to go, I'm
>> happy to reroll.
>
> I'd actually be fine with just marking all credential-* as "credentials
> helper". I think we have staked out the "git-credential-foo" namespace,
> so anybody putting something unrelated in there deserves what they get.
> And it makes one fewer list to keep up to date.
>
> I _do_ have other git-credential-foo's that should be ignored (and are
> not in your list), but I am probably the only person in the world (they
> are due to me experimenting with the credential helper code :) ).

Let's do this on top of the "typofix helper" one, as there was
another show-stopper typo.  I could also amend the log message
and declare that we now squat on git-credential-<anything>, but
I do not think it is necessary.

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fdf0ddc..af78212 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -665,13 +665,8 @@ __git_list_porcelain_commands ()
 		checkout-index)   : plumbing;;
 		commit-tree)      : plumbing;;
 		count-objects)    : infrequent;;
-		credential        : credentials;;
-		credential-cache) : credentials helper;;
-		credential-gnome-keyring) : credentials helper;;
-		credential-netrc) : credentials helper;;
-		credential-osxkeychain) : credentials helper;;
-		credential-store) : credentials helper;;
-		credential-wincred) : credentials helper;;
+		credential)       : credentials;;
+		credential-*)     : credentials helper;;
 		cvsexportcommit)  : export;;
 		cvsimport)        : import;;
 		cvsserver)        : daemon;;
