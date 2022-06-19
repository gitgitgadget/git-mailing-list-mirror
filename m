Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EC6C43334
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 05:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbiFSFjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jun 2022 01:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiFSFjO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jun 2022 01:39:14 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD8CB1DF
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 22:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655617133;
        bh=ArkuhsJcyFvPve5mAgGBbW5K2Imd6dHTBMVAbU2UN48=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=X4GxYBlPGSIR++MD5uvyL8eUEre7p+WCtWcloJO9pNCPPaCAfglK/OKSrkyqCOmpq
         1y84fEqNeEXLs0dPKnvWhSOmgofiEnt6fTBY5qi51z10hUTUY1ZCUC88BrUZPPhV7x
         RPQiQ/+D1bum6VnrDB3glOBVi2L1mSnv3+lqrFDc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgANA-1nU03v0ln4-00hbRG; Sun, 19
 Jun 2022 07:38:53 +0200
Message-ID: <157741e2-cd06-9304-bb21-c67c2cbd923e@web.de>
Date:   Sun, 19 Jun 2022 07:38:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v5 16/17] builtin/gc.c: conditionally avoid pruning
 objects via loose
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
 <43c14eec0762170393c5e9681c3d5ef8fa60c96c.1653088640.git.me@ttaylorr.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <43c14eec0762170393c5e9681c3d5ef8fa60c96c.1653088640.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:69ddi51QqZmZDY9mxI2akemKB8u8WN453zuoZcEH0izgrrlqFko
 y9vViP/dBYTet1HK73Wt7wfiKpMfyrZX/maC2+NdBMa8Zzlnn2sLMwCQ+EOQ3GLm1aucFBR
 9a0J+NvW01cGdCXHmqAHNaMyBUVQ/1S0pJTvoI/xGc+RvevPojIf0Yh9mAE3J6ruql87Oem
 QOtKvlLKCQ+QtiKSPUDBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ggy9gNchyrA=:I4hUhyVpIr9Ctq0qwoAiBd
 TOtoSzdKSPi2sTvLkTDi51xT7rgNz9sqkItgTQOkZgi1rCR8qJdhnk8ROIM9BfaKOvKQvkKrL
 /QS3KPd0DC+C2fXuXPA4XXYi64L2tyQ99YJliVozu+SnoAr7SJs8x2+t+wrEuQnf3pvXeBh/U
 /eZG91+ePjgHHYGaKrNyvEQwy6dP5QZtqccDrQSDiXFfSeOmS2Efz/oqfB+4RFQUSoh25l3sH
 8GLVo4OLUeIybI9cjQ4XjE5OC6VeW4RU/20hnl0X29hUBD44QKbqGw5EjilvPWoteDvoaNPDc
 kLOv78ysN5D/5M+Mk6XKoQkUyLKqn7t2VYRIjIluLeHx/25h9nMdfEjIfL673zY9HEn1xSxW7
 8V2QTCQ5MQpSTeLjX5agWOXbKM0NQXGZpCFWsDoE3sfySTOLmP8ATrsHLa28H/WcV0VLR5lHk
 Txe8orNY7eCz3hRHxXxN89JqJPtKmWCpCbnb92sJi9GlIZqMF4Y5lYZUzSgc2/QSHVQBprImI
 Id5J5PVi/1QoNpTkERDp9YjsuogdgSV5MePjW4iG2J0kVi/Wg01FjbDSBqDZPLdhZ2MK6fPGw
 Xo2CmvIos3zpwWwCqEyHTiCIdJCUhG9eVd4LTmxrZmxqWLAL6PAmzvsnt4pOhDiMkdiwdx3ME
 7NpcM8ryhZjjkwGIotafiqWlHxyHdDlZ0nFu7rVcUg1ef3jYsrAZ7VF8RzkwU/sHVFVoF6o/5
 Nxozc38SCtYjHFdiG9dJudHGMYkJ4abyDnOnNKrAS5K8r5WHc27pZHtoHofaYaqy27ZatHiT2
 f9U/bKmj1ddSmwlqaPXTUdJTzmHjNwhRfKMwjje0NofFqfwba7ye0/ezaVB6zmdL4UsY0W/Zm
 VG8PfcMzjGCkITSrKUKF7TDmvXzfBpH5GXirwPbgIdqgJoIGBcyGLVageh2+2Uf95lqpqBo8R
 uFDA3IZ1UOjoXoe8iqqdreu5mIomr1nB4GZoEYT9AMScWKzBJ8lWbxUOZCbblO3xud1b8cZo1
 j/dsA/lA/x3fjrSZ0bLcdVLlTn+3Of96BsqQXsknfPAansZooqYT6QUWDMaV3SXNqnWZYj8E+
 BF/xA9baWboQDUfI2KRM8MmVuFBChcIlhSk
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.05.22 um 01:18 schrieb Taylor Blau:
> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index 853967dea0..ba4e67700e 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -54,6 +54,11 @@ other housekeeping tasks (e.g. rerere, working trees,=
 reflog...) will
>  be performed as well.
>
>
> +--cruft::
> +	When expiring unreachable objects, pack them separately into a
> +	cruft pack instead of storing the loose objects as loose
> +	objects.

The last part looks tautological.  How about:

=2D-- >8 ---
Subject: [PATCH] gc: simplify --cruft description

Remove duplicate "loose objects".

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-gc.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index ba4e67700e..0af7540a0c 100644
=2D-- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -56,8 +56,7 @@ be performed as well.

 --cruft::
 	When expiring unreachable objects, pack them separately into a
-	cruft pack instead of storing the loose objects as loose
-	objects.
+	cruft pack instead of storing them as loose objects.

 --prune=3D<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
=2D-
2.36.1
