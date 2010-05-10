From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 5/8] fmt-merge-msg: minor refactor of fmt_merge_msg()
Date: Tue, 11 May 2010 01:17:49 +0800
Message-ID: <1273511872-4924-6-git-send-email-rctay89@gmail.com>
References: <1273511872-4924-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 10 19:18:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBWd0-0007lB-02
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 19:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755903Ab0EJRS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 13:18:27 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:49993 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755891Ab0EJRSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 13:18:25 -0400
Received: by mail-pz0-f204.google.com with SMTP id 42so275995pzk.4
        for <git@vger.kernel.org>; Mon, 10 May 2010 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6O/z90KrFIaY7GEO5gk4jhapueZNXbzX3pOitMdeG0U=;
        b=E6DfCcMu6LKvPqCxp/uzZDKeJs1QCwN7WO4NSycogKS5Ff1GfP5pa9p0ELyvlo7crj
         4Ynbufsg6Pz5Xgkz3sKw/j01ktYw30mOkbz3lJcfey/eT0eju/ZkRSo4PSWvsxmcJuRX
         G15o9NcWwjmXbQO1T/acPGH2vyue1E6EsOVUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OHUAm5SDAbXh6VaQclMIVPexvwjrxWujfJSj1HdajoNcablGyt4SUY7+afshpozJJb
         /dbFIWZ0axjHP7FsQrEQDPcZ62CicNe7frSollIxunv+q0j0yXWmb6fRUDz0Jk35xDyb
         CO0/PYBgmQmDcaTKW/nNH4tArIvQFf0/hnVuA=
Received: by 10.115.36.31 with SMTP id o31mr3375452waj.171.1273511905162;
        Mon, 10 May 2010 10:18:25 -0700 (PDT)
Received: from localhost.localdomain (cm71.zeta153.maxonline.com.sg [116.87.153.71])
        by mx.google.com with ESMTPS id v13sm27449213wav.2.2010.05.10.10.18.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 10:18:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.337.gbd0bc
In-Reply-To: <1273511872-4924-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146835>

Shift implementation into a private function, do_fmt_merge_msg(). This
allows for further changes to the implementation, without affecting the
interface.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin/fmt-merge-msg.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 379a031..a2bccd6 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -202,7 +202,8 @@ static void shortlog(const char *name, unsigned char *sha1,
 	string_list_clear(&subjects, 0);
 }
 
-int fmt_merge_msg(int merge_summary, struct strbuf *in, struct strbuf *out) {
+static int do_fmt_merge_msg(int merge_summary, struct strbuf *in,
+	struct strbuf *out) {
 	int limit = 20, i = 0, pos = 0;
 	char *sep = "";
 	unsigned char head_sha1[20];
@@ -296,6 +297,10 @@ int fmt_merge_msg(int merge_summary, struct strbuf *in, struct strbuf *out) {
 	return 0;
 }
 
+int fmt_merge_msg(int merge_summary, struct strbuf *in, struct strbuf *out) {
+	return do_fmt_merge_msg(merge_summary, in, out);
+}
+
 int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 {
 	const char *inpath = NULL;
-- 
1.7.1.189.g07419
