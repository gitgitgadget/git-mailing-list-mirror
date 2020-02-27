Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD45DC4BA24
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 12:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB8124692
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 12:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RkAGZlCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgB0M4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:56:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24369 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729052AbgB0M4c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 07:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582808191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5gDZTj85s2+ShEwAm9EOu3sitIywVm85y8I8I4f9oRM=;
        b=RkAGZlCsmJvEVrzfenwmcr9237BOL/6xTFGNBbNOHEHLkna/CLmLbsFnLAjEnn5imLXHUG
        ka3uL10/v3aP326chuqqjxQeLVmz1m+3QPwUml2WCDrjMd1VPSzllchebdDEZQu0e9r7Oj
        sThv3Cx986l87ytPJPrvg8j9eXixkVk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-5FpnI1koNVK7pNGsjpqnYQ-1; Thu, 27 Feb 2020 07:56:25 -0500
X-MC-Unique: 5FpnI1koNVK7pNGsjpqnYQ-1
Received: by mail-wr1-f69.google.com with SMTP id l1so1285777wrt.4
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 04:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5gDZTj85s2+ShEwAm9EOu3sitIywVm85y8I8I4f9oRM=;
        b=R2x6Tac7xRO0vgwyzv/EeQ7B//rS9yYGDPFXuszH4UFLs9reV0VLTMhZLWxLuIXsPL
         Au+xoBsdZ6f78Gx2HjIpiQsONiw4hX0mVM2sHHnoUFzwmhKbCXdiXra22lCUVWvAv1Ii
         rwGpdAGgU4VuKcXpIJm+nflClNZ6qFLJXK3/ca661KAt3ubn+fpo//QafPE7qZ1fVGzY
         iRic31weJ8dvDvbVpFrVDXAfZDiCZJ5Gx8Et2H+QKnQzahG7t5v1Cba6SJ9b/XygNHWE
         Pr65IRLxU0vrs9iUdnBaNA5TsMmWiQKdW+d82+nTLTYhhCOZB7zbiijb6rEdch+6usE5
         LFGQ==
X-Gm-Message-State: APjAAAWPgO3IERKgj9XnsD8yeEcHPza5Cx56Jca1n9Otxqid+bE7HQsA
        FrhiakqjSeNxNrQJWojkRfZpoldQ07DZPYEV1iNE+WKy4lAFL8x5DHKMLVOh3yjmGq6tro/Tqu/
        /bSP8aA5YD2HTxMj42qFuzJF737Gh
X-Received: by 2002:a05:6000:1252:: with SMTP id j18mr5076467wrx.103.1582808184107;
        Thu, 27 Feb 2020 04:56:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqzbq8ynAkgHOmaz0jrLhWmSrEZvcKr0R1s7MxrXB2ljgJ/CgmHcFN4wy/GUYcaWpEKPVviwOEl68JjU4ye3iPI=
X-Received: by 2002:a05:6000:1252:: with SMTP id j18mr5076450wrx.103.1582808183938;
 Thu, 27 Feb 2020 04:56:23 -0800 (PST)
MIME-Version: 1.0
From:   Ondrej Pohorelsky <opohorel@redhat.com>
Date:   Thu, 27 Feb 2020 13:56:13 +0100
Message-ID: <CA+B51BFFvn9puia8+kheeWkDfOQ7RYHTcGa74M5aeiTd8-QJXA@mail.gmail.com>
Subject: git-core: try_to_follow_renames(): git killed by SIGSEGV
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

there is a SIGSEGV appearing in Fedora[0] with Git 2.24.1

This bug started to appear after update to Git 2.24.1.
Bug reporter said that Git crashed on him while running VS Code with
Git Lens extension[1]
I have tried to reproduce this bug with my own compiled Git with debug
flags, but sadly SIGSEGV never appeared.

To me it seems like there is a problem in commit a2bb801f6a[2] which
changes move_diff_queue() function. This function calls
diff_tree_oid() that calls try_to_follow_renames(). In the last two
functions there are no arguments checks.

Best regards,
Ond=C5=99ej Poho=C5=99elsk=C3=BD

[0] https://retrace.fedoraproject.org/faf/problems/bthash/?bth=3D25aa7d7267=
ab5de548ffca337115cb68f7b65105
[1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1791810
[2] https://git.kernel.org/pub/scm/git/git.git/commit/?id=3Da2bb801f6a430f6=
049e5c9729a8f3bf9097d9b34

