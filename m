From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv17 08/11] run_processes_parallel: correctly terminate callbacks with an LF
Date: Wed, 24 Feb 2016 19:06:55 -0800
Message-ID: <1456369618-18127-9-git-send-email-sbeller@google.com>
References: <1456369618-18127-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 04:07:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYmH1-0000mq-Ei
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 04:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759903AbcBYDHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 22:07:20 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34178 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759892AbcBYDHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 22:07:16 -0500
Received: by mail-pa0-f42.google.com with SMTP id fy10so23805822pac.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 19:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ma0KCMjPw71hSgagzYa+khPIlA8z8ojjLtLrk+48c8M=;
        b=HFpBUwSNUu48T597xfDQpzYhzKMlNeF7z9oalorcWgd2LIfxx8bAU+3nkOtia2loWO
         zCiqHU+16DMzA7FCvugbICoEk8KX4DhHGuOpeNOFOTIoozzDvk4mT+mh5hBREQuZ36Vf
         m+vl5FADD0zyOlaTUfmYL2/qqpT3eyIoOXsSDBKqD9r/Wg00LvXG/L4o2L066/CJBkQI
         yfgyhwCgqtjUu0712+8iQeIstA1Anfv44GlMk0wKGJLUnjD4YKzMZTrC12bUVXsYHbF7
         Z7tRn+wxp1bDS7OzwG5rQoec0kgnH7DaWHIqJ70r7Ch5UkRvkAQbNigQgHYQ45GRu36+
         c99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ma0KCMjPw71hSgagzYa+khPIlA8z8ojjLtLrk+48c8M=;
        b=HJhBoIXdcNfbgWvkdWZYDrIvblNDDtB+ETpx1NLeM3wAWFhhwSXB6sBkosuA5ZtsUT
         rDDH5f+qQOVknTt5tTd83GDjyavpD2FB4nip6p5QPw/3gjTM5yt41BhllHn06cFrlLlV
         kNeys2aMSu2LgaFMUloR2pt3YX4OKadjgC3suwe5xLe+C1B5DmXOmSBiTl0sJZhBE/KA
         LJ3ShF25EokGLK0HxhMhlNzF4WCTDaVryqqjvThBhs9K2BYPtCGj3PuGCK9JuDe8SWCK
         bT3AOJv4p/qwfjlzX6U9IMSA9mKfOJalCbB9Cg8yWW9gwLX3agyE684//hCNjoOIfZBa
         iduQ==
X-Gm-Message-State: AG10YOQaGgUQS+FignphAzVsVcUTT3bqOcQykky0JhamPu4qPO/47QNuoT4WkaSxHMJBen+b
X-Received: by 10.67.3.67 with SMTP id bu3mr7882644pad.39.1456369634063;
        Wed, 24 Feb 2016 19:07:14 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:74de:af7a:dfba:15a4])
        by smtp.gmail.com with ESMTPSA id u84sm7956770pfa.57.2016.02.24.19.07.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 19:07:13 -0800 (PST)
X-Mailer: git-send-email 2.7.2.373.g1655498.dirty
In-Reply-To: <1456369618-18127-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287318>

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
2.7.2.373.g1655498.dirty
