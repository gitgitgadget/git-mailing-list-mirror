Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F07C433FE
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 12:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6AD61039
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 12:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbhJKMUP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 08:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbhJKMUN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 08:20:13 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7530CC061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 05:18:13 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t4so22579808oie.5
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 05:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3W3D3dA+AiII24jd7FbmNZvEeWF3FUDdsrfvTSRu9R4=;
        b=NIhzwKzgkVY9BZoRLtTCGk/IowOX83l0SXzRw5unjomhuR2V7NEIFJT45YHch37raQ
         DWAWv1YrLpT9Gq9hh7+7Amh5ILtGsRQH73jwVqQWPN9OsWh7HUEwK9V1vb+wE7RuUdDz
         bLi23Yz+MeTth7C1KYhylFJ1IvmJLv1uEOmGjvUK7xZxrxqPLpUNEq4S2/nkdOPH4hDZ
         oRgAE7Jnk5MdxyrsIQLTQWB42orFzhqTEy1GXij23j4ZTK7K+AlhgQIig8Heab3ClpW2
         P8RhsrjX8TJKzF/A8mabHnJ0lYcw9E44WmPTVMje+2orf6EzFcQTFGAX75gm8OXUQBLq
         Kqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3W3D3dA+AiII24jd7FbmNZvEeWF3FUDdsrfvTSRu9R4=;
        b=Yvkof2na7eQAAfCjW+Rbud/dKsGxuldynFJ71gOGNX0vNZhCeHdfHMaHnvfy1Py/U2
         28/wxoWB6/ZtaF6iN0RtiCijX2n4a4VfrRUQ9e3osTYO8uTakA83BqI6DMi+U15kL1aU
         zZxhT7vUm7oYxgrrJi1Jeg5yti1GHKRQo8QNS5QErFXO8eUp/cOogPYXc0a2FECZp2NH
         QYhy602TYbkizMiE7/FGhgJ+/ls9+FQ9KWvSf6Mx0eCKm+fUgZEsdYAidytO69fv9Sva
         PZ7Yvm8l1C6MYls7HBgfMp0/A5C9oa+Soaum1xW7A3cIKhJTdF3yazrgGDPkO1hN0G/0
         o/OA==
X-Gm-Message-State: AOAM5324DZIrvJCqNNVDuCbZBdLOKwe132OuDAAERgVwfZJrjXe0Fzhm
        KizfllfyyAsljdwG/4MimoHYieKTjAunCQ==
X-Google-Smtp-Source: ABdhPJzWVql50f4/8VBtLLISudzYndFICOkjXTWiOqKl73afmyFhq2UNzysusQF+WOpkYpAPkM8ihg==
X-Received: by 2002:aca:dfd5:: with SMTP id w204mr26649743oig.161.1633954692675;
        Mon, 11 Oct 2021 05:18:12 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id u21sm467892oiv.25.2021.10.11.05.18.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Oct 2021 05:18:12 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     angavrilov@gmail.com, me@yadavpratyush.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH 4/4] track oid_size to allow for checks that are hash agnostic
Date:   Mon, 11 Oct 2021 05:17:57 -0700
Message-Id: <20211011121757.627-5-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.1081.g099423f5b7
In-Reply-To: <20211011121757.627-1-carenas@gmail.com>
References: <20211011121757.627-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows commit to work.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 git-gui.sh     | 5 +++--
 lib/commit.tcl | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index c0dc8ce..1646124 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1821,10 +1821,11 @@ proc short_path {path} {
 
 set next_icon_id 0
 if { [get_config extensions.objectformat] eq "sha256" } {
-	set null_oid [string repeat 0 64]
+	set oid_size 64
 } else {
-	set null_oid [string repeat 0 40]
+	set oid_size 40
 }
+set null_oid [string repeat 0 $oid_size]
 
 proc merge_state {path new_state {head_info {}} {index_info {}}} {
 	global file_states next_icon_id null_oid
diff --git a/lib/commit.tcl b/lib/commit.tcl
index 11379f8..1306e8d 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -337,6 +337,7 @@ proc commit_committree {fd_wt curHEAD msg_p} {
 	global file_states selected_paths rescan_active
 	global repo_config
 	global env
+	global oid_size
 
 	gets $fd_wt tree_id
 	if {[catch {close $fd_wt} err]} {
@@ -356,7 +357,7 @@ proc commit_committree {fd_wt curHEAD msg_p} {
 		close $fd_ot
 
 		if {[string equal -length 5 {tree } $old_tree]
-			&& [string length $old_tree] == 45} {
+			&& [string length $old_tree] == 5 + oid_size} {
 			set old_tree [string range $old_tree 5 end]
 		} else {
 			error [mc "Commit %s appears to be corrupt" $PARENT]
-- 
2.33.0.1081.g099423f5b7

