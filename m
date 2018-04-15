Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0E061F404
	for <e@80x24.org>; Sun, 15 Apr 2018 12:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeDOMV0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 08:21:26 -0400
Received: from a27-142.smtp-out.us-west-2.amazonses.com ([54.240.27.142]:46078
        "EHLO a27-142.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751190AbeDOMVZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Apr 2018 08:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=7v7vs6w47njt4pimodk5mmttbegzsi6n; d=amazonses.com; t=1523794884;
        h=Content-Type:From:To:Subject:Message-ID:Date:Content-Transfer-Encoding:MIME-Version:Feedback-ID;
        bh=Q8pxFLMt/qZfjZJS9Wfp1L7mgH9KsxZEUYgHTBigG4M=;
        b=XumISRgVnjGa+E0ayF3LL67rtTAGGUM6Wpiz1EGJ7tsthdX1oh6gOWQ1vJ9xRQHG
        16HxUcbOEStyC3LHRVhowCboRI+FZHY6lonDzpauaIbFBgh09Ecblo1XRxk0iMUKd7X
        dycMTqCowm7OVhCfAIpytIDWFEpnxGI9y4iPqIgg=
Content-Type: text/plain
From:   mqudsi@neosmart.net
To:     git@vger.kernel.org, mqudsi@neosmart.net
Subject: Regression in patch add?
Message-ID: <01010162c940b8bb-d8139971-3ee2-4cd6-bb19-35126d46753b-000000@us-west-2.amazonses.com>
Date:   Sun, 15 Apr 2018 12:21:24 +0000
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-SES-Outgoing: 2018.04.15-54.240.27.142
Feedback-ID: 1.us-west-2.PCEy91/Vd+GU67P48MglE9FKtQG6qQD9MhgwC/YKQRM=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I'm currently running the latest version of git built from `master`, and
I'm running into what appears to be a regression in the behavior of the
piecewise `git add -p` when applying a manually edited chunk.

I first run `git add -p`, then manually edit a chunk (after hitting `s`
once, if it matters). The chunk originally contains the following:

```diff
# Manual hunk edit mode -- see bottom for a quick guide
@@ -20,7 +20,7 @@
 	"call dein#add('Shougo/dein.vim', {'rev': 'master'})

 	" Add or remove your plugins here:
-	" call dein#add('flazz/vim-colorschemes')
-	call dein#add('Haron-Prime/evening_vim')
+	call dein#add('flazz/vim-colorschemes')
+	call dein#add('danilo-augusto/vim-afterglow')

 	"core plugins that change the behavior of vim and how we use it globally
```

Under git 2.7.4, I can edit it to the following, which is accepted
without a problem:

```diff
# Manual hunk edit mode -- see bottom for a quick guide
@@ -20,7 +20,7 @@
	"call dein#add('Shougo/dein.vim', {'rev': 'master'})

	" Add or remove your plugins here:
-	" call dein#add('flazz/vim-colorschemes')
-	call dein#add('Haron-Prime/evening_vim')
+	call dein#add('flazz/vim-colorschemes')
+	call dein#add('Haron-Prime/evening_vim')

	"core plugins that change the behavior of vim and how we use it globally
```

All I did here was remove one `+` line and manually add another (which
is a variant of the second `-` line).

Under git 2.17.0.252.gfe0a9ea, the same piece is opened in $VISUAL for
editing (and if left unmodified applies OK), but when modified in the
to the same exact value, after exiting the editor I receive the
following error from git:

    error: patch fragment without header at line 15: @@ -25,7 +25,8 @@

I'm not sure what to make of this.

Thank you,

Mahmoud Al-Qudsi
NeoSmart Technologies


