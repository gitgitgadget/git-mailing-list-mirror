Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBF4C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 23:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbiGRXlN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 19:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiGRXlM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 19:41:12 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A3F26572
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 16:41:11 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id i4so365469qvv.7
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 16:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=W/TTqAuRlj3cwfttrgwnPpHA0oSDgenLOBCqt+e1HNc=;
        b=h2C0LzNWDRh1NB+9NE2QWcqPBErufoMCGb9dP46zJpoEcnyZmYrlmrfek0sTjgYnmU
         YhDtyzgsJjGCMzzMLNf9qY7uqdbqvzYU6eL4HGw2U7hCevimpKP0tfm8ZZ1+2hmYXXlL
         Xaucwkd5vhZl5Ax7ZlX9SxVVE4z7R2cvuZYWWJffcizT4W0IsuPmbXJkpjlu+kkGciNk
         Im4kI6mAHzwi9SA0JP0S4jyTaUnPIdHXEW1YBRQIX2QjiKyIXCerjL0cjfJczVtrS0sY
         E20x8Yczhvq6mU0CCkafmC2oUiyMRBEmu3WxgMN2+CN9Cb373xXNFBzvHabofLoyP6Vi
         gvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=W/TTqAuRlj3cwfttrgwnPpHA0oSDgenLOBCqt+e1HNc=;
        b=rJScQdpA+7/hScftx5+1ifoKLuI8D+rY20cDVDPwVpXfuUsrE/T6kZI2pqQXUEsFAj
         0OWOOx+R0sGpeq/kGgCrR1bDZjv/FfMLSt+U9o3Zv9N70iLftoUKKamo+7PSkNInN4q1
         Z7JJT/dEj/GleTNPBCasuZNcgrFQYR9IA5d36XCh/FnueQoUaOXxhpOGNtpZ456HnCkp
         z6eAdslGenV4pdO5CRUh4Ji2DeAapbEibMxT0fIfkrdnQbyK0VhOYdhvemsyXjZOoGx9
         vD36KtLXaYTsTA6MuDVLr49ykkxERvBLhgrite+AqyjrTmNWEMgySK3QmjcQAmKuwlPh
         2U4g==
X-Gm-Message-State: AJIora+Rz/aA1CiS359gy84pr2MK/Tps5oTUKy8CKM0wRXFia6RgEh0/
        dMAuzNO/RLHQKk4ZQLXA7Kwxq4WC7mKhAZK3fpjYBYdxcdE=
X-Google-Smtp-Source: AGRyM1vJBezpkPHJvOL71BZGQITOORv8OmNTUJD6xLX7Wnj0A4f22qEXYCI1rLeh/6ZawVJfcwM7/CfafoVyrjcr66A=
X-Received: by 2002:a05:6214:d41:b0:472:f5cf:1fa6 with SMTP id
 1-20020a0562140d4100b00472f5cf1fa6mr23302586qvr.98.1658187670270; Mon, 18 Jul
 2022 16:41:10 -0700 (PDT)
MIME-Version: 1.0
From:   Britton Kerin <britton.kerin@gmail.com>
Date:   Mon, 18 Jul 2022 15:40:59 -0800
Message-ID: <CAC4O8c-Tf11CpwuRudyrpXv5bGshuyEenV9kKrs0zRWER-+yHA@mail.gmail.com>
Subject: git-send-email doesn't entirely understand --subject (or --in-reply-to)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm not absolutely sure this is git's fault but I tried to use the
reply mechanism described here:

     https://public-inbox.org/git/20220718232843.151392-1-britton.kerin@gmail.com/#R

whic is to say this:

     git send-email \
         --in-reply-to=20220718232843.151392-1-britton.kerin@gmail.com \
         --to=britton.kerin@gmail.com \
         --cc=git@vger.kernel.org \
         --cc=gitster@pobox.com \
         --cc=newren@gmail.com \
         --subject='Re: BUG: git-check-ignore documentation doesn'\''t
come close to describing what it really does' \
         /path/to/YOUR_REPLY

and it failed like this:

$ git send-email     --in-reply-to=xmqqtu7lc587.fsf@gitster.g
--to=britton.kerin@gmail.com   --subject='Re: BUG: git-check-ignore
documentation doesn'\''t come close to describing what it really does'
~/my_reply_git_checkignore_bug_post
/home/bkerin/my_reply_git_checkignore_bug_post
No subject line in /home/bkerin/my_reply_git_checkignore_bug_post? at
/usr/lib/git-core/git-send-email line 720.

Until I added this line to the top of
/home/bkerin/my_reply_git_checkignore_bug_post:

     Subject: Re: BUG: git-check-ignore documentation doesn't come
close to describing what it really does

maybe this is normal but it seems weird given the presence of
--in-reply-to and --subject and the fact that I didn't need to copy
any other headers in.

Britton
