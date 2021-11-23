Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FCDC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 09:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbhKWJMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 04:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbhKWJMM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 04:12:12 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456E4C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 01:09:05 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id 70so3560774vkx.7
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 01:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ON/HQKE8wuGSZ4XNEjqCSQDd2audmvh9U906rLGpDTQ=;
        b=fClkBd5LTmHwO45YZiXVUs2FktGvx9GjvigwrExv9B0fdG3Lzl0WIHaqwuJ/I/sepF
         ovge84uwa6jJU1L17/3oSh8pKyUddgGgCJ4FPPn1B6ta4eBPHusQrKCzrqXrsjmpQEUI
         z/MGZG2eZGwIiPVUXuALZYZhgzlwCzXpKBFmMt3fTYFttGniZC/emBk7x1Xm6lEwks05
         kixj+IvLsc1oMSzqysTYgErv4/fnz6r6m4hrJDWJSw2xE37MjEdhPKO8zCO/kgl9RHQ2
         QfELmlAeK2kANTVE17vpb4kAuJp0d7HoVQM47oIwr3xndINWr5pG0zO+JMEM/pfnIfF5
         dm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ON/HQKE8wuGSZ4XNEjqCSQDd2audmvh9U906rLGpDTQ=;
        b=LjJiuB1NgTenNsghZhTvJbxRRlZ0b9fK69t4ev/3W3P81Cwri+xOjORnsSDUeqS5j0
         X8Ql4s/P0jcgFM2MLsP2iWGO3rY4HMcjOF0HbT+PiqG5IWUdzCd0TH4J3k+f4dsJg29X
         LhxWvjHM0W++mvSfUpOZ4v803fjutzld3bkCLqI9R4a+qEdry6GEQ3cku4RCAEwAnwLc
         qR62Tk/1MkEwJbifIBHnyNe1UBUiXLBMAMhg4scjoJvJQ3v7C8LPPLeaFO++0FB25/cd
         vqDJl4u7c4I3VZWfieFijo0/b7RWUxK3d9GuBTFcIY8C5m0CRt32V6fCQffcMIc/QxMU
         b2Aw==
X-Gm-Message-State: AOAM532IwoMSeqaAmu8njte/QSDApSWWEtVwbIjTue5oeItB5/KKoQHZ
        jz5FpnhW0Kql3S1mJpQahsR5iPZ9P2vEZHgiFy8=
X-Google-Smtp-Source: ABdhPJzngwPvHTxu+eJtwO1vSI+8Mo1jQeZK9rD0P8lsOyVNDP8/DVOTsGTCFr5NctiF+lnQWdSvleyHa+jTXiO8cco=
X-Received: by 2002:a05:6122:201e:: with SMTP id l30mr7572849vkd.10.1637658544425;
 Tue, 23 Nov 2021 01:09:04 -0800 (PST)
MIME-Version: 1.0
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
 <20211122222850.674-1-carenas@gmail.com> <xmqqa6hvbxob.fsf@gitster.g>
 <xmqq5ysjbxfm.fsf@gitster.g> <37d7c35e-54a3-04f5-b03c-b8197a8070a3@nezwerg.de>
In-Reply-To: <37d7c35e-54a3-04f5-b03c-b8197a8070a3@nezwerg.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 23 Nov 2021 01:08:53 -0800
Message-ID: <CAPUEspiD+-FF5oqA_LrZeVf+tSzUttHdpLGB8QwrGBZ8uqUSKg@mail.gmail.com>
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using a tty
To:     Alexander Veit <list@nezwerg.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        phillip.wood123@gmail.com, thomas.wolf@paranor.ch,
        Alexander Veit <alexander.veit@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 23, 2021 at 12:52 AM Alexander Veit <list@nezwerg.de> wrote:
>
> Am 23.11.21 um 00:08 schrieb Junio C Hamano:
> > So, here is that first step, to be hopefully mergeable to 'master'
> > and also to 'maint' for 2.34.1
>
> I've applied the patch to 'maint' and it worked. The application does not freeze anymore.

great news; apologies for the disruption.

Carlo
