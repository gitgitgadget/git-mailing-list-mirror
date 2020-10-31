Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C53C388F7
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 12:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2EBA20731
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 12:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="sgMg2Ity"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgJaMVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 08:21:10 -0400
Received: from mout.web.de ([217.72.192.78]:58243 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgJaMVK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 08:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1604146864;
        bh=IpEA/5LV24WOTFjzMfLc9WkB1QZoOhmqhUB9MkYKR70=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=sgMg2ItyvPkVDlcYyDkkTdfziZjhwFIhQzADlWKmLC8SKiONfTJ8DmiRA7GDhmk36
         s7OsdhowrCGIjvC/LD8+l1NfKQq/azzPfJ749Unbfpg4p3HqvuFnRI6I7Fp7WIpQhf
         zBXRMqqRqFjYgBUYcguX8fgeD2hlsUg4Q6BxUgAU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKuON-1kmnSn2TG9-00LIhv; Sat, 31
 Oct 2020 13:21:04 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] object: allow clear_commit_marks_all() to handle any repo
Message-ID: <f8cce944-a094-6097-39c3-904f52e4b9f6@web.de>
Date:   Sat, 31 Oct 2020 13:21:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E6Fbe9jRI8PdoTjLssA/6kEF90MuoP6VHGJA7BIasl1JIZLhNzO
 NC3VTjbHWEzLwtuFWNJMpKCiH1luMp3WVjs6rQmBdDUvK9ytTE6zpEZVQrnUaiFXWt9n5Gt
 1eEkbtxauNQeDyXFQRBim2tLhAcd76g3XtQnyRosVIeXBiFJcZtoaf90HlYrH7ATbVBs5CW
 Fl75jivfz1HFMNj1i0Qjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bC8CFozPnC4=:BYwfumjVm+zzh0SxUVwPDT
 dLb+9xd2RmbjxPhFcmzFUtSak2bhdhxSdjHWECb6VvcNzVlcHPSdcLDvIgkIq7dppvs8oq8pb
 ZEbO8wOIIE6dZPsjphvalaJyiU2eSNsvQeyDrIVpkSBtOJwC/0lcXbFQYiWG3GANMbMOqdCnd
 x+cQtSRIbgNH+gsPyV2QHSkA/ckT233sbm2N0DzvtpaYPU5Yeuf4ApgS+R/sNBQhIAe4Dh3Sk
 d41fN04mTUvUQdesQLsU3YdOvwLlo283MgvdQ7FEwgB05VLVN2E29GCLe1Hxn/PnG18iw8bdH
 qHmefF1ahoxgX1TEwk1D8ROeXkjQgZn+S6hqVfqHtPFBUBIaMgsqcMlWzGAlHcUV9XZEGDiPv
 N5ap8XmGFDF02dKsNS8eMzj75cAbvYMLrQD0r2ABBVoD7zZZFOBN5+6UXaItGIfACBO3CLpW0
 xYUMbcWifGNn14U2U1MpGp3bwPDgZlOZQqE19zWPQGf9OBp1NoabLgdZhqBBcf3FuYqJGGQz1
 NnmlvQ2Xol4ouXQ/2H74O3HC9zWRJpWRvx68wNIH0piVERK1yTxnlOdymRT8Z7xTbdn2YyDXO
 05FSYCv+37hpkXQrPcrcdhMIjD3M/PL1tCfF39whjarjSRYymWzEAhxGxF7eGc+vyU5ilPsLe
 93cX0dKAXjtKzTJJfIrdl01J858Md9y3tiL9h9fSQ3eDvd41qcGwF6fwAhzf5KVMpHc3maNMp
 pH0aaLaJKu4HBBh0yS8GCxUfb/BxvlrEKFeVcn4slwCObY8Zp3Q1vfae443OlLUap+Oa79HFC
 M0H6E6tViP/HDGL4yewlCcExEqvFjfv44G5x1k5y6Gts9eZFbYheusn1DEOIQgQCOAgGkGASF
 YZzbeHOmTYtcPVpmQVXQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow callers to specify the repository to use.  No functional change
intended.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 bisect.c           | 2 +-
 builtin/checkout.c | 2 +-
 builtin/gc.c       | 2 +-
 object.c           | 6 +++---
 object.h           | 5 +++--
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/bisect.c b/bisect.c
index f5b1368128..ee7f7bd017 100644
=2D-- a/bisect.c
+++ b/bisect.c
@@ -1090,7 +1090,7 @@ enum bisect_error bisect_next_all(struct repository =
*r, const char *prefix)
 		  nr), nr, steps_msg);
 	free(steps_msg);
 	/* Clean up objects used, as they will be reused. */
-	clear_commit_marks_all(ALL_REV_FLAGS);
+	clear_commit_marks_all(the_repository, ALL_REV_FLAGS);

 	return bisect_checkout(bisect_rev, no_checkout);
 }
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7c311cecb3..49d599a994 100644
=2D-- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1042,7 +1042,7 @@ static void orphaned_commit_warning(struct commit *o=
ld_commit, struct commit *ne
 		describe_detached_head(_("Previous HEAD position was"), old_commit);

 	/* Clean up objects used, as they will be reused. */
-	clear_commit_marks_all(ALL_REV_FLAGS);
+	clear_commit_marks_all(the_repository, ALL_REV_FLAGS);
 }

 static int switch_branches(const struct checkout_opts *opts,
diff --git a/builtin/gc.c b/builtin/gc.c
index 2b99596ec8..4e3a904f70 100644
=2D-- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -788,7 +788,7 @@ static int should_write_commit_graph(void)

 	result =3D for_each_ref(dfs_on_ref, &data);

-	clear_commit_marks_all(SEEN);
+	clear_commit_marks_all(the_repository, SEEN);

 	return result;
 }
diff --git a/object.c b/object.c
index 3257518656..27cc72fc7c 100644
=2D-- a/object.c
+++ b/object.c
@@ -453,12 +453,12 @@ void clear_object_flags(unsigned flags)
 	}
 }

-void clear_commit_marks_all(unsigned int flags)
+void clear_commit_marks_all(struct repository *r, unsigned int flags)
 {
 	int i;

-	for (i =3D 0; i < the_repository->parsed_objects->obj_hash_size; i++) {
-		struct object *obj =3D the_repository->parsed_objects->obj_hash[i];
+	for (i =3D 0; i < r->parsed_objects->obj_hash_size; i++) {
+		struct object *obj =3D r->parsed_objects->obj_hash[i];
 		if (obj && obj->type =3D=3D OBJ_COMMIT)
 			obj->flags &=3D ~flags;
 	}
diff --git a/object.h b/object.h
index 20b18805f0..eccacc8bb8 100644
=2D-- a/object.h
+++ b/object.h
@@ -191,8 +191,9 @@ void object_array_clear(struct object_array *array);
 void clear_object_flags(unsigned flags);

 /*
- * Clear the specified object flags from all in-core commit objects.
+ * Clear the specified object flags from all in-core commit objects from
+ * the specified repository.
  */
-void clear_commit_marks_all(unsigned int flags);
+void clear_commit_marks_all(struct repository *r, unsigned int flags);

 #endif /* OBJECT_H */
=2D-
2.29.2
