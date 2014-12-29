From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 7/9] receive-pack.c: enable atomic push protocol support
Date: Mon, 29 Dec 2014 13:35:13 -0800
Message-ID: <1419888915-31760-8-git-send-email-sbeller@google.com>
References: <1419888915-31760-1-git-send-email-sbeller@google.com>
Cc: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 22:35:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5hyX-0001f8-Jl
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 22:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbaL2Vfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 16:35:37 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:64329 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbaL2Vfb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 16:35:31 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so12739213iec.29
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 13:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AVvddql4r1pvjtXn390K9CZGRhPP+e9rNWvYKyauhNk=;
        b=gqnSqr9FJKK34lQLYTxV5U3iu1ylvJ5qKHT9Hry4kEztMMTb/Eal/HxV2/1eWfcGXu
         LVHeg8a91deeF8zWniXA9EVu1+TVe2bVOJHO+lba1iqmorCZh2TexEvE+N9pq5mybQIV
         xd2j4iv16AoJ/GoCDpUdWE9FU8F4BVq4LM2MboxX8MSi51WeRP5cMs4zHWOpIDFPC7Sq
         9Q94BLIkk3dLOfGhgFroxdSbxkJ+uBKHYOdR34DD840WACt776UAdHdOapuQkfxib73q
         pJV7r3hRKyf3t0PwLvkNh44jBmyKgL+Ei+QNasDQlzPE3DnF0MmgX4FQJaSrX2ipgMvd
         kYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AVvddql4r1pvjtXn390K9CZGRhPP+e9rNWvYKyauhNk=;
        b=F2/j9F52c9Nj/IfTmqggD95UQJzLS+S9hY9OlsS0Cwjx3OjjA59f244+DgWAsfn/dU
         eTVqb0aCwYfWlPnOpZJM5nfrmai+kUfAD0lD9gU3bidByp20tKRpQpauKwRgDjxW2g81
         kZvdJXgrRxlXvWzbZqXxE7yJqrOEyTWfXa8E+pUnE6uxQERBVs/j9YJYrDgxQxUfpdVt
         7BXpI4+dtuMqzLGSshQk0xy8jPjxIU99nOQVkLfe+U56LytyE660m6J4nYDvqk+kyYOk
         8w2hxossLMcFew2qd2OYhB5VvlPMYikoaE+cGErz2wn51AJhXLLnLeT0sUUj1f2mJiu2
         OEZg==
X-Gm-Message-State: ALoCoQnSzRm0/Mw3TnEEp4GjaZDNcVIa05WpFjed/VgaSxl3o/9Qno2d06VfaP8sE3jpfctSZOlV
X-Received: by 10.107.137.199 with SMTP id t68mr53447570ioi.38.1419888930415;
        Mon, 29 Dec 2014 13:35:30 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5860:dcf1:88a4:141b])
        by mx.google.com with ESMTPSA id b194sm18189034iob.38.2014.12.29.13.35.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Dec 2014 13:35:29 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1419888915-31760-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261885>

This enables the atomic protocol option as implemented in the previous
patches.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v7:
    * new with v7 of the patch series.
    * this was part of the first patch in the series, moved back here
      for bisectability

 builtin/receive-pack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 7e3bbe6..6da6975 100644
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
