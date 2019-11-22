Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA55C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BD820658
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvveC04r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfKVTrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:47:15 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:37778 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKVTrO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 14:47:14 -0500
Received: by mail-lf1-f43.google.com with SMTP id b20so6393046lfp.4
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 11:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=aqLGjwbvKBXXHe4/TRjnXJ5hPtmGN1neR5AWyE/gL90=;
        b=QvveC04r66Vxvu+8Jetgksjp4ON0qm+/Qc9EA27yausEfQpVkk9LyBW+P0/D/6sh+7
         MI1q10VtFhN9EXMBTqdmM4BW8abeEBKSaz8Jbiagt+ulHWAhudyVih6MaoScLIxZ/eA9
         u+AQgBju/OlsFNttcZbq7x0i9JdAvjOvRIDoAowd31ND7F5LbKjRRH78sgO64WHufJWV
         W0JENRNswBhmnNgotk1xQqubkctfucknHVm+WxMoqbs7UpF0OfLm/U5amOpYrspCDkGa
         CIj0/xD8M4DlDG6zzhg6FmAVfY7MKFCYZTc2ezdbM/UREmLkhdbJcHIVMNLc0dzev2MN
         elWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aqLGjwbvKBXXHe4/TRjnXJ5hPtmGN1neR5AWyE/gL90=;
        b=GArNNIXrA+mZnMDgn1xzAuL4I8uMCtv24Ard9Dc40HKbyMcuYGgkrrlUw6BVWo7P9U
         F9PGZjCIYm76Y8RWnjaPVX7/7aZd3drryWWW28DXAYQAGPuAUSBoH9RUSY2fbmq3QF8m
         2n+up2SakwoMvc4LWyRzf3dOHW4qyrRX2I/+en1iw/0pqjApM80fi9ln3JvFZo69Mz/k
         NzMPmBUFwrz5T+y3sJB1gszg+nuM5bSGXaeudpVDFg2GmuDTFKPdeydiOcFJBQELpsWC
         Ejw8ZA6n+Ofo6OyzZkXzB9Ms5ZOvoQjiiMBVkAY3iYB3DwYK4iPLYQwnLIoeJ4mYsJZa
         W6zQ==
X-Gm-Message-State: APjAAAUJ7YUHCkBITftuRm2ClskUvkPyw2FwIavB623pc1kShfV9eM1f
        rAFtMbTFD5uqgAym78KTdUzBZfkQ4r2COEzwnHIF/u/5Cr4=
X-Google-Smtp-Source: APXvYqzIEh+nTFWQEY+/iOWcqkgONkf3SOB61vRfdyHdqTTKAegaA60ZTm2D5JnxmQkDWkhXt6bz8yOMQh0qmGQA+9A=
X-Received: by 2002:a19:22c4:: with SMTP id i187mr12303051lfi.152.1574452032843;
 Fri, 22 Nov 2019 11:47:12 -0800 (PST)
MIME-Version: 1.0
From:   Wes Hurd <13hurdw@gmail.com>
Date:   Fri, 22 Nov 2019 14:47:02 -0500
Message-ID: <CAOAGZwFScnS=FSfe9WiJ2h5W1-NCtxU4HM4FUH9LwtcCRuimcg@mail.gmail.com>
Subject: [Bug] git diff assumes executable permissions change is always 0755
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git 2.24.0
macOS 10.14.6

To reproduce:
 - Start a file, commit in git
 - chmod 0744 file.txt
 - git diff
 - ls -l file.txt

git diff reports :
old mode 100644
new mode 100755

expected:
git lists actual permissions of file
new mode 100744
File's permissions are 0744 (-rwxr--r--)

Thanks,
