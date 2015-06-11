From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 1/2] t5520-pull: Simplify --rebase with dirty tree test
Date: Thu, 11 Jun 2015 21:20:04 +0800
Message-ID: <CACRoPnSnxT2_joEcgiimbiuo53sA_JobNGHj+ZJ_1+mjkaG8HQ@mail.gmail.com>
References: <1433282157-8171-1-git-send-email-me@ikke.info>
	<1433625145-29668-1-git-send-email-me@ikke.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Junio C. Hamano" <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Thu Jun 11 15:20:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z32Oy-0008NM-4P
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 15:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbbFKNUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 09:20:08 -0400
Received: from mail-la0-f67.google.com ([209.85.215.67]:36223 "EHLO
	mail-la0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbbFKNUG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 09:20:06 -0400
Received: by lams18 with SMTP id s18so1264656lam.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 06:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jRdZwvpCfmMGk1Js9ZySll8UiVtSaM5KDtBGHVSkmxg=;
        b=PENZPEYWsU12Q0N69BVeQDRfKkfg1RM9NV41RaSiMN0smZ4e6AWaXVcIkKa7hq+/3G
         USyBrhUitYpUCFVgfGnHpL4WEqdPwtCC+K0o83s22waPukK2mIBEj6eu+J2+4sT/Ymq1
         JYMbIOWzISk29+6ctuIdsl04kOUMsN5nX2yrS4OT1l7TUyhA3gKRxCzY9wiG9rS9IroL
         Jh/Zblj66DQZ6CcRogVK6/t1uYfirn7OuABNgTCY5UxThv1UxroHG1M32CNR//ipN80a
         EaA/HHPrhtkZM60OiPQMIjQA9xr1XBZ383e+KlL5enslnGz3gChMr3TQtYP+J/jKWSMK
         j1WA==
X-Received: by 10.112.27.238 with SMTP id w14mr10103170lbg.80.1434028804563;
 Thu, 11 Jun 2015 06:20:04 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 11 Jun 2015 06:20:04 -0700 (PDT)
In-Reply-To: <1433625145-29668-1-git-send-email-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271404>

On Sun, Jun 7, 2015 at 5:12 AM, Kevin Daudt <me@ikke.info> wrote:
> @@ -278,25 +291,6 @@ test_expect_success 'rebased upstream + fetch + pull --rebase' '
>
>  '
>
> -test_expect_success 'pull --rebase dies early with dirty working directory' '
> -
> -       git checkout to-rebase &&
> -       git update-ref refs/remotes/me/copy copy^ &&
> -       COPY=$(git rev-parse --verify me/copy) &&
> -       git rebase --onto $COPY copy &&
> -       test_config branch.to-rebase.remote me &&
> -       test_config branch.to-rebase.merge refs/heads/copy &&
> -       test_config branch.to-rebase.rebase true &&
> -       echo dirty >> file &&
> -       git add file &&
> -       test_must_fail git pull &&
> -       test $COPY = $(git rev-parse --verify me/copy) &&
> -       git checkout HEAD -- file &&
> -       git pull &&
> -       test $COPY != $(git rev-parse --verify me/copy)
> -
> -'

Eh whoops, I don't think we should touch this test. It comes from
f9189cf, which states that:

    When rebasing fails during "pull --rebase", you cannot just clean up
    the working directory and call "pull --rebase" again, since the
    remote branch was already fetched.

Which makes me believe that "die-ing early with dirty working
directory" has something to do with the rebased upstream handling
feature of git-pull, and so this test is correct in testing that, and
thus we should not touch it.

The location of the test in the other patch is fine though.

Thanks,
Paul
