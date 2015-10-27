From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/9] run_processes_parallel: Add output to tracing messages
Date: Tue, 27 Oct 2015 11:15:47 -0700
Message-ID: <1445969753-418-4-git-send-email-sbeller@google.com>
References: <1445969753-418-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 19:16:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr8nP-0003IA-Rr
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 19:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbbJ0SQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 14:16:25 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34052 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964938AbbJ0SQE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 14:16:04 -0400
Received: by padhk11 with SMTP id hk11so229738884pad.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 11:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=anK7oEUquYap+Xmnftn83DHHJKZArjioRMSqso+2Vt0=;
        b=CIaDsuQrSy4byE3RGnCf0iwDLApAGTLkrxx5/wXSLOxuKGkWFYA0jBZtLPMEON3D3P
         11Z0to0qXofC0R1C7Y64TFUrrD37sAPJ2jcbSeEWNTKqL92txdQa6HM7WVBlZzUq3Jcw
         Gv6tlNT2j1rwBfv19N4IVCQipLPalZp5SYVG+VSvxs7fSJ14lt6fo7teFQWPgGGKBGiW
         KLDKpGkM0nEMl7wO5DSsFG0TbunoypGB1fyvw5jblHTBaycrmcUl+tNy3hvPt1Uqyga5
         MH4Zku379xMS7ymHjMqdNG6PRy4a+mbw1mDgc18ZGWb0meJn8v0Ki30KKzyYtOqMyunf
         SGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=anK7oEUquYap+Xmnftn83DHHJKZArjioRMSqso+2Vt0=;
        b=jmMs5q7yjNGKwH9ANvOyh7WeN5FlM3a9RabTaMlMF4T2NqGumPE8t/tU/CW/z7uTd2
         Dp94ee0IFoZEfi48j0qgHDUw0igJVoIdaLwljhs7rp1RfS2kFCJoXOemqcsTU8ZoVVjR
         hrJO+IOzRsJH1g0NQjVDshftSbiNSWqti/usFsDTLBsIMAlIXAWIubqTy3do7EMZa4fM
         4ynEax0zp9tYG2FjdJ9sW5+aide0sN6QfeE27h6Np6d6bNwLg6IivPis+jfF+qiusAvU
         edpILQJK4gkplbH5dUlzCTxpE/WUXVzxRAGrbeHMNi5x2gjJ/KB3oWhv1uMXmylQgdCr
         zb3g==
X-Gm-Message-State: ALoCoQnG4Bcg38D/Pitweig68MImDXXZu5kYCPYS2gPsI5KffXJDIWGkAljdzgOgJwK+2asf+yVj
X-Received: by 10.68.225.41 with SMTP id rh9mr29736979pbc.116.1445969764317;
        Tue, 27 Oct 2015 11:16:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:582c:77b:3135:2d26])
        by smtp.gmail.com with ESMTPSA id sz9sm41001659pab.13.2015.10.27.11.16.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 27 Oct 2015 11:16:03 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.283.g1a79c94.dirty
In-Reply-To: <1445969753-418-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280279>

This commit serves 2 purposes. First this may help the user who
tries to diagnose intermixed process calls. Second this may be used
in a later patch for testing. As the output of a command should not
change visibly except for going faster, grepping for the trace output
seems like a viable testing strategy.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/run-command.c b/run-command.c
index 1fbd286..9ac2df5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -949,6 +949,9 @@ static struct parallel_processes *pp_init(int n,
 		n = online_cpus();
 
 	pp->max_processes = n;
+
+	trace_printf("run_processes_parallel: preparing to run up to %d children in parallel", n);
+
 	pp->data = data;
 	if (!get_next_task)
 		die("BUG: you need to specify a get_next_task function");
@@ -978,6 +981,7 @@ static void pp_cleanup(struct parallel_processes *pp)
 {
 	int i;
 
+	trace_printf("run_processes_parallel: parallel processing done");
 	for (i = 0; i < pp->max_processes; i++) {
 		strbuf_release(&pp->children[i].err);
 		child_process_deinit(&pp->children[i].process);
-- 
2.5.0.283.g1a79c94.dirty
