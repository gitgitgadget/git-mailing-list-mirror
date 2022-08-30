Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66854ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiH3Jcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiH3Jc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:26 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88075A6AC9
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:11 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-11f11d932a8so6967252fac.3
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vISy3uR92Ws5Lgv961BLrAugQCJgxovBDOxDeoem3FE=;
        b=EoERlk8CnzJysXIs/trLnkUByMYovsUtyOg0ahsVyiUTL9sdt2s887QdFu4xdDLiOP
         RhcljnmtP+6TmDNTQXAmkkDIcDCH528MGj+mlpaYfH7tlBcuVYxRnvZgw4DxOUWXjbM9
         3A/d10mqKYokvusLlzPGMTp8qxWuWBDLadkcH1FKRwYVCeDZTD4NinYBLBDnwbwQwrWg
         3EXmlCRjb8Tytas2OzrhbB/jfg142dL0k4AGxvMSHfM9MQVndMGdGdL0vmKA3WaQkSgZ
         EefS9iCIlFRKxm7u9Iq5WLgWdvMLqlb9ERCDexAxNPmCgPwN0Xx1OQuRINQkeIqQyWu4
         IsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vISy3uR92Ws5Lgv961BLrAugQCJgxovBDOxDeoem3FE=;
        b=gQOiuOWU4UglzgSksBqv+EkXivoNKEUKLU3foGhEv9thtglZG5R6TDYIM12dp2N6Aa
         3yD0JShyIoZl90Ti/RGbB/epcjsOlu9bapQJD2uHXdT9Fi2Mz5zfbnmwFdK2K8QLwlLz
         xcPb7Qh0StS86lxCuBzJ3bPNr2aBhbaZHLoOUJfd1DEXXagsP1TADRj9sJc7p6031i9c
         nrBnYVrD4RyL/aJ73exqZD8e9pMX0kckzKlcnxKWZ4sg/3xG+ch7bhBJA8QWtk2zAe9O
         87q1EDSAT3bOZeWv+IkrCaAJZb9HwAqDBwtfIu2VypBcQUukBG4X+VZMByanQ/Dil5oq
         LEew==
X-Gm-Message-State: ACgBeo1qgLPF3Nt6+gbuTXRPXOfanKt6QtCT42GEgh+1YjizWjr0V2Sc
        eeAlO6ajJErqU/Ksf2nzZUUTzJE8pcg=
X-Google-Smtp-Source: AA6agR6z8GagKY0IesMmys09t2fVSfVTOe94R7K8Sdrtxs9Q62GKbwiSU9hgN8lKiV/vYS0wGOE3dA==
X-Received: by 2002:a05:6870:9613:b0:10d:cc11:62ec with SMTP id d19-20020a056870961300b0010dcc1162ecmr9688047oaq.9.1661851926693;
        Tue, 30 Aug 2022 02:32:06 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id y64-20020a9d22c6000000b006369d5d6372sm5986187ota.50.2022.08.30.02.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:06 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 16/51] completion: bash: remove non-append functionality
Date:   Tue, 30 Aug 2022 04:31:03 -0500
Message-Id: <20220830093138.1581538-17-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no point in setting COMPREPLY only to override it later, and in
fact... we don't do that.

Therefore there's no functional difference between __gitcomp_direct()
and __gitcomp_direct_append(), since __gitcomp_direct() *always*
operates on empty COMPREPLY.

The same goes for __gitcomp_nl().

This patch makes the functionality of append and non-append functions
the same.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ef0b7aa192..6571dc1b2d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -312,7 +312,7 @@ __gitcomp_direct ()
 {
 	local IFS=$'\n'
 
-	COMPREPLY=($1)
+	COMPREPLY+=($1)
 }
 
 # Similar to __gitcomp_direct, but appends to COMPREPLY instead.
@@ -464,7 +464,6 @@ __gitcomp_nl_append ()
 #    appended.
 __gitcomp_nl ()
 {
-	COMPREPLY=()
 	__gitcomp_nl_append "$@"
 }
 
-- 
2.37.2.351.g9bf691b78c.dirty

