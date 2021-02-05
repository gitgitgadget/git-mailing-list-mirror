Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766B6C433E9
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 01:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34CE464FC0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 01:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhBEByM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 20:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhBEByB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 20:54:01 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EA2C0617A9
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 17:53:12 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id ew18so2770352qvb.4
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 17:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+vpPRYj1kIBITg9x5/nAr9RtnoYhTQZmZ5WLgibZWCw=;
        b=jgYAZP2U97jCs+VcXWwtOPxkfPhEvl4k9sw08HsFYaWwRQbnWi6+7ZR9wK+pnBzvP7
         zN+0aECkQYrdFr6RkKAFozjMz9/H3slaSmFggjkMcPJgxKv/AWiRkO+VmoxvJ8zUwE3o
         KT5JGRFzFliwxBeLflYj1vIaWZ3lL0sg/CPWzDoSp1HHGrxs0d67BVAL3d99xunSaekf
         RT8tioktG+JhRzKvNr4elJWl7FRCVtRd9ipTagLdtGE6OYNnS/Pg33xhoJqO6kD0zytW
         BoAVnUtrGV4ude9bIjycpo/FMR83cHeFZgmMUSchNC2/hG2T/mGMfPLWy/t7joxQmH0w
         K2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+vpPRYj1kIBITg9x5/nAr9RtnoYhTQZmZ5WLgibZWCw=;
        b=p+lzVCCgDQf0LY+yqM6kHkhMVkGWsiiVyPMZaqeDtORXXcp3tevFqgnbEstiwteQVk
         TyGtj/xUUZlZpMgL7zso/aRQmj5PQArNK4HDS2kKmosCxAZNpnJuqvULzAWpoVV7Wj07
         qgFO9LjXFZ1CFmi/YcEiILVuA6FUYMBrBPj/AVA59V6lSWANkoJLqDiNIDs2gLfYETo2
         VG008OnrpI/vTcPdeGSW27cLie68hT0zR3i1AuKsWN40WqAAemg410dOe4zYd9FLaX8N
         hXZJMLYxqEhnCL2lWmceZitJF1IfVtNT0g2WozJhw6IMGtrR3HfgczFqc75hJvT7XpPX
         6MWQ==
X-Gm-Message-State: AOAM532YPwdz6koxeoy3fMlyO4+2kPJxI3r/A07xideNUIpMADOorl3N
        V330xadAGeTj57hqzMc2Mko1zw==
X-Google-Smtp-Source: ABdhPJxPr8H4Ks2P59NLGceDAqhh1jO+mZUCjTiHaOpUOlf/NuvkuxFEKpppPl9EsA6g/F72/0aQGQ==
X-Received: by 2002:a0c:a905:: with SMTP id y5mr2380857qva.55.1612489991359;
        Thu, 04 Feb 2021 17:53:11 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:d1cf:24a5:841d:d52b])
        by smtp.gmail.com with ESMTPSA id h12sm6495177qko.29.2021.02.04.17.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 17:53:10 -0800 (PST)
Date:   Thu, 4 Feb 2021 20:53:08 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [rfh] where is coccinelle these days on Ubuntu?
Message-ID: <YBylBKMG4G4dbiOW@nand.local>
References: <xmqqeehv2t71.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeehv2t71.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 04, 2021 at 05:34:42PM -0800, Junio C Hamano wrote:
> This is probably something that is very obvious for GitHub folks or
> a debian person, but does anybody know what made it suddenly wrong
> that we have been doing to obtain coccinelle?
>
> https://github.com/git/git/runs/1835560289?check_suite_focus=true#step:3:108

Not obvious to me, but I did happen to notice it last night when waiting
on some workflows to finish on ttaylorr/git.

From a quick search, it looks like coccinelle was moved to the
"universe" repository, at least in the Azure mirrors (which is what
GitHub Actions uses):

    http://azure.archive.ubuntu.com/ubuntu/pool/universe/c/coccinelle/

I just pushed the patch below the scissors line to my fork, and I'll
watch the static analysis build to see if it works again:

    https://github.com/ttaylorr/git/actions/runs/539049631

--- >8 ---

Subject: [PATCH] ci/install-dependencies.sh: install coccinelle from universe

The apt package "coccinelle" moved to the universe repository in the
package mirrors that are used by GitHub Actions. This causes
coccinelle to be reported as missing, since it is no longer available in
the main repository.

Since universe isn't sourced by default, add it as an apt repository
before updating and installing coccinelle.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ci/install-dependencies.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 0b1184e04a..0350538d52 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -61,6 +61,7 @@ osx-clang|osx-gcc)
 	esac
 	;;
 StaticAnalysis)
+	sudo add-apt-repository universe
 	sudo apt-get -q update
 	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
 		libexpat-dev gettext make
--
2.30.0.667.g81c0cbc6fd

