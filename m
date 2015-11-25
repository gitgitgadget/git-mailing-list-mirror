From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 1/9] run_processes_parallel: delimit intermixed task output
Date: Tue, 24 Nov 2015 17:14:48 -0800
Message-ID: <1448414096-22021-2-git-send-email-sbeller@google.com>
References: <1448414096-22021-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 02:15:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Ofs-0000qN-QE
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 02:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063AbbKYBPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 20:15:07 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33585 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190AbbKYBPE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 20:15:04 -0500
Received: by pabfh17 with SMTP id fh17so40372816pab.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 17:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sjp64pdBW2kqrC25Tlxi9bxtSb7+LfBZy6hPVMYquro=;
        b=F5i8gGfwbVnLbPOC7+WPW0UfHWrHzr7nzNZwtRkjyyuvgC667a8cY8nMr9mPnW0lFc
         d9izo9cGAuvmLp5FYKn+82O3gDbNhHQnvkI7OtLgY+qr7fbX0W2ZHxDAZXttJw1JgSFs
         O6yZEWYoA2tch+axkVjkHYCLcXz25opi/W3QIqsJGbq716x/enHVk9j1eSS+sTz/vXjb
         fh6vMgEn0zFzC1L/iXtwuJPvzKVY0z1iwoooN0ssDZEf8II8yhqw131U2BuWdpNF3rqE
         W5+ydJIcCmVwF+F/gZbsydY2WLdHjkokqds4ju9nQK5b6cm3HTipAjl4u28vbtn5EkHf
         qvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sjp64pdBW2kqrC25Tlxi9bxtSb7+LfBZy6hPVMYquro=;
        b=IilxaPf0WD3h8nP6NuZC8XsoWXCnmOB9vgL0evFgA0kxIO8ULu/5aDEv0sGrHwCRM6
         8oUSLTBl0Somo8n/ui5qFcifYCdg/RuaE/WmpRjdDvU0D36bJ5JKMKYqnMhovgInydVB
         Vw4orjxg0GjNE9SYbrV2SVLxvS0IHg9wwO0OZ/goeHJFDsOlCFqVGqm9+7LLCUaAyFzx
         6ZlSRx76+dPx3bWC6voMPeQhewqOrSxrl2q4GjaGXpy55V+ksklySZRnQzRlUN+VThKJ
         DEEC9qHmGzKawMEopGPBw/pMLTbqvnyveuZCXabOBfj0WzgRawWGUUVr2VEAgW1GKtBT
         oLYg==
X-Gm-Message-State: ALoCoQnxOJQ1H6wVGPPdiQbJG2U43MH7CGXDd5kWDvgF8CBmoOaYHrFXar2D6mhI3z48jAdOr/mv
X-Received: by 10.67.30.227 with SMTP id kh3mr46891897pad.69.1448414103652;
        Tue, 24 Nov 2015 17:15:03 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5407:71cc:c14:4343])
        by smtp.gmail.com with ESMTPSA id 68sm9094058pfq.37.2015.11.24.17.15.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 17:15:03 -0800 (PST)
X-Mailer: git-send-email 2.6.1.261.g0d9c4c1
In-Reply-To: <1448414096-22021-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281659>

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
index 358429f..b246118 100644
--- a/run-command.c
+++ b/run-command.c
@@ -965,6 +965,9 @@ static struct parallel_processes *pp_init(int n,
 		n = online_cpus();
 
 	pp->max_processes = n;
+
+	trace_printf("run_processes_parallel: preparing to run up to %d tasks", n);
+
 	pp->data = data;
 	if (!get_next_task)
 		die("BUG: you need to specify a get_next_task function");
@@ -994,6 +997,7 @@ static void pp_cleanup(struct parallel_processes *pp)
 {
 	int i;
 
+	trace_printf("run_processes_parallel: done");
 	for (i = 0; i < pp->max_processes; i++) {
 		strbuf_release(&pp->children[i].err);
 		child_process_clear(&pp->children[i].process);
-- 
2.6.1.261.g0d9c4c1
