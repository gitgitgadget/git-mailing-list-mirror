Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5ABC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 07:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D6A60240
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 07:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbhIKH5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 03:57:12 -0400
Received: from mout.web.de ([212.227.15.3]:45809 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235349AbhIKH5M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 03:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631346958;
        bh=/+1nHcKPTapgD+2bdC+dLzf7BEtTSLnxF3YHa43gRG4=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=fBuM0o6rqYNVgncHn25mN219vW25P1f62HgiXn6qG7ruHZpDec0Izyc7VcaexXrmE
         r22hzcDfgfWj3vh4P05EP3MbotZDozMJB3jn0lq9C6jI8366e/NUq9h0nrbt26eexG
         eV2bs6jTkfYFl3ueQg/UJny8zOU8i1zwt1c4nQ04=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1Mtgyp-1nDKwU1u87-00ukrw; Sat, 11 Sep 2021 09:50:37 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/3] packfile: use oidset for bad objects
Message-ID: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
Date:   Sat, 11 Sep 2021 09:50:36 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kuhm7+iUpPp1Zsn/ttFsX5ulTptQ1uGPMcRBDtiO+7Khaq0AiCz
 r8Jk3dg6AkhE8jrm2cgA0jTto07WSvQlHTelLsx7wkWYHTBCSQ9ZG926IzhSQbtZgs9h2j2
 ocF64kJ4QKPvhPeYvibgqIPBmuUcNrHb9xwYePpqFxxaAQHdSWOxpVjJDp67TmNqklJF+XX
 Lcvc4ecihkjLYAI+EFROw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p5U8ZbJHD1I=:FpZyo7r6A8ZFtW4mKNLFdK
 ab5mR0ON+FD/DAK+IRumxATRFNdJ3u7Q3gKAaR2ldwu1W2sZSQiijp7kbsf3IeDflgfEGFu0y
 wN/PlOGOzJ8EmA0SWaCLjJYZOiJn1x7MFaEmshP/QgGSnnY+AucEbwUnV1KNKQgo9siSbKRnt
 ATuYpHuskP8mTmmCW6W3YCzIKIOVmUQr0MjSjuWZih53zFWNrO+udcEMmJzcdZDsdig52mdKY
 7wiYrolUSKhRSqbtkE8nnV61jEtS8xjTEjBVVg/9GJ+b1sopL4OJZSeNwac6Wwwe22VtPLK3X
 BYCmwO636tcvnsp12zh+g36vNkJgjSebAu7HjTTCXipZyd1+qAmKVTdQsPF4C2R85ROppV5k6
 e1xv8xItr//XORSaPWLNQi2ozIFTILXJrRW5g76iVttcIzs/3utFOy6HTaJqS/V9XBNNmpynh
 9rdlfFfC/Q55+LmM2gMwxtxV9F8nI+CobesP5bWk0gXkKiRNBIbHsfqB0tIwsZbbKgWO+N5pA
 lYT79XyFm44UHG2txcWkNy3Jcy25dvRvsrJUtus+MakODrsZCIXb++Bx5UN7mMfnWUFfpy+FJ
 U+XgBQ35i4X0ENnaGl3H9vsIOC6uQmixaOqgX+uek03s9WBTPIfB3Lw6eAYb0Uas8dJbA9EES
 HGhLDTWlb0S4GaGhjOw7sdPimWnQKlgIuBaHS/TQEVmjKoYj8p7p0IGB5a//GQSENlFJr+DRk
 Hd6nWyRRnXUhxcN23Mt2GBKLNqryomhpXl4d9nyHn8azU0AqIrV/LcHljgF1tmYwC67aQ83FV
 +NToAbl5zpY15pHj2hM9UV/wH+io4VW9ABX53kREZh03BpDaor3yEmJ54PEHyAaaHw2+z/nyj
 6LkUlV1Mx+48ZI+2lu9LvMYUqlX84TsxseyNvzQ6xNYikfPZq55lEv7VcD6Mk+Upqcms9YWTk
 7VzKiXl3pM/DtGeM+d6iQqhnreJG9HDaPnm6FyYEX1f9nEohsqFPCE37pUCWLsVeT8BKzdwSb
 US5DqccPqXWDrZOzoQVflTFdHDtXmY3Lp4Ya1Osv8FVK+p8Y81KEQrIuwsoF59M5oA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the custom hash array for remembering corrupt pack entries with
an oidset.  This shortens and simplifies the code.

  packfile: convert mark_bad_packed_object() to object_id
  packfile: convert has_packed_and_bad() to object_id
  packfile: use oidset for bad objects

 midx.c         | 13 ++++---------
 object-file.c  |  4 ++--
 object-store.h |  4 ++--
 packfile.c     | 37 ++++++++++---------------------------
 packfile.h     |  4 ++--
 5 files changed, 20 insertions(+), 42 deletions(-)

=2D-
2.33.0
