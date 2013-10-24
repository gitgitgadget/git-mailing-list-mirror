From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= <pclouds@gmail.com>
Subject: [PATCH v2] entry.c: convert checkout_entry to use strbuf
Date: Thu, 24 Oct 2013 08:55:35 +0700
Message-ID: <1382579735-21893-1-git-send-email-pclouds@gmail.com>
References: <1382532907-30561-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: kusmabite@gmail.com,
	j6t@kdbg.org,
	apelisse@gmail.com,
	tboegi@web.de,
	wnoguchi.0727@gmail.com,
	Johannes.Schindelin@gmx.de,
	l.s.r@web.de,
	msysgit@googlegroups.com,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncBC2ZN5PHQUMBBJH4UGJQKGQE3KHAXPA@googlegroups.com Thu Oct 24 03:55:51 2013
Return-path: <msysgit+bncBC2ZN5PHQUMBBJH4UGJQKGQE3KHAXPA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pb0-f56.google.com ([209.85.160.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBBJH4UGJQKGQE3KHAXPA@googlegroups.com>)
	id 1VZA9N-0000GR-Tf
	for gcvm-msysgit@m.gmane.org; Thu, 24 Oct 2013 03:55:50 +0200
Received: by mail-pb0-f56.google.com with SMTP id rp16sf330188pbb.11
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Oct 2013 18:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=y55GCbxxU7rU8nJR80rXd1iXqIbUoQOW3IDqyPVHAHk=;
        b=H2bMMmKTgdsBOJm3ihkBKlCtjnS6lVMTXtVxN9OZm9U12ycekRU/RPffWOCdU/QnX1
         oQCiQ1PsvJnOwEa4aqs3+ZL55Ee+DX3/baDNtaSu1q6FW25wT1r2vbv6/La3HP138+00
         oShi3yg3OD6bZqJXD8kNux7PXv4n82SgC31mGvW6/MXHQ3nfL3rJj1KSVrb5Aiv6UbNO
         Qrgiit2iNqgu9cL//0CB36/N14ZurCCf7/Vnm7h4aOjkGI7nhZJ6MPxyF0kOiZIvAQoc
         bI7ld+Vn3UfnrlTt1aX9mTZdL8rSEllkVMDNaYqnmV4WCbCu7iSeFyPw+M6h6q/fZ7bl
         atjg==
X-Received: by 10.49.51.197 with SMTP id m5mr4098qeo.5.1382579748777;
        Wed, 23 Oct 2013 18:55:48 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.118.103 with SMTP id kl7ls678178qeb.32.gmail; Wed, 23 Oct
 2013 18:55:48 -0700 (PDT)
X-Received: by 10.236.82.115 with SMTP id n79mr256769yhe.35.1382579748263;
        Wed, 23 Oct 2013 18:55:48 -0700 (PDT)
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com [2607:f8b0:400e:c03::22b])
        by gmr-mx.google.com with ESMTPS id dk16si203035pac.0.2013.10.23.18.55.48
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Oct 2013 18:55:48 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400e:c03::22b as permitted sender) client-ip=2607:f8b0:400e:c03::22b;
Received: by mail-pa0-f43.google.com with SMTP id hz1so1761850pad.16
        for <msysgit@googlegroups.com>; Wed, 23 Oct 2013 18:55:48 -0700 (PDT)
X-Received: by 10.68.182.3 with SMTP id ea3mr337085pbc.124.1382579748119;
        Wed, 23 Oct 2013 18:55:48 -0700 (PDT)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id hz10sm7521004pbc.36.2013.10.23.18.55.42
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 23 Oct 2013 18:55:47 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 24 Oct 2013 08:55:40 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1382532907-30561-1-git-send-email-pclouds@gmail.com>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400e:c03::22b
 as permitted sender) smtp.mail=pclouds@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236560>

The old code does not do boundary check so any paths longer than
PATH_MAX can cause buffer overflow. Replace it with strbuf to handle
paths of arbitrary length.

The OS may reject if the path is too long though. But in that case we
report the cause (e.g. name too long) and usually move on to checking
out the next entry.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
---
 v2 does two strbuf_add() instead of one hard-to-read strbuf_addf()

 entry.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/entry.c b/entry.c
index acc892f..fbb4863 100644
--- a/entry.c
+++ b/entry.c
@@ -237,16 +237,19 @@ static int check_path(const char *path, int len, stru=
ct stat *st, int skiplen)
 int checkout_entry(struct cache_entry *ce,
 		   const struct checkout *state, char *topath)
 {
-	static char path[PATH_MAX + 1];
+	static struct strbuf path_buf =3D STRBUF_INIT;
+	char *path;
 	struct stat st;
-	int len =3D state->base_dir_len;
+	int len;
=20
 	if (topath)
 		return write_entry(ce, topath, state, 1);
=20
-	memcpy(path, state->base_dir, len);
-	strcpy(path + len, ce->name);
-	len +=3D ce_namelen(ce);
+	strbuf_reset(&path_buf);
+	strbuf_add(&path_buf, state->base_dir, state->base_dir_len);
+	strbuf_add(&path_buf, ce->name, ce_namelen(ce));
+	path =3D path_buf.buf;
+	len =3D path_buf.len;
=20
 	if (!check_path(path, len, &st, state->base_dir_len)) {
 		unsigned changed =3D ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MAT=
CH_IGNORE_SKIP_WORKTREE);
--=20
1.8.2.82.gc24b958

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
