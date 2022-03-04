Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6DAC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 00:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiCDAnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 19:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiCDAnn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 19:43:43 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76C53982A
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 16:42:54 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id y24so8932268ljh.11
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 16:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yc/CxMuotqDKy0EMm7WT3doZ/LbZcikBo/RSIQGEQg8=;
        b=eBhVeQ8JbtTylpCjPRmVIApqHYvueuqtmPX6SCUEZpDWWzRwP2L/D1FKtKdSnrMLFd
         YgcUgDw23vupEPH1JP5n8EgtNtFRgbGkNKSmrEz1m5P4EMX4Al7GgjKZSpAtQ3iM49B0
         aMVdaMIIGg4F/ThrnvpRahn3MtyIM7nJGFfy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yc/CxMuotqDKy0EMm7WT3doZ/LbZcikBo/RSIQGEQg8=;
        b=Ziy6KjqaRAXiZlN5lBK179RdqDQBY6ouEHhdZfzO/wInWk77c8+n4O4BeNLD33K4oH
         w4+vCjrQRYwITqnQhv0DK0HcO9e2v5KZoL2U4EnsuXCKif6ir8StujfymEgrJ4t4D1FF
         PzVDsae+7AWNkq9pIMXKO43TtOoHVHy0yADKqojiC8L5nPS/cmhE4gUWWkvQ+mOocght
         JazqYvkoqNiWqVkBrQyos5TLA4CtfY/cLPDtCFPrlQRtoxkCKZVw2ongwtlW19w5l0C5
         1ACAIUHQboHuCVA2X3iS3t2ZiKI8+EgaM5Gd0qcvFi82lAGi3L4Jk9TlJ5CF2waC5ooP
         uIBg==
X-Gm-Message-State: AOAM532B/ZApSkvumxygA1dqY2ys0aQ/1R04QZoCTrSq2bt9+gVt2YVz
        hY27MMhXcQee9rGEcIKTfYlkQhWqfTI510lX
X-Google-Smtp-Source: ABdhPJwk9I1btxSEIovGL/k+3kIgUdLRRpabLAEySfFxgLL89jlVaTrYk3LXxEY41FXyEY+LWZPhrg==
X-Received: by 2002:a2e:881a:0:b0:22e:b61:9d9b with SMTP id x26-20020a2e881a000000b0022e0b619d9bmr24516253ljh.48.1646354572473;
        Thu, 03 Mar 2022 16:42:52 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id i6-20020a198c46000000b0044424910c94sm718699lfj.113.2022.03.03.16.42.51
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 16:42:51 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id f37so11373258lfv.8
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 16:42:51 -0800 (PST)
X-Received: by 2002:a05:6512:3049:b0:447:d55d:4798 with SMTP id
 b9-20020a056512304900b00447d55d4798mr544549lfb.531.1646354571158; Thu, 03 Mar
 2022 16:42:51 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wi2HkQ648sYe3BusCEh5tBYjJbQ9c5T-DrykfEdgRbi=g@mail.gmail.com>
 <xmqqlexq8zqo.fsf@gitster.g>
In-Reply-To: <xmqqlexq8zqo.fsf@gitster.g>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Mar 2022 16:42:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjQP8PwYZMYUhKu3s9wMhE2yDqdAO_OKagqXuvPrHRyAQ@mail.gmail.com>
Message-ID: <CAHk-=wjQP8PwYZMYUhKu3s9wMhE2yDqdAO_OKagqXuvPrHRyAQ@mail.gmail.com>
Subject: Re: Silly 'git am' UI issue
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List Mailing <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000641a3705d959cb87"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000641a3705d959cb87
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 3, 2022 at 1:58 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> I wonder if something like this would have helped.

That would certainly have helped, yes.

But I think we can do better.

How about just parsing the "--whitespace" option in 'git am' before
passing it through?

Something like the attached patch seems to work for me.

With this one, I simply get

    $ git am --whitespace 0001-Dummy.patch
    error: unrecognized whitespace option '0001-Dummy.patch'

when I make the mistake of not giving that whitespace argument.

I'm not claiming this is extensively tested, but I did *some* testing
on it, and it's not a complicated patch.

             Linus

--000000000000641a3705d959cb87
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l0boysn10>
X-Attachment-Id: f_l0boysn10

