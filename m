From: santiago@nyu.edu
Subject: [RFC/PATCH] verify-tag: add --check-name flag
Date: Tue,  7 Jun 2016 15:56:08 -0400
Message-ID: <20160607195608.16643-1-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Colin Walters <walters@verbum.org>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 21:56:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAN6q-0002Hp-8f
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 21:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161707AbcFGT4P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2016 15:56:15 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:33998 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161210AbcFGT4O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 15:56:14 -0400
Received: by mail-qg0-f66.google.com with SMTP id z67so9896369qgz.1
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 12:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eW4sWSfMfY3MttMSaj8li2cUOC9JbMV6wZZ7oteZC2c=;
        b=svFCzZu9YEKX2X40xx/qnDqSe0MusWir0TU3vkT+/uAFT7AhEWRgnAmS30wjN53z/Y
         hqj60YIGdkcjhzoxFzFh4hkj0JFA0/M4emK1TW/Oqlkf/R3fTSF+zBo8uiLy2TnqvwS4
         ECRm/9dn3dO/yXYaKpV5THKcDtRbAQ1HpH6ONnmzOKay0uxXi3xgI/i1UbmQkNgrMHEd
         kkx+Ui1CZmun22Htr8eq/s2ds34dAxZEeQYRjztKRm8l86CqNBdZ7rjnMzT9xGErKMNw
         FtdHxZWfv6FWUQKTAuKwnbN67nypkLldUvcKvw+P8RsKcG+YbQb058rzFOMCSOTtsMOx
         gKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eW4sWSfMfY3MttMSaj8li2cUOC9JbMV6wZZ7oteZC2c=;
        b=VCzo/UlNngo56vQu6AJvF3rFG9pHWJ/k64y0VPEEbA+11Z/OWdYI7ir4fcIGyvozVJ
         RBN1nA42TbOjRl2kbCRVpLDJDtCzY0Th/HsoR5FzBTv7lRNqVkY6ejGRnaAVbA0SbxpN
         mL4TCUqafma1G/2NXvDskglzasfLXNRkevJNBthHL/CDIg99ojJNRQoXsgrW5qVYNDgO
         vzpVAFtQN7+dz8J6bi9uAXMxwWtiZ697+ACOZj2R1HxKf4WKaegepkjx8vBzaCX2CZCy
         nn07se1dvwV+5U8IQQm1BwTMhpvTOfUSTtVLcBZIiO6yypDQP/c7M8/LsmNJ1c1MtjQO
         KPCw==
X-Gm-Message-State: ALyK8tJhHhkMRyjxHcRpxuvw0IIe+xb4IV0JBM8hCpLKjvyytRDytz6Ua+0glHm1Q8vtCTc2
X-Received: by 10.141.30.195 with SMTP id t64mr1355437qhf.38.1465329373073;
        Tue, 07 Jun 2016 12:56:13 -0700 (PDT)
Received: from LykOS.nyu.edu (NYUFWA-WLESSAUTHCLIENTS-EXP01.NATPOOL.NYU.EDU. [216.165.95.69])
        by smtp.gmail.com with ESMTPSA id j190sm6987630qkf.29.2016.06.07.12.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jun 2016 12:56:12 -0700 (PDT)
X-Mailer: git-send-email 2.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296713>

=46rom: Santiago Torres <santiago@nyu.edu>

Hello everyone,

In a previous thread [1] we discussed about the possibility of having a
--check-name flag, for the tag-verify command (and possibly git tag -v)=
=2E
Although many points were in the table, I don't think that it was
conclusive as to whether having it or not. Also, I noticed that the,
refactored interface requires really minmal changes to do this
(see attached patch).=20

This is the behavior I had in mind:


    santiago at ~/.../.../git =E2=9C=97 ./git-verify-tag --check-name v=
2.7.0-rc20000
    gpg: Signature made Tue 22 Dec 2015 05:46:04 PM EST using RSA ...=20
    gpg: Good signature from "Junio C Hamano <gitster@pobox.com>" [...]
    ...
    error: tag name doesn't match tag header!(v2.7.0-rc2)

    santiago at ~/.../.../git =E2=9C=97 ./git-verify-tag --check-name v=
