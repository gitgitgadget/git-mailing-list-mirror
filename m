From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/4] notes: only allow to append a blob to a blob
Date: Fri, 11 May 2012 08:25:06 +0700
Message-ID: <1336699506-28388-5-git-send-email-pclouds@gmail.com>
References: <1336658701-9004-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 03:26:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSed7-00025f-MT
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 03:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758146Ab2EKB0p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 21:26:45 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49237 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757853Ab2EKB0o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 21:26:44 -0400
Received: by pbbrp8 with SMTP id rp8so2606716pbb.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 18:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oiADCWBDe1LZjZc71Bz1sa8fuprdCVLQ0xXAsn9eHDA=;
        b=eXzLE4Uxz9pGGNXr4TkQEaxs1LLY/9Wxk/2GRJ+PYWH/U02oWimQSyUuqAgUFnZs7w
         db1uKRk3pmuSUv2pyNcYWAiMaoFlcO4y06FNQY9Y0rpkjST9JK7Uo1Z/0rTj0uAsRXek
         cPAisjguv0g5ePDQax/Rypzoo+6knkWHyShNe7oagqsxxB5ZTrES1/HX8ts3Os4Jg0DE
         HoeAp0Ht6+f+7c5PXCiUu9MKQs+D5fJuF4QkJBYdbZJ/nTCPG/xp6HpRvLCghcYVPDQp
         VBMtnTCSbj7QDlBSZJYodmgY177vnZ1FynCKgwWDOy5gjUqoXqrdnUVbtwfRwc0OjqK4
         5dTQ==
Received: by 10.68.192.67 with SMTP id he3mr5091297pbc.114.1336699604061;
        Thu, 10 May 2012 18:26:44 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id d6sm11127212pbi.23.2012.05.10.18.26.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 18:26:43 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 11 May 2012 08:25:43 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1336658701-9004-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197653>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Thu, May 10, 2012 at 10:45 PM, Jeff King <peff@peff.net> wrote:
 > On Thu, May 10, 2012 at 10:31:23PM +0700, Nguyen Thai Ngoc Duy wrote=
:
 >
 >> >> +static const char *type_name(enum object_type type)
 >> >> +{
 >> >> +     switch (type) {
 >> >> +     case OBJ_BLOB: return _("a blob");
 >> >> +     case OBJ_TAG: return _("a tag");
 >> >> +     case OBJ_COMMIT: return _("a commit");
 >> >> +     case OBJ_TREE: return _("a tree");
 >> >> +     default:
 >> >> +             die("BUG: put a new string for type %d here", type=
);
 >> >> +     }
 >> >> +}
 >> >
 >> > Don't we have object.c:typename for this
 >>
 >> The key difference here is _() with an article. It's i18n friendly.=
 I
 >> wanted to make 15 combinations (blob/blob cannot happen) of "cannot
 >> append %s to %s", which is best for translators but probably too mu=
ch
 >> for C developers.
 >
 > I do not pay much attention to the translation details, but I would
 > think that we would keep terms like "tree" and "blob" universal, as =
they
 > are technical terms. IOW, you would not expect the "blob" in "git
 > cat-file blob $sha1" to be internationalized, and this seems like th=
e
 > same level of technical detail.

 It's the article that's important here. Putting "appending a %s to a
 %s" may be safe in this case because no object type begins with a
 vowel (and we would need to turn "a" to "an"). But it raises a
 question: does any other language have different forms of article
 depending on the main noun?

 But this is for the sake of discussion. The new patch (with your
 suggestion) does not have this problem any more.

 builtin/notes.c  |    7 ++++++-
 t/t3301-notes.sh |    6 ++++++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 44fb8b6..a90d9b6 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -204,8 +204,13 @@ static void create_note(const unsigned char *objec=
t, struct msg_arg *msg,
 		strbuf_grow(&(msg->buf), size + 1);
 		if (msg->buf.len && prev_buf && size)
 			strbuf_insert(&(msg->buf), 0, "\n", 1);
-		if (prev_buf && size)
+		if (prev_buf && size) {
+			if (type !=3D OBJ_BLOB)
+				die(_("cannot append to a non-blob note"));
+			if (msg->type !=3D OBJ_BLOB)
+				die(_("cannot append non-blob object to a note"));
 			strbuf_insert(&(msg->buf), 0, prev_buf, size);
+		}
 		free(prev_buf);
 	}
=20
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 66cc872..7a682fe 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1240,4 +1240,10 @@ test_expect_success 'cannot edit non-blob notes'=
 '
 	test_must_fail git notes edit
 '
=20
+test_expect_success 'refuse to concatenate two notes of different type=
' '
+	test_must_fail git notes append -m foo &&
+	git notes add -f -m foo &&
+	test_must_fail git notes append -C HEAD^{tree}
+'
+
 test_done
--=20
1.7.3.1.256.g2539c.dirty
