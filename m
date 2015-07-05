From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 09/12] t4150: am with post-applypatch hook
Date: Sun, 05 Jul 2015 17:58:49 +0200
Organization: gmx
Message-ID: <17f64cb49c820eb41d0fb58435c91c40@www.dscho.org>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
 <1435861000-25278-10-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 17:59:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBmK2-0000Xm-0g
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jul 2015 17:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbbGEP66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2015 11:58:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:50368 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454AbbGEP64 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2015 11:58:56 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lv8hi-1Z3dPt023W-010PrS; Sun, 05 Jul 2015 17:58:51
 +0200
In-Reply-To: <1435861000-25278-10-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:ki3bcQBd+dsruX3vRpOn6AWkXzyKq66ZFmCmfWRrqPbPV6B9eLu
 FWaalAtswFPsHdOhiRoraPrR0JwWWKFX/q3Y5BpDJdiFc2EEt8aNH97pavcgMWPmnksSNTh
 C/UNqgZHMSTVrWzrZrbzC3TzAT7ZQFUPLNpoVCyM1201tHzNUqSbbG4h7vgnG7aFfJBST6O
 GKckYjO2k7MWHCbG6lKOw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lri7AK+opXI=:CBAQEdm+2PaSe1kD46lmdZ
 104qOiZDQDnzPt7XzTlFVlJ71+ReAT7Xbpr910bGFuPEWnKLYloV8sbH+iuLniKANZwbFCzAp
 BVlfgXSogtKgQ1X9dIJyv5Dzkukv9UY6y5jQCmxHTRicZ/8612GTYCQpDavKPUcRJPKWM5JIl
 JUrZ2ruIUItL/2tEUwwzf0mVaERZOeVd8Rx9NjXH/pS0azjTc1QrjSU2o6u709BMpB5nOc2y3
 PmhiDuMpFkmsSWHes4YKNVT7cV8rANPS5uSOIpGGQCCzEQpaJju9326YdCb4NNHQPvhDR6NJO
 jt+p5swnO7y2ds7EdpxOofkXYNhGwjhSLHlQikB/6yn6m6xD65ntGFe/LfFRy829yIsrJXziM
 fsTflOHqU1xMBYv+3qkPmRFwCCWNPeYBBm9k03klBC1msIslkPexyd/8dyD2SJYTX+3tCQBjW
 zJGxzwP4oEOTPyqBJSGDC21HGvgjznFM5ZJpd860DB07mTuSE7BlVp0ZVyvaSVgKAUCm0JRU7
 oRbqDxKK0ZNM1JhC1PI8DX5g8JGzOsYML6MhYcfQvTDVvh5tfc3BXrGhtZiQBg8Ux/jNP5bhu
 gSco99mzb7/W8NyKBQIbt38nkCIs8ZtM4gG3mqaQz9ugqwOHJgaPdU/LFa6+437iq8Jm23iq4
 6/VpNvf79V/NLcfOY0btxmVGLfKwD3LGE97v1iHIu1+ia9aF4A+Qi+wk+e6QSqwrve+k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273367>

Hi Paul,

On 2015-07-02 20:16, Paul Tan wrote:

> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index dd6fe81..62b678c 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -275,6 +275,48 @@ test_expect_success 'am with failing pre-applypatch hook' '
>  	test_cmp_rev first HEAD
>  '
>  
> +test_expect_success 'am with post-applypatch hook' '
> +	test_when_finished "rm -f .git/hooks/post-applypatch" &&
> +	rm -fr .git/rebase-apply &&
> +	git reset --hard &&
> +	git checkout first &&
> +	mkdir -p .git/hooks &&
> +	cat >.git/hooks/post-applypatch <<-\EOF &&
> +	#!/bin/sh
> +	git rev-parse HEAD >head.actual
> +	git diff second >diff.actual
> +	exit 0
> +	EOF
> +	chmod +x .git/hooks/post-applypatch &&
> +	git am patch1 &&
> +	test_path_is_missing .git/rebase-apply &&
> +	test_cmp_rev second HEAD &&
> +	git rev-parse second >head.expected &&
> +	test_cmp head.expected head.actual &&
> +	git diff second >diff.expected &&
> +	test_cmp diff.expected diff.actual
> +'
> +
> +test_expect_success 'am with failing post-applypatch hook' '
> +	test_when_finished "rm -f .git/hooks/post-applypatch" &&
> +	rm -fr .git/rebase-apply &&
> +	git reset --hard &&
> +	git checkout first &&
> +	mkdir -p .git/hooks &&
> +	cat >.git/hooks/post-applypatch <<-\EOF &&
> +	#!/bin/sh
> +	git rev-parse HEAD >head.actual
> +	exit 1
> +	EOF
> +	chmod +x .git/hooks/post-applypatch &&
> +	git am patch1 &&
> +	test_path_is_missing .git/rebase-apply &&
> +	git diff --exit-code second &&
> +	test_cmp_rev second HEAD &&
> +	git rev-parse second >head.expected &&
> +	test_cmp head.expected head.actual
> +'

These 2 tests as well as the previous patches look to me as if they could be refactored (the paradigm is the same: add a certain hook after resetting and then apply the patch, verify that the hook ran/failed)... do you think there is a chance for that?

Just to make sure: I think the patch series looks good, and if it would be too cumbersome (or just not feasible) to simplify those test cases, I am totally fine with them as-are.

Ciao,
Dscho
