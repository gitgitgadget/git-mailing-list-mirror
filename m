Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1EFC43457
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 16:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5881B2223C
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 16:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="shi2AF0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387739AbgJKQD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 12:03:57 -0400
Received: from mout.web.de ([217.72.192.78]:33065 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387696AbgJKQDo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 12:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1602432220;
        bh=4jpPmmx2V78wfa0tAROZhDSPYbETw8uXAogbxQMHRB8=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=shi2AF0Cjj0mhWhLPcSLpWi0f1Zuu5r8Li6aH+BG/HUsKGlc14nsMpRaeFw/EGsQJ
         5ZBLwe/oJ5u/gorAxP2jRQ41eIKuv2s10lG8iqo7WSiAI8YrJb0T0YB5o328O0XnAl
         2gRrHWoVF2Vc2Hxev35xiIqxlVR39ab5RV3F5ncc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.172]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LhNs4-1k5lL22A6a-00mdGX; Sun, 11
 Oct 2020 18:03:40 +0200
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] line-log: handle deref_tag() returning NULL
Message-ID: <90968bb8-61da-e31e-e697-97cbe048e73e@web.de>
Date:   Sun, 11 Oct 2020 18:03:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ER4Z7EMzZmNiX2crILXu38b0yeBzLmneo3I1bI9B8eDCo9ZqF71
 /fRDxGDV//JFdBZZD740Q6xXlbIEtYxa3DV/Nm3xgMQIxpE7ij33KE4aANIcTv0apTAv7bN
 Nh0b+Gj+gEPXMfvj7hX78yvlIrnEERHexKlpPQnt4uMKUEBmOwQmjSqjsaW1Ny2anag2ZSr
 wLolW2tTU3BxU+fqY2UqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qGpQ6bH6+rc=:toFU8nBYwyRZs60fwXjKAA
 8KHM5IEItq5zWh5Ua2OQldRzG9BSvT/fTvrvVZqVqUWSVhGpIVUeWQLFLJldNsgheuLTcAM0V
 Bmkpdgz+NcDyNQWWPYXw10AJZgKwT2m3ctpF7gIz+EeQiC3lkY93sCrxDUUsvdS8v1GxtBmkn
 3Tfjwje4VvyPtsUWBp6ZKrBf/31zR/aZIDlDTxXlqvuXcC8O3lR3V7MJ1plvuZEnehPBz+aWn
 eDH2cNSD8cu0hJdjrdDr/J1UP9XQRVFL7a7B9WtbYLuReqvaqSHfrnmdwCbY9uWuFuN6JymZu
 5r6db2H118zFeGA/faUPzEST0Rychzn5ZHnNIZNXAmg7Fcccqg59uiimFSKD4LgMqjOilwGiy
 ou+/78SPzGbpJ+wsTeD4bJnC8vvX/CZBH8sXJIiWagmlENR998cSOoxAeMlEQpHg0DvHBjrBG
 cUgPbYiq9XEEShj/p2Iy+jPhk8HUAUy/dk/M/WO68NffVdvYS6xN6+nWAJLJgsDtUcahsU/pu
 wWA97I2QYrRUiQvKhEzrlCB9G93f5Uwa0r6HPr+pBtTKq0sB6FMPveT7x1NrJ7pie+OfvFsmy
 PPbgeMXmXTTri6iR1lu4Zi6rhZICn4R577QHaAZevN/eo08BjJ85S7JfK2Cn0owfZObZTLJxq
 +DPrqE3F4Tqui85KjVjzSxSPjYuqwawchyOO1nYCe9midH8NLjk+MT09TVQpsfXI0RNhFMhyD
 9P9vkw+fgm95WAZy2ZetPEjIr0Dyg2rsJqaHeDhcs75G0lYr8ijjjglgLV33ncK87IgIUpzFm
 w8D6ujZy7PwL9jcevjVXau/BTinL+vxmozr8hcY0jnx2fSANK8yC04Sm4Y9eMPZJtLz7HJI5E
 rhzJV4zqQL73nWnha7KPssc45grqKwhQsqdr1rsqSodfXU/XBXloo/xUKnXp9+lE8cgOjmQAl
 vL9gjdBE3+YocjHobxXZ/tOgOhWTGf25T7MGTQs0NDpf4k8Rgx9Ma24xLFGNws6krPdn7Ntf6
 RMq8uoDTAlbsNRd8j7ebyhzUxodOArvOgBMhUvZ/8HnaxujA4K0hhzNxdOS01pgcfk8su35bv
 NA1xppRo3rrnAsRWqo2ZJllFScibwDceaoFdbdtE2XaTwILuoumnvN8G5g5MDTNPA3lA2LkpS
 3FRYnEK5pb5zmxEq7MUa7XdVsRQlr7rYq1DRfmSP8Bx+uWncRxS1i3aoqj/WkisJvOj21aJdb
 D7SRiD5dIBrufB7zc
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 line-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/line-log.c b/line-log.c
index 68eeb425f8..75c8b1acff 100644
=2D-- a/line-log.c
+++ b/line-log.c
@@ -481,7 +481,7 @@ static struct commit *check_single_commit(struct rev_i=
nfo *revs)
 		if (obj->flags & UNINTERESTING)
 			continue;
 		obj =3D deref_tag(revs->repo, obj, NULL, 0);
-		if (obj->type !=3D OBJ_COMMIT)
+		if (!obj || obj->type !=3D OBJ_COMMIT)
 			die("Non commit %s?", revs->pending.objects[i].name);
 		if (commit)
 			die("More than one commit to dig from: %s and %s?",
=2D-
2.28.0
