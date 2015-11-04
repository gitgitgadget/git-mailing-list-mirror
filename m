From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 02/11] run-command: report failure for degraded output just once
Date: Tue,  3 Nov 2015 16:37:05 -0800
Message-ID: <1446597434-1740-3-git-send-email-sbeller@google.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 01:37:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztm5I-00030L-H0
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 01:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756080AbbKDAhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 19:37:23 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35597 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755583AbbKDAhV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 19:37:21 -0500
Received: by pasz6 with SMTP id z6so34261572pas.2
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 16:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aq/QqaYYXLpg0tbhxmDN8MPkEqY7ZZ7W1qv+s2fMTko=;
        b=CA3SueMkUNesXdhnnjntbkYBi6rCvc6eEuiNnHjxkYLrDXjtsMcffqkwi5wJI2zTJt
         JTOwlRu8KT6AA2K45c0SNT4e6ZYQaPwlvFVq8ZJZVCL8M893Kz2y3p+SsaXJaksuB/DU
         2gHl8HbkS8faJeH8YlqsGG92Esd2WFNXggrz9Tzqb+3/Eox0UALPC/amVOm53sLfoavw
         osybMadnY8v91T5FibKJBcQMXPBfqjNIOuLOp3UYGPOuR9wKFgYwA2HOqcDCtYOwXbmZ
         7JW+C3Z+GzqNFFvV5ERompQt04NWNdrOLwvaRwNIvBIXIsgRYM15R+lkMYhg/aoovYsi
         l1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aq/QqaYYXLpg0tbhxmDN8MPkEqY7ZZ7W1qv+s2fMTko=;
        b=ToUJBAAnlLJe73T/RpYT3zLmAle788Oi6oVZMogD1ojuM3qDJCYkyScKNHXRwSg0og
         yhkxm5OxoLEsC1EAMBMrT6U689QyD/HUGXxkIkBGn4PufNzoX0Ay30bB6qO+lYlAfh91
         J4l0wwkSmKGO/7aIbXhrNnW50Dlvz4ixWTFyoSkuyyz8TqsaWUH+PzkRcxH1Ff/oHQVV
         C7HKS28X+cDccWMJYG+YGPJ4v9zfbb0LzMm6LcTxFI4ejfQHPRcTZy9NknZWMGj2r+Ue
         To51t7Ny+Txdu9XM/7sCFxYJqBZiDbwUa6i/Vk+WBJXJEKO/y7v7IvSRxFa0s4SkN3P4
         uDpA==
X-Gm-Message-State: ALoCoQmDCqL7gTfVWu5QgQq78MWf4WPC8uQsQfGwzEzJaBSlwf68j7rb1CILEF6hKUBeB06yDd84
X-Received: by 10.68.213.198 with SMTP id nu6mr36777577pbc.96.1446597440682;
        Tue, 03 Nov 2015 16:37:20 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:799e:c67e:2702:f55])
        by smtp.gmail.com with ESMTPSA id kd9sm15075508pbb.32.2015.11.03.16.37.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Nov 2015 16:37:20 -0800 (PST)
X-Mailer: git-send-email 2.6.1.247.ge8f2a41.dirty
In-Reply-To: <1446597434-1740-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280839>

The warning message is cluttering the output itself,
so just report it once.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/run-command.c b/run-command.c
index 7c00c21..3ae563f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1012,13 +1012,21 @@ static void pp_cleanup(struct parallel_processes *pp)
 
 static void set_nonblocking(int fd)
 {
+	static int reported_degrade = 0;
 	int flags = fcntl(fd, F_GETFL);
-	if (flags < 0)
-		warning("Could not get file status flags, "
-			"output will be degraded");
-	else if (fcntl(fd, F_SETFL, flags | O_NONBLOCK))
-		warning("Could not set file status flags, "
-			"output will be degraded");
+	if (flags < 0) {
+		if (!reported_degrade) {
+			warning("Could not get file status flags, "
+				"output will be degraded");
+			reported_degrade = 1;
+		}
+	} else if (fcntl(fd, F_SETFL, flags | O_NONBLOCK)) {
+		if (!reported_degrade) {
+			warning("Could not set file status flags, "
+				"output will be degraded");
+			reported_degrade = 1;
+		}
+	}
 }
 
 /* returns
-- 
2.6.1.247.ge8f2a41.dirty
