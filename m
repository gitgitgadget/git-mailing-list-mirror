Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB4AC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 18:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346903AbiHISry (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 14:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345376AbiHISr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 14:47:27 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EA14AD75
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 11:20:54 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 196-20020a6301cd000000b0041b0f053fd1so4676236pgb.6
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 11:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date:from:to
         :cc;
        bh=GXwoaoFjh/rn7oHDi1PDnA6xixZU6WByyDW95voazJs=;
        b=ZdLtpe5GnzUGAkvPbj/u2e5lmf2lAJSTLQ9XZ9J4gGmsHn3BzD5YoEQOpaxESTAjpc
         NmAvvFb/9ZebzFfQARRxf7X+rZF5av9RtdmvHZP6+B79/daf2F8HIceC7i+bS39eiz6v
         E67AeMp4cXfXjUCJebKPMzZEyeRoMvFoZ+20JhCCokk/NLShsekhFyZS3Z04p5z0zpHz
         iCSoBu1gFPLP1M/n3tVss7XUubDC9bNBZEgTe28s8ywgxmGs/YjD7aezUMkWFEuRcT5/
         +ltAkIRDYlcCOxeZFDv7PlODyl8+Ji/MeyBZlD83Rj8JpGQbhMK5bJDCf1IYjfJrfnDU
         fjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc;
        bh=GXwoaoFjh/rn7oHDi1PDnA6xixZU6WByyDW95voazJs=;
        b=fdG8ruaD47cHzAhP1YB87w30vYkiieOeOdvpo3wzX0D60jSj3v0ecU5d80HvR0utg6
         HcVIMAN0SEYwHBiStYMO5F29MwIl03Zm/bSjbmKoXVBGm7MaJAEBWaOToUYB84O7MlIj
         BdOt7AUzLFPtrPuFS+qKQE4qIqdBpDtE03qRPQ5NA+hhzcRxCgZEzEYh1DImi2rUwilo
         wOUPw8nlGABa9ISO9677+lYAJYDsRTkFNRz0jG9WvCH4JM3GiFiToh1g48UMBhT/TBiY
         aLewbJ/1eRtJGeidWxTmrErQIWkN1l3nqW12HcIuF3JTIO60riULh7KW4zlNL1jwwTMl
         zrVQ==
X-Gm-Message-State: ACgBeo058v2QyfdPMgt4+ab4y9lu5L7c9yyCtPAwcHZ1hG81GnMtcmN5
        qWn6zO9TLVmhVjKzcU70+GvGYZdIHnaKJ6E=
X-Google-Smtp-Source: AA6agR6Va7kU/PmiRHfGAT5HS3s8ZkUv4qy7tQX/V05Ruzy0y/GicSzPSJe71eXmns3Q43kmFDUN0SNZeY8QucA=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:8b43:0:b0:41c:cb91:2c47 with SMTP id
 j64-20020a638b43000000b0041ccb912c47mr19980248pge.609.1660069249118; Tue, 09
 Aug 2022 11:20:49 -0700 (PDT)
Date:   Tue,  9 Aug 2022 18:20:44 +0000
In-Reply-To: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
Message-Id: <20220809182045.568598-1-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: Re: [BUG] Unicode filenames handling in `git log --stat`
From:   Calvin Wan <calvinwan@google.com>
To:     Alexander Meshcheryakov <alexander.s.m@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alexander,

Thank you for the report! I attempted to reproduce with the steps you
provided, but was unable to do so. What commands would I have to run
on a clean git repository to reproduce this?

- Calvin
