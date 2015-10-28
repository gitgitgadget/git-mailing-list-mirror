From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 1/8] run_processes_parallel: Add output to tracing messages
Date: Wed, 28 Oct 2015 16:21:37 -0700
Message-ID: <1446074504-6014-2-git-send-email-sbeller@google.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
 <1446074504-6014-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 00:22:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zra2h-0002sU-TI
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 00:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756366AbbJ1XWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 19:22:04 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:32838 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756013AbbJ1XWB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 19:22:01 -0400
Received: by padhy1 with SMTP id hy1so14338390pad.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 16:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0lA2AhCC+iev/ECmbbiib0LUaTVGegbc2UCyIDsH/2g=;
        b=LYA9srXf8yo0c2FeGi/uI0lCRrpVhMlATiVWAw0hjfAbvSW8PG+DuuY0qLgSiyitwx
         EggSn58v22p9KzmYOK6E0FQWbIuoFzLwco2ZhRUtFZnixZfLQRUUOnbD89DaE4g+bgrC
         gfKcQk6756tlPC6IE/1IowIPSIWYiL/BmjzavDjBiKe3w51ZXSoik1H00hepcCsCpRv6
         lTmd9JTpzX0tKbt6wkvi9Dvk2BPO77ZFfisxDp5claCsj7QTJO+es6uNC9sGLrELh5V1
         uibB4asLelDVpG7LIj9TF9OjLim13DJsju8SuI1Hy01DrUYqyJ996yMjdPbATSklyuyl
         YRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0lA2AhCC+iev/ECmbbiib0LUaTVGegbc2UCyIDsH/2g=;
        b=IybCitjDSImFgi3IU6dHYjNZeNSWsacbofLeUJhLbTJFsxxVQen2MwX6sTJUAcmYpg
         IQ/MGE+/dfOq5gisbuDt8Bw+yAzkAJyLcqxiUgL7ehDS0RnahQBt+VboJEn6ZICHRmJ2
         0YGqdAZRIhMDwzIpzD3LGxgQReDiiQkIQPRmi8JpI/HpIyo1c7idvHMNDtPS3/e+Mb53
         TsZ6q27U0Vsz7AypJUjzNKFSAr++Ge4y28iiwxSB7UksXShHx74/Xe270CuP0FKrnDI4
         NjxxMWkiZ/WTglSCV9S/Pi02KHpX3kg3qCWuevVqFcPN5vxVvi+lMQVq19w1aurY6vpC
         wGXQ==
X-Gm-Message-State: ALoCoQnR8n61faWXLH1GvTGka6neJJJ35xtZVLHasjZk319ZHc8KSpYSVLBGvk3goXK1/2aPAe2s
X-Received: by 10.68.90.3 with SMTP id bs3mr11495140pbb.49.1446074520601;
        Wed, 28 Oct 2015 16:22:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:202f:ecb0:ea3e:b8f7])
        by smtp.gmail.com with ESMTPSA id rm10sm34590276pbc.96.2015.10.28.16.21.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 Oct 2015 16:22:00 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.281.g4ed9cdb
In-Reply-To: <1446074504-6014-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280422>

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
index 82cc238..49dec74 100644
--- a/run-command.c
+++ b/run-command.c
@@ -959,6 +959,9 @@ static struct parallel_processes *pp_init(int n,
 		n = online_cpus();
 
 	pp->max_processes = n;
+
+	trace_printf("run_processes_parallel: preparing to run up to %d children in parallel", n);
+
 	pp->data = data;
 	if (!get_next_task)
 		die("BUG: you need to specify a get_next_task function");
@@ -988,6 +991,7 @@ static void pp_cleanup(struct parallel_processes *pp)
 {
 	int i;
 
+	trace_printf("run_processes_parallel: parallel processing done");
 	for (i = 0; i < pp->max_processes; i++) {
 		strbuf_release(&pp->children[i].err);
 		child_process_deinit(&pp->children[i].process);
-- 
2.5.0.281.g4ed9cdb
