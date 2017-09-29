Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD0A020281
	for <e@80x24.org>; Fri, 29 Sep 2017 18:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbdI2S0u (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 14:26:50 -0400
Received: from mout.gmx.net ([212.227.15.18]:56535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752334AbdI2S0u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 14:26:50 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZTbR-1ddSRM04c9-00LAua; Fri, 29
 Sep 2017 20:26:45 +0200
Date:   Fri, 29 Sep 2017 20:26:44 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH] clang-format: adjust line break penalties
Message-ID: <073f00fa11930a3607e34828e7563e1b2dc27d2a.1506709551.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gcAWYqgjpQTrB2dXDwg8muz68JGAtfN6GQ5qybx4B1xoek0KMv5
 vGp63BVQnbAg31htiJw2kk26FaMtG9cHIabxeNVeberotYNzTXUk+LcJZHJj0b/u9QxdPhR
 kParRsh5IfKI9dLWllSOx5QlaDjSJVl7yMDuIiIrmWgImjj2ajxNqLpNPL22DjOfb2wQ5Mi
 jUtOrTK/E8iDdpijqfKRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wt3SCrjrekE=:xqEvTRHJA2M4OdAgG2Opgu
 8QuY6/FCRCFEktz348qv1efe1tnf3KR12mLTLOTXWaatXWZIhrfnuiVJacx8ouhXlh0id1Ggf
 tQjCfxraVubzJLv77pBqUUzRKh43NRyV8aZ6ofnGi/f5i7Thx9sTUUo2zLYR19hTuAKzLiaSe
 U4L2cA0BupsKybSRFq66T8WYHvcr/5eVn4/l2LCE42/lk4HxBRMOXheVaoODnpI5jEPhBdIS7
 Je6wk3wXRRVJYgREfSKX5hFwjKlsZOfnG2Fu81GFqNvQTH3XmlN6ZkCOMUJfTiYKmcojI+Xc3
 IrZsfu0NVnoNz4H8lb70J1h6xn3T5HDyh9pKjK8X1WKEIXO5wgvcPnm1WzfEBV2CsPyl+Arav
 IfRIR2t2q8RAA1rZgRIRhgSpy+bmjNYyw6e8jRRYDlGQ/MCc3if+3rsRn0LdbDoDg5FhI7k2/
 bnYiZRh7Xzx7GfGPneckxDEYhIdh/37P8hi11nc5rTaLiKAyZ8i3glo0HBeVB5ORYvPmAasa9
 LU98kiM57UPNof6T1rIOCGGC5gDKf60PRnhXnrU6FtxJQsZhW7arcSwW0W7ti4QVwdZmxKLtH
 NSo+Trg2xuSobW8MrJvtEIfW232T2bROShzyJoapBbglh/SYExebZYsFPU0Vl0pEEE+uzQVPT
 IcDlVVPp5qziu6KIcA7MbT46/ozeKMbcUkbpqhxVZpO6l+wpFlam//6b44R/jY/sE0YvERIjI
 mxbCAxEk9mPww5hblF1N/GBC7oGLiPlOOpdKOkpWf4CT+9Y1eN0Fc6NsEOIXIyGb/KUpI/4h4
 d4UybXGTzLttGZ6eauUA2U6osYRlBZARtdVVklWUAb0wf5GDz8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We really, really, really want to limit the columns to 80 per line: One
of the few consistent style comments on the Git mailing list is that the
lines should not have more than 80 columns/line (even if 79 columns/line
would make more sense, given that the code is frequently viewed as diff,
and diffs adding an extra character).

The penalty of 5 for excess characters is way too low to guarantee that,
though, as pointed out by Brandon Williams.

From the existing clang-format examples and documentation, it appears
that 100 is a penalty deemed appropriate for Stuff You Really Don't
Want, so let's assign that as the penalty for "excess characters", i.e.
overly long lines.

While at it, adjust the penalties further: we are actually not that keen
on preventing new line breaks within comments or string literals, so the
penalty of 100 seems awfully high.

Likewise, we are not all that adamant about keeping line breaks away
from assignment operators (a lot of Git's code breaks immediately after
the `=` character just to keep that 80 columns/line limit).

We do frown a little bit more about functions' return types being on
their own line than the penalty 0 would suggest, so this was adjusted,
too.

Finally, we do not particularly fancy breaking before the first parameter
in a call, but if it keeps the line shorter than 80 columns/line, that's
what we do, so lower the penalty for breaking before a call's first
parameter, but not quite as much as introducing new line breaks to
comments.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/clang-format-column-limit-v1
Fetch-It-Via: git fetch https://github.com/dscho/git clang-format-column-limit-v1
 .clang-format | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/.clang-format b/.clang-format
index 3ede2628d2d..56822c116b1 100644
--- a/.clang-format
+++ b/.clang-format
@@ -153,13 +153,13 @@ KeepEmptyLinesAtTheStartOfBlocks: false
 
 # Penalties
 # This decides what order things should be done if a line is too long
-PenaltyBreakAssignment: 100
-PenaltyBreakBeforeFirstCallParameter: 100
-PenaltyBreakComment: 100
+PenaltyBreakAssignment: 10
+PenaltyBreakBeforeFirstCallParameter: 30
+PenaltyBreakComment: 10
 PenaltyBreakFirstLessLess: 0
-PenaltyBreakString: 100
-PenaltyExcessCharacter: 5
-PenaltyReturnTypeOnItsOwnLine: 0
+PenaltyBreakString: 10
+PenaltyExcessCharacter: 100
+PenaltyReturnTypeOnItsOwnLine: 5
 
 # Don't sort #include's
 SortIncludes: false

base-commit: ea220ee40cbb03a63ebad2be902057bf742492fd
-- 
2.14.2.windows.1
