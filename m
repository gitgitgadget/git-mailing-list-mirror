From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/5] run-command: Initialize the shutdown flag
Date: Mon, 19 Oct 2015 11:24:44 -0700
Message-ID: <1445279086-31066-4-git-send-email-sbeller@google.com>
References: <1445279086-31066-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 19 20:25:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoF7Q-0007aB-BE
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 20:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbbJSSZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 14:25:06 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35232 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319AbbJSSY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 14:24:57 -0400
Received: by pasz6 with SMTP id z6so37163572pas.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 11:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iJUPvXW7lePCY8+xobozuZCSpJbSsvVcnsk2eVdkGng=;
        b=kh7bx/eGAbW7vy6nxTG3HO8Pwl28K9zqk/wHQ8voJSkV6734T8Z95rjcVntSDytzVG
         ta2rY8VvA63hvVkHEc6Jroqr/6so5u7D8w8exz/uvbWcJps+fEVss/IUrwWj3mkIOtUL
         tgGkonN44bafoXgdiQ7mXlX2CnXj8So1xXVFwNSFekiUFIKeuMR4sF8Cjqe9RUV6hxh8
         yrzBcI7+EuHAXoO2OSwaiWVFqAaVpUUaqLYgBidNq/TN1LrXjLoQGkOcQ4dzaTALTZoh
         vC3V3eP0/4RNqZGPMVR7hwYgY53+hby0YNkVAqhgPrif4cgWov/aQZ9dup0t9iykIlcH
         gR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iJUPvXW7lePCY8+xobozuZCSpJbSsvVcnsk2eVdkGng=;
        b=hRdxJauQiY/EXIvcKc6DjvPDw7eNzF2cMWWftLkbEgrxwKD9G+TNJzuFHWTD3uu1Ks
         MfjCV8Sm/DuriTcznFr0dx/j/c/Lg4uARgQys8G7dq6/dHqWNw+YtkeC1iWsGUKA63Kq
         1mK1SNcf0UEoh20y3XFKP/+b3zxBh3E112TQGq0/BGAGa+fCbVQM3Yc/h3GwDC+qV1XV
         KJW536rSVQDUAKccpiDlQ5cYcDK6QL9EmOWhrSvf7k49qhsbr+Fz+r6aXOIurG3sqkax
         cxEpKzoAs4/0Xc7lk26hTf2K2Ztp9AHeovzSzG9mpBhGbpFhNhnL9YH0d9wVK4kaDEMS
         MArQ==
X-Gm-Message-State: ALoCoQlc3xuTjDWELigx6qDF7ZmtxmAhtGRjnJmq7OY9VQb1OS/4+PzeHWKa7niSGMcVVYqNCipo
X-Received: by 10.68.168.97 with SMTP id zv1mr36469548pbb.86.1445279096515;
        Mon, 19 Oct 2015 11:24:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:e1e6:ddb6:de02:325])
        by smtp.gmail.com with ESMTPSA id pq4sm37535851pbc.53.2015.10.19.11.24.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 11:24:56 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.285.g8fe9b61.dirty
In-Reply-To: <1445279086-31066-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279881>

It did work out without initializing the flag so far, but to make it
future proof, we want to explicitly initialize the flag.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/run-command.c b/run-command.c
index b8b5747..108b930 100644
--- a/run-command.c
+++ b/run-command.c
@@ -956,6 +956,7 @@ static struct parallel_processes *pp_init(int n,
 
 	pp->nr_processes = 0;
 	pp->output_owner = 0;
+	pp->shutdown = 0;
 	pp->children = xcalloc(n, sizeof(*pp->children));
 	pp->pfd = xcalloc(n, sizeof(*pp->pfd));
 	strbuf_init(&pp->buffered_output, 0);
-- 
2.5.0.285.g8fe9b61.dirty
