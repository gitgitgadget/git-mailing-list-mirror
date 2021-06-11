Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D702CC48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 19:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF54A6128A
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 19:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhFKTGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 15:06:19 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:41885 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhFKTGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 15:06:16 -0400
Received: by mail-pg1-f172.google.com with SMTP id l184so3202190pgd.8
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 12:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UYMvkmuPXGWgfHXjdBfoZ+KHP/htL+kRezYMrMTIVr4=;
        b=NPYvcjkaTGxxm8mgiti0BXEaCPw7hWRQ9wIRZ+QSypxP1qfeiRP7wy48cGO3U3AnV7
         UtxU0MI0J8mPqQTuyX4UdokASr9FXb3gl0YRgIU+u56Aa4Tc1KQDo2txDSI2l5tg7dYU
         cSJv03Yk3xWdNbV2pYuNsiSk3nj8DYr0M3GYAMlerh0br0Lkhi3G6CvhbOyi+IBsJec0
         cG0T3K7qASh7aTdA+t3YOGKojFjGPm3pNhCmmuR1TN+OlQGVyhYpiSOteu/W/oi8R4QP
         fsOI6IAqwYG1ejMZOeQbhbbV03Fm2y3A61aw4xhZAvXUUS/On1hoRKvE+GvhsIicsKb1
         qWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UYMvkmuPXGWgfHXjdBfoZ+KHP/htL+kRezYMrMTIVr4=;
        b=a+RpCtifXP/tPDwht8RXYLAIXcRXl9l89hUV0oOplq9UQR8XTIr1rqZl8K1gZR3k1s
         xaZuS8tJoBNrAMaQSiiBqYujl+pAi1IH+1EUJL9wZOsvS+Oq2yMEvDEtAnsVIbbJrUdE
         UAJy1HiCeKt3ZGChVlq9s52Ad8WhGq+RQdrTWAZilsmr29x9Yo80iceuicGSKP7CBQ6p
         EwL0NkLeMZUOIambXI+D42h6S1iaSCgjVWak9/l5OH3aaxHpKVR6elO294zqI8OyD8sW
         YnhJbNnuVVaThvhXVb1mBXG+tbEql6hPMzbdGjsU7V7IiW+PlYXdmAI+tdzSwQdXGSMI
         5v9g==
X-Gm-Message-State: AOAM532MbzTSHYssjBoJHP4hcvvHhwzla3CArN7ykDX+JeHk6iHNciFs
        2c2lsu2QlrJ1CPCfjQR5IaQ=
X-Google-Smtp-Source: ABdhPJwKX6CPQ+MBf708f3wl8FQmX6DiPt0HAkLmUnKjWpQtpm5TdNarBEoiDox2wPZQT2iNVOMpbQ==
X-Received: by 2002:a65:434c:: with SMTP id k12mr5069498pgq.17.1623438187045;
        Fri, 11 Jun 2021 12:03:07 -0700 (PDT)
Received: from tiger.hsd1.ca.comcast.net ([2601:646:8d01:eb40::14a3])
        by smtp.gmail.com with ESMTPSA id w21sm6083508pfq.143.2021.06.11.12.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 12:03:06 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        David Aguilar <davvid@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
Date:   Fri, 11 Jun 2021 12:02:35 -0700
Message-Id: <20210611190235.1970106-1-newren@gmail.com>
X-Mailer: git-send-email 2.32.0.59.g86dff2990a.dirty
In-Reply-To: <60c3a41bd25e3_8d0f2089e@natae.notmuch>
References: <60c3a41bd25e3_8d0f2089e@natae.notmuch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 11, 2021 at 10:57 AM Felipe Contreras <felipe.contreras@gmail.com> wrote:

