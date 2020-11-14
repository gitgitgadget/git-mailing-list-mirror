Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A01C55ABD
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 21:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C7CC222BA
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 21:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ZC5wy/Pl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgKNVkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 16:40:17 -0500
Received: from mout.web.de ([212.227.15.3]:57965 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgKNVkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 16:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1605390003;
        bh=DZ8mVzWk9YUlDU8oP+3I3AT5AFX7n1mvgu6kcbtypYk=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=ZC5wy/PlN4KAqMMtTQ+XACgUOslrs6OOahBwWxv6haxTSg8htTwbjwjveLShJHly2
         JkvIFw0ZsQ7yBv6AODVblehcAjGb7vH1SHkyhOqQ9iWzHRBkYxcqGp844edv+VC0w8
         Ia/9SnT9bo5ow5nqWRJpG2prG1qezCJoPtAytq9A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWeGR-1klRw93b47-00Xpnw; Sat, 14
 Nov 2020 22:40:02 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] chdir-notify: UNLEAK registrated callback entries
Message-ID: <8a9cf9ba-f615-3ff5-8d35-c24c22d5d859@web.de>
Date:   Sat, 14 Nov 2020 22:40:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MEh4OqXesEb5L7INiq4LiiOk1K/CLfPYcpcZA2x9UbF70BucIPN
 x8sCjAhCZ6JwGO55midd9JkwC6X9cLAYE//tdABSy/EE1gPb+r6W5rwzSNLoA7FTXoSl/Do
 3RL0F5W8a+HfBlgtka8W6TJ5YvBNnhaezQOoxTmGGJPIFg1YiepJVnepNNNMNR2cOLNT6CF
 ykNqwR+LbVcrfbAXg7/aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ImZPoyunJ3w=:J9k7+9K+wXBzPWERBRoJQk
 pBJyEL8YDlehTWR+dFWeeLz+BKRS78PS7ZF168j+zcm1GGiDXwSQXeWlNFA8qFtfUw6KvBsSp
 Q66SR7716MRr9r0KXGRNtAnxmdajZR0Vq7Tv1Hhfh5yn3oZcZFYRhyNBPS637COLQ77OOwBh7
 8+WipNHBT6OJn2U3tAeGCLG5/hk26CY3ryp1FL2neUC4zxT38E2ZuROKOXdVpkzO3P65FJPuT
 DWM+nO92Q1b5S4F7dygX4UA0HpgpnP3CgWJ79ocjmnMrTOffViHzo1SgARXtXOtLqjh6+afll
 U5nZCT3+7S84CuyJ1By/k24hsUVuqrc+gvdhpGEbShSMgPmKP3umOtalZEDpcN9Zaidvlk0wD
 QauXkMloFX2TzaOmlSVkElVFN10tdrFjovuI9nhLdobLTOGoRgwTrR1E3JUPxw1X8tVXpp/xO
 knJpJYxQChKvyPssl/QZ8jV5KLoNb56ynuSTj6pxzTVuilM0jkRQz1u41BRIxjOSq1h9ivskX
 V0FtYgou1ONP2v+OEMJ0wP0colj0ZSigyg7RovZSa+mV6amwQGfw3sct1gnQkg2wzPePoRJLH
 g7Xk9rTAQ6Sr6WBoZRriIImmFC+iGpEuBkhPzg26FYN0btvj/3CvAPFgDa/+g29NKXTRhZW8o
 R9MapunrhgKZ/fdo7peDJscP/BdhAZyLqUk/O9m39eisjzNBH7UcCJ1j263CEiXqCvU5CZy7c
 AU+hExnb9b0ZU4JZazO5gmoW/qsC6fwr0zg8kvK4x5g+VXlO+JOk1i097v1oqynuuhoaVmrhl
 jyXMTjWn89YoojpgfNa06/9EWbodkXQj/fOvAVP1MeS1TasU+kZYiAHpHgUi+Z7oEtPB//gQe
 O+zhafX9ym9upGFOcqKA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

chdir_notify_register() allows registering functions to notify when
chdir() is called.  There is no way to unsubscribe or shut this
mechanism down, so these entries are present until the program ends.

Valgrind reports allocations for these registrations as "possibly lost",
probably because it doesn't see through list.h's offsetof tricks.
Annotate them using UNLEAK, which causes Valgrind to report them as
"still reachable" instead.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 chdir-notify.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/chdir-notify.c b/chdir-notify.c
index 5f7f2c2ac2..b236288416 100644
=2D-- a/chdir-notify.c
+++ b/chdir-notify.c
@@ -16,6 +16,7 @@ void chdir_notify_register(const char *name,
 			   void *data)
 {
 	struct chdir_notify_entry *e =3D xmalloc(sizeof(*e));
+	UNLEAK(e);
 	e->name =3D name;
 	e->cb =3D cb;
 	e->data =3D data;
=2D-
2.29.2
