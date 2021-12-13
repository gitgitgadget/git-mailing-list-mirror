Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BB9C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 06:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhLMGb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 01:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhLMGb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 01:31:59 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308B3C06173F
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:31:59 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id k21so17344647ioh.4
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=thLAqml5CnKqYNYJf4GY+83kZ8R+VVqn4J8QAfv3qPI=;
        b=dCpFOQ2RiaIKST8iSOvvyl3YDl4cYHfBkz3EnQ5AOEk5sLPhAdiTS7ABd5uAVr6dZr
         MFU6Uo9NkYrrG/0hzckyLX0dzbf2wLhzN9mxj+mCnX55pTeZ7pNjMp1osWluv4TVNNiJ
         zeWyTHl33msUr5Ama8Q0vcUkiXL3LYTH9AVv1POPBXVBmcwY9Rl6R/u/hlaS+dpPRH06
         f1T5sYmr3dOOnzvbatRziul3/q1kO0mNdugTgFll+m5A8yGLljX+QiwZav6JDaVF9BIm
         y/ktJFuhTqzdcmF5YJffRpqKjnOz9GmppJPZdbJ18/IJ39oAFtpD1Gfckm5J+d1C9L1k
         LVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=thLAqml5CnKqYNYJf4GY+83kZ8R+VVqn4J8QAfv3qPI=;
        b=N9XcWkBaZMHC06wB+qhtTqwgTJJTqvjkWmM0pmhKY2whpqpd/6GBkip67d0sSTS9Sz
         5vcItLkRhJSNFphwru3iZUKlOViCiOqzFUSeZwb21ldHZ2VnU5zvjUOykPvdmMgqrYhh
         dkSUN1FC41vVA3IuBdKd81mfYfNjVq/e0cnQECeLM7daPfmaJVzVCTpHYpnlFkPiSwjb
         7VgRb5HnQgE2JfH8dMrpwRS/i1HuFgq0tNJSqKYgsNOIMHuvqYK2cYpIOAeYmWJ1RdtT
         4ykn/UO7wXTtuPz3ZTH7ZybgU6XC9e58m4FFblEtBRFMP0uWswg1epWQHSno6G5Yo/C3
         v3sA==
X-Gm-Message-State: AOAM530PDZXa46LgqHPYKM3Zt31XArBovnnrctkOIISBfpdsWNLt3Atz
        XkOOFiEKk0W8oNPlEHNn7F9y7ZTvy9Tl/g==
X-Google-Smtp-Source: ABdhPJwWqNSbIDIQTIoPAMfWcSNVYXtsdkZk0wAS04mJ2VJxpHS/6v40VFhfG1cE5euw59watKbhfw==
X-Received: by 2002:a05:6638:130f:: with SMTP id r15mr31513359jad.19.1639377118180;
        Sun, 12 Dec 2021 22:31:58 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id f10sm7305408ils.13.2021.12.12.22.31.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 22:31:57 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 00/15] generalize chainlint self-tests
Date:   Mon, 13 Dec 2021 01:30:44 -0500
Message-Id: <20211213063059.19424-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.397.gfae76fe5da
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A while back, Peff successfully nerd-sniped[1] me into tackling a
long-brewing idea I had about (possibly) improving `chainlint`
performance by linting all tests in all scripts with a single command
invocation instead of running `sed` 25300+ times (once for each test).
A description of some of the important features of the new linter can be
found at [2].

Although the new chainlint implementation has been complete for several
months, I'm still working out how to organize its patch series. In the
meantime, _this_ patch series makes it possible for the new linter to
re-use the existing chainlint self-tests. It does so by cleansing the
self-test ".test" and ".expect" files of implementation details and
limitations specific to chainlint.sed.

I'm sending this series separate from the (upcoming) patch series which
actually introduces the new chainlint because it would be too burdensome
on reviewers as a single series which, combined, would likely contain
30-35 patches; this preparatory series is already long enough at 15
patches. Although this series arose from the same work which begat
'es/test-chain-lint'[2], it is independent of that series.

This series merges cleanly with 'next' but has a conflict in t/Makefile
from 'ab/make-dependency' in 'seen'. The resolution involves replacing
`'$(CHAINLINTTMP_SQ)'` with `$(call shellquote,$(CHAINLINTTMP))`. The
resolved code should look like this:

--- >8 ---
clean-chainlint:
	$(RM) -r $(call shellquote,$(CHAINLINTTMP))

check-chainlint:
	@mkdir -p $(call shellquote,$(CHAINLINTTMP)) && \
	sed -e '/^# LINT: /d' $(patsubst %,chainlint/%.test,$(CHAINLINTTESTS)) >$(call shellquote,$(CHAINLINTTMP))/tests && \
	sed -e '/^[ 	]*$$/d' $(patsubst %,chainlint/%.expect,$(CHAINLINTTESTS)) >$(call shellquote,$(CHAINLINTTMP))/expect && \
	$(CHAINLINT) $(call shellquote,$(CHAINLINTTMP))/tests | grep -v '^[	]*$$' >$(call shellquote,$(CHAINLINTTMP))/actual && \
	diff -u $(call shellquote,$(CHAINLINTTMP))/expect $(call shellquote,$(CHAINLINTTMP))/actual
--- >8 ---

[1]: https://lore.kernel.org/git/YJzGcZpZ+E9R0gYd@coredump.intra.peff.net/
[2]: https://lore.kernel.org/git/20211209051115.52629-1-sunshine@sunshineco.com/

