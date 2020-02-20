Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74618C11D1B
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 18:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5792467B
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 18:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IjnPP/Tr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgBTSyz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:54:55 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37839 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgBTSyy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 13:54:54 -0500
Received: by mail-vs1-f66.google.com with SMTP id x18so3374885vsq.4
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 10:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=laifh/U9dxoUxe7+vwxJVHvPEawUiTB5137DxIOI5L0=;
        b=IjnPP/TrQ0ikdq7C3YpvoEedqXewo8UbbD1iJdIL9ckxr0SzxMbnTsyHS7PPGrAXZ0
         CofB6eDGeyhPTvH5Jo6n5dOY/C5gRqDahI4yIA2wCrqzA2qObGdgePs5nKfj3NQZwSfO
         phmhPzPX3N3hjQ+awN0RhPqQKvir17UBEkVbiLZvGPtyGtiKKNFsQ4HLcsU9Er/HolNp
         eXg+d3BS/MCY3DEBmQSX/UPsLHZA68PHvNaR7OL9xQqzBhiHmcGhwpnlE2pKvVOt6hJB
         c1cxLV/jcHqYB9npoaIdfE6rRwK95WecqcE+w4T6bqPK1q11vt67XDEDjUz0HuMPaiAX
         TKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=laifh/U9dxoUxe7+vwxJVHvPEawUiTB5137DxIOI5L0=;
        b=IeS/Io2bnbX/l3I2ZjwDlDMeuP4Imu4anMOF3/6j1nBYjPliRR+cletPpOuofWzLMG
         B/UGLNjLeS4dqeUI82YzABpcswKbHcB275+YHs9PR6TMODYybQRXShxHMplQ/lFA4jyn
         6DEZ1f7cgn6UaC39VFB57bCWMa96RKwvTDxLowXAHkGfh2AQ8hnABwIcoKYD2y5HZIQ7
         m6hmUf8wnBoNkwvX6f/Y/n1eT7ardrzMYRT5qDMrReserk/KQxNOGW/qS5ON3ygj+NG0
         dBM0jIx6ScmESb2J0Pe0P6QDbw4miOONlpSpOZTjucB5+3n5ULXjJM9OgEMBOnAwIJfI
         95kQ==
X-Gm-Message-State: APjAAAXDzD7C1rks5Pb/uhNo2A54lLJVpyNf9fnu2UyPNKaukt6jxn9q
        L+8mG+yPJGSA/yRmLCZTVVOtWhfSsrtvB1TmlJKfNNVaFDU=
X-Google-Smtp-Source: APXvYqz26tHEN1P5Ihqd4wAKQp8IrYXCLf0wuLBnuQWSf9x8PpUQO3pKxiaUmTMgZp7avLmnZBS7gfZMJCdFPvIlNZE=
X-Received: by 2002:a1f:1f0f:: with SMTP id f15mr7451116vkf.18.1582224403682;
 Thu, 20 Feb 2020 10:46:43 -0800 (PST)
MIME-Version: 1.0
References: <BL0PR2101MB10898F2F84B06B1A6B23228380130@BL0PR2101MB1089.namprd21.prod.outlook.com>
In-Reply-To: <BL0PR2101MB10898F2F84B06B1A6B23228380130@BL0PR2101MB1089.namprd21.prod.outlook.com>
From:   Daniel Knittl-Frank <knittl89@googlemail.com>
Date:   Thu, 20 Feb 2020 19:46:32 +0100
Message-ID: <CACx-yZ0e-rAsJbeKr5WO32kG-HChTva4nhpfZ98B7C+YiJ4KXw@mail.gmail.com>
Subject: Re: BUG: git clean -d cannot remove files from read-only directories
To:     Adam Milazzo <Adam.Milazzo@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adam,

On Thu, Feb 20, 2020 at 7:27 PM Adam Milazzo <Adam.Milazzo@microsoft.com> w=
rote:
>
> Repro steps:
> 1. git init
> 2. mkdir d
> 3. touch d/a
> 4. chmod -w d
> 5. git clean -fd
>
> Actual result:
> Git doesn't remove anything, saying "warning: failed to remove d/a".
>
>
> Expected result:
> Git should remove the subdirectory 'd' along with its contents. Note that=
 git can remove a read-only file (touch b; chmod -w b; git clean -f) with n=
o problem.

this is not a limitation of Git, but of how Linux Filesystems work.
When you delete a file, you do not modify the file, but you change the
directory which contains the file. In other words, if you have a
directory which is write protected (you do not have the write
permission), you cannot add, remove, or rename files. You may however
still modify the content existing files.

Your repro will yield the same result when executed without Git, i.e.
plain shell commands:

$ mkdir d ; touch d/a ; chmod a-w d
$ rm -rf d
rm: cannot remove 'd/a': Permission denied

If the write permission were removed before touching the file, this
would already fail:

$ mkdir d ; chmod a-w d
$ touch d/a
touch: cannot touch 'd/a': Permission denied

In summary: this is expected and I doubt Git can do much in such a
case. After all, the directory is marked as read-only, so why should
Git be able to write it? :)


> [=E2=80=A6]
>
> * It seems inconsistent for "git clean" to be able to remove read-only fi=
les but not files from read-only directories.

Again, deleting a file will modify its containing directory, not the
file itself. Making a file read-only does not protect it from being
renamed or deleted, that's what directory permissions are for.

- Daniel

--=20
typed with http://neo-layout.org
