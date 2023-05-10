Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A65C77B75
	for <git@archiver.kernel.org>; Wed, 10 May 2023 03:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbjEJDBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 23:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEJDBG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 23:01:06 -0400
X-Greylist: delayed 589 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 May 2023 20:01:01 PDT
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646C71FD7
        for <git@vger.kernel.org>; Tue,  9 May 2023 20:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1683687072;
        bh=px9+4tXT4ojcJa1SazdLMS+jin2lVe8IR0055jK2nJ0=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=P6R5IP9EyijzepkQ7pASGnueObI8Qd4zuOCXa2e2vEWaEiFPRB1U0XwVUQqpVXsCM
         bUrwMNsIoyfw1Q70PLVNuv8DluXy0hAj85nheDgQZHHoq9g2CCON/0mq1Jf69VlH1C
         XZ4qBytu/WL2Nd/sBrwcuu/ILjwpppBfBj1451uE77oXrukiQd52k9KaNwVeuNEmUa
         F8dD+rWJm6oZS2zzuSliTcDU+mYKd6OqhL//bUQDAScVWUVVwbHZIzbxOjN+26hEfM
         n/TQmOCusKQqLvkaXPcr5fY1iOFI5jd0mlr3ijzPHTm7DvmbNmUxUOGrlPFPzpxkGN
         NIZMT9VeBw7Ww==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id 956688E00CE;
        Wed, 10 May 2023 02:51:10 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: Feature Request - Better i18n support
From:   Emir SARI <emir_sari@icloud.com>
In-Reply-To: <ZApgtJqVxkory4/B@tapette.crustytoothpaste.net>
Date:   Wed, 10 May 2023 05:50:56 +0300
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D9534BB9-DF29-425D-9B4D-4DE051C1DB8B@icloud.com>
References: <ZAnXddDN7v0AOBdm@mbp.local>
 <ZApdaAMrkmFcxarq@tapette.crustytoothpaste.net> <xmqq7cvp8sdu.fsf@gitster.g>
 <ZApgtJqVxkory4/B@tapette.crustytoothpaste.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: Apple Mail (2.3731.500.231)
X-Proofpoint-ORIG-GUID: 4lIVg9kCworIjww91LtlxLezQ4X4q0Yn
X-Proofpoint-GUID: 4lIVg9kCworIjww91LtlxLezQ4X4q0Yn
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2305100020
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

How does the below diff look:

diff --git a/apply.c b/apply.c
index 6212ab3..3e1d08d 100644
--- a/apply.c
+++ b/apply.c
@@ -4247,11 +4247,11 @@ static void show_rename_copy(struct patch *p)
 	 * new_name through the end of names are renames
 	 */
 	if (old_name !=3D p->old_name)
-		printf(" %s %.*s{%s =3D> %s} (%d%%)\n", renamecopy,
+		printf(_(" %s %.*s{%s =3D> %s} (%d%%)\n"), renamecopy,
 		       (int)(old_name - p->old_name), p->old_name,
 		       old_name, new_name, p->score);
 	else
-		printf(" %s %s =3D> %s (%d%%)\n", renamecopy,
+		printf(_(" %s %s =3D> %s (%d%%)\n"), renamecopy,
 		       p->old_name, p->new_name, p->score);
 	show_mode_change(p, 0);
 }
@@ -4270,8 +4270,8 @@ static void summary_patch_list(struct patch =
*patch)
 				show_rename_copy(p);
 			else {
 				if (p->score) {
-					printf(" rewrite %s (%d%%)\n",
-					       p->new_name, p->score);
+					printf(" rewrite %s ", =
p->new_name);
+					printf(_("(%d%%)\n"), p->score);
 					show_mode_change(p, 0);
 				}
 				else
diff --git a/progress.c b/progress.c
index f695798..1f8d372 100644
--- a/progress.c
+++ b/progress.c
@@ -124,10 +124,24 @@ static void display(struct progress *progress, =
uint64_t n, const char *done)
 			progress->last_percent =3D percent;
=20
 			strbuf_reset(counters_sb);
-			strbuf_addf(counters_sb,
-				    "%3u%% (%"PRIuMAX"/%"PRIuMAX")%s", =
percent,
+
+			struct strbuf progress_sb =3D STRBUF_INIT;
+			strbuf_addf(&progress_sb,
+				_("%u%% (%"PRIuMAX"/%"PRIuMAX")%s"), =
percent,
 				    (uintmax_t)n, =
(uintmax_t)progress->total,
 				    tp);
+			struct strbuf progress_str =3D STRBUF_INIT;
+			strbuf_addstr(&progress_str, progress_sb.buf);
+			strbuf_release(&progress_sb);
+
+			if (percent < 10)
+			    strbuf_insert(&progress_str, 0, "  ", 2);
+			else if (percent < 100)
+			    strbuf_insert(&progress_str, 0, " ", 1);
+
+			strbuf_addf(counters_sb, "%s", =
progress_str.buf);
+			strbuf_release(&progress_str);
+
 			show_update =3D 1;
 		}
 	} else if (progress_update) {

I=E2=80=99ve left diff.c out, since there are no accompanying localised =
strings to my knowledge. If this looks good, then only remaining thing =
to tackle would be localised decimal separators I think.

Best regards,
Emir (=F0=90=B0=BD=F0=90=B0=BA=F0=90=B0=8D)

** E-mail needs to stay simple
** Use plain text e-mail

