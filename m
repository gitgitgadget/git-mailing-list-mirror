Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC473C433E1
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 02:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC1E721789
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 02:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHwNq/fE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgGNCoM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 22:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGNCoL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 22:44:11 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A3BC061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 19:44:11 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id q198so14339634qka.2
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 19:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=OiprK/V7EDGolGgre48aYDISZrkCiNc0ptTYQzrGOYA=;
        b=FHwNq/fEZguzwMeNM8Iqn/DwgbOx0tV5dDUsSUvJi0OVfkOugQIBbU7aNEnRVwDE8Z
         e6PjLJBQrxPnEBf0s5GgN9xLCWPjeF/CwlxFHBB1a76HP+k7RFmCnm7ZsmPvmNs6yztY
         PVrYc/AVr6Vetcpek7tnb8GreqEdHv3tz8okYDysRm/+/KZAoX3OLvIIlMc3dEW4d3ng
         oUrN2x+obvJf0GePx3Ibk/k7Uk9U5zPBTV2+sb/6GhYxtuMr5hn2Y9h2+GRh95LK0RWX
         YooYG27paUMlINKhFslVj+2LurreLlFKs/ESFJH5erKNMPIWYG8nGq41D2S+JDzQWBgB
         wgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=OiprK/V7EDGolGgre48aYDISZrkCiNc0ptTYQzrGOYA=;
        b=puzbZ2d9ypnmUxo8RqqOiUTrznnepKzIgZUMiMOm5gXz84OB1eZ1ngBaNE1Tfc7JQB
         8yutd/HKVFTNZxQvY7E1ebrDCs1WMZWw3vklV1mjROCbSS+WvLeCdqHykMLKVZBE2/9E
         vbVAkyb1AhLfhOrxeNkEnqXJSuutqzQAmMtOVr+8dTsYQEdWvDIOipX0FiSv6kyll73S
         ybXhmJiLGxPjHmI6B5IYA9uJPawLmWnRxKhOVzNY+SY6ivgcVGgWeTJUanRn3aoxYoNc
         5sLj9IN2KgCE9o7lEE4uWel6nSIWCW9ebO/w3T76efUZ/Tkrdb7ojGLcdcQ+JLFJutSe
         k7nQ==
X-Gm-Message-State: AOAM531VzCd2cwJMCdMQPvq0SxfvFkf3lYP3dLeImuvfRTqf7Bkrx8su
        uOwQLWRtfFMfPbfwy5ZbAtrGHW0QOHg=
X-Google-Smtp-Source: ABdhPJxeMZx5pvRIBe6fQsE1/bxsc3xpardQ9A8V6B1wD6xoe/mI9OjGD6s+m2VT4uJ610l5yr6Kpw==
X-Received: by 2002:a37:8283:: with SMTP id e125mr2458708qkd.175.1594694649354;
        Mon, 13 Jul 2020 19:44:09 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id m14sm21725039qke.99.2020.07.13.19.44.08
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 13 Jul 2020 19:44:08 -0700 (PDT)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: [RFC] should `git rebase --keep-base` imply `--reapply-cherry-picks` ?
Date:   Mon, 13 Jul 2020 22:44:06 -0400
Message-Id: <0EA8C067-5805-40A7-857A-55C2633B8570@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I learned today that doing `git rebase --keep-base master`=20
will drop commits that were cherry-picked from master to the current =
branch.=20
I was simply doing a code clean up on my feature branch (the full =
command was
`git rebase -i --keep-base master`), and this kind of confused me for a =
moment.

Is this a sane default ? I understand that it is a good default when we =
are rebasing=20
*on top* of master, but here I'm just doing some squashing and fixup's =
and I did not
want the commit I had cherry-picked from master to disappear (yet). In =
fact, because it
was dropped, it created a modify/delete conflict because in a subsequent =
commit=20
in my feature branch I'm modifying files that are added in the commit I =
cherry-picked.

How would a change that made '--reapply-cherry-picks' be the default =
when using 'keep-base'
be received ?

Tangential question: in any case, would it make sense to still add the =
"dropped because=20
already upstream" commits to the todo list, in the case of an =
interactive rebase ?=20
(maybe commented out, or listed as 'drop' with some kind of comment =
saying those=20
are dropped because they appear textually upstream?)

Cheers,
Philippe.
P.S. I CC'd those who were involved with the 'keep-base' patch or the =
'reapply-cherry-picks' patch.=