> Elijah Newren wrote:
> > On Fri, Jun 11, 2021 at 8:32 AM Felipe Contreras <felipe.contreras@gmail.com>
> > wrote:
...
> > The alternative to the above two options was the
> > make-a-virtual-merge-base-by-merging-merge-bases strategy.  It apparently
> > was very successful.
> 
> OK. That makes sense.
> 
> > But it does mean that merge bases can have conflict markers in them.
> 
> But why? And even if they do, why do they have to be diff3 conflict
> markers?

This could be changed; I suspect it just was a natural consequence of how
the code was built.  (Recursive means there's not a separate code-path for
merging the merge-bases, so they get the same merge style by default.)

> This would be more human-friendly:
> 
>   <<<<<<< HEAD
>   D
>   ||||||| merged common ancestors
>   <<<<<<<<< Temporary merge branch 1
>   B
>   =========
>   A
>   >>>>>>>>> Temporary merge branch 2
>   =======
>   C
>   >>>>>>> C

I suspect that would be as easy as this (not compiled or tested):

diff --git a/ll-merge.c b/ll-merge.c
index 095a4d820e..bdd129cbd6 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -131,7 +131,7 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 	xmp.level = XDL_MERGE_ZEALOUS;
 	xmp.favor = opts->variant;
 	xmp.xpp.flags = opts->xdl_opts;
-	if (git_xmerge_style >= 0)
+	if (git_xmerge_style >= 0 && !opts->virtual_ancestor)
 		xmp.style = git_xmerge_style;
 	if (marker_size > 0)
 		xmp.marker_size = marker_size;


> Or just put a stub conflict marker:
> 
>   <<<<<<< HEAD
>   D
>   ||||||| merged common ancestors
>   <<<<<<<<< Temporary merge >>>>>>>>>
>   =======
>   C
>   >>>>>>> C

I don't know what would be involved to do this one; I think it wouldn't
be too hard, but I don't think we'd want to pursue this option.

> Or just use the base of the virtual merge:
> 
>   <<<<<<< HEAD
>   D
>   ||||||| merged common ancestors
>   1
>   =======
>   C
>   >>>>>>> C

I think that implementing this choice would look like this (again, not
compiled or tested and I'm not familiar with xdiff so take it with a
big grain of salt):


diff --git a/ll-merge.c b/ll-merge.c
index 095a4d820e..dbc7f76951 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -130,6 +130,8 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 	memset(&xmp, 0, sizeof(xmp));
 	xmp.level = XDL_MERGE_ZEALOUS;
 	xmp.favor = opts->variant;
+	if (git_xmerge_style >= 0 && opts->virtual_ancestor)
+		xmp.favor = XDL_MERGE_FAVOR_BASE;
 	xmp.xpp.flags = opts->xdl_opts;
 	if (git_xmerge_style >= 0)
 		xmp.style = git_xmerge_style;
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 8629ae287c..b8d1a536c2 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -62,6 +62,7 @@ extern "C" {
 #define XDL_MERGE_FAVOR_OURS 1
 #define XDL_MERGE_FAVOR_THEIRS 2
 #define XDL_MERGE_FAVOR_UNION 3
+#define XDL_MERGE_FAVOR_BASE 4
 
 /* merge output styles */
 #define XDL_MERGE_DIFF3 1
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 95871a0b6e..a8dc42595a 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -313,6 +313,9 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 			if (m->mode & 2)
 				size += xdl_recs_copy(xe2, m->i2, m->chg2, 0, 0,
 						      dest ? dest + size : NULL);
+		} else if (m->mode == 4) {
+			size += xdl_orig_copy(xe1, m->i0, m->chg0, needs_cr, 0,
+					      dest ? dest + size : NULL);
 		} else
 			continue;
 		i = m->i1 + m->chg1;

> We don't have to use diff3 all the way.

Right, thus my mention in the other email to consider adding a
XDL_MERGE_FAVOR_BASE -- which you then also mention here in your third
option, and which I've now given at least a partial patch for.  Not
sure if it's a crazy idea or a great idea, since I don't do very many
criss-cross merges myself.



Hope that helps,
Elijah
