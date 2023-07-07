Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A11EB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 18:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjGGSqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 14:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjGGSqa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 14:46:30 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549242682
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 11:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688755586; x=1689360386; i=l.s.r@web.de;
 bh=Iqyumc9rkqRabbBd/y7XFIrXjbBRvLwVGgxJaXEedrs=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=uwSuY/Q4A/Jscf8MGjJXwDdqbWrsUZKBgsqhdK/e0u6vfv3rtcLIEngEr0SPLVpkcO3l+Qh
 hnTjOkfcXI9vwl9ICIpxON9fe2S6WyHgVaaDqaCCXzsXMvljdDhiFkGbO7UKSQW3iZPTQK4Zd
 sARqRLI3HaHfkAYjchjWMKDogjuD58qCpJmQeu8L5/gjByKooBCEHAzVn03xVCj1EHu9N0qU5
 nqvV5OAsxU5Q8yxhT55B7peEfPjEERkBZaymBU6HnfcQCnf7OhhmnlS4P3s3N0SYqxiX+N56P
 5XqcD0QuDa3oAXkdVjtAQbvvmzGCvUYRHhNuU/pf4bm8UwbGpL8w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.158.134]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MaHWj-1qWMZ51bnB-00Vvhh for
 <git@vger.kernel.org>; Fri, 07 Jul 2023 20:46:26 +0200
Message-ID: <8d4fcad1-5f71-4790-17ee-e9ba0a3118dc@web.de>
Date:   Fri, 7 Jul 2023 20:46:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] pretty: avoid double negative in format_commit_item()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MbhFyxYXvfHC6PQAwPEY1/Se+z1p+sOQMAcq/ZqOQh9nPfofMTQ
 EaL9Sa84Eft2H7PDJyAe/4+/Wn/J9lVQR1QLWNUMkGb7Pj0ea45KvKescK2VNc96/Ja39yL
 Nt1c2BDo+3RLMR3pTUFDVP3cyAEvD9EZkNASVKcj6thw7baIwGnDhpEAPtWp10PFgZQnt1B
 4B/wyfqS+iyni3UrOliEw==
UI-OutboundReport: notjunk:1;M01:P0:O0Z0U5BraEQ=;uMOUizgmwIABjmofrvJX/6Kuxpx
 /T0teM0kmLv1vrJYs5/0GLHc1w2z463/MWLMPz5UXT+UKpLXndRkxC43IldQWcHA04hwTEq7d
 /1ao3EAjuFYFg15hMdiFJfCD9Xci3te6jZYD6w/vVtplD2zQea78/evxoGobNmi8K9ZXsp4LT
 XuaodS284Ne2j/86akXD1vy8MIgXHNXcWlkJq7iRWtKRwxWZINjIabxx5DYJgN8zIeEOKa+6m
 78lNOJ0detuNYEBGzXuAPB0UtCpzo8MQlU8jLeFGjXkO6fRn2cQzN7hiD2uSyOZ6uVk7LWytN
 21SWOUzvZdVyIg+FeVri9QsU6dZCGMohp180x2HCaUvNNVYeqQ8rZnStF5xKaOVn1mReXsufl
 52lDw2m+zkcRu9y0Cd1IrrHdqzTUVjYA3ud8bMZoHSGykDz99GJL/QtKJNUU1hSnVOJK0slcH
 igPCxyRsPnIg3hyT7fhgMJDCikLihgHUvosjDBiz20XwB9CSuZ11PwwsX7eowMtUmXnCqU+rT
 6Lep1ICCTLz1QZgdu9RCofkdj77Dw/i9A+kMfDrVcLQxtAZXT4AEQ9xI3MaTn+FeLOB704oAe
 DsVNKvMxBuAPSs3MKn20jNvCatTvB4mIKQnxXUDFSIIt1xtJy5wDuITxzZyEI3DfNFZlkcz5N
 /vFFqpmIPkOigrE+1qBxuAzsWEksd1EgaGoSxUeEzFN/cxDTfaMTde8ocU5AjJo6x51ickpLd
 35oUBPAl4f1oIMs/o9noVzmvr8jGhyvAAeuTHA2zKVrI4OXPxwVPVDlwA0je0xh2istzya3ME
 hI4UzawH31fLjARLU59IB57Q5u+0sZikdtZ+QclnSz+gnqBm7O28sneGAHj2tzmQENX9WudFX
 kByGxG7NPoBIgRKQgmtOx0XnXGtjh2wNhtYVNpjrWoUV+Xp5xZRmy+/4jtpBI7w0wWbC6nhWO
 w62UqA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test for equality with no_flush, which has enough negation already.  Get
rid of the unnecessary parentheses while at it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 pretty.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/pretty.c b/pretty.c
index 7862be105d..81cdc9f2cd 100644
=2D-- a/pretty.c
+++ b/pretty.c
@@ -1855,10 +1855,10 @@ static size_t format_commit_item(struct strbuf *sb=
, /* in UTF-8 */
 	}

 	orig_len =3D sb->len;
-	if ((context)->flush_type !=3D no_flush)
-		consumed =3D format_and_pad_commit(sb, placeholder, context);
-	else
+	if (context->flush_type =3D=3D no_flush)
 		consumed =3D format_commit_one(sb, placeholder, context);
+	else
+		consumed =3D format_and_pad_commit(sb, placeholder, context);
 	if (magic =3D=3D NO_MAGIC)
 		return consumed;

=2D-
2.41.0
