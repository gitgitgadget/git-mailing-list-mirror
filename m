Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41FBC433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 12:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8893E61038
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 12:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbhJKMUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 08:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbhJKMUM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 08:20:12 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7470C061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 05:18:12 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id n15-20020a4ad12f000000b002b6e3e5fd5dso1596904oor.1
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 05:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a/c4bmdwgJ6ap7j3aJxgG1DkJOZvDQgRa6ATBuQQ0PM=;
        b=FzGmO/36oNwdNBV7tmKjLk+ZoUTx+47z2H6N+xDOiDxXBX1djcGKznLpm5RnuML23v
         3aK7qBxC+ohIdil9rATzrgFecg1dWMS61O5Wl1YjIvpGssTjZLr+Jx8LCSdq6sXB3YZm
         0hX4qMcV06ybixLNe0ezM8qhP+OeKYS2CAFmqlcmPHxLKqfvd0NWvoZKp/C+xLKyPKiS
         g/7jcoNUV21B2sIz1PXsOjZhlmbWfmDKdCxPCEZ3ukSzAeQ/VpyP033q0Vi9yck3mkn8
         DjbQgU78S46F4/sOCr6PGXs1MC3ZgPTSPVe8jOJ2NxvFd1XlR6mrrWFAhYvqjaJahcAg
         6pUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a/c4bmdwgJ6ap7j3aJxgG1DkJOZvDQgRa6ATBuQQ0PM=;
        b=rL6DSnkZYxfdEFEt232iC23oKxoNcuwXQfZZbu3+wlQ6BTxHbURlM9frKXQUVqMOV5
         OYPEkHQ5kATINdZKu/SuRCgmZuFDxmYwlngoNXJQK2MzLK/olbwmKHKg3wPuNYo+jd9Q
         gKAN8/iWKeqAxqx8FUdVKiTr32VGAOiv1u5OU5DxZxkkXDVEroavTG5nIvDB5Pi0SJXD
         rOHYLtfw4OABNNwHrcY7ZIjgMbN81DVPFYHHmSK37odVuMk/khoW/1SQ+EV0Q1ysysse
         Fc2mn6vEq2oUbOyRmJFUo7Ki2JFHGiA7g1cB71jOU2qC6a/54lbbJfg3j+jzVmhqKQpz
         o0MQ==
X-Gm-Message-State: AOAM533N6fRbSmx/sK79v2tY8mL00AsJzskvFW8E7Hy+ra2jQeGpelRF
        1mUdnqk9xteDh4T9p8bkHHlRiL6sat92ZA==
X-Google-Smtp-Source: ABdhPJxklYzvUG1FBpVtB1oO7+uRRwq2peJrwXGyRA40gQBRPAPJv269K2mn00Ki2DS/8zhnC0pPBA==
X-Received: by 2002:a4a:4006:: with SMTP id n6mr9715868ooa.73.1633954691803;
        Mon, 11 Oct 2021 05:18:11 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id u21sm467892oiv.25.2021.10.11.05.18.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Oct 2021 05:18:11 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     angavrilov@gmail.com, me@yadavpratyush.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH 3/4] expand regexp matching an oid to be hash agnostic
Date:   Mon, 11 Oct 2021 05:17:56 -0700
Message-Id: <20211011121757.627-4-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.1081.g099423f5b7
In-Reply-To: <20211011121757.627-1-carenas@gmail.com>
References: <20211011121757.627-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before this change, listing or blame will fail as it couldn't find the
OID in an SHA-256 repository.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 lib/blame.tcl                | 8 ++++----
 lib/choose_repository.tcl    | 2 +-
 lib/remote_branch_delete.tcl | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/blame.tcl b/lib/blame.tcl
index e6d4302..ee7db9d 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -436,7 +436,7 @@ method _load {jump} {
 			$i conf -state normal
 			$i delete 0.0 end
 			foreach g [$i tag names] {
-				if {[regexp {^g[0-9a-f]{40}$} $g]} {
+				if {[regexp {^g[0-9a-f]{40}(?:[0-9a-f]{24})?$} $g]} {
 					$i tag delete $g
 				}
 			}
@@ -513,7 +513,7 @@ method _history_menu {} {
 		set c [lindex $e 0]
 		set f [lindex $e 1]
 
-		if {[regexp {^[0-9a-f]{40}$} $c]} {
+		if {[regexp {^[0-9a-f]{40}(?:[0-9a-f]{24})?$} $c]} {
 			set t [string range $c 0 8]...
 		} elseif {$c eq {}} {
 			set t {Working Directory}
@@ -635,7 +635,7 @@ method _read_blame {fd cur_w cur_d} {
 
 	$cur_w conf -state normal
 	while {[gets $fd line] >= 0} {
-		if {[regexp {^([a-z0-9]{40}) (\d+) (\d+) (\d+)$} $line line \
+		if {[regexp {^([a-z0-9]{40}(?:[0-9a-f]{24})?) (\d+) (\d+) (\d+)$} $line line \
 			cmit original_line final_line line_count]} {
 			set r_commit     $cmit
 			set r_orig_line  $original_line
@@ -648,7 +648,7 @@ method _read_blame {fd cur_w cur_d} {
 			set oln  $r_orig_line
 			set cmit $r_commit
 
-			if {[regexp {^0{40}$} $cmit]} {
+			if {[regexp {^0{40}(?:0{24})?$} $cmit]} {
 				set commit_abbr work
 				set commit_type curr_commit
 			} elseif {$cmit eq $commit} {
diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index af1fee7..e864f38 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -904,7 +904,7 @@ method _do_clone_full_end {ok} {
 		if {[file exists [gitdir FETCH_HEAD]]} {
 			set fd [open [gitdir FETCH_HEAD] r]
 			while {[gets $fd line] >= 0} {
-				if {[regexp "^(.{40})\t\t" $line line HEAD]} {
+				if {[regexp "^([0-9a-fA-F]{40}(?:[0-9a-fA-F]{24})?)\t\t" $line line HEAD]} {
 					break
 				}
 			}
diff --git a/lib/remote_branch_delete.tcl b/lib/remote_branch_delete.tcl
index 5ba9fca..57bae9c 100644
--- a/lib/remote_branch_delete.tcl
+++ b/lib/remote_branch_delete.tcl
@@ -330,7 +330,7 @@ method _read {cache fd} {
 
 	while {[gets $fd line] >= 0} {
 		if {[string match {*^{}} $line]} continue
-		if {[regexp {^([0-9a-f]{40})	(.*)$} $line _junk obj ref]} {
+		if {[regexp {^([0-9a-fA-F]{40}(?:[0-9a-fA-F]{24})?)	(.*)$} $line _junk obj ref]} {
 			if {[regsub ^refs/heads/ $ref {} abr]} {
 				lappend head_list $abr
 				lappend head_cache($cache) $abr
-- 
2.33.0.1081.g099423f5b7

