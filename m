Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED0AC432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 12:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3F420862
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 12:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNQ6FOKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfKYMmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:42:09 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46528 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfKYMmI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 07:42:08 -0500
Received: by mail-pl1-f194.google.com with SMTP id k20so2000854pll.13
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 04:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version;
        bh=dSStyl7XmO5TbnBt2j3t/O1je0+OOfXVVmhnh/BmNgc=;
        b=VNQ6FOKe83hMM0Q7H0o06xxLu5tKbzUs6KAyAC2CIMAiP/OawdqGVMbm+OQPiUwuYw
         e6WIyrxaLE3O2tNenVBS8vm9p+qCCO/0JBo8vkADYHhm0XZ601pZYDUdtIOSiO9jwrcg
         A7/qAlkzgW9fL4JlIp3BIkUfMphGqq+bZvFFL3YbRSeQqQXmGG5Gm+JLQpV191w0yg19
         fON7WUWO4rfb8uv4A50WSShuYr4iHtBN5774HlFEGjq5EjhLtaUxNL71VRY/2h9S/QOB
         53yJxax5tSOh0vweveqRRPaHgk9FHOPXqOpBmM7lI04g3i27EKqrEKwIhdUozLERx3yy
         QGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version;
        bh=dSStyl7XmO5TbnBt2j3t/O1je0+OOfXVVmhnh/BmNgc=;
        b=RT3eiCZUcnk+mVuJz8j3k4ovsloW/YfXnUAKZFYaI4n1Slk4wTCDH85QS5G73zKqMy
         AyF62+CQRyw4wXHkuecoJNQKqe9C9T2BlA+9YC5KEpbhDWtTPowjLH+X/ms9ExMHf9Pg
         12UAcuYmKByGNavxlJGGb1QuTFBGXCvDJQXdCMcevhCe47TRGR1WHpLRgZX+fvol9Nuc
         OxVqaFmTXAnjBa/J3XUbQke16enQgmjgG3jcg2C+iw+fGEHDwy6Zewf2LxfyDhl9wR+1
         XSyKNIYJqmCN7gN4O7HOc8NWGkbx78bGc3c6r9+aY2BtDb4xdL5NYfkVu4eXVEcpnCqO
         41GQ==
X-Gm-Message-State: APjAAAVLl7CtHFI+wX9rN2MpickbxKAj2A1axu5kVH0JOXzXpMjPf6gH
        XQFMDAwOeMwsjvTB6tlLSXqnBRCmpPk=
X-Google-Smtp-Source: APXvYqzE5AU9+3W4MvdAjcOsOBrHc3V7TfnBhIGq8vxXRA9O23VQ5P+4rdLWsv7wfdJw3J53+dkP2g==
X-Received: by 2002:a17:90a:3522:: with SMTP id q31mr38745648pjb.18.1574685726169;
        Mon, 25 Nov 2019 04:42:06 -0800 (PST)
Received: from sydneypc ([203.213.81.65])
        by smtp.gmail.com with ESMTPSA id 186sm8846482pfb.99.2019.11.25.04.42.04
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 04:42:05 -0800 (PST)
From:   Chen Bin <chenbin.sh@gmail.com>
To:     git@vger.kernel.org
Subject: A new idea to extend git-blame
Date:   Mon, 25 Nov 2019 23:41:55 +1100
Message-ID: <87o8x06sbw.fsf@sydneypc>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I already implemented the idea in Emacs Lisp. See,

http://blog.binchen.org/posts/effective-git-blame-in-emacs.html

I tested at https://github.com/redguardtoo/test-git-blame

Looks it works.

The only issue is Lisp is slow in big code base.

So I'm thinking I could re-implement it in C instead.

My question is, *who can I contact to understand git-blame?

I'm experienced at C but need some expert's guide.

The key algorithm is simple,

The algorithm only works for one line blame and the user must
select text inside the line first.

Step 1, `git blame -L6,1 --porcelain -- hello.js` output,

    4f87408612e0dacfd89a1cd2515944e21cf68561 6 6 1
    skip...
    filename hello.js
     doit({bad: 'destroy world', good: 'hello world', ...});

I got the commit id (1st column), the line number (2nd column),
file name (hello.js) and the code line (last line).

Step 2, if the code line does not contain the selected text, the
  recursive search stops

Step 3, or else use commit id, line number and file name to build
  new git blame cli, like,

`git blame -L line-num,1 --porcelain 4f8740^ file-name`

Step 4, execute new git blame command and start from Step 1

Here is my first commit (added some debug code),

https://github.com/redguardtoo/git/commit/d01d26f2df

-- 
Best Regards,
Chen Bin

--
Help me, help you
