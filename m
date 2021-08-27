Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419DDC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 19:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1796260F58
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 19:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhH0T0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 15:26:25 -0400
Received: from mout.web.de ([212.227.15.3]:46213 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhH0T0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 15:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1630092334;
        bh=w6rkPkdKHCrebM/2D6K3EAgcpn+WFdyuQlibYgzRzUY=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=T4DyyczWNrLTqZzPSD4xN/RFGOlQE1WI7L3lCgbcSk8AVYZhGSUTi22zc2a4IamYh
         Ix7JmILBvTiPUQGXZWZNEmUgd2Sojl9m9lZPQO5xZr9Jwc7CWVkVGIpJeFWoBC0Ui+
         AzU+Ek3CtK4Uc8e8Pu9U862rlJxEyQQOsx2YtdhU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LqDTc-1mxPrg1gvY-00ds3C; Fri, 27 Aug 2021 21:20:28 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] show-branch: simplify rev_is_head()
Message-ID: <a5800c55-0147-214e-fb75-968476d9d1fe@web.de>
Date:   Fri, 27 Aug 2021 21:20:27 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1TSdvbPyrZ4joaY05xJe9138d72OqVGd5H1RDjY+fDzfHd0D1jP
 pTGM7A+zuQFlb2WFeFoqJF3kMXtRd0wUEkMoyhXJ2woFLunh1+oO5jINVxoKi+bFk0cJhRD
 lUFk5avX382aNOnEXCF5ik1c73PJNDoAB0j0kOdB8RRcHbyCTIusTUkViFkd6YXT3Or1aBD
 IP4KR24XlusB9i0JRVpnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WRr+7/13zK0=:RmyfONrZJrChObrKBM58WZ
 DnwZ6jrQ8ZcPuWeKzawZfg5mBXqc1U1befZaBK3JFcLh/Il/Ah01VrQMYvztWrCeGhdTSqPff
 XSA4mmCCkfCuLetqYihZZALth36Wsqcgpy4Bcw4gu1807GaK2E6h8bKMhlxuW+3rEUS0Hzel0
 TohHxHcuwLF2gIg7FWGFf6Acbhxm71mGjLhLqnqJQAWSiYacSskU9WF4DjQsAGU7NGUVMYekD
 cEcRMP97/X+BYk1Z6M32H00y6TNx9rh3r/q2ZKL5z4KDnZbeVTahM56dMUwp2NN0aMU2kPkmu
 NRxGoyDHchiPsUBrZvZaYtBQBy05C8keCD4ca8DufxhySf4O/hUGnvcWzyTnvsEbhDk8VgiFr
 CTfX0+f6ZUiffzq1c/a50KtLXZF4lhYMGZBEZYGkSGn1uY6MxYwemHFbb1sMBC5FJxOqHy5Pp
 /LgFabaM07ylWxSVdCMd9/9o5aXYV8gtYfA6X8nKSf6m35JLH1nBA7UBjK6mZQi5a8gAdDdC6
 SrKaD3eMaa6PX/XilpK6kqx/fqeyfuZZx2BoQX+LAB+P5G9Z5rEk493txJElr1oKvTQeFGtoh
 A8U1dnleZeAUXGdDjLk7xY+jdK+7tkRsL6rpD5MwuJXp2mnBaAdalqME/d4cVxB5FQVRJ5fC8
 pOTQZZHrh0mgatnoSrlryZIkAMxqW3wqYFp7QbCuOtps+5yTUZYeEuT2g7YZ+ki7EGM72o1pz
 l08c5rsIWKdcM8XwQSjpdgzJaE91agPKOFUSSS88ICuLbhntIyF2bTrPbQu6q/r+eI/DzhQBC
 LIhkrXdAwPBGYjrfgIenqZKK6egrMo1lT6TkWO/VBRfL1491/Yy51PT8iDHQ2dhJmMzQPv9IA
 9Oohs8JT9VEHD/Zf897v8LnEQiyoQ4FwXhzJ0QjuTHkGIRx/zQSn9dAKPK7wZGGzekqHW45Hy
 Tdv1i6d+Ci3i/9h0YwSM2UXllk4cp2S6PVOmofETXDHMq4S/mOuOwlO5UbrUksK94Wro6Wl2G
 0QOfGK3F8ip9WfBLdyUenNmZQQ5JVB83SHyYYmjDBPrVG5hpYScHwxhtBqB1koScDrtvNLn+b
 s+SuVg7mpZ56RiaOIC3Y33SAxA7wc6vAlSQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Only one of the callers of rev_is_head() provides two hashes to compare.
Move that check there and convert it to struct object_id.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/show-branch.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index d77ce7aeb3..bea4bbf468 100644
=2D-- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -482,10 +482,9 @@ static void snarf_refs(int head, int remotes)
 	}
 }

-static int rev_is_head(const char *head, const char *name,
-		       unsigned char *head_sha1, unsigned char *sha1)
+static int rev_is_head(const char *head, const char *name)
 {
-	if (!head || (head_sha1 && sha1 && !hasheq(head_sha1, sha1)))
+	if (!head)
 		return 0;
 	skip_prefix(head, "refs/heads/", &head);
 	if (!skip_prefix(name, "refs/heads/", &name))
@@ -806,9 +805,7 @@ int cmd_show_branch(int ac, const char **av, const cha=
r *prefix)
 			/* We are only interested in adding the branch
 			 * HEAD points at.
 			 */
-			if (rev_is_head(head,
-					ref_name[i],
-					head_oid.hash, NULL))
+			if (rev_is_head(head, ref_name[i]))
 				has_head++;
 		}
 		if (!has_head) {
@@ -867,10 +864,8 @@ int cmd_show_branch(int ac, const char **av, const ch=
ar *prefix)
 	if (1 < num_rev || extra < 0) {
 		for (i =3D 0; i < num_rev; i++) {
 			int j;
-			int is_head =3D rev_is_head(head,
-						  ref_name[i],
-						  head_oid.hash,
-						  rev[i]->object.oid.hash);
+			int is_head =3D rev_is_head(head, ref_name[i]) &&
+				      oideq(&head_oid, &rev[i]->object.oid);
 			if (extra < 0)
 				printf("%c [%s] ",
 				       is_head ? '*' : ' ', ref_name[i]);
=2D-
2.33.0
