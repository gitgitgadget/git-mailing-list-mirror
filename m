Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C92DECAAA1
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 12:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbiIFMcj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 08:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbiIFMcF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 08:32:05 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9288B1034
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 05:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1662467489;
        bh=kM20vDkHXj0A8A20XH6Fh9R/T97HPaB4jGXyd2XIUoc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CtelHR45IXIMET08xJ1Doka3SIP9U0naCDiwg/F6d//ZUmMCyIWmCJ6TmDPOM8sBP
         saxHL+EoQwAn8CMYganXQYtx2tVMDw7J/aGFf/HPCnKVppdq9vDVCuAUNRZumV9pzo
         r4AaU9X0+v9FCIUsHhveL6XQKouXIauQK8a4Ma1g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([91.47.144.123]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJFdB-1ooZvW0ZVz-00KrcA; Tue, 06
 Sep 2022 14:31:29 +0200
Message-ID: <a3e73848-4262-1875-5ba1-085d31297933@web.de>
Date:   Tue, 6 Sep 2022 14:31:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: [PATCH 1/2] diff-no-index: release strbuf on queue error
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <xmqqilm579hc.fsf@gitster.g> <xmqqilm51gn6.fsf@gitster.g>
 <181c029b-8b36-4b04-30f9-97a3f252bfbc@web.de> <xmqq8rmx1saz.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq8rmx1saz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HeIGmh+jrnuZqCkpQYdnQ4C1qxARqWbFAwNcG3NrBoYEVEgKZGf
 C0apDwt1iqWfTbo429UVIBIfjGAp/HMbOMpmGG80f9reDYN1hiKKKQAKYHBjWIT8LQXl4Ba
 TeVwK1sByYZU+gv3hVzgEM8TKAtAEYw7ZnpZeSa5JLHYG1DjOXt6D6W2RTR00ZkICnioRhU
 mxfW8le2J4L0qFr8mIiow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5XNbyRz1Ar4=:qXGQaAz/6J/ZsMp7k13pOh
 3zZ6hLGQmYoJBrfqAHpPbcY668vZkZcPkjhzRYa+7gmMcutelxG7liHj0IBiZnlTSepSw6LBC
 Hv/MEgJX63YirsHVW+ZM0CP0CunSUqNc+mKALk9TlJT/4fl+Z+FWYIjuw5vuEalAuOcim6JtN
 Sh+Vyy44JDQOcizNJA9pNhI7z1ze7xFC7kNhIpHbIoJgrlkU2V9mfxK1D8jck1LUOosKjsgc0
 yI+1qLNHrZ6vVn01o62jfI37NxeVHkdoclaf+LL86RB98jITZdZJIEgXQC3RZa6eCBPUPPwFq
 HFOIQuCW73V7b+Cy9n2qEwRddkRGP0b7z53ofBkUK836f7j5xeVK6Jn+vuJk+KRjNyAk8zoyX
 jP2xnJDHIiHLzX6woRFJVAadAKX1Wv5MBp+LF+FM6fOT8j6sL0LEnnTEU+ke+vKLp4qdNYbtw
 LJwoJP1iPW5hf3RYXtVxY19aAwlYi6A5dMvud0jBrkb2tZOT9312V4H5i8Kp+ytXxUddeLa5l
 9vbioHOSUY5bD19krNulZv6moH3JLjFZpx8ZajoI6SaEpy/cBwxkgwAV8vsEI1x9T4LH7kgpX
 e3M3DtxuGeN5jm/P/sIHHpu7g6IlZYYyRvTbkH/5xqqZ0gRh+j+p2YJBS5ex1SbTRH78lXyj7
 3Jxm8aDVu/hX1PdH8cFsXfZfdTZpAtnI8p9nZ+FZduKhPqYu1udsI4R3LdViZUWwjrJD/yie+
 cF9FLTRwZOpIY0dPh4fsLvoMb7Baop8+39mcjPZQ+a7DlbESmGy/S3ZJxTKHscoDKMUqLg3yi
 /XwrDdcHg7B241uxz5ZUBsl09N95CuMCBMBeAAGVl97L4C5qWmh86n9pCa7Pu91NlHIeMMGE3
 +hr3GTXQxC0Shw9xdNoivc2SAh51KDaXXQq/V/NdFRn8TzoFasI8uk+1VvSqlG8o6PVmBXJrA
 o2eaWyMMo1VOUtw+4lvBRZ/wUsKjhU7c5vsHRo3wvQlOTeg99Qvpi37/FFzgfzG3RKKBOSNd7
 HPJRf07Y+JC7laorEvSZGg7o9m+ccp3yVvC+qs6dSf+dpTl3flaqtwvjWLk6kbsk5zs4Q/Ak6
 WTG4phV0PjkdmAT1kBaUPbI2fRAIW7qiLEWD5iCZ9JwstnSRA65qcheA4HN6PbxMCiwGK37tp
 MMftg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The strbuf is small and we are about to exit, so we could leave its
cleanup to the OS.  If we release it explicitly at all, however, then we
should do it on early exit as well.  Move it to a new cleanup section at
the end and make sure all execution paths go through it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 diff-no-index.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 9a8b09346b..a3683d8a04 100644
=2D-- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -243,6 +243,7 @@ int diff_no_index(struct rev_info *revs,
 		  int argc, const char **argv)
 {
 	int i, no_index;
+	int ret =3D 1;
 	const char *paths[2];
 	struct strbuf replacement =3D STRBUF_INIT;
 	const char *prefix =3D revs->prefix;
@@ -295,16 +296,18 @@ int diff_no_index(struct rev_info *revs,
 	revs->diffopt.flags.exit_with_status =3D 1;

 	if (queue_diff(&revs->diffopt, paths[0], paths[1]))
-		return 1;
+		goto out;
 	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);

-	strbuf_release(&replacement);
-
 	/*
 	 * The return code for --no-index imitates diff(1):
 	 * 0 =3D no changes, 1 =3D changes, else error
 	 */
-	return diff_result_code(&revs->diffopt, 0);
+	ret =3D diff_result_code(&revs->diffopt, 0);
+
+out:
+	strbuf_release(&replacement);
+	return ret;
 }
=2D-
2.37.2
