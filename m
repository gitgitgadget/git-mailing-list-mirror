From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 7/9] receive-pack.c: enable atomic push protocol support
Date: Mon, 29 Dec 2014 18:36:45 -0800
Message-ID: <1419907007-19387-8-git-send-email-sbeller@google.com>
References: <1419907007-19387-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Tue Dec 30 03:37:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5mga-00020N-C8
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 03:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468AbaL3ChQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 21:37:16 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:41377 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbaL3ChL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 21:37:11 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so13197116iec.1
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 18:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zrULD7F1NdRhR2WzzoDzxTHumvhO0gC9Wd1v9wbltAA=;
        b=STadDTvcwrEWJyhRR5s6xhlkqfdr3PRydGG/XGRQyAGw1rvK8Dsm7tUi/er1GD+Lfa
         di9thPDk7LANAubWsAL3HFxkJi6qMa+WW2plkLOn7MhP9ato2q6f6BDkAzhIKPk5yseD
         /o8hvtuHIkHriUEmK/rO2Ci3Wxut6M1SJ1PvqJsUrzSpUqItmUJFiUWUWiyM0fTlSC1L
         MJjqtnSS6JN6M8olTyvWLw1UPi1WtqxklZ1xg2EUzgNnBJLNH0WG8eF0EYSNJDM+zu2p
         5k6faj882MSRpjoWpZR7T/emno8er4GDyI2tJC2fZQvzyey9L4fb/dhDowuiKWVvkvaG
         j9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zrULD7F1NdRhR2WzzoDzxTHumvhO0gC9Wd1v9wbltAA=;
        b=Rhz/BucHYrhXpaizR+DLaOOR2VlG2UpF/wO6X5pbAF6SDfSZgF6yzMhQZuQ4UhEqTA
         OcELL6nip94dp73ssDGtMZ1+i0axzFDCVPH+U8b2JXznvevaV/CWxoPZBdEgHOsLgram
         s040sO66f8y5JmrFjHdfWrD8qTWBfXP6MSYkWl2/N3EH/3nGxwvQotbZk65lKq8IrHNy
         zjMe/bu8Cz8u7VltF0xXlFCleQlPF0LmOWApdH8cfSZk0IxLMAwpxq1TlE3ZcLuXCTH9
         nUjG3LIuxxx5PRD3+Doh3Os8yDNCq/1j40OGLYIcbFtOCF40Xv8Hrb/pwtPf8Y8dk7D1
         Ecng==
X-Gm-Message-State: ALoCoQn2eVFxzF3FuZm543kmNZk80i2OQQjIM2ofxjEYOAcDsRPWy7E20kGl+kxHWOEBpS9fsa8h
X-Received: by 10.107.6.196 with SMTP id f65mr52539786ioi.54.1419907030512;
        Mon, 29 Dec 2014 18:37:10 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5860:dcf1:88a4:141b])
        by mx.google.com with ESMTPSA id 3sm18508247iof.3.2014.12.29.18.37.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Dec 2014 18:37:10 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419907007-19387-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261905>

This enables the atomic protocol option as implemented in the previous
patches.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v8:
     no changes
    
    v7:
    * new with v7 of the patch series.
    * this was part of the first patch in the series, moved back here
      for bisectability

 builtin/receive-pack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 35a2264..61eba4e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -173,7 +173,8 @@ static void show_ref(const char *path, const unsigned char *sha1)
 		struct strbuf cap = STRBUF_INIT;
 
 		strbuf_addstr(&cap,
-			      "report-status delete-refs side-band-64k quiet");
+			      "report-status delete-refs side-band-64k quiet "
+			      "atomic");
 		if (prefer_ofs_delta)
 			strbuf_addstr(&cap, " ofs-delta");
 		if (push_cert_nonce)
-- 
2.2.1.62.g3f15098
