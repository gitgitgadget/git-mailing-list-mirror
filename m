Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F22C33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 13:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7662073A
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 13:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFfJZsf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgAQNaM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:30:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30614 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726329AbgAQNaM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 08:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579267811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pAD2rAmuCnYKWn5wahchetmZNOamYWY0IkFcoTP23EE=;
        b=VFfJZsf0wCXb76sOxO8TwGlpQgqIshsRPPUMzZzhHMtSy3OlPX3OR3MfqM2Dn6iX09dajk
        X6tXrM0FsWDHztS0TZ4qNUhyiRL9h1LV3cZmHozUItBBlE+tJ+T/JAsBqHppnCMxThlBl6
        IGbRCLAeY+OOt60pgeoMVgEsb663724=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-s4-pZHpIMaust-S-jKbJvg-1; Fri, 17 Jan 2020 08:30:07 -0500
X-MC-Unique: s4-pZHpIMaust-S-jKbJvg-1
Received: by mail-wm1-f72.google.com with SMTP id q26so1157268wmq.8
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 05:30:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=pAD2rAmuCnYKWn5wahchetmZNOamYWY0IkFcoTP23EE=;
        b=kzSn8un9JAUmLBe+xdBnivWKcI1XkjCveeTwPw+b4kelyja2ttH+rKMSHiZvoGaKMV
         yQDPVidoYjVMgt7UUZf9kDKGXA6fa1zb+BIpN5V4yEplycwEQAeewQTMOm6D09X/QLSM
         xdNiZiFUx2YzpwwDsg9SRBZEFRc9LBcfgHI76waLf0sCQm1BT0S9JVpa4uJFsJu/cwKu
         8jJurVI7uSu0C3z8Y9T7mkLtnDVmByyUACHpEdzq9hODi374OwpnARfj5pU11UvolkQC
         YcoQuhKOxi/83RshsWOrkeTuL+0QiPZKvI14Yi2wkJyy1hfMiz3BLvVi/C7xIlxeQnqm
         oaNw==
X-Gm-Message-State: APjAAAUOB1Lg7CZ4gtVb6tDqGIhphQvUCjovpwE+U6Z2J6626NJvD4CD
        pl21J3ygeGQQKMZYUdKzJ7iIeyk/rZCdtya3GDNDqMsW7PTYgCanKwRuUEFMb/22E5f8mnfmJGv
        YL0XbQa6CbMXD+kCsTgdn43UQnzty
X-Received: by 2002:adf:f789:: with SMTP id q9mr3221866wrp.103.1579267805400;
        Fri, 17 Jan 2020 05:30:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqyh2lQAjvusDu/XHvp87J2zosD+T1Mdzg0TU86qSs7S0vNAzDwGXzoDI3h9BsejjDA9xa1Ki5kImE7w5p4Ycfw=
X-Received: by 2002:adf:f789:: with SMTP id q9mr3221849wrp.103.1579267805158;
 Fri, 17 Jan 2020 05:30:05 -0800 (PST)
MIME-Version: 1.0
From:   Ondrej Pohorelsky <opohorel@redhat.com>
Date:   Fri, 17 Jan 2020 14:29:54 +0100
Message-ID: <CA+B51BERnCMJMK5dgo6+=22yr8Upv6RbKPh-Br6fALubVN-D9A@mail.gmail.com>
Subject: Bash-completion missing option merge-base
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm a new maintainer of git in RHEL. We have encountered a bug where
merge-base is missing in bash completion. [1]

First I applied a patch[2], that should fix this problem, into
git-1.8.3.1 we are using in RHEL 7.7 and I discovered that completion
is still missing.

Then I tried to reproduce this bug in the newest version of git and
completion is still missing.


[1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1288506
[2] https://marc.info/?l=3Dgit&m=3D138945079300929&w=3D4

Best regards,
Ond=C5=99ej Poho=C5=99elsk=C3=BD

