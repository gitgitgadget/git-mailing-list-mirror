Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253A5C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhLIFPn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhLIFPm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:15:42 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BD2C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:12:09 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id h16so4298550ila.4
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zopoo8wtt2GlTHBzO7My+muQe+fLW/XxA2p+cF3wUK0=;
        b=VKftf1GMSFvZQd8YilZV0CsELMgTkXrDlQtYLOAE8gqq9W535LUax4i7j7aMkhMHKT
         VQ4QAM1nG6g496VD3EXbjODuneegPedKhByM1mWXsBJ1h1CRXR1JSjIBWL0yi0BqhGRH
         3ivLZbwlhcyUvkmtYY8FJAlYf2kN89eOmgrQyrr1RqKpCNIJNOlHNHBjbmr7kux7SOuT
         H57ZgGEhpEy9Uba7A7K06ioD3nMrnVnfCx7KeSHqvpbX9iu0gBjobVby9gZfnfuqIpzP
         Zepf6KJ3rM3NsI3iD/eA3Y3v6Kpt2BoE1o/n2ICBa7AuiN+SQ4aHIfncN8VYBVZc9PMn
         SN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=zopoo8wtt2GlTHBzO7My+muQe+fLW/XxA2p+cF3wUK0=;
        b=QD6Tcj90z0S9Wsp0//YaLNTDkV4eQtVflLEsjBuuD10COkupg+crS0GKTzNNuIFHIm
         qzZsEX10y0qPJ9D0JXwVK9Pm91Cu2i0QvW/dVzeiCZpR3qn4VH72B3rNIUIZljumEf0K
         vYX+5txolldOgLZGjjpVF6RvpRl3j3nToQAIHL9d0tE69DCFF7+ibUs7nQU9PskyEmuZ
         gMKuaTPbEGjM2kLvvpYeyNl0L/1ges8+86rq8MzTVeiD8QAewoewrTIIs+bUZUKBoXgw
         nshzNLjCBXZeqNlvkxqtlfa99UalOFtCj2H+QD/65thZa1AG73vyLqqMFo5quNg01yw7
         QwPg==
X-Gm-Message-State: AOAM533q3uVRpzVzfPEqryb4+YpYcKmOBmoxUhL0+e45U5uFVrV4sqKm
        IydZNgWb7JKZbCQeQjNNZhRFWtOIz4S6Cw==
X-Google-Smtp-Source: ABdhPJzv0RS+v4Rf9f+t1JzgojjafC3ZW+p0G7was9tPS019ymbxv863bPYtlRHIMF3hlVPDA4i+kw==
X-Received: by 2002:a05:6e02:cc1:: with SMTP id c1mr13157644ilj.91.1639026728529;
        Wed, 08 Dec 2021 21:12:08 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id b8sm3127401iow.2.2021.12.08.21.12.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 21:12:08 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <ericsunshine@gmail.com>
Subject: [PATCH 00/19] tests: fix broken &&-chains & abort loops on error
Date:   Thu,  9 Dec 2021 00:10:56 -0500
Message-Id: <20211209051115.52629-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A while back, Peff successfully nerd-sniped[1] me into tackling a
long-brewing idea I had about (possibly) improving `chainlint`
performance by linting all tests in all scripts with a single command
invocation instead of running `sed` 25300+ times (once for each test).

Beside the obvious improvement of checking all tests in all scripts at
once, the new linter is also a good deal smarter than chainlint.sed and
understands not just shell syntax but also some semantics of test
construction, unlike chainlint.sed which is merely heuristics-based.
For instance, the new linter recognizes cases when a broken &&-chain is
legitimate, such as when `$?` is handled explicitly or when a failure is
signaled directly with `false`, in which case the &&-chain leading up to
the `false` is immaterial, as well as other cases. Unlike chainlint.sed,
it recognizes that a semicolon after the last command in a compound
statement is harmless, thus won't interpret the semicolon as breaking
the &&-chain.

The new linter also provides considerably better coverage for broken
&&-chains. The &&-chain checker built into t/test-lib.sh, which causes
tests to magically exit with code 117 if the &&-chain is broken, only
works for top-level command invocations. The magic doesn't work within
`{...}` groups, `(...)` subshells, `$(...)` substitutions, or within
bodies of compound statements, such as `if`, `for`, `while`, `case`,
etc. chainlint.sed partly fills the gap by catching broken &&-chains in
`(...)` subshells one level deep, but bugs can still lurk behind broken
&&-chains in the other cases. The new linter catches broken &&-chains
within all those constructs to any depth.

