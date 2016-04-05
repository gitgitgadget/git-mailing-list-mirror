From: santiago@nyu.edu
Subject: [PATCH v5 6/6] tag: use gpg_verify_function in tag -v call
Date: Tue,  5 Apr 2016 12:07:29 -0400
Message-ID: <1459872449-7537-7-git-send-email-santiago@nyu.edu>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 18:07:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anTWG-0000aC-IX
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 18:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759461AbcDEQHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 12:07:51 -0400
Received: from mail-qg0-f67.google.com ([209.85.192.67]:35792 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759451AbcDEQHl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 12:07:41 -0400
Received: by mail-qg0-f67.google.com with SMTP id b32so1624313qgf.2
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+E4pyUJvu3I41cQvlvqJrNtJFf6NZks0iQD3GY8IWzg=;
        b=vVyFokInVZ0t/uf5vz3d7GfhfVy/zHzcq5f7PCbIt+qxbdY3zqPZSYJjvcWZteVAKG
         8bAnRElApr60hwuAGWjdlWMUMV+514NgUNMG9luTQw48o3myqfXH1LNknAicVOt3dpxr
         5vXYHkcvGDtkjhCX272nIM2hRfJqhEJZsUMHYCeTxViI32hp6RD29Kh26LzM4fThKaaO
         bshWIPrisl3F0N2be04HTrJhjBIzPWSun4Rj54Gznt52jUvCAcXY/8m7K6svyjKDM+Ot
         k2+bIdknzFsb7LlSOZYUtOPz/b2S8RVn9oqUKc8mjjP2hoK9bI4/IDw2DXUg5R+YpQVR
         Xi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+E4pyUJvu3I41cQvlvqJrNtJFf6NZks0iQD3GY8IWzg=;
        b=UyhBaGcAzOnTFRbxjTu+x2lx3rTrp5rq+zEC89ThrpqGdShSVXpvlENqn+NoCyf8is
         /+pdYwp+PE7bGQmcOCbytQWWFcXdhuHa5MEUf+7nsPPE69eqItnnwlSEM9l//B2b3yRl
         O6mImsK4TrajhRJ+4CurKxoGMqkrK6bJio3oWzlCn6fz4S7Iced1LKMT0rPchPtZlRU8
         iNqTEiU5BHlJq8z5ZYRC1DwyfUXiB+4LsymAudyYXSginbCi6lTpl/IjmuO64oRgmCv7
         0p5do7r/9amcPMxqow1HKxWW084AgLoqIsoifgIXPdy+VCYv5hJeLflDZ9yHJ/6dZcCn
         ueTw==
X-Gm-Message-State: AD7BkJJ8tVtMTPM+fNDkiCfzFt2Rpv/b/5/bzo9w0Kgj8zCmphcgPymy/in9bkSXHMBp7uO0
X-Received: by 10.140.130.14 with SMTP id 14mr28276492qhc.85.1459872460540;
        Tue, 05 Apr 2016 09:07:40 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-20.NATPOOL.NYU.EDU. [216.165.95.9])
        by smtp.gmail.com with ESMTPSA id b66sm14671343qhb.48.2016.04.05.09.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Apr 2016 09:07:39 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290791>

From: Santiago Torres <santiago@nyu.edu>

Instead of running the verify-tag plumbing command, we use the
gpg_verify_tag() function within the verify_tag function to avoid doing
an additional fork call.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 builtin/tag.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 1705c94..398c892 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -104,13 +104,7 @@ static int delete_tag(const char *name, const char *ref,
 static int verify_tag(const char *name, const char *ref,
 				const unsigned char *sha1)
 {
-	const char *argv_verify_tag[] = {"verify-tag",
-					"-v", "SHA1_HEX", NULL};
-	argv_verify_tag[2] = sha1_to_hex(sha1);
-
-	if (run_command_v_opt(argv_verify_tag, RUN_GIT_CMD))
-		return error(_("could not verify the tag '%s'"), name);
-	return 0;
+	return gpg_verify_tag(sha1, GPG_VERIFY_VERBOSE);
 }
 
 static int do_sign(struct strbuf *buffer)
-- 
2.8.0
