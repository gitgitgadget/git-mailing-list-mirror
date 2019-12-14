Return-Path: <SRS0=+pXB=2E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549ACC43603
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 22:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA1720724
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 22:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQHZFkqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfLNWly (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Dec 2019 17:41:54 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]:35662 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLNWly (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Dec 2019 17:41:54 -0500
Received: by mail-qk1-f179.google.com with SMTP id z76so2319019qka.2
        for <git@vger.kernel.org>; Sat, 14 Dec 2019 14:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:references:in-reply-to:subject:date:message-id:mime-version
         :content-transfer-encoding:content-language:thread-index;
        bh=Kp+2ZQZYMY9gclsi6G2IapFnN5R+I4diYODJ5m8vIcM=;
        b=SQHZFkqQQmTxfUjS8LM3rh9I16oo0WCJOLWd5p3VMDWvCWAg4T5/1d/+rnUyevVetM
         s37o8mn7fkgeRCz6KMFGnF8yxdjqsUQ1X+hk8br0DMlZ/XFFw+OuTZ7qBRrdz+lRXGS/
         p2ql1Vf/pWyISKUjeZrY7SjPYHaTNZD3IB6VKIm8sk867htjRCY0pB7OBLuSxJj8f7TE
         Ooij5LuT6DYI3BF1cUMFe5zEpiOBjJbkCT+UKXXCZyRkNxrFqExoFtKe9VgEZBsbfwYp
         dQyzNrTZHwebdj6nEx9gHo0sjIe+q7f+n4qy1eDh0hVk1tOlrG78aM+NIkDWUjs1a6af
         MFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=Kp+2ZQZYMY9gclsi6G2IapFnN5R+I4diYODJ5m8vIcM=;
        b=Gu6mGSwbjzcD0xKgSrwnysgc8fAk/JOCCgiXljRZXYRfV4OPqZnx1Zxare04qMmUXf
         jCtMtUQLX/1GQSHpGo13RT2ArgLCfXpR9u56NxoGnP3mY4WgL2kpnpLjW484ejvuB2ON
         h6xwadmVc3N11IpHcK5sUFUYtbcUvYvTpT4ljS1CeJnUZIroI0pwo+M/4clDpc1xP1Dm
         +ZfgW9HI5A76W4wgiz88bP9Ey2n1yUN5r64eAwoAw5sDOVclS9g3EaHR3SpqK7x/VVmM
         KCFAIyYEhhw2xURRf9nALXw7DsoHdApw0jO5qBEH+7y/HOhiUxmrde3Nnwmd185hkA+p
         uHdQ==
X-Gm-Message-State: APjAAAUQVyd6cnpUDcRcuWBiyxIBpAd8xfIsGHXf2BQNanpI9fYoaZn0
        fNs1961UmUOPOzb3Sn0ysWHC6+eOao8=
X-Google-Smtp-Source: APXvYqynxsHJKfdGgkQB9XZ2UWbX1cxHiX0cckO1tq1DZbGdHIrWz4buTWFjvjRkSdZqGc3WzQ8iaA==
X-Received: by 2002:a05:620a:1005:: with SMTP id z5mr20554365qkj.26.1576363313361;
        Sat, 14 Dec 2019 14:41:53 -0800 (PST)
Received: from DESKTOPCTCSEL8 (ool-44c0afa6.dyn.optonline.net. [68.192.175.166])
        by smtp.gmail.com with ESMTPSA id w1sm3375119qtk.31.2019.12.14.14.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Dec 2019 14:41:52 -0800 (PST)
From:   <mattr94@gmail.com>
To:     "'Tomas Zubiri'" <me@tomaszubiri.com>, <git@vger.kernel.org>
References: <CAE3VKEpPye+GyR7Uo9WBa=1i1L=dFq9AHfdNnhiw19K-jWLtBA@mail.gmail.com> <CAE3VKEppVv=rocJU7jHKu7i=dLyaHhpauTBmm91udjZ_DOpW+g@mail.gmail.com>
In-Reply-To: <CAE3VKEppVv=rocJU7jHKu7i=dLyaHhpauTBmm91udjZ_DOpW+g@mail.gmail.com>
Subject: RE: Head, Branch != Head -> Branch?
Date:   Sat, 14 Dec 2019 17:41:49 -0500
Message-ID: <007401d5b2cf$ac787ed0$05697c70$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
thread-index: AQHPpBSHjNIuCSm5NXhjTqdHYm6yxQJD0Zc6p7Q2XBA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


After going through the code and thinking about this. I think the =
unexpected results came from git branch not checking out the branch I =
created.
I know git checkout -b master would have been the result I wanted. If I =
were to create another commit with HEAD checked out instead of master, =
master would not update, only HEAD would.
> I guess the real crime here is that git branch does not checkout the =
branch created. I don't think I ever wanted to create a branch without =
checking it out, otherwise I would use git tag.

The problem with this is that git tag doesn't create a new branch, but =
rather just a new tag so running something like:

git tag my-tag
git checkout my-tag
git add .
git commit -m "message"

wouldn't update my-tag either, you would need to create a new branch for =
that.  Sometimes I want to create a branch without checking it out, as =
I'm sure many other users do.  Is it an issue of documentation where =
maybe the behavior isn't clear? It does specifically say this in the =
description of git branch, but to be fair it is buried 6 paragraphs in

