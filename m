From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv18 08/11] run_processes_parallel: correctly terminate callbacks with an LF
Date: Thu, 25 Feb 2016 15:08:25 -0800
Message-ID: <1456441708-13512-9-git-send-email-sbeller@google.com>
References: <xmqqoab4mnoc.fsf@gitster.mtv.corp.google.com>
 <1456441708-13512-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 26 00:09:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ52Q-0008RA-DA
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbcBYXJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:09:10 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35705 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbcBYXJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:09:09 -0500
Received: by mail-pa0-f51.google.com with SMTP id ho8so40884576pac.2
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qRy6K9vkCFnittZFNz4/0CDkNq424Ede/VgigJ62FX0=;
        b=JBmnMS/OxsYMfvTluhramhc6442QsZC4WteEn2ZRGmUeQOpyvDomiLZ+0Ymr6BVe63
         yHp836D1ac309NqgVL4MlHGxdVQt1aTw5QuuSAisHNq11o4+oYhM3HKl5SxMzWdl9c8w
         JdASOWQcy686s1o9RMRKDE6ULl0V3XUXztyJHSXtf5fhezNjduvYVsdNt9lq3FHXG9qa
         kCo9OxC7kqEZWIG+qFap8xwoRDSUz2XYiNOA9rFWmsNTTnNojZ+R0KVQ0LRV7zTrBjnO
         QAUoAcUINSGolzcxsn7Epj5r4J0nbCOoarH0lnlxdSpxriCncOgnsx9P/Ow/81kyq6NF
         m/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qRy6K9vkCFnittZFNz4/0CDkNq424Ede/VgigJ62FX0=;
        b=FfZbmhJIkfHJDya8RCtilUT86qU3PgTv4pJ0oPvqYDEgnUT1gEAwk+3fE9uiyD69WB
         aDCdz/LpEhTKxo5qA7nnSDPP2mHKRufarPcKNPFLnHl28zDDSFzCadXWvIEsLRTMx7CZ
         jvx0j9Apw4u8nJxG9KummksUwJ916vqBaR/1ams2tPTNpWx1DAqgWHw3yZcuwcQGfYbO
         hqJZ42f9s99PqDyAvJb6S/BfkVWj6gIaMKRfip+fK61yNuauo9GSGUpQJkw0nScqcJuV
         Skc9z0qUD/qcW1uTOzZUc7u5biftzJEodt5z7aQbFQMrXLVUi9TJZrVZrxBPxTQ0w1Us
         otGA==
X-Gm-Message-State: AG10YOQoHELSyaoh3sIEENKWDtd/d/e/Sju7fNCQEsG/JsT4PAkhQ6pan13bkJZcFjUoXhTx
X-Received: by 10.67.21.205 with SMTP id hm13mr66898183pad.56.1456441748555;
        Thu, 25 Feb 2016 15:09:08 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a893:1c03:aadb:c3d])
        by smtp.gmail.com with ESMTPSA id to9sm14555167pab.3.2016.02.25.15.09.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 15:09:07 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.36.g75877e4.dirty
In-Reply-To: <1456441708-13512-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287482>

As the strbufs passed around collect all output to the user, and there
is no post processing involved we need to care about the line ending
ourselves.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/run-command.c b/run-command.c
index d2964e1..6fad42f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -912,6 +912,7 @@ int default_start_failure(struct child_process *cp,
 	strbuf_addstr(out, "Starting a child failed:");
 	for (i = 0; cp->argv[i]; i++)
 		strbuf_addf(out, " %s", cp->argv[i]);
+	strbuf_addch(out, '\n');
 
 	return 0;
 }
@@ -930,6 +931,7 @@ int default_task_finished(int result,
 	strbuf_addf(out, "A child failed with return code %d:", result);
 	for (i = 0; cp->argv[i]; i++)
 		strbuf_addf(out, " %s", cp->argv[i]);
+	strbuf_addch(out, '\n');
 
 	return 0;
 }
-- 
2.7.0.rc0.36.g75877e4.dirty
