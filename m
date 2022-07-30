Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3557C19F2A
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 19:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbiG3Txd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 15:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiG3Tx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 15:53:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E09F13F50
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 12:53:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sz17so13812842ejc.9
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 12:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=twALePqo2FKTs3UTX5SDIunEuCEPkSIqnFHl7kXC3TI=;
        b=dzVq6p/Qpk9OVxB/OSyz7BZS44YKQDqfQFAnUvrErVn/Zymj862y0mFp0O+qCqetmK
         12t/IfnhlaBahOHS+X97eWOUTgPa41x63R8Ecr1E/iy2bXPDUo0OCV0cppkrvgSU7JN0
         qqnQ8hHRRC4TpRUr1WKE5Rbp835CksowIXcE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=twALePqo2FKTs3UTX5SDIunEuCEPkSIqnFHl7kXC3TI=;
        b=OeDLhjbfKKQLJ3qqIWMKcoRRmxzNnwT75PRjEsGEBQ8TmgWKLTbUw1lNBKLVZ9yF5R
         zJc3ja4oF8QGVQnMgDV6970PSb6bs4aHZDlJRa96BunLz19FKDXMoFMhoagpD8g/DWL4
         J0zBy1sdNN6PdBjAV2VwkIRcdQPj0Bf3H+VdKb2t3NXHrAQsIrg9PYOS3yzl/WCCaEKm
         fK0rqqRr/NayrK99J/Vdi3EyWZehqfnEzeHjabdB4nizOHjMsP9HCxqEOkynsCDbplON
         ZL0FFO3U5L2/M7D6VEnAPiZeo9q/5W9ya/WYRR2dhwL5mciO16Z4ISjEs6euZkUE6jik
         FDZw==
X-Gm-Message-State: AJIora9/yD/3KecUKetMkwyDP73+s/Qr5i10l2aKg/GbUq8m88oH5DR+
        DSJCNdiR4aw/0Kh9ok1PA5Oo0EGBKA436cfF
X-Google-Smtp-Source: AGRyM1vZbLW+lE1D/i58CFLGD1+b2l5LgOZ8K2Fpd4m973UPxPVmNlQHFPOQMCKiXaQgCBABCfTJZA==
X-Received: by 2002:a17:907:1c0c:b0:72e:e206:bfed with SMTP id nc12-20020a1709071c0c00b0072ee206bfedmr6687957ejc.682.1659210806927;
        Sat, 30 Jul 2022 12:53:26 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id fg7-20020a1709069c4700b007304d084c5esm180491ejc.166.2022.07.30.12.53.26
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jul 2022 12:53:26 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso5607838wma.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 12:53:26 -0700 (PDT)
X-Received: by 2002:a05:600c:3553:b0:3a3:2b65:299e with SMTP id
 i19-20020a05600c355300b003a32b65299emr6411020wmq.145.1659210805709; Sat, 30
 Jul 2022 12:53:25 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Jul 2022 12:53:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh9f0EmsNFgoxUa8BzVej06+7MbLr-MLBjDjtj_=Pf90A@mail.gmail.com>
Message-ID: <CAHk-=wh9f0EmsNFgoxUa8BzVej06+7MbLr-MLBjDjtj_=Pf90A@mail.gmail.com>
Subject: "git symbolic-ref" doesn't do a very good job
To:     Junio Hamano C <gitster@pobox.com>
Cc:     Git List Mailing <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000aec0d205e50b1e99"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000aec0d205e50b1e99
Content-Type: text/plain; charset="UTF-8"

So in subsurface, we had trouble with a very annoying bug introduced
in libgit2-1.2:

  https://github.com/libgit2/libgit2/issues/6368

which made "git_clone()" fail horribly if the remote repository
doesn't have a default branch.

Subsurface uses git for the cloud storage back-end, and the cloud
repositories are just bare repositories with a single branch, and they
have no HEAD at all (ok, technically in the bare repo it points to the
non-existent default branch, but as far as the client is concerned
that's the same thing, because it won't show up in the remote
listing).

That's all perfectly valid git behavior, and the real git client has
no issues with this at all. It's a libgit2 bug, plain and simple.

I think the fix for libgit2 is probably a oneliner:

    https://github.com/libgit2/libgit2/pull/6369

but that doesn't really help subsurface, because the buggy version of
libgit2 has already spread enough that it just ends up being a fact of
life.

So what the subsurface cloud side will end up doing is to just force
that pointless HEAD thing, to work around the bug. And I told Dirk to
use

   git symbolic-ref HEAD refs/heads/<branch-name>

to do it, because it was "safer" than doing it by hand with a mindless

   echo "ref: refs/heads/<branch-name>" > HEAD

Which brings me to this email.

After I told Dirk that that was the "proper" way to do it, I actually
tried it out.

And "git symbolic-ref" is perfectly happy to take complete garbage
input. There seems to be no advantage over using that silly "echo"
model.

You can do things like

    git symbolic-ref HEAD refs/heads/not..ok

and after that all the git commands that want to use HEAD will die
with a fatal error

    fatal: your current branch appears to be broken

which kind of makes it pointless to try to use the git plumbing for
this. The *only* verification that "git symbolic-ref" does is
basically

                    starts_with(argv[1], "refs/")

and even that minimal test is only done for HEAD.

Does anybody care? Probably not. But it does seem to be a bit sloppy.
We do have that 'check_refname_format()' function to actually check
that it's a valid refname,.

Maybe create_symref() could do this, but if we do it in
builtin/symbolic-ref.c we could give better error messages, perhaps?

Not a big deal, but I thought I'd at least send out this silly patch
for comments, since I looked at this.

                   Linus

--000000000000aec0d205e50b1e99
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l68b7zyn0>
X-Attachment-Id: f_l68b7zyn0

IGJ1aWx0aW4vc3ltYm9saWMtcmVmLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvYnVpbHRpbi9zeW1ib2xpYy1yZWYuYyBiL2J1aWx0aW4vc3lt
Ym9saWMtcmVmLmMKaW5kZXggZTU0N2EwOGQ2Yy4uNTM1NGNmYjRmMSAxMDA2NDQKLS0tIGEvYnVp
bHRpbi9zeW1ib2xpYy1yZWYuYworKysgYi9idWlsdGluL3N5bWJvbGljLXJlZi5jCkBAIC03MSw2
ICs3MSw4IEBAIGludCBjbWRfc3ltYm9saWNfcmVmKGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJn
diwgY29uc3QgY2hhciAqcHJlZml4KQogCQlpZiAoIXN0cmNtcChhcmd2WzBdLCAiSEVBRCIpICYm
CiAJCSAgICAhc3RhcnRzX3dpdGgoYXJndlsxXSwgInJlZnMvIikpCiAJCQlkaWUoIlJlZnVzaW5n
IHRvIHBvaW50IEhFQUQgb3V0c2lkZSBvZiByZWZzLyIpOworCQlpZiAoY2hlY2tfcmVmbmFtZV9m
b3JtYXQoYXJndlsxXSwgMCkgPCAwKQorCQkJZGllKCJSZWZ1c2luZyB0byBzZXQgJyVzJyB0byBp
bnZhbGlkIHJlZiAnJXMnIiwgYXJndlswXSwgYXJndlsxXSk7CiAJCXJldCA9ICEhY3JlYXRlX3N5
bXJlZihhcmd2WzBdLCBhcmd2WzFdLCBtc2cpOwogCQlicmVhazsKIAlkZWZhdWx0Ogo=
--000000000000aec0d205e50b1e99--
