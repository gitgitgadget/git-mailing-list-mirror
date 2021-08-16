Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30797C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 09:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EBC961B74
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 09:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbhHPJuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 05:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbhHPJuu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 05:50:50 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3B0C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 02:50:19 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id l36-20020a0568302b24b0290517526ce5e3so12765584otv.11
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 02:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=IGJLrXPa+v8MUL5U3mQKOPTf8XYsEdRH+k7PiMot/H0=;
        b=gAKI1MpmnDzNRNM7kWmFjPv96aWGKoCxNkHhhhQGp6H9ZC8apr+mprIfKr8WZDcQ4A
         BARiMwvSstsa8pte4ThnbxGGoboeu4qpW+36UTb8V9xJRH8V12sNbPjD9BihJXrC7mSt
         DAyS6z1IJ1WCdFQiD/sQNFfwRne08M//NmNcILxgyQyvV69BYudAWqJI/x/1WnjZLp6J
         hxXaqA0eCFz1yPv6vXP6JzmxMjUFC+unDYCVximRjBbkDBSpJ02TaqYfkv35geHugV5M
         tZI94hRvh8fuuZhRGVAFBEcMAwuE7wN793ILZpBBkBMnd4b8vrJHX5GT5pZZOUeqZzZe
         JRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=IGJLrXPa+v8MUL5U3mQKOPTf8XYsEdRH+k7PiMot/H0=;
        b=VHonCMahA8SPV0lQaomxjsHB/npp9DrNY9aK/hpk9jsi0C1lLsWQgJRJV2lWlKly4B
         HcqoED+RdbRhBpVWxw6ot8WR1nbRyJunnP2HQ9tu7f0QQOYkfjjWr+iFxu/36h9e8YhN
         Y4AO+xFUIDENtCzUQxmE1jkqoJt4K8WzLLimc2h5LZuGgjZVuYiLqzTQqywDCqW4TC/G
         4sXaRdKwEwRS5/WOc7sKKECqzrgmBd2x7eFqnD5gVTxgAwc9MSztUZieQHEjMh4IGy+w
         YWYOB35sQ3cCsY5sgyp6QIS7iHSy5CyUgu+rkBrsjFjXQJbqQ+v7DLr8HqfW+dTNTeSh
         cRcw==
X-Gm-Message-State: AOAM531XcOrZZHzhQItedCGzUAbfH6FC2469+rVZkqZJ355eITWCee6M
        vBzYoq+jOAOm87C+l8WusPmdqt5H/X4=
X-Google-Smtp-Source: ABdhPJxt4WWp6zYxU9O5ywF4/85XaYwcLAmirYmy+J+epvw9vxSlzggVKZPaeAt8kQCWaOIH5RoXhQ==
X-Received: by 2002:a05:6830:544:: with SMTP id l4mr12031447otb.164.1629107418721;
        Mon, 16 Aug 2021 02:50:18 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id l3sm687590otr.64.2021.08.16.02.50.18
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 02:50:18 -0700 (PDT)
Date:   Mon, 16 Aug 2021 04:50:06 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Message-ID: <611a34cdecb10_863a02083a@natae.notmuch>
Subject: Opinions about the health of the Git community
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Now and then I've received personal emails stating opinions that people
fear to share publicly on the mailing list.

Since recently I was punished by the Project Leadership Committee by
what in my opinion is nothing more than expressing my opinion [1], I've
decided to start this public query about the health of the Git
community.

Essentially I'm looking for all opinions, which I promise to keep
anonymous. If you are afraid of expressing an opinion because it might
hurt your job, or your standing on the community, here is the place to
do it.

Reply directly to me. If you don't trust me to keep your opinion
anonymous you can use an anonymous email service [2].

Because the community leaders believe this kind of discussion is
"harmful", please reply only to me, and not the mailing list, even if
you are not afraid of sharing your opinion publicly.

Although you can share any opinion you have, here are two questions you
can use as a baseline:

  1. How is in your opinion the health of the Git community?

  2. If it was up to you, is there anything you would change?

Cheers.

[1] https://felipec.wordpress.com/2021/08/16/git-ban/
[2] https://anonymousemail.me/

-- 
Felipe Contreras
