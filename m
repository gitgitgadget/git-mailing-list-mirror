Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4ECC3F2D1
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 20:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5FE20842
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 20:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="nTENKaEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731966AbgCCUzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 15:55:51 -0500
Received: from mout.web.de ([212.227.17.12]:56919 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731339AbgCCUzv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 15:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583268938;
        bh=AZy8CSPY7geFhj+k5Zo43ydoal4kK93XPaDy1BkFDnU=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=nTENKaEPa1sSi1VHW+hO60RJvboQKBGqzQ6pFn6Diw0H+C63trGrNqM2QMVCZURI2
         GHZjLYbeadaVJHL2kgT25C2yg04zQ6Ol2T33iOsuQfcfhvlf8EU7xQANQfTYxWklLr
         k+8CNQnrlmyv1OIT8Qs79vxqDSm0mdBQZ8ttplrQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.21.89]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lrryk-1jVcM03BaY-013bZs; Tue, 03
 Mar 2020 21:55:38 +0100
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Manish Devgan <manish.nsit8@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH RESEND] remote-curl: show progress for fetches over dumb HTTP
Message-ID: <e387d31d-afab-fe09-4e37-535a2650afca@web.de>
Date:   Tue, 3 Mar 2020 21:55:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NSdb9txwXsqPDrnitE5Ov8MqCClexfJuZHW22M7TSE2fWuDpt8b
 lWBJRZQM0AoHhDls5F10u2p+6ffGoBokgoeURSr1kONDhBkBYbLhO83tDVWHCeuhjQkTOcD
 PaQF7mqMHmyMpuwawaHcQydayCBBR77ojm/7fHz3hjsssbW9U83nDuc7ATrqoVQCgQIYtpE
 i5fHfIwczOYmI5U7Ax7aA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1B0Q8Dltspg=:YHZY0vaj7eUOTDtFMpPv6I
 PS/6KpwnjtMZEuIWPnaUINPcfcqq3j+BA9pD2PggzUpBQhONigP64emL3G745ijP0EJfUx1lB
 NERjWKlrWSgLBgzOR8zM03cmJddMknKJvv0i7Ve6nwgQNV0s54KSQkDPt3TWTmxBhiD9A/IU0
 D6rN+hEH35mBjilCAbF25Ta66cUWvYK9R0tLlUgOz/3zuVhJLjmuPuJyFg89vE1gLtzxTTFKk
 QM34wG5Xjz03eL88hrduVEX1dohWBtXmWkkeqXg2mHZBO1hrzRBUKMd5VRDKhN8XRpuSexwD0
 I8QZ6AY9hm6v4JobVlKqU4vsDN/W8LWM8tJBTXvZ2KqjLxtMW4XQIkTKDn0/HdFVzayBxVG3e
 syDErcRgXf0D3w7U/wj2rGTJHaj7JOhzq3LTJ7cX5tE5RimuNTehRV1Bj30yzX4F0tL9OZzTA
 5FjFAeY0HAVWTRukwqzcxZg4pPH0kiZBE8UL66wJk7rxc/Bq682Fai5KpBN74OFtU5OnpLO0Q
 MDVkpMfqMm7Sk/DvVV//RaesVX+iS1k0aoRrJTZ5aKfTevZwUo74gavS+6qDMlm/euQmvZbnP
 Zse8QgcoJziV2qDcw4JxpKTKuc/82JVztt5LzojHYfo+1wXea/tcCmA6YIdsuAqSeipWmXTGt
 /r/KNXjKPXD0yqPELZG+huCROR2lAqeCaO5/hnHxWYmkCXEGi+gmUoBGuynOhawV1eUgcXdWq
 qe9ybv4Ppcs4+sDRDFsWWj0g/cBFtAUuBhTcQy4nOM/9J+8FF/tQMSbauYHBnwN7WqAGzKlI+
 xDAa80QOfv6M3CM3QBMvOuhd80uMO9QB+TwhZfIBMANHbF5oqDEY2rLpbwWutxyV6vQyxUoc2
 6u+mZpD/VsSZ8Iy33XyQaiT/BSr8kuLdnosXXlbXPkUTqUkM8hUHBGwEjb6feqygEmAxXgvxo
 WGEFQ/ea9rUB45uDrJeFpsxqD640QkdbAo+XP65vhGCcjh1pTzKrc0PPf2ZhR5Tkfq9ojCvKK
 pyo252JW8OtEbb9M1Gt+DEe3o/f0wFASdWtISWmhtesQK7PmwIxJIZX8Y0uqCOEZNngWcFxvT
 RLSYIiuvcuKG4sZ2pXDgRI1FaviW+aVQQqIpEYtYnWjmUkEAtsjiu4BBn/uF+m4WWrn78psYx
 kb8wHapcfPllUuZ18449E4FJIk/7eTDijoaL98VGtP0dJ/sMlqKRBm1r+orGsBNS0zEgE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fetching over dumb HTTP transport doesn't show any progress, even with
