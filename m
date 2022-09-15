Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029D0ECAAA1
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 14:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiIOOwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 10:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiIOOwV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 10:52:21 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A432B43315
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 07:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1663253525; bh=fuYAzHKGgZWX3jNE/5nRrvdhz0MnDeg/o/aZY3REUvg=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=OgZ0abzAVpZG8/AHQLsgFk/tSPp7ebAV1pjiM2Pr476CjKh6eBqoBNuWNB4DsmuwG
         rTzhhpod3vPGNSm+nZrS0eXZ3B8u4K5Tkf4DTK6LFb8vGZrgRAOLa8yLDH68OE9Gg5
         P+CUt2lD5SBdHHn0W+H1DbNnXQ1738vVzGPCjHdlG8agFIU9ViEFBNPe+k3LUrbZa8
         pLwqCOv7Zt8IfB90GBRx4cxYFR14mjcFPABzs5tmP9I3ORSMhFVGChZb+88rPC6cAn
         6G2wB+3EFi0hvr91cHHYcnnTyWZ8C1GAhyQPa874H5iEX7wYwgBXuVIh43DhS/bD2D
         6lyJxAaS52b8A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.24.217]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7gXQ-1pKqVb2axe-014ujF; Thu, 15
 Sep 2022 16:52:05 +0200
Message-ID: <90bdf408-9bad-6816-06c1-66ac64ea9c3b@web.de>
Date:   Thu, 15 Sep 2022 16:52:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: [PATCH 2/6] revision: factor out get_commit()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tim Jaacks <tim.jaacks@garz-fricke.com>,
        Chris Torek <chris.torek@gmail.com>
References: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
In-Reply-To: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KfiZ4C5nhLaXTWPCwAcgQd66k+/dg1+ej8atjg4RpkRuUqQ9Imi
 VzPbJHgPRDDwRBA27CqJ3CVQ6+2qAya8GT8KeQ5PoPPCEkFIL2gucI1zHIeeQOUccBibr5s
 rk7v6WEqp67pS4ESNMsN5Xqxvl2DYmkf7iDWn3D7kSWjHoW6d24YLrt16lT30p409wkbYHf
 jMyaqfKDmgiu+hORerfhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nsu1/cBYMFA=:H7PFi3zZdwRzM5vgH2l3jc
 8Ke7HwQSEkcBc3qrp0WiYMLDKp4wkcCZoheryUmWDeyrWpzRmJDEKrIs6lhMu7FGExhFGQVAt
 UaXgXDUGre/n13XrcwXyp5gcoLnQEmnSPzcVUrIRtK+67oH1ArRfMtWOBz+445SmMGWLbQIYt
 yrdC2FC95x37tv12l+yWGyDpsHuMkOyFOyq93EVdbLMwiqLRDu6vmnNCtXAywhufETOThK0K/
 2iKsinjJfkytqNlRyw/RDvCm4lqCisjZpDVXYzVvAz1Ng7pzpJibyOrcZh3qv9UdOvIlHkSsk
 phteQdkfG8VvuVpvDpdZM1Bxf58KZtTxsKqMlBDi6h6fyu2PgaT3xdFLlX7/LMC7rP0EbRrjp
 3LLsNfT5IAtSK5ecj9UzRcXxRjbRynb+Ms1klsAzeAxhqDhiTJ+W8T28vcyZt6nh86ijyv1tP
 zacC0sHGX5qd9p0uBNmcrA5GPUMLp9CoGxC7+MTF0lZjrxWQzdxID1jbEPite8RXyz+P/r1EC
 +tQoQpJVgdyi7G4sBB6OOv/RPgSGcdOVE8atMrozdE/A17DtyMFL7xhnN1VMGKjQfeazig160
 PjkyrZVkfckZh04Gj0pAoG9nkQi3zEt2SQTGQ0MkcBAg0K9rATJnmO0gd8h3oLlV9i+K/m2UJ
 PA+5dRDRXTcJ3xfHBHFxMk3GGTLa7Tbmmjw9MLPt+tRCvOgkB0rcAE4aDMbiQm0XyStxMofRS
 4GvZ0XwmTLx3IC5PZ+c5UqiUO6l/EerV8qumI6+/Lfp5+lpeOcnFCL5DFl+Arse6mT3vQgQgj
 Lq5mH9tATTCm5ZItwAgqhB5ycgu/4/KSCvmVWOhycO815Tbd9fvYhalyoBF4toyXM3QmJ3Q2u
 2DrEkBiDXJ/suTzJgLkVFXA+tUxcUkJNsnZedpy/LGCV0l/nZgsI9PENFQld2FAdpCleo1P8Y
 Z4+AYru0MPao15kFao60Cx0xKOvZDtvd9bzJYPVEgZEqbQQUUE2MNxSqvdtyh5p4Rq26u0mQy
 Hv86+n9G08tNi4iF/MTBCE2CjughybK7U05wZBO+qqob9cI6PYtVczP1EhonAzTe9fSsRHClW
 vOyyNmfwDRAVlusTJnGFlXlkwy98NoHaYfAMMkJ6SgRwWcGoqiATYrjsjj0tKUWf5/TaWg99G
 p5DUY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split out the first half of add_parents_only() to obtain a function that
finds and returns the commit object.  It allows checking the validity of
the child separately from adding its parents.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 revision.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/revision.c b/revision.c
index 0b8d48f94c..4f896b4992 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -1822,35 +1822,46 @@ static void add_alternate_refs_to_pending(struct r=
ev_info *revs,
 	for_each_alternate_ref(add_one_alternate_ref, &data);
 }

-static int add_parents_only(struct rev_info *revs, const char *arg_, int =
flags,
-			    int exclude_parent)
+static struct commit *get_commit(struct rev_info *revs, const char *arg_)
 {
 	struct object_id oid;
 	struct object *it;
-	struct commit *commit;
-	struct commit_list *parents;
-	int parent_number;
 	const char *arg =3D arg_;

-	if (*arg =3D=3D '^') {
-		flags ^=3D UNINTERESTING | BOTTOM;
+	if (*arg =3D=3D '^')
 		arg++;
-	}
 	if (get_oid_committish(arg, &oid))
-		return 0;
+		return NULL;
 	while (1) {
 		it =3D get_reference(revs, arg, &oid, 0);
 		if (!it && revs->ignore_missing)
-			return 0;
+			return NULL;
 		if (it->type !=3D OBJ_TAG)
 			break;
 		if (!((struct tag*)it)->tagged)
-			return 0;
+			return NULL;
 		oidcpy(&oid, &((struct tag*)it)->tagged->oid);
 	}
 	if (it->type !=3D OBJ_COMMIT)
+		return NULL;
+	return (struct commit *)it;
+}
+
+static int add_parents_only(struct rev_info *revs, const char *arg_, int =
flags,
+			    int exclude_parent)
+{
+	struct object *it;
+	struct commit *commit =3D get_commit(revs, arg_);
+	struct commit_list *parents;
+	int parent_number;
+	const char *arg =3D arg_;
+
+	if (*arg =3D=3D '^') {
+		flags ^=3D UNINTERESTING | BOTTOM;
+		arg++;
+	}
+	if (!commit)
 		return 0;
-	commit =3D (struct commit *)it;
 	if (exclude_parent &&
 	    exclude_parent > commit_list_count(commit->parents))
 		return 0;
=2D-
2.37.3
