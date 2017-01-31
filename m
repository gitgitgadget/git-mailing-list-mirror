Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FAB71F437
	for <e@80x24.org>; Tue, 31 Jan 2017 17:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbdAaRVu (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 12:21:50 -0500
Received: from [195.159.176.226] ([195.159.176.226]:50367 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbdAaRUS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 12:20:18 -0500
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1cYc69-0002wZ-BQ
        for git@vger.kernel.org; Tue, 31 Jan 2017 18:20:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   "Herbert, Marc" <marc.herbert@intel.com>
Subject: =?UTF-8?Q?Feature_request:_flagging_=e2=80=9cvolatile=e2=80=9d_bran?=
 =?UTF-8?Q?ches_for_integration/development?=
Date:   Tue, 31 Jan 2017 09:12:17 -0800
Message-ID: <70ccb8fc-30f2-5b23-a832-9e470787a945@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
Cc:     josh@joshtriplett.org
X-Mozilla-News-Host: news://news.gmane.org:119
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Thanks to Josh Triplett[*] for contributing to this message)

Hi,

We often work with development/integration branches that regularly
rebase, in addition to stable branches that do not. Git is used to share
two different types of branches:
  1. Pull requests and merged code with final SHA1s
  2. Work in progress with volatile SHA1s.

We’d like to have a consistent way to distinguish these two types by
advertising a branch as “volatile”. Such a branch supports shared
development on work-in-progress code (not yet ready to merge, or still
being emailed as PATCHv{2,3,4,...}), or an integration/testing branch
for a combination of such development branches.  Branch naming
conventions could help a bit here, but a large and varied set of naming
conventions already exist, none of which provide machine-readable
information that git itself can rely on. So the only thing available is
tribal knowledge or out-of-band documentation at best, e.g.:
https://01.org/linuxgraphics/gfx-docs/maintainer-tools/drm-intel.html

Such a “volatile” flag would instantly warn that code is not ready to
re-use:
https://www.chromium.org/chromium-os/chromiumos-design-docs/upstream-first

Another common issue with volatile branches is their commits being
misunderstood as immutable and then their transient, top SHA1
being reported as bogus and unusable version control information in bugs
(on a non-volatile branch, a single SHA1 captures the entire and exact
snapshot and history).

Humans would be the initial consumers of this flag but I can imagine git
itself also using it. For instance, cherry-pick could have a “smart”
setting for -x, that doesn’t bother recording transient commit hashes. A
merge could print an optional warning when pulling in changes from a
volatile branch, and a rebase could similarly print a warning when
rebasing on top of such a branch. A git server could be configured to
treat non-fast forward forced pushes differently depending on the
“volatility” of the target branch. A fancy user interface could
color volatile SHA1s differently to discourage copy/paste. Etc.

Maybe this has already been discussed (or implemented even), and I
couldn’t find the right search keywords; in this case please help me cut
this discussion short. We’d appreciate any feedback you might have,
either on the idea itself, or on other ways to solve the same problem.

[ ] “send patches”
[ ] use some other existing mechanism to solve this
[ ] will never work because of X and Y; don’t even bother

-- 
Marc

PS: please keep me in Cc:, thanks.

[*] on a related topic: https://github.com/git-series/git-series