Eric Sunshine (15):
  t/chainlint/*.test: don't use invalid shell syntax
  t/chainlint/*.test: fix invalid test cases due to mixing quote types
  t/chainlint/*.test: generalize self-test commentary
  t/chainlint/one-liner: avoid overly intimate chainlint.sed knowledge
  t/Makefile: optimize chainlint self-test
  chainlint.sed: improve ?!AMP?! placement accuracy
  chainlint.sed: improve ?!SEMI?! placement accuracy
  chainlint.sed: tolerate harmless ";" at end of last line in block
  chainlint.sed: drop unnecessary distinction between ?!AMP?! and
    ?!SEMI?!
  chainlint.sed: drop subshell-closing ">" annotation
  chainlint.sed: make here-doc "<<-" operator recognition more
    POSIX-like
  chainlint.sed: don't mistake `<< word` in string as here-doc operator
  chainlint.sed: stop throwing away here-doc tags
  chainlint.sed: swallow comments consistently
  chainlint.sed: stop splitting "(..." into separate lines "(" and "..."

 t/Makefile                                    |  10 +-
 t/chainlint.sed                               | 124 +++++++++++-------
 t/chainlint/arithmetic-expansion.expect       |   6 +-
 t/chainlint/bash-array.expect                 |   4 +-
 t/chainlint/blank-line.expect                 |   2 +-
 t/chainlint/blank-line.test                   |   2 +-
 t/chainlint/block-comment.expect              |   6 +
 t/chainlint/block-comment.test                |   8 ++
 t/chainlint/block.expect                      |   4 +-
 t/chainlint/block.test                        |   3 +-
 t/chainlint/broken-chain.expect               |   4 +-
 t/chainlint/broken-chain.test                 |   2 +-
 t/chainlint/case-comment.expect               |   8 ++
 t/chainlint/case-comment.test                 |  11 ++
 t/chainlint/case.expect                       |  10 +-
 t/chainlint/case.test                         |   6 +-
 .../close-nested-and-parent-together.expect   |   5 +-
 t/chainlint/close-subshell.expect             |  16 +--
 t/chainlint/command-substitution.expect       |   6 +-
 t/chainlint/comment.expect                    |   2 +-
 t/chainlint/complex-if-in-cuddled-loop.expect |   5 +-
 t/chainlint/complex-if-in-cuddled-loop.test   |   2 +-
 t/chainlint/cuddled-if-then-else.expect       |   5 +-
 t/chainlint/cuddled-if-then-else.test         |   2 +-
 t/chainlint/cuddled-loop.expect               |   5 +-
 t/chainlint/cuddled-loop.test                 |   2 +-
 t/chainlint/cuddled.expect                    |  22 ++--
 t/chainlint/cuddled.test                      |   3 +-
 t/chainlint/exit-loop.expect                  |   6 +-
 t/chainlint/exit-subshell.expect              |   2 +-
 t/chainlint/for-loop.expect                   |   8 +-
 t/chainlint/for-loop.test                     |   8 +-
 t/chainlint/here-doc-close-subshell.expect    |   2 +-
 .../here-doc-multi-line-command-subst.expect  |   6 +-
 t/chainlint/here-doc-multi-line-string.expect |   4 +-
 t/chainlint/here-doc.expect                   |  10 +-
 t/chainlint/here-doc.test                     |   7 -
 t/chainlint/if-in-loop.expect                 |   8 +-
 t/chainlint/if-in-loop.test                   |   6 +-
 t/chainlint/if-then-else.expect               |  15 ++-
 t/chainlint/if-then-else.test                 |  17 +--
 t/chainlint/incomplete-line.expect            |   2 +-
 t/chainlint/inline-comment.expect             |   9 +-
 t/chainlint/loop-in-if.expect                 |   8 +-
 t/chainlint/loop-in-if.test                   |   6 +-
 ...ti-line-nested-command-substitution.expect |  10 +-
 t/chainlint/multi-line-string.expect          |  12 +-
 t/chainlint/multi-line-string.test            |  16 +--
 t/chainlint/negated-one-liner.expect          |   4 +-
 t/chainlint/nested-cuddled-subshell.expect    |  14 +-
 t/chainlint/nested-here-doc.expect            |   8 +-
 t/chainlint/nested-subshell-comment.expect    |   6 +-
 t/chainlint/nested-subshell-comment.test      |   2 +-
 t/chainlint/nested-subshell.expect            |   6 +-
 t/chainlint/nested-subshell.test              |   1 -
 t/chainlint/not-heredoc.expect                |  14 ++
 t/chainlint/not-heredoc.test                  |  16 +++
 t/chainlint/one-liner.expect                  |   6 +-
 t/chainlint/one-liner.test                    |   4 +-
 t/chainlint/p4-filespec.expect                |   2 +-
 t/chainlint/pipe.expect                       |   4 +-
 t/chainlint/pipe.test                         |   2 +-
 t/chainlint/semicolon.expect                  |  27 ++--
 t/chainlint/semicolon.test                    |   4 +-
 t/chainlint/subshell-here-doc.expect          |  15 +--
 t/chainlint/subshell-here-doc.test            |   8 +-
 t/chainlint/subshell-one-liner.expect         |  12 +-
 t/chainlint/t7900-subtree.expect              |  10 +-
 t/chainlint/t7900-subtree.test                |   4 +-
 t/chainlint/while-loop.expect                 |   8 +-
 t/chainlint/while-loop.test                   |   8 +-
 71 files changed, 339 insertions(+), 293 deletions(-)
 create mode 100644 t/chainlint/block-comment.expect
 create mode 100644 t/chainlint/block-comment.test
 create mode 100644 t/chainlint/case-comment.expect
 create mode 100644 t/chainlint/case-comment.test
 create mode 100644 t/chainlint/not-heredoc.expect
 create mode 100644 t/chainlint/not-heredoc.test

-- 
2.34.1.397.gfae76fe5da

