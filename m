Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F37A520372
	for <e@80x24.org>; Fri,  6 Oct 2017 22:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753004AbdJFWZt (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 18:25:49 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.26]:10352 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752999AbdJFWZs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 18:25:48 -0400
Received: from [89.246.212.34] (helo=sandbox)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1e0b3x-0000pv-Ko; Sat, 07 Oct 2017 00:25:45 +0200
Date:   Sat, 7 Oct 2017 00:25:44 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, Jens.Lehmann@web.de,
        bmwill@google.com
Subject: [RFC PATCH v3 0/4] implement fetching of moved submodules
Message-ID: <20171006222544.GA26642@sandbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The last iteration can be found here:

https://public-inbox.org/git/20170817105349.GC52233@book.hvoigt.net/

This is mainly a status update and to let people know that I am still
working on this.

I struggled quite a bit with reviving my original test for the path
based recursive fetch (first patch). The behavior seems to haved changed
and simply setting the submodule configuration in .git/config without
one in .gitmodules does not work anymore. I did not have time to
investigate whether this was a deliberate change or a maybe a bug?

So the solution for now is that I write my fake configuration (to avoid
skipping submodule handling altogether) into a .gitmodules file.

The second patch (cleanup of a submodule push testcase) was written
because that currently is the only test failing. It is not meant for
inclusion but rather as a demonstration of what might be happening when
we cleanup testcases: Because of the behavioral change above, on first
sight, it seemed like there was a shortcut in fetch and so on-demand
fetch without submodule configuration would not be supported anymore.

IIRC there were a lot more tests failing before when I implemented my
patch without the fallback on paths. So my guess is that some tests have
been cleaned up to use proper (.gitmodules) submodule setup.

So the thing here is: If we want to make sure that we stay backwards
compatible by supporting the setup with gitlinks without configuration.
Then we also should keep tests around that have the plain manual setup
without .gitmodules files. Just something, I think, we should keep in
mind.

Apart from the tests nothing has been added in this iteration. Since I
finally have a working test now I will continue with reviving the
fallback to paths.

Cheers Heiko

Heiko Voigt (4):
  fetch: add test to make sure we stay backwards compatible
  change submodule push test to use proper repository setup
  implement fetching of moved submodules
  submodule: simplify decision tree whether to or not to fetch

 submodule.c                    | 155 ++++++++++++++++++++++-------------------
 t/t5526-fetch-submodules.sh    |  77 +++++++++++++++++++-
 t/t5531-deep-submodule-push.sh |  29 ++++----
 3 files changed, 174 insertions(+), 87 deletions(-)

-- 
2.10.0.129.g35f6318