IGFwcGx5LmMgICAgICB8ICAyICstCiBhcHBseS5oICAgICAgfCAgMiArKwogYnVpbHRpbi9hbS5j
IHwgMTQgKysrKysrKysrKysrLS0KIDMgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcHBseS5jIGIvYXBwbHkuYwppbmRleCAwOTEy
MzA3YmQ5Li4yOGU2ZmUwY2ZhIDEwMDY0NAotLS0gYS9hcHBseS5jCisrKyBiL2FwcGx5LmMKQEAg
LTM2LDcgKzM2LDcgQEAgc3RhdGljIHZvaWQgZ2l0X2FwcGx5X2NvbmZpZyh2b2lkKQogCWdpdF9j
b25maWcoZ2l0X3htZXJnZV9jb25maWcsIE5VTEwpOwogfQogCi1zdGF0aWMgaW50IHBhcnNlX3do
aXRlc3BhY2Vfb3B0aW9uKHN0cnVjdCBhcHBseV9zdGF0ZSAqc3RhdGUsIGNvbnN0IGNoYXIgKm9w
dGlvbikKK2ludCBwYXJzZV93aGl0ZXNwYWNlX29wdGlvbihzdHJ1Y3QgYXBwbHlfc3RhdGUgKnN0
YXRlLCBjb25zdCBjaGFyICpvcHRpb24pCiB7CiAJaWYgKCFvcHRpb24pIHsKIAkJc3RhdGUtPndz
X2Vycm9yX2FjdGlvbiA9IHdhcm5fb25fd3NfZXJyb3I7CmRpZmYgLS1naXQgYS9hcHBseS5oIGIv
YXBwbHkuaAppbmRleCA0MDUyZGE1MGMwLi5jOTMxNzg2YTJhIDEwMDY0NAotLS0gYS9hcHBseS5o
CisrKyBiL2FwcGx5LmgKQEAgLTE3Myw2ICsxNzMsOCBAQCBpbnQgcGFyc2VfZ2l0X2RpZmZfaGVh
ZGVyKHN0cnVjdCBzdHJidWYgKnJvb3QsCiAJCQkgIHVuc2lnbmVkIGludCBzaXplLAogCQkJICBz
dHJ1Y3QgcGF0Y2ggKnBhdGNoKTsKIAoraW50IHBhcnNlX3doaXRlc3BhY2Vfb3B0aW9uKHN0cnVj
dCBhcHBseV9zdGF0ZSAqc3RhdGUsIGNvbnN0IGNoYXIgKm9wdGlvbik7CisKIC8qCiAgKiBTb21l
IGFzcGVjdHMgb2YgdGhlIGFwcGx5IGJlaGF2aW9yIGFyZSBjb250cm9sbGVkIGJ5IHRoZSBmb2xs
b3dpbmcKICAqIGJpdHMgaW4gdGhlICJvcHRpb25zIiBwYXJhbWV0ZXIgcGFzc2VkIHRvIGFwcGx5
X2FsbF9wYXRjaGVzKCkuCmRpZmYgLS1naXQgYS9idWlsdGluL2FtLmMgYi9idWlsdGluL2FtLmMK
aW5kZXggMGY0MTExYmFmYS4uNTQyYzZjNWNhYiAxMDA2NDQKLS0tIGEvYnVpbHRpbi9hbS5jCisr
KyBiL2J1aWx0aW4vYW0uYwpAQCAtMjI5OCw2ICsyMjk4LDE2IEBAIHN0YXRpYyBpbnQgcGFyc2Vf
b3B0X3Nob3dfY3VycmVudF9wYXRjaChjb25zdCBzdHJ1Y3Qgb3B0aW9uICpvcHQsIGNvbnN0IGNo
YXIgKmFyCiAJcmV0dXJuIDA7CiB9CiAKK3N0YXRpYyBpbnQgcGFyc2Vfb3B0X3doaXRlc3BhY2Uo
Y29uc3Qgc3RydWN0IG9wdGlvbiAqb3B0LCBjb25zdCBjaGFyICphcmcsIGludCB1bnNldCkKK3sK
KwlzdHJ1Y3QgYXBwbHlfc3RhdGUgZHVtbXkgPSB7IH07CisKKwlpZiAocGFyc2Vfd2hpdGVzcGFj
ZV9vcHRpb24oJmR1bW15LCBhcmcpKQorCQlyZXR1cm4gLTE7CisKKwlyZXR1cm4gcGFyc2Vfb3B0
X3Bhc3N0aHJ1X2FyZ3Yob3B0LCBhcmcsIHVuc2V0KTsKK30KKwogc3RhdGljIGludCBnaXRfYW1f
Y29uZmlnKGNvbnN0IGNoYXIgKmssIGNvbnN0IGNoYXIgKnYsIHZvaWQgKmNiKQogewogCWludCBz
dGF0dXM7CkBAIC0yMzU1LDkgKzIzNjUsOSBAQCBpbnQgY21kX2FtKGludCBhcmdjLCBjb25zdCBj
aGFyICoqYXJndiwgY29uc3QgY2hhciAqcHJlZml4KQogCQlPUFRfQ0FMTEJBQ0tfRigwLCAicXVv
dGVkLWNyIiwgJnN0YXRlLnF1b3RlZF9jciwgTl8oImFjdGlvbiIpLAogCQkJICAgICAgIE5fKCJw
YXNzIGl0IHRocm91Z2ggZ2l0LW1haWxpbmZvIiksCiAJCQkgICAgICAgUEFSU0VfT1BUX05PTkVH
LCBhbV9vcHRpb25fcGFyc2VfcXVvdGVkX2NyKSwKLQkJT1BUX1BBU1NUSFJVX0FSR1YoMCwgIndo
aXRlc3BhY2UiLCAmc3RhdGUuZ2l0X2FwcGx5X29wdHMsIE5fKCJhY3Rpb24iKSwKKwkJT1BUX0NB
TExCQUNLKDAsICJ3aGl0ZXNwYWNlIiwgJnN0YXRlLmdpdF9hcHBseV9vcHRzLCBOXygiYWN0aW9u
IiksCiAJCQlOXygicGFzcyBpdCB0aHJvdWdoIGdpdC1hcHBseSIpLAotCQkJMCksCisJCQlwYXJz
ZV9vcHRfd2hpdGVzcGFjZSksCiAJCU9QVF9QQVNTVEhSVV9BUkdWKDAsICJpZ25vcmUtc3BhY2Ut
Y2hhbmdlIiwgJnN0YXRlLmdpdF9hcHBseV9vcHRzLCBOVUxMLAogCQkJTl8oInBhc3MgaXQgdGhy
b3VnaCBnaXQtYXBwbHkiKSwKIAkJCVBBUlNFX09QVF9OT0FSRyksCg==
--000000000000641a3705d959cb87--