Another important improvement is that the new linter understands that
shell loops do not terminate automatically when a command in the loop
body fails, and that the condition needs to be handled explicitly by the
test author by using `|| return 1` (or `|| exit 1` in a subshell) within
the loop body to flag the failure. Consequently, the new linter will
complain when a loop is lacking `|| return 1` (or `|| exit 1`). There
are a number of other improvements, as well, but the above are some of
the more important ones.

Although the new chainlint implementation has been complete for several
months, I'm still working out how to organize its patch series. In the
meantime, _this_ patch series fixes problems discovered by the new
linter due to its improved coverage and extra semantic knowledge about
Git tests. As much as possible, I resisted the temptation to make
ancillary cleanups (including indentation fixes) to tests even when such
cleanups would be obvious improvements. Avoiding such unrelated cleanups
should make the long patches in this series, which touch a lot of tests,
easier to review (--color-words helps a lot here).

This series merges cleanly with 'next' but conflicts with a couple topics
in 'seen':

* jh/builtin-fsmonitor-part2

  t/perf/p7519-fsmonitor.sh
    simple resolution: keep all changes from jh/builtin-fsmonitor-part2
    (it obviates the need for the fixes made by this series)

* ms/customizable-ident-expansion

  t/t0021-conversion.sh
    this is a messy conflict but resolution is simple enough: keep all
    the changes made by ms/customizable-ident-expansion and throw away
    the changes by this series; this will leave a few broken &&-chains
    in t0021-conversion.sh but there are a few other topics in 'seen'
    with such problems already, so it has company; anyhow, "What's
    Cooking" indicates that ms/customizable-ident-expansion is going to
    be discarded, so it may not be worth worrying about it

[1]: https://lore.kernel.org/git/YJzGcZpZ+E9R0gYd@coredump.intra.peff.net/

