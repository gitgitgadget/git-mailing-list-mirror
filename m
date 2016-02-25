From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv19 08/11] run_processes_parallel: correctly terminate callbacks with an LF
Date: Thu, 25 Feb 2016 15:48:36 -0800
Message-ID: <1456444119-6934-9-git-send-email-sbeller@google.com>
References: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
 <1456444119-6934-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 26 00:49:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ5ea-0008Ca-VT
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbcBYXtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:49:00 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33812 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbcBYXs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:48:58 -0500
Received: by mail-pf0-f181.google.com with SMTP id x65so41123397pfb.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qRy6K9vkCFnittZFNz4/0CDkNq424Ede/VgigJ62FX0=;
        b=a6Dp9KwgJc6M57kCSZcq6AF+wBCMzdoDyoTRjMm4JfDozXJ3S7UhiD5B6hjMrth+35
         Xk7Jy4/KVekbrAl7qANoSWM3b6bnC/mVymuPgZV0+33U0YLMo5EgA31ibOi0yVtYzgwJ
         4xYyeK7wGE5Hgt0cJBYcqtNdv6RXF5NfMwBt/sQqPArG4HD2nvXe83B62ewLePkAtn7d
         OLMMispDXJCFWFP/PjI6eCzmrNZew9ZaD22iwqa4Nspse4Rr/ybrbBXfCNyJR+IaBxfn
         QMa2cNQJRyFVMbFPrjjziiC3CZaaYvSrEF62WKKukMYW8QZIugY2V7N4D92dgTP50NMj
         s1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qRy6K9vkCFnittZFNz4/0CDkNq424Ede/VgigJ62FX0=;
        b=SqIOvf+x2wH+RUtGosg5/MypyzS8P5E0F2gjxWdnfUbLJ+3bkE+IISA3zofhFxicra
         TCiAJgrzu1olLsEj/vovgcHldgxsTBF0kfZ3J8IF5S/Xwbp1Ox3QslddGPEuVafxy5+S
         WyHfDQ4VYPd06PbtrD/CyjFaKQvQ713VX9H1fqkMNhyKl4Gp47oAvqYgzXrCiIk0WodY
         7U2AYrpKCDTLJJDuGshe924bCOe+jv7lfGcLNUkXVh19x74drfJZTcQD2z/2it45nCcu
         p7iM1zsWqNzKR6zhuFcUQNKsgy93RAXHqj1j8DXZO4sDWYdCSom8smoK72SkmPttx1Ct
         V+Ug==
X-Gm-Message-State: AG10YOQJiAXZAH2EDUoeeKJVLJzFR8c964menLFFXe948ZShe/TSmoc48IevlR1FEm4tbig5
X-Received: by 10.98.42.8 with SMTP id q8mr66308010pfq.13.1456444137649;
        Thu, 25 Feb 2016 15:48:57 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a893:1c03:aadb:c3d])
        by smtp.gmail.com with ESMTPSA id cq9sm14617713pac.26.2016.02.25.15.48.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 15:48:57 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.36.g75877e4.dirty
In-Reply-To: <1456444119-6934-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287502>

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
