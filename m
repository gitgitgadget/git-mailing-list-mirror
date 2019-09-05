Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2A441F461
	for <e@80x24.org>; Thu,  5 Sep 2019 19:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389853AbfIET4H (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 15:56:07 -0400
Received: from mout.web.de ([212.227.15.3]:53341 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733174AbfIET4H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 15:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567713356;
        bh=040opt7cliTMgUnVydvKI+S1G27ePa/nUA8toK9WTwE=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=Qx5U70a64rMRdc0fJHzz3XP+6rT9EU6JovrAkxPrX1gYufi8Yyid7QDxrzC1Bwa8J
         K1IRYG9LNDFbNtjezml2EJItZmNdbKB5sadwY2CRfO9VpkCBotYX9/FWOYoMVam8dg
         udrTrdpht6j6NXd4YigG6OMxBKIarFs4paST86Tg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LxNyU-1iD9xG0mc6-0170kl; Thu, 05
 Sep 2019 21:55:56 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Sperling <stsp@stsp.name>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] tag: factor out get_tagged_oid()
Message-ID: <1385c954-d9ef-7ef6-6185-0dad885531ec@web.de>
Date:   Thu, 5 Sep 2019 21:55:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m8qI46EJWDIhJhhNAwsfhlYIyRaG4nPqm533AK8VxAOGIrLNb22
 e1MyG6eJv5+56kHsr1RILkkPBnw0YnjamZTDEvW4+SxMULf8uJJxPpdkSsiTPzeKerdHa9P
 BzbL4bLecvkh6lKNZmG9cA4sg7gf1jCq2cd5QGNChCLY7IZNaMhYUNEEuRXXafUDlXNaLjU
 o0nOvciPa5mWZ7vS9MbkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/jn32lQ9ztQ=:F4tyn1eXqvLHFacqi19dx2
 mXOmsEgRmS64RHk14kOaIR6ZInuUnCbVwE72d4lG3mrJ0GibHl2PIgIm97HF3Mm/SHJIeRyHh
 QXsjiUjgc/YZW+RYYu+BciYjOZpw+f1htphTfIe059Mb6ywmExEiQYsb/KIacz2PEAqKvnVLw
 1nvLn0zqoC5B6JxH4zL0jg4vQK0HNdiUw7kkihgZOSn98R7/XVhId043f7vKXUh8TcHPhK7JJ
 0AFBYMSwjDnJ4STI8CDV9t+JO5Co1OtmdxExC+rWeJ+HhAnE9kw3FPvUZ6kmb/8RQ+6bl0LVW
 5mvBTR4t0gIcN/YCMSqnNCky4+78hoPwAXrYyMWhews4sGg0F/u5PT4S+NeaSJvlbNnfR5zVD
 xnGBYShiAUqH8d3IEEy92MNQK7MLW8fMc8uHHbgMt54Rfiv0pfjs6j4BeznO8Pa95JkZksXKP
 OVqAu8Hg53yczGQjv61nkr2Ql/zYMCWHsNrTowAhSqy0DT5VzvqtG/nr+nZCx9maUK/PmXnYN
 2UaVd6zv1HCJmuI0GdoJe8OBydMgFU34nlctOE2D8hZgHQU60am3qkoeC0sPhtEr1lzKb+u8T
 19Ghck8cqa1ubDyBdcj3ElazbGmf0/TdMeLW3OEvgrSGJkrrUeBohInbuJzO85Z6VBbBg4cHM
 brddp6f24cQG5lF+x33YXD40y6P3lB9N/90iU3pjwmZFf45f0smFuLbw9+nA+VNwO0WOqljBN
 Yw6ea2OLdq8ZT1ARJgaa6CXRY0G36Ol40OoYNVmAXoA7J/IDlWFEcqznWdhk+3+ieC2VLK7Lq
 uD331Zk13xTpYYIwq2+wVGxCdV3dpLMn1f+aXXQQk8NT00UiElxREaZTlmFhft6iCPq0iJcLE
 RPIfjUhOSzTX/OkhJDR5C0gxsMxyWmEOzww/VkHTas9arOPjevzYdPfLO8C2KC31jBw9Kn4C0
 A0mHfRDN2gOza0qbmX82iT3p/9If2pel9pLBnH6uqlGQ156N6ISOoPMqkhoZmePSnEtLbXh1S
 BDrwMERLNWX1GIWYdznyRIc2lj2vRAfM7mbVVAY7nrnAJSy0i8YAZTx/0/xX3lu43D9mENJlj
 D/Fg+gArh6ZyXZYf5Y9Erje5owOJx+vkxKTqXJqRbpItbU+eF4n14v8MhOK2KEHGohDmsqeo1
 PbHZlv22W0PST3zlMJ1cSOWnAXigwI3+ew5T0FsXCGN/sJ4i5+j5eqTo3FI5o723al6jI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function for accessing the ID of the object referenced by a tag
safely, i.e. without causing a segfault when encountering a broken tag
where ->tagged is NULL.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 pack-bitmap.c | 4 +---
 revision.c    | 4 +---
 tag.c         | 7 +++++++
 tag.h         | 1 +
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index ed2befaac6..30842e1e74 100644
=2D-- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -709,9 +709,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_in=
fo *revs)
 			else
 				object_list_insert(object, &wants);

-			if (!tag->tagged)
-				die("bad tag");
-			object =3D parse_object_or_die(&tag->tagged->oid, NULL);
+			object =3D parse_object_or_die(get_tagged_oid(tag), NULL);
 		}

 		if (object->flags & UNINTERESTING)
diff --git a/revision.c b/revision.c
index 07412297f0..ee1b1552b9 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -404,9 +404,7 @@ static struct commit *handle_commit(struct rev_info *r=
evs,
 		struct tag *tag =3D (struct tag *) object;
 		if (revs->tag_objects && !(flags & UNINTERESTING))
 			add_pending_object(revs, object, tag->tag);
-		if (!tag->tagged)
-			die("bad tag");
-		object =3D parse_object(revs->repo, &tag->tagged->oid);
+		object =3D parse_object(revs->repo, get_tagged_oid(tag));
 		if (!object) {
 			if (revs->ignore_missing_links || (flags & UNINTERESTING))
 				return NULL;
diff --git a/tag.c b/tag.c
index 5db870edb9..bfa0e31435 100644
=2D-- a/tag.c
+++ b/tag.c
@@ -212,3 +212,10 @@ int parse_tag(struct tag *item)
 	free(data);
 	return ret;
 }
+
+struct object_id *get_tagged_oid(struct tag *tag)
+{
+	if (!tag->tagged)
+		die("bad tag");
+	return &tag->tagged->oid;
+}
diff --git a/tag.h b/tag.h
index 03265fbfe2..3ce8e72192 100644
=2D-- a/tag.h
+++ b/tag.h
@@ -19,5 +19,6 @@ struct object *deref_tag(struct repository *r, struct ob=
ject *, const char *, in
 struct object *deref_tag_noverify(struct object *);
 int gpg_verify_tag(const struct object_id *oid,
 		   const char *name_to_report, unsigned flags);
+struct object_id *get_tagged_oid(struct tag *tag);

 #endif /* TAG_H */
=2D-
2.23.0