the option --progress.  If the connection is slow or there is a lot of
data to get then this can take a long time while the user is left to
wonder if git got stuck.

We don't know the number of objects to fetch at the outset, but we can
count the ones we got.  Show an open-ended progress indicator based on
that number if the user asked for it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Original submission:
https://lore.kernel.org/git/9ed26e7e-c19c-cdb2-0710-3b91bf31291b@web.de/

 remote-curl.c |  1 +
 walker.c      | 13 ++++++++++++-
 walker.h      |  1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 8eb96152f5..e4cd321844 100644
=2D-- a/remote-curl.c
+++ b/remote-curl.c
@@ -1026,6 +1026,7 @@ static int fetch_dumb(int nr_heads, struct ref **to_=
fetch)

 	walker =3D get_http_walker(url.buf);
 	walker->get_verbosely =3D options.verbosity >=3D 3;
+	walker->get_progress =3D options.progress;
 	walker->get_recover =3D 0;
 	ret =3D walker_fetch(walker, nr_heads, targets, NULL, NULL);
 	walker_free(walker);
diff --git a/walker.c b/walker.c
index bb010f7a2b..4984bf8b3d 100644
=2D-- a/walker.c
+++ b/walker.c
@@ -8,6 +8,7 @@
 #include "tag.h"
 #include "blob.h"
 #include "refs.h"
+#include "progress.h"

 static struct object_id current_commit_oid;

@@ -162,6 +163,11 @@ static int process(struct walker *walker, struct obje=
ct *obj)
 static int loop(struct walker *walker)
 {
 	struct object_list *elem;
+	struct progress *progress =3D NULL;
+	uint64_t nr =3D 0;
+
+	if (walker->get_progress)
+		progress =3D start_delayed_progress(_("Fetching objects"), 0);

 	while (process_queue) {
 		struct object *obj =3D process_queue->item;
@@ -176,15 +182,20 @@ static int loop(struct walker *walker)
 		 */
 		if (! (obj->flags & TO_SCAN)) {
 			if (walker->fetch(walker, obj->oid.hash)) {
+				stop_progress(&progress);
 				report_missing(obj);
 				return -1;
 			}
 		}
 		if (!obj->type)
 			parse_object(the_repository, &obj->oid);
-		if (process_object(walker, obj))
+		if (process_object(walker, obj)) {
+			stop_progress(&progress);
 			return -1;
+		}
+		display_progress(progress, ++nr);
 	}
+	stop_progress(&progress);
 	return 0;
 }

diff --git a/walker.h b/walker.h
index 6d8ae00e5b..d40b016bab 100644
=2D-- a/walker.h
+++ b/walker.h
@@ -10,6 +10,7 @@ struct walker {
 	int (*fetch)(struct walker *, unsigned char *sha1);
 	void (*cleanup)(struct walker *);
 	int get_verbosely;
+	int get_progress;
 	int get_recover;

 	int corrupt_object_found;
=2D-
2.25.1
