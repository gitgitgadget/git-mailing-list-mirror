Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F13C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 17:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1CD5613C2
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 17:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhGIRNW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 13:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGIRNW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 13:13:22 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6029C0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 10:10:37 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 128-20020a4a11860000b029024b19a4d98eso2428292ooc.5
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 10:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=y0dLaL0kDbFyF7tkWCbJtNU7jKDgDflCpvvbDMGMMoE=;
        b=PID3lE37fEchNUiNbF0KGqwsf5LxwpE3kERoF0nvMKJjygUAJfNrIHGBSMZg0TzZe3
         O21Zq80JTexsqdP6nEf9Ee2yMqejplZGH/jRIese9WnBVPq5BzggxSQ/rArTztfzsXoK
         kxtqQM49epV1KwHTFjD96QczZ1SYwa6PK4wlMHAmmtbM0Fl3ebnl6cZonjZ0XJZOBJZq
         mJdcwEqKvu6eANKrzrEcFqou4EK0U832P0YYU9aG819DQlYkEM4P5yQE2Ayy/ROs9Cny
         ZbCNz9WWe49qaxyih3ZXDbvffh1GnRWKZKaaGWt74DkSqL7O/RwOj9aQryH4jU8W6cv2
         /5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=y0dLaL0kDbFyF7tkWCbJtNU7jKDgDflCpvvbDMGMMoE=;
        b=hx86S2c27J1L2754uJMFpZQAdyFeQqNn8aCQE0oRKTbF8xQgHorUeKl89tSQQUIq4V
         XznC3aTIwANMiytDG3LeThpvdXw4br9F4ik4GurLLG2YfioPdjhLoleH2gLecs5wQHTK
         nz95o9C6szEgN5m/Fwweyi/2N+wbfgeJqWtZ/mfNen0HBFdNf6mHQqZ0vvnMTd5OSVUu
         Ib+0JTpP3D/MQC2ubob1GCNuU5vQYcTmqmH+2o/dZD3KEAB9z28Chi7IjUIWTxypZNZt
         ku4Pwic4jELIhTe1GY6Aeynn6syp645CdUJpXB496RqwrtITVX5CUj4glLFHTk+PjgAZ
         O8mQ==
X-Gm-Message-State: AOAM530S+YNfGfve9b8qm6dl9xsZ5Xvivq6Xy77otEV2JJnCs9KEI11B
        sRu/iRhJoWXupfvmnPNlG4U=
X-Google-Smtp-Source: ABdhPJxhSWMUHaeQFEAH44ls7PJaywK6M/zr5GtrV4jC1RmpwJUKlLHNuctq3Iszz5dXK7RdeCwzMg==
X-Received: by 2002:a4a:d758:: with SMTP id h24mr9161456oot.8.1625850637056;
        Fri, 09 Jul 2021 10:10:37 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id x31sm1250958ota.24.2021.07.09.10.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 10:10:36 -0700 (PDT)
Date:   Fri, 09 Jul 2021 12:10:35 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Felipe Contreras' <felipe.contreras@gmail.com>,
        'Martin' <git@mfriebe.de>, 'Sergey Organov' <sorganov@gmail.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60e8830b2f6ed_16bcb20836@natae.notmuch>
In-Reply-To: <008701d774e0$d3220f40$79662dc0$@nexbridge.com>
References: <<c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g> <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g> <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g> <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru> <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru> <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru> <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
 <084a355e-95cd-5c84-2fa5-a901da3e0e49@mfriebe.de>
 <60e8666c8707f_2153208c0@natae.notmuch>
 <57f316cb-850d-706a-592b-4376f240e032@mfriebe.de> <60e8776cdc4!=0D=0A
 55_215320852@natae.notm=0D=0A uch>>
 <008701d774e0$d3220f40$79662dc0$@nexbridge.com>
Subject: RE: switch requires --detach [[Re: What actually is a branch]]
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall S. Becker wrote:
> In all of this discussion, please be aware that many CI/CD systems use
> sparse checkout and detached heads as a matter of efficiency and
> certainty. Please ensure that you are not changing the semantics of
> existing capabilities when restricting what `git switch` will do. I am
> concerned about the 280,342 (as of this minute) current Jenkins users
> who depend on this.

I doubt 280,342 Jenkins users depend on `git switch`.

And `git help switch`:

  THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.

-- 
Felipe Contreras