Eric Sunshine (19):
  t/lib-pager: use sane_unset() to avoid breaking &&-chain
  t1010: fix unnoticed failure on Windows
  t1020: avoid aborting entire test script when one test fails
  t4202: clarify intent by creating expected content less cleverly
  t5516: drop unnecessary subshell and command invocation
  t6300: make `%(raw:size) --shell` test more robust
  t9107: use shell parameter expansion to avoid breaking &&-chain
  tests: simplify construction of large blocks of text
  tests: use test_write_lines() to generate line-oriented output
  tests: fix broken &&-chains in compound statements
  tests: fix broken &&-chains in `$(...)` command substitutions
  tests: fix broken &&-chains in `{...}` groups
  tests: apply modern idiom for signaling test failure
  tests: apply modern idiom for exiting loop upon failure
  tests: simplify by dropping unnecessary `for` loops
  t0000-t3999: detect and signal failure within loop
  t4000-t4999: detect and signal failure within loop
  t5000-t5999: detect and signal failure within loop
  t6000-t9999: detect and signal failure within loop

 .../mw-to-git/t/t9365-continuing-queries.sh   |   2 +-
 contrib/subtree/t/t7900-subtree.sh            |   2 +-
 t/annotate-tests.sh                           |   2 +-
 t/lib-pager.sh                                |   2 +-
 t/perf/p0005-status.sh                        |  12 +-
 t/perf/p0006-read-tree-checkout.sh            |  20 +-
 t/perf/p0007-write-cache.sh                   |   4 +-
 t/perf/p0100-globbing.sh                      |   4 +-
 t/perf/p1400-update-ref.sh                    |   4 +-
 t/perf/p1451-fsck-skip-list.sh                |   2 +-
 t/perf/p3400-rebase.sh                        |   2 +-
 t/perf/p5302-pack-index.sh                    |   4 +-
 t/perf/p5303-many-packs.sh                    |  10 +-
 t/perf/p7519-fsmonitor.sh                     |   8 +-
 t/t0005-signals.sh                            |   2 +-
 t/t0008-ignores.sh                            |   2 +-
 t/t0011-hashmap.sh                            |   4 +-
 t/t0020-crlf.sh                               |  28 +-
 t/t0021-conversion.sh                         |  60 ++--
 t/t0026-eol-config.sh                         |   4 +-
 t/t0060-path-utils.sh                         |   4 +-
 t/t0069-oidtree.sh                            |  12 +-
 t/t0095-bloom.sh                              |   4 +-
 t/t0410-partial-clone.sh                      |   2 +-
 t/t1006-cat-file.sh                           |  12 +-
 t/t1010-mktree.sh                             |   4 +-
 t/t1020-subdirectory.sh                       |  10 +-
 t/t1050-large.sh                              |  34 +-
 t/t1091-sparse-checkout-builtin.sh            |   2 +-
 t/t1300-config.sh                             |   6 +-
 t/t1400-update-ref.sh                         |   4 +-
 t/t1403-show-ref.sh                           |  12 +-
 t/t1410-reflog.sh                             |   4 +-
 t/t1512-rev-parse-disambiguation.sh           |  12 +-
 t/t1700-split-index.sh                        |   4 +-
 t/t2004-checkout-cache-temp.sh                |   4 +-
 t/t2012-checkout-last.sh                      |   4 +-
 t/t2102-update-index-symlinks.sh              |   2 +-
 t/t2103-update-index-ignore-missing.sh        |   2 +-
 t/t2200-add-update.sh                         |  18 +-
 t/t2201-add-update-typechange.sh              |  10 +-
 t/t2203-add-intent.sh                         |   2 +-
 t/t3005-ls-files-relative.sh                  |  10 +-
 t/t3070-wildmatch.sh                          |   2 +-
 t/t3202-show-branch.sh                        |   8 +-
 t/t3303-notes-subtrees.sh                     |   6 +-
 t/t3305-notes-fanout.sh                       |   4 +-
 t/t3402-rebase-merge.sh                       |   8 +-
 t/t3404-rebase-interactive.sh                 |   4 +-
 t/t3417-rebase-whitespace-fix.sh              |   4 +-
 t/t3501-revert-cherry-pick.sh                 |   2 +-
 t/t3508-cherry-pick-many-commits.sh           |   2 +-
 t/t3600-rm.sh                                 |   7 +-
 t/t3700-add.sh                                |   8 +-
 t/t3920-crlf-messages.sh                      |   4 +-
 t/t4001-diff-rename.sh                        |   2 +-
 t/t4012-diff-binary.sh                        |   2 +-
 t/t4013-diff-various.sh                       |  22 +-
 t/t4014-format-patch.sh                       |  32 +-
 t/t4015-diff-whitespace.sh                    |   4 +-
 t/t4018-diff-funcname.sh                      |   2 +-
 t/t4019-diff-wserror.sh                       |   4 +-
 t/t4023-diff-rename-typechange.sh             |   6 +-
 t/t4024-diff-optimize-common.sh               |   2 +-
 t/t4025-hunk-header.sh                        |  10 +-
 t/t4038-diff-combined.sh                      |   2 +-
 t/t4046-diff-unmerged.sh                      |  10 +-
 t/t4049-diff-stat-count.sh                    |   2 +-
 t/t4052-stat-output.sh                        |   2 +-
 t/t4057-diff-combined-paths.sh                |  16 +-
 t/t4105-apply-fuzz.sh                         |  10 +-
 t/t4106-apply-stdin.sh                        |   5 +-
 t/t4116-apply-reverse.sh                      |   4 +-
 t/t4117-apply-reject.sh                       |  20 +-
 t/t4118-apply-empty-context.sh                |   6 +-
 t/t4123-apply-shrink.sh                       |   4 +-
 t/t4124-apply-ws-rule.sh                      |  58 ++--
 t/t4125-apply-ws-fuzz.sh                      |   5 +-
 t/t4126-apply-empty.sh                        |   5 +-
 t/t4127-apply-same-fn.sh                      |   5 +-
 t/t4138-apply-ws-expansion.sh                 |  36 +-
 t/t4150-am.sh                                 |   2 +-
 t/t4151-am-abort.sh                           |  10 +-
 t/t4202-log.sh                                |  42 +--
 t/t4205-log-pretty-formats.sh                 |   2 +-
 t/t4211-line-log.sh                           |   2 +-
 t/t4212-log-corrupt.sh                        |   8 +-
 t/t4216-log-bloom.sh                          |   4 +-
 t/t5000-tar-tree.sh                           |   4 +-
 t/t5003-archive-zip.sh                        |   2 +-
 t/t5004-archive-corner-cases.sh               |   6 +-
 t/t5100-mailinfo.sh                           |   2 +-
 t/t5300-pack-object.sh                        |  18 +-
 t/t5302-pack-index.sh                         |   2 +-
 t/t5306-pack-nobase.sh                        |   2 +-
 t/t5307-pack-missing-commit.sh                |   2 +-
 t/t5310-pack-bitmaps.sh                       |   2 +-
 t/t5316-pack-delta-depth.sh                   |   7 +-
 t/t5317-pack-objects-filter-objects.sh        |  30 +-
 t/t5318-commit-graph.sh                       |   6 +-
 t/t5319-multi-pack-index.sh                   |  10 +-
 t/t5322-pack-objects-sparse.sh                |   4 +-
 t/t5325-reverse-index.sh                      |   2 +-
 t/t5500-fetch-pack.sh                         |   8 +-
 t/t5502-quickfetch.sh                         |   2 +-
 t/t5505-remote.sh                             |   6 +-
 t/t5510-fetch.sh                              |  14 +-
 t/t5515-fetch-merge-logic.sh                  |  38 +--
 t/t5516-fetch-push.sh                         |   5 +-
 t/t5552-skipping-fetch-negotiator.sh          |  10 +-
 t/t5562-http-backend-content-length.sh        |   2 +-
 t/t5570-git-daemon.sh                         |   2 +-
 t/t5571-pre-push-hook.sh                      |   6 +-
 t/t5611-clone-config.sh                       |   2 +-
 t/t5616-partial-clone.sh                      |  30 +-
 t/t5702-protocol-v2.sh                        |   4 +-
 t/t6005-rev-list-count.sh                     |   8 +-
 t/t6009-rev-list-parent.sh                    |   6 +-
 t/t6019-rev-list-ancestry-path.sh             |  10 +-
 t/t6060-merge-index.sh                        |   4 +-
 t/t6101-rev-parse-parents.sh                  |   2 +-
 t/t6112-rev-list-filters-objects.sh           |  22 +-
 t/t6120-describe.sh                           |  13 +-
 t/t6132-pathspec-exclude.sh                   |   2 +-
 t/t6200-fmt-merge-msg.sh                      |   2 +-
 t/t6300-for-each-ref.sh                       |   7 +-
 t/t6406-merge-attr.sh                         |   8 +-
 t/t6407-merge-binary.sh                       |   4 +-
 t/t6409-merge-subtree.sh                      |   6 +-
 t/t6411-merge-filemode.sh                     |   8 +-
 t/t6412-merge-large-rename.sh                 |  10 +-
 t/t6416-recursive-corner-cases.sh             |  30 +-
 t/t6417-merge-ours-theirs.sh                  |   5 +-
 t/t6430-merge-recursive.sh                    |   2 +-
 t/t6600-test-reach.sh                         |   4 +-
 t/t7004-tag.sh                                |   9 +-
 t/t7010-setup.sh                              |   2 +-
 t/t7110-reset-merge.sh                        |   2 +-
 t/t7501-commit-basic-functionality.sh         |   5 +-
 t/t7505-prepare-commit-msg-hook.sh            |   2 +-
 t/t7513-interpret-trailers.sh                 |   2 +-
 t/t7519-status-fsmonitor.sh                   |   2 +-
 t/t7600-merge.sh                              |   2 +-
 t/t7602-merge-octopus-many.sh                 |   4 +-
 t/t7603-merge-reduce-heads.sh                 |   4 +-
 t/t7700-repack.sh                             |   2 +-
 t/t7810-grep.sh                               | 310 +++++++++---------
 t/t8002-blame.sh                              |   2 +-
 t/t8003-blame-corner-cases.sh                 |  10 +-
 t/t8014-blame-ignore-fuzzy.sh                 |   4 +-
 t/t9104-git-svn-follow-parent.sh              |   4 +-
 t/t9107-git-svn-migrate.sh                    |   8 +-
 t/t9130-git-svn-authors-file.sh               |   6 +-
 t/t9134-git-svn-ignore-paths.sh               |  16 +-
 t/t9138-git-svn-authors-prog.sh               |   2 +-
 t/t9146-git-svn-empty-dirs.sh                 |   4 +-
 t/t9147-git-svn-include-paths.sh              |  16 +-
 t/t9152-svn-empty-dirs-after-gc.sh            |   2 +-
 t/t9304-fast-import-marks.sh                  |   2 +-
 t/t9400-git-cvsserver-server.sh               |  11 +-
 t/t9800-git-p4-basic.sh                       |   2 +-
 t/t9818-git-p4-block.sh                       |   6 +-
 t/t9902-completion.sh                         |   4 +-
 163 files changed, 740 insertions(+), 847 deletions(-)

-- 
2.34.1.307.g9b7440fafd

