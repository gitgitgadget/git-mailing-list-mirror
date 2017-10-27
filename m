Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6834F2055E
	for <e@80x24.org>; Fri, 27 Oct 2017 09:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbdJ0Jdh (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 05:33:37 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:33349 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752052AbdJ0Jde (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 05:33:34 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20171027093332epoutp037bb08c426188aeffaad74ee2eee65257~xY44c-dkp2705727057epoutp03p;
        Fri, 27 Oct 2017 09:33:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20171027093332epoutp037bb08c426188aeffaad74ee2eee65257~xY44c-dkp2705727057epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1509096812;
        bh=yTlZn3a+z1lGBYUjKUemoByC/m+is7BXPZkK6hciDEg=;
        h=To:Cc:From:Subject:Date:References:From;
        b=T8ofjpmmuJSZdiMKCCMAGt3v2JBy3K9jRighCmADKrziM3hzT4YGCMvYrJN3375V3
         QX/H0VU43EKU8ayee7ghbc37mLImyKAS3V2E8t5ZDGZ+NnvdfvBm7o6vLqcCsuah6W
         +O2V+9WmVdQ1xtlUjDiJGAzrMmpiJhhxU9htt5sM=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20171027093332epcas2p1652675441c7d5632cc4a7e7d83af8983~xY44UKmzt2317623176epcas2p1o;
        Fri, 27 Oct 2017 09:33:32 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.34.04158.B6DF2F95; Fri, 27 Oct 2017 18:33:31 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20171027093331epcas2p1a945263c12b8ba608492693da4e3eff2~xY439Epv92335423354epcas2p1P;
        Fri, 27 Oct 2017 09:33:31 +0000 (GMT)
X-AuditID: b6c32a48-8edff7000000103e-2d-59f2fd6b081f
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id D2.0A.03859.B6DF2F95; Fri, 27 Oct
        2017 18:33:31 +0900 (KST)
Received: from [106.109.129.81] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0OYH009V06JP2VA0@mmp2.samsung.com>; Fri, 27 Oct 2017 18:33:31 +0900 (KST)
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        pclouds@gmail.com, Ivan Arishchenko <i.arishchenk@samsung.com>
From:   Andrey Okoshkin <a.okoshkin@samsung.com>
Subject: [PATCH] diff: fix lstat() error handling in
 diff_populate_filespec()
Organization: Samsung RnD Institute Russia
Message-id: <72e8146b-d4ab-ad7e-6afd-9168806eeca2@samsung.com>
Date:   Fri, 27 Oct 2017 12:33:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.4.0
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZdljTQjf776dIg69TLSy6rnQzWTT0XmG2
        2Hz7FqNF95S3jBY/WnqYHVg9ds66y+7xrHcPo8fFS8oefVtWMXp83iQXwBrFZZOSmpNZllqk
        b5fAlTHv1zLmgvs8FXtermNuYGzj6mLk5JAQMJHYtKifrYuRi0NIYAejxOzFf9khnO+MEjtn
        XmWBqVqy8QCYLSSwgVGic1c0RNF9RonTFzYxgiREBMQl3h6fCdbNLNDMKPFqSR9Ygk1AT+L8
        rwnsILawgL/E3DvNrCA2v4CWxOUf85hBbF4BO4kZTUfB4iwCqhKd8z+D2aICERLHDy9nhKgR
        lPgx+R7YFcwCmhIvvkyCssUljt2/yQhhy0tsXvOWGeQICYENbBL75qxhhXjBRWLtzJ1MELaw
        xKvjW9ghbGmJZ6s2MkLY9RKtHU/YIJo7GCU+z1oKVWQvsaVrOxvEBj6JjsOgQOIAivNKdLQJ
        QZR4SOy73cwIEXaUOPQqCRJasRKbvzaxTWCUm4XkhVlIXpiF5IVZSF5YwMiyilEstaA4Nz21
        2KjARK84Mbe4NC9dLzk/dxMjOH1oeexgPHDO5xCjAAejEg/vCs1PkUKsiWXFlbmHGCU4mJVE
        eK2/AoV4UxIrq1KL8uOLSnNSiw8xSnOwKInz1m27FiEkkJ5YkpqdmlqQWgSTZeLglGpg5M7+
        4nFaVtLMUEswvyp2Sfeco11HV389k3LgVrhfVrOQXKjOLBcli4qZgZskdywOYzoWuLLP+uOM
        DeX2KwoD0ixsG9pUbx3Ud/l3a25z53b+u+8Ot75g8GLr2nNa+qR7uLwyx96Z+Utn1Z5pbpjL
        ddW8J6mVf0uVy4lJ3m0Sf04yOK7+erxXiaU4I9FQi7moOBEAll153hsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsVy+t9jQd3sv58iDX7eVbToutLNZNHQe4XZ
        YvPtW4wW3VPeMlr8aOlhdmD12DnrLrvHs949jB4XLyl79G1ZxejxeZNcAGsUl01Kak5mWWqR
        vl0CV8a8X8uYC+7zVOx5uY65gbGNq4uRk0NCwERiycYDLF2MXBxCAusYJRb2zoFyHjJKtH89
        yQ5SJSIgLvH2+Ex2kASzQDOjxMd5n8ASbAJ6Eud/TQCzhQV8JRadmcYKYvMLaElc/jGPGcTm
        FbCTmNF0FCzOIqAq0Tn/M5gtKhAh8bz5PStEjaDEj8n3gDZzAC1Ql5gyJRckzAy099j9m4wQ
        trzE5jVvmScw8s9C0jELoWMWko5ZSDoWMLKsYpRMLSjOTc8tNiowykst1ytOzC0uzUvXS87P
        3cQIDOtth7X6dzA+XhJ/iFGAg1GJh3eF5qdIIdbEsuLK3EOMEhzMSiK81l+BQrwpiZVVqUX5
        8UWlOanFhxilOViUxHn5849FCgmkJ5akZqemFqQWwWSZODilGhitW7v7/pzf0rmSKaxh4RvZ
        fZOipJZ9Cp77K/vHP7tII9WmbfLGhv8YvzGJ/nRe985L4IPTyyrRPwvX9Aj0b+CKq+XkUxUo
        P7l2usKFDdN+7NZbM2tCHb/6rvbPagZ8L6qVRYNSJXc+PXJBVf/z14muxWa5p2crfLEo1Dn2
        U70oxk5eKnvKBV8lluKMREMt5qLiRAC+ivCnZwIAAA==
X-CMS-MailID: 20171027093331epcas2p1a945263c12b8ba608492693da4e3eff2
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20171027093331epcas2p1a945263c12b8ba608492693da4e3eff2
X-RootMTR: 20171027093331epcas2p1a945263c12b8ba608492693da4e3eff2
References: <CGME20171027093331epcas2p1a945263c12b8ba608492693da4e3eff2@epcas2p1.samsung.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add lstat() error handling not only for ENOENT case.
Otherwise uninitialised 'struct stat st' variable is used later in case of
lstat() non-ENOENT failure which leads to processing of rubbish values of
file mode ('S_ISLNK(st.st_mode)' check) or size ('xsize_t(st.st_size)').

Signed-off-by: Andrey Okoshkin <a.okoshkin@samsung.com>
---
Hello,

I've injected a fault to git binary with the internal tool for fault tolerance
evaluation: lstat() returns '-1' and errno is set to 'EACCES' at
diff_populate_filespec git/diff.c:2850.
In a real life it's very difficult to reproduce such behaviour.
I'm not sure why only ENOENT error of lstat() is considered as an error but passing
by other errno values leads to reading of uninitialized 'struct stat st' variable.
It means that the populated 'diff_filespec' structure may be incorrectly filled.

Also diff_populate_filespec() result is not checked at diff_filespec_is_binary() but
it seems OK there.

Best regards,
Andrey

 diff.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 8406a8324..d737a78a1 100644
--- a/diff.c
+++ b/diff.c
@@ -2848,14 +2848,12 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
 		int fd;
 
 		if (lstat(s->path, &st) < 0) {
-			if (errno == ENOENT) {
-			err_empty:
-				err = -1;
-			empty:
-				s->data = (char *)"";
-				s->size = 0;
-				return err;
-			}
+		err_empty:
+			err = -1;
+		empty:
+			s->data = (char *)"";
+			s->size = 0;
+			return err;
 		}
 		s->size = xsize_t(st.st_size);
 		if (!s->size)
-- 
2.14.3
