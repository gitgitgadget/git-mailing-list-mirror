Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1566C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 04:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA6412082E
	for <git@archiver.kernel.org>; Thu,  7 May 2020 04:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HffIcrG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgEGE1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 00:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725446AbgEGE1x (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 00:27:53 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A9AC061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 21:27:53 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id v192so1279236vkd.3
        for <git@vger.kernel.org>; Wed, 06 May 2020 21:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=U8EP7c4QR3YEFBGh/ubo/B6rvQ1K3O+nzhgWu5n7Hng=;
        b=HffIcrG4+yNqKXvjhkck34cH2TCEJLmEKdv5fucT8cQI7ZHc9UlIwp5KaseUTFD2/5
         BGspKTW5p7MtoHenDeJBWadnfA5Y1iD/68Bt7RF7fpaIPeovmZP7xzIFv2Tb2K2LbZze
         QJE7wELZpTtkZcbvyPeSY5R+SliQSd3eZJlPfVq70vhDbGnHM4/TTcy9TnyuOc1/VDHz
         qn3IRIBAtag6VPVmVATE+CzAd4UKZgCYfv3LyVaykVQ5PAiqbmtvwG5FjPuWpLsj4k7T
         dp+mRDalHZcDe04mRItQ+QW+7pYPnpT+SG6cjNwJ4VCOC/7iKhGqwLQF2X1PV499wVip
         pf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=U8EP7c4QR3YEFBGh/ubo/B6rvQ1K3O+nzhgWu5n7Hng=;
        b=HkvJiUP0Uw7fKuwGIFm84qGFtuduRylrKiX+8mlbtNj1eKWVM//2DAwHqhD83WBeRw
         k5G0xsf1tsTbXMwBqhXttjqTcXIL3RwGqxy/gpy5iUWFWYyo8CdazbN5OMj0Tp1cl1KR
         WwROupreg0sIlwu8IWzD3xtgrqH/qZeifOJcHq5+66mzjn4bZN5n7AdjC+xDwecLqf0J
         yy/IzNih26be0Ww9Z7yfE30KKS41EX4iSUt+H9QwXIRSHaUy4y9CgqLnZ2DDsummxhV2
         lnUckd5xeKC1bT8r1Wxr2T7DzNiOOD5yNHCWutuD4noPNFjEBmAZxkyyYWzaKAeh9koT
         ZWhw==
X-Gm-Message-State: AGi0PuYyW0wWL4tCOefXkty4l2Q5toby+T1RtRMB/IURxFJxzjeSAgr/
        /kOBrc2mZ3QyIBPBbOYlsotxBXGBG1m74OwV+WVuily7
X-Google-Smtp-Source: APiQypI4+lyTe5nMmk8YUDxggCFfyp81hOWExqr7HxO03n1c7UdqGMe4IkfsJt7KGbw6HKS/N8UXvQHPXEc6OKiOCDA=
X-Received: by 2002:a1f:a452:: with SMTP id n79mr9754448vke.77.1588825672158;
 Wed, 06 May 2020 21:27:52 -0700 (PDT)
MIME-Version: 1.0
From:   Solomon Ucko <solly.ucko@gmail.com>
Date:   Thu, 7 May 2020 00:27:16 -0400
Message-ID: <CANtMP6oKN6Ueu=fqFYv2VhUP5S-ifbSzPTARvbEg4eV0pcRcHw@mail.gmail.com>
Subject: rebase -i: quick/inline reword
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, `rebase -i` allows modifying the commit titles in the list, and
the modified title is shown in the lists of previous and next commands, but
the changes are not saved. Currently, modifying just the titles of many
commits requires `reword`ing each one and separately and consecutively editing
each message, which is annoying when making small, repetitive edits, especially
since it requires double-checking each one separately. It would be much easier
if there were a mode where any changes to the commit titles in the list
modified the commits' titles. Maybe `git rebase -i --reword`?

Any thoughts, suggestions, questions, etc.?

FYI, I am using git version 2.20.1 on `Linux ghostwheel 4.19.0-8-amd64 #1 SMP
Debian 4.19.98-1 (2020-01-26) x86_64 GNU/Linux`.

Solomon Ucko

P.S. This is my first time posting here, so let me know if I accidentally
violated any rules, e.g. etiquette or formatting.
