Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EDDC6FA83
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 11:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiIGLpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 07:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiIGLpw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 07:45:52 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D622E6E2E7
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 04:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1662551143;
        bh=7XzwFojnr5T8h7EPPJemK8wTgtw7mPlcb1gZr+LhE64=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=eDPmCQ5g8xFy494ocp42Ika6gYbPqCo55NIs7/DQX3+dFExbGRaQBDqS+N6OCyKwK
         aOIhTu3OFZpkGpkDCaXhr5dF6FU0abz3TPynClbHrF9K6eilk3izk7PVLy4xGEkT2h
         beP86aBpBsEZ8o7ISZ1cRcCnost+j7pzghowLwFk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([91.47.158.123]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mkmzl-1pDWNE1bTT-00lrGX; Wed, 07
 Sep 2022 13:45:43 +0200
Message-ID: <9ea33608-3a6c-c0ef-9bb3-4bb535009aeb@web.de>
Date:   Wed, 7 Sep 2022 13:45:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: [PATCH v2 3/2] diff-no-index: simplify argv index calculation
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <xmqqilm579hc.fsf@gitster.g> <xmqqilm51gn6.fsf@gitster.g>
 <181c029b-8b36-4b04-30f9-97a3f252bfbc@web.de> <xmqq8rmx1saz.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq8rmx1saz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N+tjUduiY5v+Np9a+jIbG0YIyAE/smGv9iCXyNja/O25h2Tsmxg
 BvPFWBB4yG9amcoiSByDPNyR5lEV53/ve9r823bDkzRqKEt9tBxWyf3P9UYibOpIxDlTeWW
 QrimC0cFmL/CjdK0i3z13eHaiXVzw0ZHIjTKzKINzq9os81vtuNd1L0ZEHqNhNpVdZ2dj/u
 NUX1PG+NFtsl7d/dfNanA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P+hJA90Sbqo=:h1exyiKe6joIabVcxSjw3p
 23OoQG29KfdRH0QWuSt7E+yqFhsXMljPCXmIru1D2GxnoGCMz1ziTzJUzzcaQwuBSnQbvLang
 j1EE3hq6FtTnEdp09c35ZPuo7f05YXqf4DHA8pQkN1TqQUl8OtzHHDIgbU9RGe1ALERYmC3u6
 waNc4ZSqmgyQ7XcUweDhgV0lr2V3+zpOjTojWKWtfy0/JH6Iez0K0CAF6J2/30WPtkNvZ7VAU
 3DDPSSTQRs4OeVEXYCY9wi5GjH5S32lL0jgKd5WeSBw9Ugzjuo2urRyonmwlgAR6sjA2Hl84O
 eXgmfnrk/MajU+Xz8MK9aJhQTXpDrMTW4VMN1vdIn6lbhk7K2ecXQwQWGwuA23PTb83KTIHun
 JZQJhD0FTn8Ke1igHnmuorzD2js+efElN/vxYenr3OU8UXbmtLIuXctBrXc0qdGr5cs9Kh3L3
 BEl2NbZRZKQnh4sxLfvwknOzRmvyHj9AgqOxiM8FcMjGAQl4ij52rW4HTshBG942NdzvjA3/+
 z0J+e8Oh7OysoJtNA+pZKK1Ru+AjagXfaKIwUZHqh42K0fjLq6ehh2q2SJWH7l57+Na0wkSUs
 /H3NPrzkHWdLpPlDuGp7wg2sA2jDkgzIymB9blTW764ROBKhiRQLFv5oELKwU5DGk3UNiZ3Yx
 FLAMosU4+56cTRUNzOO/nh87UUrBEV+SE/rpu/p+qx10OGdPQCnWspmWmu6K9kFDAAHplkq4v
 /Vag8XwFuKMWzvIJsgbkaWHJ/Q8Ei4pgvK/eMSMR6bXbj6v7KG+8Na7saLS6UOP1itTsKvBBu
 hUD0YkOVEWivri599ZAppKCg4x33vRG9MGFVwTGK7oAhDwlGaXZMmH00BO4Pt2TmxJI+obegA
 72hmpAoCqRG5HJV5h938v/4HmuTR3JBM0L+WmfLfA3XoZtMnDWfBLPEZO26h2sW1LXIlxeUED
 meX3eSQC5zCFvPDW/t7nxIZz34JREppTnG+x8MdwOFwlvVMZGn+DVXieCNN/tKa2q8/ObqnXY
 RvPhJ0XDfgGrzyG3gul/J5QIpXelGt8pXTp7/DAT+177JuMavQNpYGn9ypW3dIkqFqe2zo5B3
 h1X0OAKv6MNbCdLKHUA/wTlyoxwVrzvlTnMr8iLMBBe3pAm3G9zkPI8smSTX/iwgpHBBmvWKX
 nWxS8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 16bb3d714d (diff --no-index: use parse_options() instead of
diff_opt_parse(), 2019-03-24) argc must be 2 if we reach the loop, i.e.
argc - 2 =3D=3D 0.  Remove that inconsequential term.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Bonus patch "while at it", would have saved me from going "huh?".
Generated using -U8 for easier review.

 diff-no-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index a18f6c3c63..18edbdf4b5 100644
=2D-- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -262,17 +262,17 @@ int diff_no_index(struct rev_info *revs,
 	if (argc !=3D 2) {
 		if (implicit_no_index)
 			warning(_("Not a git repository. Use --no-index to "
 				  "compare two paths outside a working tree"));
 		usage_with_options(diff_no_index_usage, options);
 	}
 	FREE_AND_NULL(options);
 	for (i =3D 0; i < 2; i++) {
-		const char *p =3D argv[argc - 2 + i];
+		const char *p =3D argv[i];
 		if (!strcmp(p, "-"))
 			/*
 			 * stdin should be spelled as "-"; if you have
 			 * path that is "-", spell it as "./-".
 			 */
 			p =3D file_from_standard_input;
 		else if (prefix)
 			p =3D to_free[i] =3D prefix_filename(prefix, p);
=2D-
2.37.2
