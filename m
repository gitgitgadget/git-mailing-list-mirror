Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0410200B9
	for <e@80x24.org>; Sat,  5 May 2018 13:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751158AbeEENYb (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 09:24:31 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:40281 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeEENYa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 09:24:30 -0400
Received: from home.lan ([86.238.54.222])
        by mwinf5d43 with ME
        id idQT1x0034nfuyW03dQT2X; Sat, 05 May 2018 15:24:27 +0200
X-ME-Helo: home.lan
X-ME-Date: Sat, 05 May 2018 15:24:27 +0200
X-ME-IP: 86.238.54.222
Received: from yann by home.lan with local (Exim 4.89)
        (envelope-from <ydirson@free.fr>)
        id 1fExAo-0004mD-T5; Sat, 05 May 2018 15:24:26 +0200
From:   Yann Dirson <ydirson@free.fr>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Yann Dirson <ydirson@free.fr>
Subject: [PATCH 1/2] Fix support for merge options.
Date:   Sat,  5 May 2018 15:24:22 +0200
Message-Id: <20180505132423.18324-1-ydirson@free.fr>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 git-reintegrate | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-reintegrate b/git-reintegrate
index a1c17d2..da45239 100755
--- a/git-reintegrate
+++ b/git-reintegrate
@@ -338,7 +338,7 @@ class Integration
   def finalize_command(cmd, args, message)
     begin
       fun = @@map[cmd] || "cmd_#{cmd}".to_sym
-      send(fun, message, *args)
+      send(fun, message, *args.split(' '))
     rescue NoMethodError
       raise Integration::Stop, "Unknown command: #{cmd}"
     end
@@ -559,7 +559,7 @@ def do_apply
   inst = inst.lines.reject do |line|
     next true if line =~ /^base /
     if line =~ /^merge (.*)$/
-      system(*%W[git merge-base --is-ancestor #{$1} HEAD])
+      system(*%W[git merge-base --is-ancestor #{$1.split(' ')[0]} HEAD])
       next true if $?.success?
     end
     false
@@ -621,7 +621,7 @@ def do_status
     when 'base'
       $status_base = args
     when 'merge'
-      status_merge(*args)
+      status_merge(*args.split(' ')[0])
     when '.'
       status_dot(*args)
     else
-- 
2.11.0

