From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv20 08/12] run_processes_parallel: correctly terminate callbacks with an LF
Date: Mon, 29 Feb 2016 11:14:06 -0800
Message-ID: <1456773250-5510-9-git-send-email-sbeller@google.com>
References: <1456773250-5510-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 29 20:14:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaTH8-0005dx-D9
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbcB2TOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 14:14:30 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33627 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbcB2TO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 14:14:28 -0500
Received: by mail-pa0-f41.google.com with SMTP id fl4so96788808pad.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 11:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h79VfNJAobJyaKk37rfWxfRMLyQPUGADCv0Cf0rwKrk=;
        b=R4Rujc0klAy48p2zxLf8T5/SmseSQ2BkBxgFdhmvwG4Q7dExIflVgvo2qm/9a+xe6R
         FWamd/Bm8ZXDbk0Ex7Dt3ZRwAWVH/m07B6qo9NjBfHy9XEXUZEeouG4V0DsTBicHudpD
         MFlV0IbEOY4oaks8vlh4jrfFoq4l9AYAzz30LPkIi+dgTco7pwGmYWvqGSr29oRmYx7R
         SRMqhdx6LYCIrj2HDlKfr78gSbiuSg04SXGV6m6Ee79mUlPHAKYtnBz/LyaZhAjwKaCt
         bQmwwLvZvjWsRAE8lOdILKCjg3CYqARCnwpN1dPS0XZmtTL6jdCzF+6/clreH6U5gaTI
         sVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h79VfNJAobJyaKk37rfWxfRMLyQPUGADCv0Cf0rwKrk=;
        b=TtN/PlSIR0b+JmARwn4QQzjzNR1XFP9jVuzGbGo65UxyA9xkQt37XCIEYY9oc0bVLM
         Qu3W2eoe6YyE7IbDM25ve+dWxQZEmr0NRz25UisK4uwkBk8l7Bfkts214C6BItJ0z+RC
         4grKJGxVjDtKh88o6H1VVbk21iL5SJlB8EwYj5HEVrSG4am7FvPxhACjCl04UxTSvzUB
         OxzSiNsN1pMjgzKPKRNonmcLFiNxo+kd0asDLApaFALxPKuiGGvI4Iyz8u9SXcErw8gp
         Dn91sP8ZNGKo4qLdGEyOqgFCyOVqkfVUHYbOmU3ISWKgj8DriYL64yWIrmgOZ5sMOnDQ
         BQgg==
X-Gm-Message-State: AD7BkJJ8j7pQSTffRi0ZgIMzmbH48ra4HBbhhmWVOMtJjSRmpsJdmzFZUbWb67KTzFgSSDS2
X-Received: by 10.66.62.169 with SMTP id z9mr24002404par.139.1456773267493;
        Mon, 29 Feb 2016 11:14:27 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id wx3sm38331672pab.25.2016.02.29.11.14.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 11:14:26 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.37.gb7b9e8e
In-Reply-To: <1456773250-5510-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287876>

As the strbufs passed around collect all output to the user, and there
is no post processing involved we need to care about the line ending
ourselves.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.7.0.rc0.37.gb7b9e8e