2.7.0-rc2
    gpg: Signature made Tue 22 Dec 2015 05:46:04 PM EST using RSA ...
    gpg: Good signature from "Junio C Hamano <gitster@pobox.com>" [...]
    ...

The rationale behind this is the following:

1.- Using a tag ref as a check-out mechanism is pretty common by packag=
e
    managers and other tools. Verifying the tag signature provides
    authentication guarantees, but there is no feedback that the
    signature being verified belongs to the intended tag.

2.- The tuple tagname + signature can uniquely identify a tag. There
    are many tags that can have the same name, but this is mostly due
    to the naming policy. Having a tag-ref pointing to the right tag
    name with an appropriate signature provides tigther guarantees abou=
t
    the tag that's being checked-out.

3.- This follows concerns about other people who wish to provide a
    tighter binding between the refs and the tag objects. The git-evtag
    project is an example of this[2].

What I want to prevent is the following:=20

    santiago at ~/.../ =E2=9C=94 pip install -e git+https://.../django/=
@1.8.3#egg=3Ddjango
    Obtaining django from git+https://.../django/@1.8.3#egg=3Ddjango
    [...]=20
    Successfully installed django
    santiago at ~/.../ =E2=9C=94 django-admin.py --version
    1.4.11

In this example, the tag retrieved is an annotated tag, signed by the
right developer. In this case signature verification would pass, and
there are no hints that something *might* have be wrong. Needless to
say, Django 1.4.11 is deprecated and vulnerable to really nasty XSS and
SQLi vectors...

I acknowledge that it is possible to provide this by using the SHA1 of
the tag object instead of the tag-ref, but this provides comparable
guarantees while keeping a readable interface. Of course that the sha1
is the "tightest" binding, so this also allows for developers to
remove tags during quick-fixes (as Junio pointed out in [1]) and other
edge cases in which the SHA1 would break.

Of course that using this flag needs to be integrated by package
managers and other tools; I wouldn't mind reaching out and even
proposing patches for the popular ones.

A stub of the intended patch follows. I'll can make a cleaner patch
(e.g., to include this in git tag -v) based on any feedback provided.

[1] http://thread.gmane.org/gmane.comp.version-control.git/284757
[2] http://thread.gmane.org/gmane.comp.version-control.git/288439

---
 builtin/verify-tag.c | 1 +
 tag.c                | 8 ++++++++
 tag.h                | 1 +
 3 files changed, 10 insertions(+)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 99f8148..947babe 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -33,6 +33,7 @@ int cmd_verify_tag(int argc, const char **argv, const=
 char *prefix)
 	const struct option verify_tag_options[] =3D {
 		OPT__VERBOSE(&verbose, N_("print tag contents")),
 		OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VER=
IFY_RAW),
+		OPT_BIT(0, "check-name", &flags, N_("Verify the tag name"), TAG_VERI=
=46Y_NAME),
 		OPT_END()
 	};
=20
diff --git a/tag.c b/tag.c
index d1dcd18..591b31e 100644
--- a/tag.c
+++ b/tag.c
@@ -55,6 +55,14 @@ int gpg_verify_tag(const unsigned char *sha1, const =
char *name_to_report,
=20
 	ret =3D run_gpg_verify(buf, size, flags);
=20
+	if (flags & TAG_VERIFY_NAME) {
+		struct tag tag_info;
+		ret +=3D parse_tag_buffer(&tag_info, buf, size);
+		if strncmp(tag_info.tag, name_to_report, size)
+			ret +=3D error("tag name doesn't match tag header!(%s)",
+					tag_info.tag);
+	}
+
 	free(buf);
 	return ret;
 }
diff --git a/tag.h b/tag.h
index a5721b6..30c922e 100644
--- a/tag.h
+++ b/tag.h
@@ -2,6 +2,7 @@
 #define TAG_H
=20
 #include "object.h"
+#define TAG_VERIFY_NAME 0x10
=20
 extern const char *tag_type;
=20
--=20
2.8.3
