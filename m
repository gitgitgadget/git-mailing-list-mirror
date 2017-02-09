Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D972C1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 22:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752579AbdBIWYB (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 17:24:01 -0500
Received: from mout.gmx.net ([212.227.17.21]:58492 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751108AbdBIWXy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 17:23:54 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPD8G-1cXZP23Kee-004W4d; Thu, 09
 Feb 2017 23:23:00 +0100
Date:   Thu, 9 Feb 2017 23:22:59 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] Let the sequencer handle the grunt work of rebase
 -i
In-Reply-To: <cover.1472805251.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1486678952.git.johannes.schindelin@gmx.de>
References: <cover.1472805251.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dEle6Kh8mJCXA5Lpn3c4JVK60ILhi9wixg2vFD07LnIzu9xxfLQ
 Hqv5yv6mk8K9C1+NhWR9viMGMPFZfLNJIvVplN5+EmRJ18NegAvWQyMTMznOjsmW9ugTiYA
 yUdHAyvDqAh5Uw8KJ2+W0m7af3wm85rK9JFBSPFe14LDY3ADDlnG2okgaffy6aTQwSIHK+Y
 ir1ZflW/dK8U2GyT59NxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j6nAPpGRieo=:0lmb6l1441k7ivmrcBYgog
 nOcFH6p/ixmY928EcOK/5dgzzTIoyZxMlUhgKyw4bNuj5a53mzkDfCzG9kSK0Fd0CVnM+4EME
 NTRpjIPv8B+/yP0QiI6fRszWGH3bvwM1Yzlbb9hmEyJomqrjudaiNVnfEolM5Bib9CVjH8HS+
 l/vsIfmX9VJE6yMyG3tC72VmsQ8wncLM8AI1tm5Bg6UKujCXN7AIZFGbPWkMYMfCDDdRTokgg
 yc+/sXNoU99IQpsPc/GhBsuEb00NcNuSixtytmLwRiqLrs25KyGXL9JHp8roLepvGGza8+LOi
 VniaLipgJ00i4rbNOyPeWANeO3QHj++xlkobr7eZXh7KsYQ4qEopTDeFm8sFp/0pgmkNtToAN
 zPZxUkhYcf5rXDEEc1Ef38jkf9sgdC/N0V1dHkCTwopCVXaEK+LAECAXG2s3P1YDZkNaHPkM8
 HekCcnn0Ul8sIg40NdTSGXKGZwtPvK2ouraQEBGMJ3VDxyeJ3LXAO/l+Va4szyI9zBrGM65W6
 3ZNI9SkG4OymgM/SjnIUO6Z9GPj7uJgkFYVe2Pn1Ia6eGMsvhKVFWLSZiWjQ+Tj2FAN/nIM0W
 nehZzDBo7fgH3QykgNUFVtVXpb0Q+CxqPrawYry2e9ZH4FoTHwxJkqPGE3sKpv7hxj6ilo5bI
 nHxXAKZpqWxHZoeID80VqeYpYZ86Lfq/0dSeSjvjCcZemEbY84sbWhKJAa564J7eLARlvdOrN
 92aVzNQpmGfdDvZGaxSe+n+RJcPNYJxbAj4KCMuRFYBfRGmzWKrAn7l7YKgxtPW3x8pPgEsfY
 JINjoWP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After all of these patch series y'all had to review, this is finally the
one that switches things over.

Please note that it does not (yet) handle the `git rebase -i --root`
invocation; I tried to focus on the common case, and I rarely use --root
myself.

Please note also that --preserve-merges is *not* handled.

The way I designed --preserve-merges is totally stupid and idiotic and I
do not want to spend any further time on it. You cannot "pick" merges
and hope to be able to reorder commits, for example. I may work on
porting Git garden shears' way to recreate the branch structure into
rebase -i proper at some stage.

And please finally note that this pair of patches does not yet yield the
full speed improvement that I promised earlier. After these patches, the
time is dominated by pre- and post-processing the todo script, at least
on Windows, so there is another patch series that ports those bits and
pieces into the rebase--helper, too.

Changes since v1:

- rebased to current master

- this required a change in t3404 because I was bullied^Wasked to change
  some messages (which should not have been conflated with the work I
  actually wanted to do, but whatevs)


Johannes Schindelin (2):
  Add a builtin helper for interactive rebases
  rebase -i: use the rebase--helper builtin

 .gitignore                    |  1 +
 Makefile                      |  1 +
 builtin.h                     |  1 +
 builtin/rebase--helper.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 git-rebase--interactive.sh    | 13 +++++++++++++
 git.c                         |  1 +
 t/t3404-rebase-interactive.sh |  2 +-
 7 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 builtin/rebase--helper.c


base-commit: 6e3a7b3398559305c7a239a42e447c21a8f39ff8
Based-On: sequencer-i at https://github.com/dscho/git
Fetch-Base-Via: git fetch https://github.com/dscho/git sequencer-i
Published-As: https://github.com/dscho/git/releases/tag/rebase--helper-v2
Fetch-It-Via: git fetch https://github.com/dscho/git rebase--helper-v2

Interdiff vs v1:

 diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
 index e2f18d11f6..33d392ba11 100755
 --- a/t/t3404-rebase-interactive.sh
 +++ b/t/t3404-rebase-interactive.sh
 @@ -556,7 +556,7 @@ test_expect_success 'clean error after failed "exec"' '
  	echo "edited again" > file7 &&
  	git add file7 &&
  	test_must_fail git rebase --continue 2>error &&
 -	test_i18ngrep "You have staged changes in your working tree." error
 +	test_i18ngrep "you have staged changes in your working tree" error
  '
  
  test_expect_success 'rebase a detached HEAD' '

-- 
2.11.1.windows.1

