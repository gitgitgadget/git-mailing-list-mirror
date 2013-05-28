From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/5] rebase: improve the keep-empty
Date: Tue, 28 May 2013 08:33:22 -0500
Message-ID: <CAMP44s2KX+Rsd+WL-=PUeF4jt9J2sp1QbkyaTL0VU+8aggaWYw@mail.gmail.com>
References: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 15:33:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhK1o-0001Fu-WD
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 15:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934144Ab3E1NdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 09:33:24 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:45537 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934122Ab3E1NdY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 09:33:24 -0400
Received: by mail-la0-f48.google.com with SMTP id fs12so7330120lab.7
        for <git@vger.kernel.org>; Tue, 28 May 2013 06:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vJg6f384oao1Yh3XAfXJeB9beiU4PKNL6h9cqS9voKc=;
        b=X9JGtZyKOuwdF5CrMAUGnYWJ4XNZpIP/+Vb1csaGcrDyKaohDd4vPu9xG0DwOMncKu
         e3r/8pl0I6sEtcsLhVUQzW2zAqbTVrFQCIIKtjSy+yIm7sSdzzTxNvu1e8wRTLP+emJr
         JakEjtXhgBkhUbhqL0mlkKHsl/zThS5EMI0tv6E767bJJT+9yXuP1XviTky2/Lu+zpZM
         bFGJspzXonsq9q2htvJR/rvjxMOPZO4K1O7JNOasqFaQlY7326R1WB5RAyg+Jbcm8UVl
         +uV4oswbyR/hBlPglWtFMd+OkpcJAogKUzmJCPSjfTTLvbPjZqoZkiSv7Iea8L4waEyu
         f53w==
X-Received: by 10.112.167.72 with SMTP id zm8mr16500559lbb.11.1369748002624;
 Tue, 28 May 2013 06:33:22 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Tue, 28 May 2013 06:33:22 -0700 (PDT)
In-Reply-To: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225652>

On Tue, May 28, 2013 at 8:29 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Hi,
>
> I've been analyzing 'git rebase' and found that the --keep-empty option
> triggers a very very different behavior. Here's a bunch of patches that make it
> behave like the 'am' does does for the most part.
>
> There's only a few minor changes, after which it might be possible to replace
> the whole 'am' mode to use cherr-pick instead.
>
> Felipe Contreras (5):
>   rebase: split the cherry-pick stuff
>   rebase: fix 'cherry' mode storage
>   rebase: fix sequence continuation
>   rebase: fix abort of cherry mode
>   rebase: fix cherry-pick invocations

To see the issue, simply enable keep_mode by default, and run the tests:

    Test Summary Report
    -------------------
    ./t3401-rebase-partial.sh                          (Wstat: 256
Tests: 7 Failed: 4)
      Failed tests:  3, 5-7
      Non-zero exit status: 1
    ./t3403-rebase-skip.sh                             (Wstat: 256
Tests: 10 Failed: 3)
      Failed tests:  4-5, 9
      Non-zero exit status: 1
    ./t3406-rebase-message.sh                          (Wstat: 256
Tests: 6 Failed: 3)
      Failed tests:  3-5
      Non-zero exit status: 1
    ./t3400-rebase.sh                                  (Wstat: 256
Tests: 27 Failed: 10)
      Failed tests:  13-17, 22-25, 27
      Non-zero exit status: 1
    ./t3407-rebase-abort.sh                            (Wstat: 256
Tests: 11 Failed: 5)
      Failed tests:  2-6
      Non-zero exit status: 1
    ./t3412-rebase-root.sh                             (Wstat: 256
Tests: 31 Failed: 17)
      Failed tests:  4, 6-8, 10-12, 14-17, 23, 25-26, 28-29
                    31
      Non-zero exit status: 1
    ./t3417-rebase-whitespace-fix.sh                   (Wstat: 256
Tests: 4 Failed: 4)
      Failed tests:  1-4
      Non-zero exit status: 1
    ./t3419-rebase-patch-id.sh                         (Wstat: 256
Tests: 9 Failed: 1)
      Failed test:  4
      Non-zero exit status: 1
    ./t3418-rebase-continue.sh                         (Wstat: 256
Tests: 6 Failed: 2)
      Failed tests:  3, 5
      Non-zero exit status: 1
    ./t5407-post-rewrite-hook.sh                       (Wstat: 256
Tests: 13 Failed: 4)
      Failed tests:  4-6, 8
      Non-zero exit status: 1
    ./t5520-pull.sh                                    (Wstat: 256
Tests: 21 Failed: 8)
      Failed tests:  12-15, 18-21
      Non-zero exit status: 1
    ./t7512-status-help.sh                             (Wstat: 256
Tests: 35 Failed: 3)
      Failed tests:  5-6, 28
      Non-zero exit status: 1
    ./t9106-git-svn-commit-diff-clobber.sh             (Wstat: 256
Tests: 10 Failed: 3)
      Failed tests:  6, 9-10
      Non-zero exit status: 1
    ./t3404-rebase-interactive.sh                      (Wstat: 256
Tests: 71 Failed: 2)
      Failed tests:  50, 69
      Non-zero exit status: 1
    ./t9137-git-svn-dcommit-clobber-series.sh          (Wstat: 256
Tests: 5 Failed: 1)
      Failed test:  4
      Non-zero exit status: 1
    ./t9140-git-svn-reset.sh                           (Wstat: 256
Tests: 6 Failed: 1)
      Failed test:  6
      Non-zero exit status: 1
    ./t9903-bash-prompt.sh                             (Wstat: 256
Tests: 51 Failed: 20)
      Failed tests:  27-34, 36-39, 41-42, 45-49, 51
      Non-zero exit status: 1
    ./t9164-git-svn-dcommit-concurrent.sh              (Wstat: 256
Tests: 8 Failed: 4)
      Failed tests:  4-6, 8
      Non-zero exit status: 1
    Files=629, Tests=10036, 308 wallclock secs ( 7.60 usr  1.39 sys +
556.35 cusr 382.46 csys = 947.80 CPU)
    Result: FAIL

-- 
Felipe Contreras
