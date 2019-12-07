Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7BDC43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 07:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071D821835
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 07:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="0qDh6AdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfLGHfI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 02:35:08 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37757 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfLGHfH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 02:35:07 -0500
Received: by mail-lj1-f196.google.com with SMTP id u17so10103170lja.4
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 23:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=F1MoBOJspG9i2u4AqfvtCBQGcA577AIxEcXZ+SXvghs=;
        b=0qDh6AdPwBT6lSUXzXF0Jzpm+sKGNkhdJphCFGwFZjB9wFltAEL6fAu1G5fHH6wnEG
         nbB6shsBas2ycCFRW3Qmq+ROC4tojow6QSvCqCUGPTXdgAafmXL2PHnbunjM7COzD3l5
         R9Mf86DrP/nsM1ik+VvzJM6mAyHOPBc5InGfDa6wVflXKNXt3azDKFGDqT3rwxwsdZRz
         xsWK/W/ul/wq6j4SLZ30NVSkXEWm6ev6revK4mFh4O69DUpCv0TZ1z8MLvKA5GAOvV7j
         3AmknAciS4ze5ZUNwaYbD6aXGQ9AVRrgxq1FODq646uKQl2heSSHKS2OUo6WF9408myC
         KDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=F1MoBOJspG9i2u4AqfvtCBQGcA577AIxEcXZ+SXvghs=;
        b=eKS5EUDoTiB1/d4AkeBpffRzLDBkfWi203zxR/ZMhV9nW/TiF4w+HEVnXCHkv4dgE8
         7Uf2SQFBn5JM2dftuIY7xxUkesU1QExh4D8LJu5p10RQYOsMW7rQUc6rkdOBIvNwd99o
         ub8w3ou377I4jWzZH/mUtULm6eNHYqt06GV8v+rF1QGnr3SSkk1fXmg94Sg+pbat/qAn
         iHQVoVwwcCuu5i2ZbOLdyBsuLQ8KsEpumCtyZRuVkiQPcMZUxl2MWK51urt8R+0Zb3P+
         Me9yC4i3/UKFv3kjAlxNoKjKdHbq8q1nnSkHJdxCofNPBnyr8s7ObIluz+bik5btt+gD
         evZg==
X-Gm-Message-State: APjAAAXuY0XU5mPOaQVAJq+NdufTtSU4UhxOCA7WrpKlvcI7JtN1ExO+
        FzkzuMJziHTi6+EtqJHVHS4TTeZC2mqFqHGm4mwqnG7rX74=
X-Google-Smtp-Source: APXvYqxYZeX8/gQ6BoSGrSK2TY/09UmTkUsV8QDBgqBSJwBTMp6BvHJoSLXyCNEcp3g/rNZa6eD0SvzRBlv/QSKYWW8=
X-Received: by 2002:a2e:7816:: with SMTP id t22mr10837255ljc.161.1575704105370;
 Fri, 06 Dec 2019 23:35:05 -0800 (PST)
MIME-Version: 1.0
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
In-Reply-To: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
Date:   Fri, 6 Dec 2019 23:34:51 -0800
Message-ID: <CABvFv3+06yTTaF6VQ=DpRV5U5wDBBmrQc2ZNXDEmvoGw6R_o0Q@mail.gmail.com>
Subject: Re: [PATCH 00/13] git-p4: python3 compatibility
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 6, 2019 at 4:33 PM Yang Zhao <yang.zhao@skyboxlabs.com> wrote:
> This patchset adds python3 compatibility to git-p4.
>
> While some clean-up refactoring would have been nice, I specifically avoided
> making any major changes to the internal API, aiming to have passing tests
> with as few changes as possible.
>
> CI results can be seen from this GitHub PR: https://github.com/git/git/pull/673

Looks like p4 LFS tests are failing for python3.  Looks like it's just
more bytes vs str.

Will have to enable LFS tests in my own environment.

-- 
Yang Zhao
