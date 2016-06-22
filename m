Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D502320189
	for <e@80x24.org>; Wed, 22 Jun 2016 20:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbcFVUXe (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 16:23:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:49472 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbcFVUXd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 16:23:33 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Mgt3g-1b2X1C3feK-00M1FK; Wed, 22 Jun 2016 22:23:26
 +0200
Date:	Wed, 22 Jun 2016 22:23:24 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 1/2] t/perf: fix regression in testing older versions of
 git
In-Reply-To: <20160622194013.GA1697@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1606222223100.10382@virtualbox>
References: <20160622193904.GA1509@sigill.intra.peff.net> <20160622194013.GA1697@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZSPQLSHxrgUV9rWEWwwK4M2pDet2xZ+0Q+d7xfk2QtVBfSW4+3e
 8VcLcrIzVFfe9iU+eLKi1/fQPBnVpVhMpX9zgZ4PkqvRXm2F+ZBxuW8DEZeLwdojKEVjOWO
 iiDrEIfmGVkYeBlc1tJUMfG1ssUTgS2YmDhrT+wPCPz+y3HTv1WvZHjvPtDcSnQd0tAvEmy
 ebk25Ffp75rh5epzf6Lyg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:PseCpQQG8zA=:WkvtvpGU7ResuKi3iltRp1
 bAQkFCKBimue2UhCCewgrc4VC9AAC18TaUqQ77Cbv6kVv3Nxk2cG+bBEh13A87JF1S6w+5LMM
 cuKKG1q30iGRtOfy8vFyjgTL9JLHCoJZ8sLO/ogb2xs8PDet8+fGpoUdTwIQmqSRWmOfdhtBQ
 +id1cMEoSLf5fpWWjn6FrDaXXuR6p45MjwiDFwLs68TWkIR6gfgn4+JcWwKU+UJ4NwfuCVZ35
 BejWtGJC2wVOhJDooa9y8AdZUBh6Nan9GTviCashuz8C3tdJIYsbRIdXVXIewqsFsAwVH8I3X
 qNZnFQmjRqpKwSDZBKLzIOpred0WOWap44y0UwRQOr56/clqQZq1CuroouNoMS9IKDu2+1465
 igl6BgVgpIolxmpEndyZ2k0s6bgLL8sxgE2AWDXa2gKb2Y97CvS8u891JttVDcYRHxN3nL+x+
 2+tDnDG02jpcro6eHwuqp52q5B7uoUk4cv26eOn4anVoyr9Voy9lYvJwFM6JFUpzg+4/7G0D8
 UfvmprtoWaEt4J0r0tSYoz6Z0d/RgYRSdW6LNHD7XU7qCpmN8cLhCctF3QQwcO9WpLeXq3+At
 ehpSmB0CyE4Ms6zM5cOl/awbnGZLNdblTfG52GKy2BCV0U/4vXxV8rdTuKEKKWLcDsN+g/kV1
 HIrvD5Kcz/tNKPmA6briJ4ZbNIr2/ynoxAzuuWtTxkgQTgqZAAQaHsUh5njH9shN5MYXFCqQK
 HM6xtFR2EMT8gJ9ofnaOUsXnoz5gpq2Nt35dmL/T7DpjLFPeLWWgy+V1YMttG5FcfkfIX7mKj
 EshJ5Yo
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Wed, 22 Jun 2016, Jeff King wrote:

> Commit 7501b59 (perf: make the tests work in worktrees,
> 2016-05-13) introduced the use of "git rev-parse --git-path"
> in the perf-lib setup code. Because the to-be-tested version
> of git is at the front of the $PATH when this code runs,
> this means we cannot use modern versions of t/perf to test
> versions of git older than v2.5.0 (when that option was
> introduced).
> 
> This is a symptom of a more general problem. The t/perf
> suite is essentially independent of git versions, and
> ideally we would be able to run the most modern and complete
> set of tests across many historical versions (to see how
> they compare). But any setup code they run is therefore
> required to use the lowest common denominator we expect to
> test.
> 
> So let's introduce a new variable, $MODERN_GIT, that we can
> use both in perf-lib and in the test setup to get a reliable
> set of git features (we might change git and break some
> tests, of course, but $MODERN_GIT is tied to the same
> version of git as the t/perf scripts, so they can be fixed
> or adjusted together).
> 
> This commit fixes the "--git-path" case, but does not
> mass-convert existing setup code to use $MODERN_GIT. Most
> setup code is fairly vanilla and will work with effectively
> all versions. But now the tool is there to fix any other
> issues we find going forward.

Thanks for beating me to it!

Ciao,
Dscho
