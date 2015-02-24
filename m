From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] receive-pack: add advertisement of different protocol options
Date: Mon, 23 Feb 2015 19:12:41 -0800
Message-ID: <1424747562-5446-3-git-send-email-sbeller@google.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 04:14:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQ5x7-0002Kl-Vy
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 04:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbbBXDOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 22:14:22 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:37713 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbbBXDOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 22:14:16 -0500
Received: by iecrl12 with SMTP id rl12so28848736iec.4
        for <git@vger.kernel.org>; Mon, 23 Feb 2015 19:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wg1yGZcl5HDCwdLybmclUAhtvMxYzsxITUfXJaYU9Zg=;
        b=QkJ5T4QL9Dq0e3XkWFT20IPqH4LiVqS+h6lsRhQnnmwGeGStsyhysn8DawNxOTEjDk
         AS2gA5n3M8NkvW7sRebJoccEvpmCOfvCyJOG80cEF4RR3yeptdb0vIy2T+g62exDJ7w4
         jnWMHOdPm6WQ/XZzt7Rl7x9Pa2webCnFensDm0+5Pt3Bt9ZdTBFxf8wlS1sSV35s56UT
         jSAjvkKnXGOBBjO5vTKULUBvnqzEHySNev4mkZXD/fi4ICbT2IPUGnvtJ9t32qNjixXK
         1qx8+LT5/vCwH++S0EZ2rPBvbhXd1k7KGxgsbdzUtC/vjLfANpye7/bRqlZhc5Pe9eIe
         sL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wg1yGZcl5HDCwdLybmclUAhtvMxYzsxITUfXJaYU9Zg=;
        b=V7zg/zNAZ6cZhTsenPKG0qXJV/u4bKFogkcd/u13pjaEGTxyaHlRQ+fhkkHObXm9o7
         8jpH1dxXqit2T//3AjeqLJfAhBUS4uaanMp1DDCGt5mcRHsKBrEitKmWjir/2Vmhs7p6
         Mxqg0zfXMGLNCSx1LyV4dX2XNvHdUf4ul5sYRXh3AfEK0u8GSuaB3LjFzaZ+YpVeysjo
         u1e45V/mh4swABy4Omkb0C8FU9iquQZiFvTA6HyxeLUAQORqAu4YL/lISxk+vpD/0iH3
         I/Nyg576CBnfskKBs3bMOjWhQau+Y5+WK86gsttuHrc3TYL6R8QwcftmBj+kFMd8XP7K
         JmnA==
X-Gm-Message-State: ALoCoQn4NIt+sAsOkeLxyz6NxwHHLyzw4Fu6WQpOkN6UrxHaA64e5w7WQUinp7qK02h5eh7HeGbX
X-Received: by 10.50.73.99 with SMTP id k3mr17147827igv.21.1424747656189;
        Mon, 23 Feb 2015 19:14:16 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:acce:8652:941a:5856])
        by mx.google.com with ESMTPSA id d1sm7317004igl.9.2015.02.23.19.14.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 23 Feb 2015 19:14:15 -0800 (PST)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1424747562-5446-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264307>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/receive-pack.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e0ce78e..a077b1d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -71,6 +71,8 @@ static long nonce_stamp_slop;
 static unsigned long nonce_stamp_slop_limit;
 static struct ref_transaction *transaction;
 
+static const char *advertised_versions = NULL;
+
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
 	if (value) {
@@ -168,6 +170,9 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.advertisedversions") == 0)
+		return git_config_string(&advertised_versions, var, value);
+
 	return git_default_config(var, value, cb);
 }
 
@@ -189,6 +194,8 @@ static void show_ref(const char *path, const unsigned char *sha1)
 			strbuf_addstr(&cap, " ofs-delta");
 		if (push_cert_nonce)
 			strbuf_addf(&cap, " push-cert=%s", push_cert_nonce);
+		if (advertise_versions)
+			strbuf_addstr(&cap, " versions=%s", advertise_versions);
 		strbuf_addf(&cap, " agent=%s", git_user_agent_sanitized());
 		packet_write(1, "%s %s%c%s\n",
 			     sha1_to_hex(sha1), path, 0, cap.buf);
-- 
2.3.0.81.gc37f363
