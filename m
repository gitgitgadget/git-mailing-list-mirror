From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= <pclouds@gmail.com>
Subject: [PATCH 1/2] entry.c: convert checkout_entry to use strbuf
Date: Wed, 23 Oct 2013 19:55:06 +0700
Message-ID: <1382532907-30561-1-git-send-email-pclouds@gmail.com>
References: <20131021193223.GC29681@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Antoine Pelisse <apelisse@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=83=C2=B6gershausen?= <tboegi@web.de>,
	Wataru Noguchi <wnoguchi.0727@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?q?Ren=C3=83=C2=A9=20Scharfe?= <l.s.r@web.de>,
	msysGit <msysgit@googlegroups.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncBC2ZN5PHQUMBBP4MT6JQKGQEQRZTRMY@googlegroups.com Wed Oct 23 14:51:13 2013
Return-path: <msysgit+bncBC2ZN5PHQUMBBP4MT6JQKGQEQRZTRMY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f60.google.com ([209.85.216.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBBP4MT6JQKGQEQRZTRMY@googlegroups.com>)
	id 1VYxu4-00011m-QX
	for gcvm-msysgit@m.gmane.org; Wed, 23 Oct 2013 14:51:13 +0200
Received: by mail-qa0-f60.google.com with SMTP id j7sf197814qaq.15
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Oct 2013 05:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=4k+5F+wrrAPmyFO1FQmYt3jbaQo+fDlNIOicCD2Mr6M=;
        b=i+GLr2QKKtZlNlkf72uwsKyTStFvxbMmjgqTpY0NDbAfJOp+Hq61iA1TJfkCLKtlYt
         Cni2HJRVkRxeJ0ofcVwXg+/xMhBn77/wC6UqTYJ246wKJ9NCzs5WNz+YgA1egdT+Df3Q
         TqAS3/ZU2eXCgfEy8LL8iWlqG+xtowOISHTPSy9duIl8+Sib86uIBPxeyh+m4oCiLUV6
         I/tcI7nNgBQb4Ikto1vxvy3yCM4SiR7gqo4aNybxMoRD/My+SWjnlRLxkaUgMDU86t/o
         dbDBUEEAJ+dYNw6s7cYZYgSu9PiBgakxmX0ExmH75Bd0dR1CBlNjgqxaAad9mK4KQhnm
         jQdw==
X-Received: by 10.49.27.168 with SMTP id u8mr31811qeg.11.1382532672072;
        Wed, 23 Oct 2013 05:51:12 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.130.233 with SMTP id oh9ls455316qeb.62.gmail; Wed, 23 Oct
 2013 05:51:11 -0700 (PDT)
X-Received: by 10.236.115.198 with SMTP id e46mr1275216yhh.33.1382532671631;
        Wed, 23 Oct 2013 05:51:11 -0700 (PDT)
Received: from mail-pd0-x22b.google.com (mail-pd0-x22b.google.com [2607:f8b0:400e:c02::22b])
        by gmr-mx.google.com with ESMTPS id kh12si5509325pab.2.2013.10.23.05.51.11
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Oct 2013 05:51:11 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400e:c02::22b as permitted sender) client-ip=2607:f8b0:400e:c02::22b;
Received: by mail-pd0-f171.google.com with SMTP id z10so1041745pdj.16
        for <msysgit@googlegroups.com>; Wed, 23 Oct 2013 05:51:11 -0700 (PDT)
X-Received: by 10.66.25.133 with SMTP id c5mr3172635pag.4.1382532671485;
        Wed, 23 Oct 2013 05:51:11 -0700 (PDT)
Received: from lanh ([115.73.233.152])
        by mx.google.com with ESMTPSA id gf5sm4397751pbc.22.2013.10.23.05.51.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Oct 2013 05:51:10 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 23 Oct 2013 19:55:08 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <20131021193223.GC29681@sigill.intra.peff.net>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400e:c02::22b
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236505>

The old code does not do boundary check so any paths longer than
PATH_MAX can cause buffer overflow. Replace it with strbuf to handle
paths of arbitrary length.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
---
 To get this topic going again. These two patches kill PATH_MAX in
 entry.c and builtin/checkout-index.c

 entry.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/entry.c b/entry.c
index acc892f..d955af5 100644
--- a/entry.c
+++ b/entry.c
@@ -237,16 +237,18 @@ static int check_path(const char *path, int len, stru=
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
+	strbuf_addf(&path_buf, "%.*s%s", state->base_dir_len, state->base_dir, ce=
->name);
+	path =3D path_buf.buf;
+	len =3D path_buf.len;
=20
 	if (!check_path(path, len, &st, state->base_dir_len)) {
 		unsigned changed =3D ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MAT=
CH_IGNORE_SKIP_WORKTREE);
--=20
1.8.2.83.gc99314b

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
