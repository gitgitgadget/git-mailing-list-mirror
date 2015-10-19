From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 04/34] mailinfo: explicitly close file handle to the patch output
Date: Mon, 19 Oct 2015 00:28:21 -0700
Message-ID: <1445239731-10677-5-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:29:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4si-0002f8-7f
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbbJSH3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:29:09 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35509 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbbJSH27 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:28:59 -0400
Received: by pasz6 with SMTP id z6so22255417pas.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=xzxdCRyvwNJw9FY5MVOmO3tVfr5l8iLZLoSXPiNizic=;
        b=TxP+giZGpnqnYD293h6VfXXszBoJ7po4EYkjcdXHbs5GGM6MujZUz2AyG1VjuxhjLy
         yOkCLIrgYivwxBpCEpiNtwhC3n5gpgOI1En5ewddhqHchHRXJC4JZMtX5EPqvQbdQhQm
         GpYrxyEN0RgTZb1lnO/XutN9rCS12skzx1S+oaNtZ+tqFb+KzeZQmQ863sl3qQ5IQ1L/
         kBaL2+BlOEJO1oFJOY8UKupSsYJYhEEVJw2YFztKufosvhPa5abLLSvAKX7T7WbKUXU9
         mRtnD3LbHUd9gFAiGbeYxt4FLLwmVNozMT03Wx3npWc5TI/0ugnDyEnEbJ/40d/LYgQP
         L3Pw==
X-Received: by 10.68.136.103 with SMTP id pz7mr33095155pbb.114.1445239738734;
        Mon, 19 Oct 2015 00:28:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id kv9sm34899918pab.39.2015.10.19.00.28.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:28:58 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279838>

This does not make a difference within the context of "git mailinfo"
that runs once and exits, as flushing and closing would happen upon
process termination.  It however will matter when we eventually make
it callable as an API function.

Besides, cleaning after yourself once you are done is a good hygiene.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 1566c19..73be47c 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -999,6 +999,8 @@ static int mailinfo(FILE *in, FILE *out, const char *msg, const char *patch)
 		check_header(&line, p_hdr_data, 1);
 
 	handle_body();
+	fclose(patchfile);
+
 	handle_info();
 
 	return 0;
-- 
2.6.2-383-g144b2e6
