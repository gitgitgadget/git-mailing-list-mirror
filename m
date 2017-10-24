Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01D371FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 15:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbdJXP1c (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 11:27:32 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:41669 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751519AbdJXP1a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 11:27:30 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20171024152728epoutp0157de6d2e683d69424fbf2f1474ca7830~wiyDjbgSN0594305943epoutp01A;
        Tue, 24 Oct 2017 15:27:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20171024152728epoutp0157de6d2e683d69424fbf2f1474ca7830~wiyDjbgSN0594305943epoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1508858848;
        bh=Ea7E16VDS/MmFIranQgWT8zUy3RlM1PkTZPGOHwK3uY=;
        h=To:From:Subject:Cc:Date:References:From;
        b=PbQUOx6m+TRiktpmTLNuuBN+gdbYZbwpX4kUJJ1uUWtrEuX2y4zG3sqX4ORPhM5QG
         AL5e54az5IA7ZmgIg+XHMZ7PVQyHGuQGSgWV8cgT8Avo3VyP0I9L2oaNYLOrlZjY7g
         3MfH3GPbc6pYELGHoWJK01xPJfwUlK1+dql5odPc=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20171024152728epcas2p32eb8843e29d8ed8cb87320e3090a4b03~wiyDJY-hR0427704277epcas2p3P;
        Tue, 24 Oct 2017 15:27:28 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.49.04158.FDB5FE95; Wed, 25 Oct 2017 00:27:27 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5~wiyCSqDa70964309643epcas2p4v;
        Tue, 24 Oct 2017 15:27:27 +0000 (GMT)
X-AuditID: b6c32a48-905ff7000000103e-df-59ef5bdfba30
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.0F.03859.FDB5FE95; Wed, 25 Oct 2017 00:27:27 +0900 (KST)
Received: from [106.109.129.81] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0OYC00B3Z2XP5F50@mmp1.samsung.com>; Wed, 25 Oct 2017 00:27:27 +0900 (KST)
To:     git@vger.kernel.org
From:   Andrey Okoshkin <a.okoshkin@samsung.com>
Subject: [PATCH] merge-recursive: check GIT_MERGE_VERBOSITY only once
Organization: Samsung RnD Institute Russia
Cc:     vmiklos@frugalware.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Message-id: <3aed764b-388c-d163-08fc-32b294c6b9d3@samsung.com>
Date:   Tue, 24 Oct 2017 18:27:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.4.0
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7bCmhe796PeRBi3zbCy6rnQzWTT0XmG2
        +NHSw2xxpP0zkwOLx5PmHhaPZ717GD0uXlL2+LxJLoAlissmJTUnsyy1SN8ugStj0oaXjAWH
        uCpOT3jD0sD4kqOLkYNDQsBEYutvwy5GLg4hgR2MEjuXr2aGcL4zSjw938jUxcgJVrTy+R02
        iMRuRokXmzoZIZz7jBI7VnWwgFSJCIhLvD0+kx3EZhPQkzj/awKYLSzgKvFrcxsbiM0voCVx
        +cc8ZhCbWSBa4umkA2AbeAXsJB5u+wsWZxFQlWjvnccKYosKREgcP7ycEaJGUOLH5HssEL2a
        Ei++TIKyxSWO3b/JCGHLS2xe8xbsBQmBBWwSf/93skK84CIxZ8N7NghbWOLV8S3sELa0xLNV
        Gxkh7HqJ1o4nbBDNHYwSn2cthSqyl9jStZ0NYgOfRMfhv+yQwOOV6GgTgijxkJjw9CA0uBwl
        jqw5D1YuJBArMfPWJfYJjHKzkPwwC8kPs5D8MAvJDwsYWVYxiqUWFOempxYbFZjoFSfmFpfm
        pesl5+duYgSnCi2PHYwHzvkcYhTgYFTi4W0wfxcpxJpYVlyZe4hRgoNZSYR3hcn7SCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK8dduuRQgJpCeWpGanphakFsFkmTg4pRoYz5rmNYl6hc5Y6bHF
        Jv7eoSnvTLcucJym92N2bHjbZDOR6Ieexyc++MMe0SCpIuf0+Pn/iZXzjlxsymKbeu/i83v9
        8TdlA76lCa4J9O+7sJD3zKX41TWyUTcmzQmevGzic7eM/069jEG/X27h+R43sX7LYpHPCmbP
        nCU5OBI/+updOZnx6PoUeSWW4oxEQy3mouJEALu5tg8RAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t9jAd370e8jDV5f4rToutLNZNHQe4XZ
        4kdLD7PFkfbPTA4sHk+ae1g8nvXuYfS4eEnZ4/MmuQCWKC6blNSczLLUIn27BK6MSRteMhYc
        4qo4PeENSwPjS44uRk4OCQETiZXP77B1MXJxCAnsZJT4/ekRM4TzkFFi2Y42NpAqEQFxibfH
        Z7KD2GwCehLnf00As4UFXCV+bYao4RfQkrj8Yx4ziM0sEC2xcM0RsDivgJ3Ew21/weIsAqoS
        7b3zWEFsUYEIiefN71khagQlfky+x9LFyAHUqy4xZUouxBhxiWP3bzJC2PISm9e8ZZ7AyD8L
        SccshI5ZSDpmIelYwMiyilEytaA4Nz232KjAKC+1XK84Mbe4NC9dLzk/dxMjMIC3Hdbq38H4
        eEn8IUYBDkYlHt4blu8ihVgTy4orcw8xSnAwK4nwrjB5HynEm5JYWZValB9fVJqTWnyIUZqD
        RUmclz//WKSQQHpiSWp2ampBahFMlomDU6qB8cB5j7C1n6dsCpvql6faaP9bouKgesrOvx3G
        Rtt6js16t6tm37xdLa8m/Z75LmrW9Hzvnonv9zyMdXA6dcaPf7aKcR6fc+appQfnW8u8WZHb
        HPu7XDfAUOjb5J4TgspsQl/XJatVT1EtkXbcvbhjd8GB13HLAr03ez48YuhZ/Sc8rfWBRO7a
        50osxRmJhlrMRcWJAMczjJ9cAgAA
X-CMS-MailID: 20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5
X-RootMTR: 20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5
References: <CGME20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5@epcas2p4.samsung.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add check of 'GIT_MERGE_VERBOSITY' environment variable only once in
init_merge_options().
Consequential call of getenv() may return NULL pointer and strtol() crashes.
However the stored pointer to the obtained getenv() result may be invalidated
by some other getenv() call from another thread as getenv() is not thread-safe.

Signed-off-by: Andrey Okoshkin <a.okoshkin@samsung.com>
---
 merge-recursive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1494ffdb8..eaac98145 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2163,6 +2163,7 @@ static void merge_recursive_config(struct merge_options *o)
 
 void init_merge_options(struct merge_options *o)
 {
+	const char *merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
 	memset(o, 0, sizeof(struct merge_options));
 	o->verbosity = 2;
 	o->buffer_output = 1;
@@ -2171,9 +2172,8 @@ void init_merge_options(struct merge_options *o)
 	o->renormalize = 0;
 	o->detect_rename = 1;
 	merge_recursive_config(o);
-	if (getenv("GIT_MERGE_VERBOSITY"))
-		o->verbosity =
-			strtol(getenv("GIT_MERGE_VERBOSITY"), NULL, 10);
+	if (merge_verbosity)
+		o->verbosity = strtol(merge_verbosity, NULL, 10);
 	if (o->verbosity >= 5)
 		o->buffer_output = 0;
 	strbuf_init(&o->obuf, 0);
-- 
2.14.3
