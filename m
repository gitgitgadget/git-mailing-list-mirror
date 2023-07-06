Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19389EB64D9
	for <git@archiver.kernel.org>; Thu,  6 Jul 2023 21:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjGFVAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jul 2023 17:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGFVAP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2023 17:00:15 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839551999
        for <git@vger.kernel.org>; Thu,  6 Jul 2023 14:00:13 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-313f0ca48c7so293428f8f.0
        for <git@vger.kernel.org>; Thu, 06 Jul 2023 14:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uw.co.uk; s=google; t=1688677212; x=1691269212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QG7sYqv+sG8UqYRkfVSJBi055y0fo2zJgjRbp+HhRA4=;
        b=BynrbuGvtdqUM++P1qd3ZRQhw4o8XJAtXlN23hUg/faVP760VxrwxXKOkyUzGHO+Uu
         M+Igm4aS6yTbHfAU97Js26tRsHDEbQSSHAWmW0CZRK4CjCNvhgfODiUcvVte4XiRdKiY
         e2+UNhHvBgQ5gQjkXJ3x6HVCCwXB0k928CsR4AEy/qSlJuM7ZakCH7QLAxSzu9JI1mU6
         lT23b3KALxFTZsWQPeqEHlknKl4dUIzFFacSMP9f4Bbe6jDBpxITbzxcTlBxYhtYXkZJ
         ACbMqMEqBYS/+3sA6g41hRYeL+xHKv+lV2mps1Hww6tJpa8u7G4OyBMqfgz5n3Pp/Tto
         hGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688677212; x=1691269212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QG7sYqv+sG8UqYRkfVSJBi055y0fo2zJgjRbp+HhRA4=;
        b=da79wZIB5FlPWm5rL1Z2uFhrHNTMhbcI/Ilw65WUZ8OFk4R/RX49TglwDbNaPRHAM/
         ZHSxR2gml/zbWvQ1dmTdJpNLHfPfSCVwjW3q1pBbjk53pIkeOS+ekLFO1X1u41aclQ76
         3YOv7P5+FzaVBF3sDaCaBJRe27GZz8GMsDySCPFUWD9w6DjZm4Uzukya6NRAYEwkaZqY
         fEID+KqV/ZqR8XnGfWqdbaZf2Rsd1wtdQFIBKdnBYL5tN1XUWmWb6F10l+fQWzcvEZRV
         9PvEFP9f4I1GrZjgND+t4tN1x5GIMJDDxYUXXM3PvElajay799LQVz2YoZl4cr4nzCm1
         d1JQ==
X-Gm-Message-State: ABy/qLbhICHTXI3nPOU1I7j3w7JzN0TCj4RRNtMvL9eWNyLhmW6BSyyh
        /2k72CfxtrdJ5dRBZB7PJ6W1E8JT3FTDpstQyXA0X7fy0jrcmUhm
X-Google-Smtp-Source: APBJJlHWvp5z20QGpoMsqswZksElQ3318C1gxnnLDwN//EXr2Y+/ytfDnySRJNWKaE9m9ejUyEX0kF4MXtpEzf/TeoE=
X-Received: by 2002:a5d:5290:0:b0:313:e9da:772c with SMTP id
 c16-20020a5d5290000000b00313e9da772cmr2344995wrv.5.1688677211837; Thu, 06 Jul
 2023 14:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzX-aD1wfgp8AvNNfCXVM3jAaAjK+uFTqS2XP4CJbVvFr2BtQ@mail.gmail.com>
 <xmqq7crddjtq.fsf@gitster.g> <CAEzX-aC=UDkf6nevLbN0bNyGXujZVDuqtCp3YcYhAPD6zvYZiQ@mail.gmail.com>
In-Reply-To: <CAEzX-aC=UDkf6nevLbN0bNyGXujZVDuqtCp3YcYhAPD6zvYZiQ@mail.gmail.com>
From:   Matthew Hughes <mhughes@uw.co.uk>
Date:   Thu, 6 Jul 2023 22:00:01 +0100
Message-ID: <CAEzX-aBUyKivBYTFaLh0_irEH5ToVTVBUsSSU03-3ZMdPbjOow@mail.gmail.com>
Subject: Re: Expected behaviour for pathspecs matching attributes in subdirectories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000005ab63a05ffd7cd3a"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--0000000000005ab63a05ffd7cd3a
Content-Type: text/plain; charset="UTF-8"

Apologies, re-sending the patch as an attachment instead, since Gmail
decided to strip the tab characters

--0000000000005ab63a05ffd7cd3a
Content-Type: text/x-patch; charset="US-ASCII"; name="attributes_test.patch"
Content-Disposition: attachment; filename="attributes_test.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ljrmrn2o0>
X-Attachment-Id: f_ljrmrn2o0

ZGlmZiAtLWdpdCBhL3QvdDYxMzUtcGF0aHNwZWMtd2l0aC1hdHRycy5zaCBiL3QvdDYxMzUtcGF0
aHNwZWMtd2l0aC1hdHRycy5zaAppbmRleCA0NTdjYzE2N2M3Li43YTc1MDJhNmViIDEwMDc1NQot
LS0gYS90L3Q2MTM1LXBhdGhzcGVjLXdpdGgtYXR0cnMuc2gKKysrIGIvdC90NjEzNS1wYXRoc3Bl
Yy13aXRoLWF0dHJzLnNoCkBAIC04Nyw2ICs4NywyMyBAQCB0ZXN0X2V4cGVjdF9zdWNjZXNzICdj
aGVjayBzcGVjaWZpYyBzZXQgYXR0ciAoMiknICcKIAl0ZXN0X2NtcCBleHBlY3QgYWN0dWFsCiAn
CiAKK3Rlc3RfZXhwZWN0X3N1Y2Nlc3MgJ2NoZWNrIHNwZWNpZmljIHNldCBhdHRyIG5lc3RlZCAu
Z2l0YXR0cmlidXRlcycgJworCWNhdCA8PC1cRU9GID5zdWIvLmdpdGF0dHJpYnV0ZXMgJiYKKwlm
aWxlU2V0TGFiZWwgb3RoZXJMYWJlbAorCUVPRgorCXRlc3Rfd3JpdGVfbGluZXMgc3ViL2ZpbGVT
ZXRMYWJlbCA+ZXhwZWN0ICYmCisJZ2l0IGxzLWZpbGVzICI6KGF0dHI6b3RoZXJMYWJlbCkiID5h
Y3R1YWwgJiYKKwl0ZXN0X2NtcCBleHBlY3QgYWN0dWFsICYmCisKKwlnaXQgbHMtZmlsZXMgIjoo
YXR0cjpvdGhlckxhYmVsKXN1YiIgPmFjdHVhbCAmJgorCXRlc3RfY21wIGV4cGVjdCBhY3R1YWwg
JiYKKworCWdpdCBscy1maWxlcyAiOihhdHRyOm90aGVyTGFiZWwpc3ViLyIgPmFjdHVhbCAmJgor
CXRlc3RfbXVzdF9iZV9lbXB0eSBhY3R1YWwgJiYKKworCXJtIHN1Yi8uZ2l0YXR0cmlidXRlcwor
JworCiB0ZXN0X2V4cGVjdF9zdWNjZXNzICdjaGVjayBzcGVjaWZpYyB1bnNldCBhdHRyJyAnCiAJ
Y2F0IDw8LVxFT0YgPmV4cGVjdCAmJgogCWZpbGVVbnNldExhYmVsCg==
--0000000000005ab63a05ffd7cd3a--
