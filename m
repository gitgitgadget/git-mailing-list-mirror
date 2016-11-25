Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CAD51FBB0
	for <e@80x24.org>; Fri, 25 Nov 2016 16:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932429AbcKYQsP (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Nov 2016 11:48:15 -0500
Received: from mout.gmx.net ([212.227.17.20]:61055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754852AbcKYQsN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2016 11:48:13 -0500
Received: from virtualbox ([95.208.59.208]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LkBPy-1chzcY2ivS-00c6x1; Fri, 25
 Nov 2016 17:41:28 +0100
Date:   Fri, 25 Nov 2016 17:41:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Markus Klein <markus.klein@reelworx.at>
Subject: Re: [PATCH 0/2] Fix segmentation fault with cherry-pick
In-Reply-To: <cover.1480091758.git.johannes.schindelin@gmx.de>
Message-ID: <alpine.DEB.2.20.1611251739570.117539@virtualbox>
References: <cover.1480091758.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MMsgQeqNCDwGbatHIHNXG4YleJwUEJBlUdLsI60C6qhWSBjpOcg
 VTe3PWEGFrH1ui4K+HqqakzW8hpNKvZ4/MrKVsSVwaq0GsqlTYUVb0eNJUXpxMKXhxvJjs9
 jUODUCwga65xsbQYcGDP/QtM9MGIQoJzWUSVqxvrE4CWQl7g7rOjOERTyTkVApD3sT+fWBy
 DN/5BBjabpIxTqJ53SYHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T1gNh4g5MCw=:vC0rTC/EZ8wSV+cWeMtPTC
 j3Xjlg4SKy8JS/SaeDLNkW44O5HhALnZLPPnrfOm1ao/CKB7UZ3XZsq0a7x5rOzFcI5FdYc4p
 wnnYlsPeO4t4GycCrklPXPO696BThGEDywHfvcl8uTEeL1otirKLcCPAXeabhPTJnH/BHjqWu
 mVGVEKh4++7JXHekHDn+qWXk6iHs9ZOY1MKpO2k7DYXTFb7eJqvse3H9XHRWISwSlUhCaCm+a
 TS1neY8Z4gCRhY25IQelwDw5A3zskeItPX8FohnJyTM0PUQOeSDKSLeNWr3FshZoLpKHLoPH5
 e5GkjqOFH+v3mVglg3qFS+JfyImPpMgdW64qAFrM40lD9NlYO3ojlvkhKPuTWkpBMvrO7w0rp
 EbIdaVGdF9QEevWXCV/gmyq5exUbE4wK/w8ZPz/lN+Dd62PZS0qbjlvHwuu/X6mb1vuXnhzmw
 dMIFaA3NVEeLDb5v89M7bfVxddlfVW1JgZcSRa/7RaiPqLSmEWLZyPWUIEEa6cVCxLNGbcub/
 xEc+pjxTa0YNnyawJrxNRhOkvj/OhBgfrHMrmtxHgEkLAYjo/HKLs7ivHnQR3Eb6fGLWL+bFv
 4qerKsbEfZNvpISoBQPVxUVBjcPUE3phb7iIixCFuudPL7kFmZlJkhnsRtl/ro5KnyRt97diK
 i1eTx7ENl/kq3MWtuar823bVCjQ1gZgZRRS8WMfCYmmyJF/HK9Pi3HGLsZYk57ECLIucVWHfh
 wXG2ckpl1KnIM0wDpo3JJ2xrI3+ldYjYjrwJO7gI6w3QoU/6qp5bS1+BHfN2dXdX7+A4rD1xI
 +AljbLu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 25 Nov 2016, Johannes Schindelin wrote:

> The culprit is actually not cherry-pick, but a special code path that
> expects refresh_cache_entry() not to return NULL. And the fix is to
> teach it to handle NULL there.
> 
> This bug was brought to my attention by Markus Klein via
> https://github.com/git-for-windows/git/issues/952.

For the record, I looked at other callers of `refresh_cache_entry()`:
there is only `make_cache_entry()`, whose callers all handle NULL return
values except in resolve-undo.c. But that latter caller is okay because it
specifically does not allow refreshing (by passing 0 as options), so
refresh_cache_entry() cannot return NULL.

Ciao,
Dscho
