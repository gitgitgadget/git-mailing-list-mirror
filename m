From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 13/39] i18n: git-sh-setup.sh: mark strings for translation
Date: Wed, 01 Jun 2016 13:30:47 -0700
Message-ID: <xmqqd1o0y7m0.fsf@gitster.mtv.corp.google.com>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
	<1464799289-7639-14-git-send-email-vascomalmeida@sapo.pt>
	<xmqqvb1sydmu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Sunshine <sunshine@sunshineco.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Wed Jun 01 22:31:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8Cn7-0004k6-Cq
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 22:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbcFAUaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 16:30:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61659 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750742AbcFAUav (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 16:30:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 20100200FA;
	Wed,  1 Jun 2016 16:30:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1ToYgLDgHyo93VOs1njJEz6v/VU=; b=XWGm9y
	NXZy56sIUaWypndb323oLVAntjAZOXptk2ZzKssHaRyYih8HfbIiQcsodc9it+AY
	Kq9N3T9fNWTORaicFoBb622p17/buZY6y/TsnxxEXPPvvL7EfqoM5Qy0Bnb6jluu
	jcw+5wnw1yRsyzjZ1sn0PxN1JECkqEmDJTB4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d16+bOgPjosprBEuOAs/Of/eEGJQXS8b
	TybGfkqtNrXQpvMcS1I+Qixh0Cym7WzpFDsRAi3Rye9Ul9AxtPpv1p5kpaohFYwT
	bNPzVaZQVdHbo7emkfedO4c0bPNwRw4YGQ4qpEQ3V2oR9Mqy6gW50B0y+jQpwgbC
	8EVio3RXKc0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 16C2C200F9;
	Wed,  1 Jun 2016 16:30:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 91DCC200F6;
	Wed,  1 Jun 2016 16:30:49 -0400 (EDT)
In-Reply-To: <xmqqvb1sydmu.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 01 Jun 2016 11:20:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BA599384-2837-11E6-BBEA-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296158>

Junio C Hamano <gitster@pobox.com> writes:

> That is correct, but doesn't that hint that the current users of
> git-sh-i18n no longer have to (and they probably do not want to)
> dot-source it, as they are already dot-sourcing git-sh-setup?
>
> Otherwise they will waste cycles reading the same thing twice
> (assuming that git-sh-i18n is safely read twice, that is).

This part still stands.

If we assume that it is a good idea to i18n shell functions that are
supplied by git-sh-setup, it might be a better direction to retire
git-sh-i18n and include its text directly in git-sh-setup, so that
any scripted Porcelain has to open just one file to dot-source it,
instead of two.

>> Source "$(git --exec-path)"/git-sh-i18n instead of simply git-sh-i18n,
>
> That is somewhat strange.  "git-rebase.sh" dot-sources both
> git-sh-setup and git-sh-i18n with just ". $name".  What is so
> special about sh-setup dot-sourcing sh-i18n your patch adds?
>
>> because latter case would fail test t2300-cd-to-toplevel.sh.
>
> What is the real cause of this?
>
> ". git-sh-setup" is supposed to work because we prepend the
> $GIT_EXEC_PATH in "git" itself and git-sh-setup is installed there.
> ". git-sh-i18n" in "git-rebase.sh" works the same way.  If it is
> because is t2300 doing something strange, then we should fix that,
> not adding $(git --exec-path) on the dot-source line to paper things
> over.

This because what t2300 does is strange; I wouldn't call it "wrong"
per se, but it is borderline wrong.

Would it allow you to lose the $(git --exec-path) prefix in the new
dot-source to have this patch before applying your patch?

-- >8 --
Subject: t2300: run git-sh-setup in an environment that better mimics the real life

When we run scripted Porcelains, "git" potty has set up the $PATH by
prepending $GIT_EXEC_PATH, the path given by "git --exec-path=$there
$cmd", etc. already.  Because of this, scripted Porcelains can
dot-source shell script library like git-sh-setup with simple dot
without specifying any path.

t2300 however dot-sources git-sh-setup without adjusting $PATH like
the real "git" potty does.  This has not been a problem so far, but
once git-sh-setup wants to rely on the $PATH adjustment, just like
any scripted Porcelains already do, it would become one.  It cannot
for example dot-source another shell library without specifying the
full path to it by prefixing $(git --exec-path).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t2300-cd-to-toplevel.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t2300-cd-to-toplevel.sh b/t/t2300-cd-to-toplevel.sh
index 9965bc5..cccd7d9 100755
--- a/t/t2300-cd-to-toplevel.sh
+++ b/t/t2300-cd-to-toplevel.sh
@@ -8,7 +8,8 @@ test_cd_to_toplevel () {
 	test_expect_success $3 "$2" '
 		(
 			cd '"'$1'"' &&
-			. "$(git --exec-path)"/git-sh-setup &&
+			PATH="$(git --exec-path):$PATH" &&
+			. git-sh-setup &&
 			cd_to_toplevel &&
 			[ "$(pwd -P)" = "$TOPLEVEL" ]
 		)
