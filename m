Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790B1C433FE
	for <git@archiver.kernel.org>; Sat,  1 Oct 2022 10:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJAKZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Oct 2022 06:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJAKZs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2022 06:25:48 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27DEF47A1
        for <git@vger.kernel.org>; Sat,  1 Oct 2022 03:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1664619937; bh=tb2RAZHi73azrjn4IqOy4ypgWKvjh4SJ/cS9zczqrAg=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=qlfu41u6V+qIXy4G0j51/VaXvr9k5yz91ZhPTMgNX0XKXe4XXg7APlXJ//EMvScMN
         F2LgZCOmg0kbcT8aSr+tLuh+Fikv1drTVV8ZhpuD7vdnbsf7arnyQsIU4U2TJ4xaqC
         D9sZseQcSuD1ckoFyshug017GKU1aD8WEZOPwQQsKid06TLKcSjuw8SzFEQfL45ld4
         S0VDE23CsAh7WEXqZT4B6lDJgashDfYL8um0xsb3CLqRB1xob8/nfK6fTSzcWhBi4o
         +U0GqDp9kfsmw47F+T+V5NvpzuYyLYIiqPTuQFzj08y3d4mwbRYsy1ACx4XHoasvGd
         GHKSZJFOR48gg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.26.45]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M604f-1oYnCU1sU7-007AgY; Sat, 01
 Oct 2022 12:25:37 +0200
Message-ID: <4fc4cf3b-a658-3959-4541-b889534fbbb0@web.de>
Date:   Sat, 1 Oct 2022 12:25:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: [PATCH v3 1/3] revision: use strtol_i() for exclude_parent
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tim Jaacks <tim.jaacks@garz-fricke.com>,
        Chris Torek <chris.torek@gmail.com>
References: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
 <16c49d20-cafc-4b48-3c6b-e11c74c29abb@web.de>
In-Reply-To: <16c49d20-cafc-4b48-3c6b-e11c74c29abb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ywPq80ZeYmw8EHjqyAcAvJTuhuX74xVKttHf3pd8C5wHN0MYrw1
 Jo80QkxMbZXXxVrYnha88sOA54AtfVf+EG0m+AsfmvGLRMFNjE1/p3e/jXoBOF+0fq4Mr03
 Z9LXyq/S3IaZbIyqE2E/qw2NHhhgPDhPaYy8WlV5HMgFam6Ek/TTObex+YQ1HuPI0I27Yt1
 YSwKFzeVXtd2DCz4AoRcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5pXxHnq9gRo=:KG4MeQobq31n05qjPggS2q
 7tRYBbCUqsGh+d/N6qAoibKtwq/g0u9ngDlf4bh7Ll8PE2y1cBjTnGt8OjxprSKqfWARBKHtq
 m1WyLtrF6BebTzLbV1RT9OXa4OOCN0tjc+mMNUcuoBo4DKrJtei7sOSJz4d516Q4J2LfOTfas
 JMvXa9EqQDnm2pjWi5rcVv4XgQampBk2dAy4tbbeaMB89Q2mIAz3ob/Sc2JqcyL7rdjQM/88U
 lVy+ex7wehe3P2CQZzWjQETLguKYn053s/vbca9R45ORecu2IovJSoMc4fmJc24SOPejR1sQN
 lR+vPbGZoySfmp03XaHM/NWcMFwXKbF5oR2ifcGsBThcFxLS4jjaODlXRxgOYb8CT08UlIWkn
 W5KEEzBoj43si64f23retBwQ66xgXEF8gDk6Epyc/mP+ChBccGOhsBIiZNqhvi4O5gWnK1oaM
 YRCUmvUmc8iK12SwbUZw9gBkRfEC5+oEhhkZ7wKiO38KuIuRbcIsiiffV6K+xJrcWqHKwNkIw
 lpKgIkqH9Bsu7GeSRAQiHd6Bv7nJzk3l9AbecLerbFJn7E9HPW536/AFbgAnYhwpa/Lq7F96x
 GMOkW95faA7MScehTGfHKifDsFIotrMbChcEmifk5/PJQ1UOChaoW9wDCiZk7O/5GIB2HFVsW
 +CcsBUOXg7CmqOjji0KCKTl9164+O/N5zCv/SDiKgj4sZonkuxzd6LFsOyJg0QWxNAoOsJqIP
 eKcI5qE7tOAZsibX6jlzRcmFiKFHWTCg5E5sPd0jRipCzDJMLxg/IBI7I8/KMYLk5d9PowdI8
 Ssb/9+q/A491uj60g8qvwtD6u4JxPMgGobGefmxlmgJge0zGBUiCYq/Dse61NiC6FLDP1+mi/
 +QSr3U5cQNW/Ta/MxARhKcUE25QqEFl0dA9kFKcLKZf5PygteBgFBGl6dw8pvEtYYJK+qYArP
 V+9w6ghS+LKx1uzc1TbxmHT7WlHohla7vLqpaHh+FXS429IHGB1zSFgwNBYc11MuuVlkxljtc
 EUHIojoQ2nK56pi8FskSypuVML0+HO/cehyjJPUNF8exWgpjYufl8UDr7S8V0Gojb5CfN9n2g
 F7tgKzOW36z/X0w7CI/ztm4M7eZhgAZg0yDgcyrrD9ocUTLOTWawGeuKs5pKGDuzQxEeH5XW2
 se/TU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid silent overflow of the int exclude_parent by using the appropriate
function, strtol_i(), to parse its value.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 revision.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index 36e31942ce..79b88604c7 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -2120,9 +2120,8 @@ static int handle_revision_arg_1(const char *arg_, s=
truct rev_info *revs, int fl
 		int exclude_parent =3D 1;

 		if (mark[2]) {
-			char *end;
-			exclude_parent =3D strtoul(mark + 2, &end, 10);
-			if (*end !=3D '\0' || !exclude_parent)
+			if (strtol_i(mark + 2, 10, &exclude_parent) ||
+			    exclude_parent < 1)
 				return -1;
 		}

=2D-
2.37.3
