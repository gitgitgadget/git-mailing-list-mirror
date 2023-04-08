Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE74C77B61
	for <git@archiver.kernel.org>; Sat,  8 Apr 2023 10:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDHK01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Apr 2023 06:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDHK00 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2023 06:26:26 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823AEE42
        for <git@vger.kernel.org>; Sat,  8 Apr 2023 03:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1680949505; i=l.s.r@web.de;
        bh=7J72HA9icmtXleDzYseaKsgh0Q2SqLCXHjndmIiR5sA=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=lwPP/UqIxnjRXYOkJ131YHI4J73eojcZ56WKh+MYxD7HKHNhJaOIxmLspNqMO0cZ3
         7hUM/ACV5EIFD7Rukv9GR+igRsj3Uh/OnGKMsfo9rOkjHUndAogFxL+zXDbV9Me7H2
         qtIy4SmbHY/5WdXuBC0ROBg744VJPkj6El0wmlvS+tDqi0F6rOOUyFLhNTf7nbC6S2
         Ff+/6TJ6GUYSSNw+qmwpiKYvOXeBxT2175Y+lKTg0PE2WUML818Tz6AtMBUEfFkBok
         H4coOSK0mbU5KcJmQAXJyewzEauAfAwqQRPteMF+TDVrJMrhWn7WlwZl3LGzWsbC8i
         k3Tn82jvE/ZXA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.158.21]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4KJR-1pkodc1Tpx-000ABi; Sat, 08
 Apr 2023 12:25:05 +0200
Message-ID: <79497392-0296-2ae3-2560-1f90c1a309b5@web.de>
Date:   Sat, 8 Apr 2023 12:25:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] get-tar-commit-id: use TYPEFLAG_GLOBAL_HEADER instead of
 magic value
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+DkB0UBfpIaPne1Xv5/bXElF8iEwR4rvSbJ1qXU5ecrJG3Oi2CM
 +u/pW40BI2R20nZ5sqf7501RqGYa8YBhkAuFyRGcCAMcy5DiYY9R/wVg4rpvIbhLsN5uqdh
 3RQV8cIDg3xOdfMwyZs0W4jtKbEVE5jrcIAeGoVjKG/SfxwPmmdsUD1EZOROM9CezsY7ZAC
 ym0O3CGsPDFzyRdUilpog==
UI-OutboundReport: notjunk:1;M01:P0:LDbmgvuDBRI=;ZeKG4MCBX70Xv482nK6nR8z8rEJ
 oQXOzEZdSPbLyChrgvJmoDORxgFKnvxA6rnr72mq+9Z3KzmYIIeA2aDJYqqTuFvua1GOFF2vc
 MFunHxX0+syrO82iWH9hEDUk//nlW9EzF3W16FcYKxU1Cm9Payn2V++0HvVjpLzofg/K6rCzP
 +0L8G5Hrvpp3HIcMqS6jVVqieQCWztQR3C4MRhIzVZSFX/YzRGNkz+aUp4HXiw2WN+NMPX5mj
 YXlZgz81WwgwO+YdvBw7jpmq/L5BrzzHsLU/y4YtPwCv5cJWYrVyrkBt91axzDzEhVLEGsmhb
 0Q9TCIMb1VYBAAraoH4wbFlbGvYKYJ7uqOem4zUP1jnXyX5wg9RwrrEevmyKPuyhku++yp3cG
 SabzCHIJoxnUf7BRSwlW93AdbAzwWDTtfEgmc9Fw6Zh8gG3+8UbHSSrS04oSTL1EcjMEUZa8v
 Vfzgq7IqikGH0Vj5JJ8lFwoJzGZ+LdAi17zXTgqah5rvo0mAyPuTdulq9mT6VyW0jsOXW8phD
 C0PPsq2wmEM8PtDb/63Hidm2SuRG5JxUuyxhhUFjQWLwUMb74M6EaG/ZD+Ft9GtFe2t362K9l
 NcjOraufxp+T0Ewn9AHoqONWOKdbg7Fria0p+uVpz74+fQasmIJuv6a3e8Gz+4LBHU36I9uEa
 +TE/SJ6D4oQj0v1TLd4lxd+IX4o5ANX476M18o1oZfbKj9H2FZl1pKV5ksmH4AOMCF6rZhQDY
 x/QADepf9vm0Ykcg1qt+1jm+hepjtYMcrwszvT3qmEsCcHH46Im66o+DBIqf6sgQOGAOKboy5
 ZSLjJEt70Q93ZLSQsSWRB2PYXA/Co12EL7F+7t+zhD3fkuk2u2p5aDvgpEwiOGtjMQiuSh66U
 ukivmw686DUGcH5BijOwDGSxa0XHStR5ftaTeH3nx0nRuGObxkq5dsgcxw1E8nvXwpj7eIvJD
 0Yp3BQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the same macro in the archive reader code as on the writer side in
archive-tar.c to document the connection.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/get-tar-commit-id.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index d5b871b21d..564cfcac4f 100644
=2D-- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -35,7 +35,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv UN=
USED, const char *prefix
 		die_errno("git get-tar-commit-id: read error");
 	if (n !=3D HEADERSIZE)
 		die_errno("git get-tar-commit-id: EOF before reading tar header");
-	if (header->typeflag[0] !=3D 'g')
+	if (header->typeflag[0] !=3D TYPEFLAG_GLOBAL_HEADER)
 		return 1;

 	len =3D strtol(content, &end, 10);
=2D-
2.40.0
