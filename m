Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CB3C43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 11:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiFRLMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 07:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiFRLMq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 07:12:46 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2186555
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 04:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655550750;
        bh=tffI9pSqKs2ilD+6vAePXDm4HNoKGfiogMZS0KFmjoE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FRGMYD7wPTt4lEQjYPDi6m4pR1E7lB6fqLKpydoXTavzBTf8BMYCTTbC6pATsun8j
         VBUsto3twVf/tXjbQSBFcPpUTMoLXYJEwGsLncQ8kYxGR4bK6+r3i/XlD8z/Gl2YYe
         kCANYHfHVk3XTBqX3+m2YihSu3F/OdFV8l7hsqq4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MEUS0-1nwQVQ0VJa-00GSlC; Sat, 18
 Jun 2022 13:12:30 +0200
Message-ID: <49bcadd1-7dc2-d5ee-36a5-59456450aeca@web.de>
Date:   Sat, 18 Jun 2022 13:12:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: [PATCH 1/2] combine-diff: abort if --ignore-matching-lines is given
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
References: <a6a14213-bc82-d6fb-43dd-5a423c40a4f8@web.de>
 <patch-1.1-f7fd645468c-20220523T182954Z-avarab@gmail.com>
 <xmqqleusqaff.fsf@gitster.g> <220524.86leurw3my.gmgdl@evledraar.gmail.com>
 <xmqqmtf6hgae.fsf@gitster.g> <220524.86v8tuvfl1.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220524.86v8tuvfl1.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2aiBWTpeTtRM9Yygdey6+IgDxfKo2BdzPAYlAFRXAyCDjPwFm4S
 YnovPzoY3Vkkf5hzpSvfkbBVhcO1Q1OtXQIh4SHQK4o/ny90R1sXb14lHI4tlvRFouCp5SZ
 JCfPUmP4SDm4F13OBb6MQpezVLwBEt73+YqXqYpfw0dCkWCxUdeOaGNw+5Zp5Vh2MGVeGvH
 ww+CcdZSR1F5Kd9xM613Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3GKZZiZGnI0=:xA0IM2Bsfo35V4mDjiOAx7
 a22mBv8B/JuC9T349/treJCeg7NaoyfbvPaNBOYQnC1ulMgOAM99p68xSnr50op2BKHknM1F5
 +BJaz5U2ZpGYQr+ByUXknzKUiOM2Cz6W791zQ4S0N/pX9KAzBbcTcQwNynzemm+rJAqbEDLzT
 merQcZ/npsD2lAAe6y+bZ60Lf4qeVlVzQpGSsxubZ8nDNF4JUrlwRLI4pQ0fr/xqYx67+bLtO
 mkQQzkPvJJibi5FtPB/oUq4pZbAf6NeCzA9PNDlntdq7V36D7iBz0e6pKJWg97vYIHoUJqEsT
 g1Qv2HxF4qG5xbEcTKKdasNokjRCmPUtPa2foHEADoA5WzV+TNCnaoZmnJErOsqquQPwfimRN
 IOFBMNKntdT7EVMHXPZFNxZPtUJlSweAOtUD4GNAzG3ZevcTosM7WJnnE93oIY8XJAmDMuR3A
 4MXuPUhGhaykDI4B8qQHPvLkV91lkgJ1l1QaUm9Ab6J6BD4Yq4zClFeBtCsF7erKVl59RZY/g
 YhWPS5nfN5xLkiKYZ7JyS6b6x+gEDKFIkFlkyGlslLEFdldMvsnMllDKxD9SDCrmHFwFa6X2+
 S7WHylMpZtCRxZyTYmso5+0Vqe5TmmjkAkQIYuRcWYEeMc6dzyMgvh5KDI0fzFivKP9IdxbG/
 EUl5ZAmynip2LGVw04haRWynCB5WdIIfNtTTYpP9x4+abw3pwJ4euYELoO8x+fMksJUZ5CaJS
 DuS4XTHpo8Xi0UU/w5q2U0lib3b0+S3g2Q70rownnlasQOua1ztso515chRNz4whdOnLXLRF7
 ENXGU1J9Ci8ahbn4YhXVBHek5HW6rxUxBeM9kPEbmknH2ivDpo7Oi2OV4wKNj89KPtoIfeSRr
 uH6hNKAH8W6+cK6M/GwSGrhhu5nCZoil4gXLGlL99NhyM9FN7x7+bxzofdGQfmhn0eXcZgVhB
 6dou8wFx0JR0xKwozhKhKwOWa2Yus1LgBidTPBaN1fE771/7F1P9XwkvQiwXZH8qkpUm6mS8j
 FrlmRcaB9dh6hZMRqevBLqkfzXCoNkk9yrQG/jTvc4+YQnc0o2HvtNcTjioOnX6qrU6IYNJWe
 1pcopavNMf5K7SlQW5oWm8TZ53mzkpiHX9O
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code for combined diffs doesn't currently support ignoring changes
that match a regex.  Abort and report that fact instead of running into
a segfault.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 combine-diff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/combine-diff.c b/combine-diff.c
index b724f02123..11df1d7f39 100644
=2D-- a/combine-diff.c
+++ b/combine-diff.c
@@ -1498,6 +1498,10 @@ void diff_tree_combined(const struct object_id *oid=
,
 	int i, num_paths, needsep, show_log_first, num_parent =3D parents->nr;
 	int need_generic_pathscan;

+	if (opt->ignore_regex_nr)
+		die("combined diff and '%s' cannot be used together",
+		    "--ignore-matching-lines");
+
 	/* nothing to do, if no parents */
 	if (!num_parent)
 		return;
=2D-
2.36.1
