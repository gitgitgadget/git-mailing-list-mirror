Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28749C433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 00:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240927AbiCKADO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 19:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345247AbiCKADM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 19:03:12 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58D11A06D7
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 16:02:07 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id w7so12288989lfd.6
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 16:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W6N/kEvqHRH0X5i7lNmQOJHzH7zU0w+gk45E3CiE/G4=;
        b=PFqpljW/cH50Eb6RKoX7JKAlcqcPAZIlkGLh/x/SN3YNuVak8PIT+AgVsHYAmNA94Z
         8rD1PSkt3L/sgUh1XEzS0JWUdcWrxJMXi7CQeiim+V8xlFCNHbPEQPaUWkUzJe5xzh1G
         OCz+r74vwwZ+CiRdyk17iH4LumAFfCtpqHl+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W6N/kEvqHRH0X5i7lNmQOJHzH7zU0w+gk45E3CiE/G4=;
        b=oPa6EcSf/n6aTlRaoZleP+QrlRabh+UlZ0sYtFLRmu17p9et4TbhlDvYFhCB9E8kyT
         bwFryJXcHIKKYXFhPcJ/hcIoC5ORLuvt4S/UeTTLTeDW7asXT7BIb4VoLgVlEUd3HF9l
         oGBpU6+z1jPXknYbqg6SSYjSh3NOtJXiqDXPlqUK3ViG9SYVa/bTL+UjX/WXxQ6Tvjqm
         X6o+RPBcZG6WKsap97XtWsV1ngxBNyQ44RTUGZEODnxRGmMLI+INvo12LuNBeyPQNDL6
         pEdS5mHmnQwbfNKYH1Eek+huNwnjFHU9Q4TnaBJDOzpI52e8pKqYISUs3+Jq2lF/Mjdn
         POIQ==
X-Gm-Message-State: AOAM531dVRa86szBgB3CTv0Hh7YUdON67KQ9obEC8Lhn5E82iJoyr2po
        liEDZsbO3ucxmPD35bpSznLee0wc92N6J1upJWI=
X-Google-Smtp-Source: ABdhPJzpgz25VLwB1+LZnZgX5hSY9VmolDHthnEyhkcml2fIVlQAK5+2CO8nRsH39wevH9VlkGE7wQ==
X-Received: by 2002:ac2:42d4:0:b0:448:2fae:83c1 with SMTP id n20-20020ac242d4000000b004482fae83c1mr4383309lfl.637.1646956925860;
        Thu, 10 Mar 2022 16:02:05 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id o1-20020ac25b81000000b00448696cfa21sm466962lfn.100.2022.03.10.16.02.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 16:02:05 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id l12so9955808ljh.12
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 16:02:05 -0800 (PST)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr4415286lja.443.1646956924808; Thu, 10
 Mar 2022 16:02:04 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgh8emJn-+FtxN=m_SCPiP6cGKHU-5ozzV9tWBMxn+xcA@mail.gmail.com>
 <xmqqo82dd0qv.fsf@gitster.g> <CAHk-=wg+n_-btzoyMqnDYsJxFYAyUh0Kb=TkpS8RiD_h3G=_cA@mail.gmail.com>
 <xmqqfsnpcxdm.fsf@gitster.g> <CAHk-=whRbuJJ1LzYN9F48JaS7EjuP3FkppHJXi1wAO_qLJQ2xw@mail.gmail.com>
In-Reply-To: <CAHk-=whRbuJJ1LzYN9F48JaS7EjuP3FkppHJXi1wAO_qLJQ2xw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Mar 2022 16:01:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj0ZfmTEhc4iPJSbn_FxzU94qZfK9WcgujKUcZK9a2UvQ@mail.gmail.com>
Message-ID: <CAHk-=wj0ZfmTEhc4iPJSbn_FxzU94qZfK9WcgujKUcZK9a2UvQ@mail.gmail.com>
Subject: Re: RFC: Using '--no-output-indicator-old' to only show new state
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List Mailing <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000076e93a05d9e60ad8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--00000000000076e93a05d9e60ad8
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 10, 2022 at 2:13 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Here's the stupid patch that "works" but doesn't allow the shortened
> version. Maybe somebody can point out what silly thing I did wrong.

I just created a short alias to do this. Maybe there's some smarter
option, but this seems to work.

I've updated the commit message - I kept the --no-output-indicator-xyz
form since it really logically ends up being exactly that, but I guess
those changes could also be dropped.

Hmm?

              Linus

--00000000000076e93a05d9e60ad8
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Allow-new-only-old-only-to-only-show-the-new-old-par.patch"
Content-Disposition: attachment; 
	filename="0001-Allow-new-only-old-only-to-only-show-the-new-old-par.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l0lnlzsb0>
X-Attachment-Id: f_l0lnlzsb0

RnJvbSAxZDIwNzU4NTM2OWVjMTcwOGRhNTU0OTE3NmE3OWJiMjJjNDcyZWUyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFRodSwgMTAgTWFyIDIwMjIgMTE6MDA6NDMgLTA4MDAKU3ViamVjdDog
W1BBVENIXSBBbGxvdyAnLS1uZXctb25seS8tLW9sZC1vbmx5JyB0byBvbmx5IHNob3cgdGhlIG5l
dy9vbGQgcGFydHMKIG9mIGEgZGlmZgoKVGhpcyBpcyBwYXJ0aWN1bGFybHkgdXNlZnVsIGlmIHlv
dSB3YW50IHRvIGp1c3Qgc2VlIHRoZSBlbmQgcmVzdWx0IG9mIGEKZGlmZiwgd2l0aG91dCB0aGUg
b3JpZ2luYWwgbGluZXMgdGhhdCBoYXZlIGJlZW4gcmVtb3ZlZCAob3IsIGxlc3MKY29tbW9ubHks
IHRoZSByZXZlcnNlKS4KClRoaXMgYSBmYWlybHkgdXNlZnVsIG1vZGVsIGluIHZhcmlvdXMgR1VJ
IGRpZmYgdmlld2Vycywgd2l0aCAnZ2l0aycgZm9yCmV4YW1wbGUgaGF2aW5nIHRoZSBvcHRpb24g
dG8gc2hvdyB0aGUgZGlmZiwgdGhlIG9sZCBzdGF0ZSwgb3IgdGhlIG5ldwpzdGF0ZS4gIEl0J3Mg
bm90IHVudXN1YWwgdG8gd2FudCB0byBqdXN0IHNlZSAid2hhdCBpcyB0aGUgZW5kIHJlc3VsdCBv
ZgpteSBjaGFuZ2VzIiB3aXRob3V0IHNlZWluZyAoYSkgZXZlcnl0aGluZyB0aGF0IGRpZG4ndCBj
aGFuZ2UgYW5kIChiKSB0aGUKb2xkIHJlbW92ZWQgc3RhdGUuCgpUaGUgb3B0aW9uIG5hbWUgY2Fu
IGFsc28gYmUgYWJicmV2aWF0ZWQgdG8ganVzdCAiLS1uZXciIGFuZCAiLS1vbGQiLgoKRXhhbXBs
ZToKCiAgICBnaXQgc2hvdyAtLW5ldyAwNGJmMDUyZWVmCgp0byBzZWUganVzdCB0aGUgZW5kIHJl
c3VsdCBvZiB0aGUgY2hhbmdlcyBpbiBjb21taXQgMDRiZjA1MmVlZiAoImdyZXA6CnNpbXBsaWZ5
IGNvbmZpZyBwYXJzaW5nIGFuZCBvcHRpb24gcGFyc2luZyIpLgoKSW50ZXJuYWxseSB0aGlzIGlz
IHNpbXBseSBpbXBsZW1lbnRlZCBhcyBzZXR0aW5nIHRoZSBvdXRwdXQgaW5kaWNhdG9yCmZvciBv
bGQgYW5kIG5ldyBsaW5lcywgYW5kIHlvdSBjYW4gaW4gZmFjdCBhbHNvIGRvIHRoaXMgd2l0aCB0
aGF0IGZhaXJseQpjdW1iZXJzb21lIGludGVyZmFjZSAoaWUgIi0tbm8tb3V0cHV0LWluZGljYXRv
ci1vbGQiIGRpc2FibGVzIHRoZSBvbGQKbGluZXMsIGFuZCB0aHVzIGFjdHMgYXMgIi0tbmV3Iiku
CgpTaWduZWQtb2ZmLWJ5OiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlv
bi5vcmc+Ci0tLQogZGlmZi5jIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQog
MSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZGlmZi5jIGIvZGlmZi5jCmluZGV4IDJiZDVlMGQ4MTcuLmYzN2YwYjM4M2EgMTAwNjQ0
Ci0tLSBhL2RpZmYuYworKysgYi9kaWZmLmMKQEAgLTEyNTQsNiArMTI1NCw4IEBAIHN0YXRpYyB2
b2lkIGVtaXRfbGluZV93c19tYXJrdXAoc3RydWN0IGRpZmZfb3B0aW9ucyAqbywKIAljb25zdCBj
aGFyICp3cyA9IE5VTEw7CiAJaW50IHNpZ24gPSBvLT5vdXRwdXRfaW5kaWNhdG9yc1tzaWduX2lu
ZGV4XTsKIAorCWlmICghc2lnbikKKwkJcmV0dXJuOwogCWlmIChvLT53c19lcnJvcl9oaWdobGln
aHQgJiB3c19ydWxlKSB7CiAJCXdzID0gZGlmZl9nZXRfY29sb3Jfb3B0KG8sIERJRkZfV0hJVEVT
UEFDRSk7CiAJCWlmICghKndzKQpAQCAtNDk4Niw2ICs0OTg4LDEwIEBAIHN0YXRpYyBpbnQgZGlm
Zl9vcHRfY2hhcihjb25zdCBzdHJ1Y3Qgb3B0aW9uICpvcHQsCiB7CiAJY2hhciAqdmFsdWUgPSBv
cHQtPnZhbHVlOwogCisJaWYgKHVuc2V0KSB7CisJCSp2YWx1ZSA9IDA7CisJCXJldHVybiAwOwor
CX0KIAlCVUdfT05fT1BUX05FRyh1bnNldCk7CiAJaWYgKGFyZ1sxXSkKIAkJcmV0dXJuIGVycm9y
KF8oIiVzIGV4cGVjdHMgYSBjaGFyYWN0ZXIsIGdvdCAnJXMnIiksCkBAIC00OTk0LDYgKzUwMDAs
MTcgQEAgc3RhdGljIGludCBkaWZmX29wdF9jaGFyKGNvbnN0IHN0cnVjdCBvcHRpb24gKm9wdCwK
IAlyZXR1cm4gMDsKIH0KIAorc3RhdGljIGludCBkaWZmX29wdF9ub19jaGFyKGNvbnN0IHN0cnVj
dCBvcHRpb24gKm9wdCwKKwkJCSBjb25zdCBjaGFyICphcmcsIGludCB1bnNldCkKK3sKKwljaGFy
ICp2YWx1ZSA9IG9wdC0+dmFsdWU7CisKKwlCVUdfT05fT1BUX05FRyh1bnNldCk7CisJQlVHX09O
X09QVF9BUkcoYXJnKTsKKwkqdmFsdWUgPSAwOworCXJldHVybiAwOworfQorCiBzdGF0aWMgaW50
IGRpZmZfb3B0X2NvbG9yX21vdmVkKGNvbnN0IHN0cnVjdCBvcHRpb24gKm9wdCwKIAkJCQljb25z
dCBjaGFyICphcmcsIGludCB1bnNldCkKIHsKQEAgLTU0NzYsMTcgKzU0OTMsMjcgQEAgc3RhdGlj
IHZvaWQgcHJlcF9wYXJzZV9vcHRpb25zKHN0cnVjdCBkaWZmX29wdGlvbnMgKm9wdGlvbnMpCiAJ
CQkgICAgICAgJm9wdGlvbnMtPm91dHB1dF9pbmRpY2F0b3JzW09VVFBVVF9JTkRJQ0FUT1JfTkVX
XSwKIAkJCSAgICAgICBOXygiPGNoYXI+IiksCiAJCQkgICAgICAgTl8oInNwZWNpZnkgdGhlIGNo
YXJhY3RlciB0byBpbmRpY2F0ZSBhIG5ldyBsaW5lIGluc3RlYWQgb2YgJysnIiksCi0JCQkgICAg
ICAgUEFSU0VfT1BUX05PTkVHLCBkaWZmX29wdF9jaGFyKSwKKwkJCSAgICAgICAwLCBkaWZmX29w
dF9jaGFyKSwKIAkJT1BUX0NBTExCQUNLX0YoMCwgIm91dHB1dC1pbmRpY2F0b3Itb2xkIiwKIAkJ
CSAgICAgICAmb3B0aW9ucy0+b3V0cHV0X2luZGljYXRvcnNbT1VUUFVUX0lORElDQVRPUl9PTERd
LAogCQkJICAgICAgIE5fKCI8Y2hhcj4iKSwKIAkJCSAgICAgICBOXygic3BlY2lmeSB0aGUgY2hh
cmFjdGVyIHRvIGluZGljYXRlIGFuIG9sZCBsaW5lIGluc3RlYWQgb2YgJy0nIiksCi0JCQkgICAg
ICAgUEFSU0VfT1BUX05PTkVHLCBkaWZmX29wdF9jaGFyKSwKKwkJCSAgICAgICAwLCBkaWZmX29w
dF9jaGFyKSwKIAkJT1BUX0NBTExCQUNLX0YoMCwgIm91dHB1dC1pbmRpY2F0b3ItY29udGV4dCIs
CiAJCQkgICAgICAgJm9wdGlvbnMtPm91dHB1dF9pbmRpY2F0b3JzW09VVFBVVF9JTkRJQ0FUT1Jf
Q09OVEVYVF0sCiAJCQkgICAgICAgTl8oIjxjaGFyPiIpLAogCQkJICAgICAgIE5fKCJzcGVjaWZ5
IHRoZSBjaGFyYWN0ZXIgdG8gaW5kaWNhdGUgYSBjb250ZXh0IGluc3RlYWQgb2YgJyAnIiksCiAJ
CQkgICAgICAgUEFSU0VfT1BUX05PTkVHLCBkaWZmX29wdF9jaGFyKSwKKwkJT1BUX0NBTExCQUNL
X0YoMCwgIm5ldy1vbmx5IiwKKwkJCSAgICAgICAmb3B0aW9ucy0+b3V0cHV0X2luZGljYXRvcnNb
T1VUUFVUX0lORElDQVRPUl9PTERdLCBOVUxMLAorCQkJICAgICAgIE5fKCJzaG93IG9ubHkgbmV3
IGxpbmVzIGluIGRpZmYiKSwKKwkJCSAgICAgICBQQVJTRV9PUFRfTk9ORUcgfCBQQVJTRV9PUFRf
Tk9BUkcsIGRpZmZfb3B0X25vX2NoYXIpLAorCQlPUFRfQ0FMTEJBQ0tfRigwLCAib2xkLW9ubHki
LAorCQkJICAgICAgICZvcHRpb25zLT5vdXRwdXRfaW5kaWNhdG9yc1tPVVRQVVRfSU5ESUNBVE9S
X05FV10sIE5VTEwsCisJCQkgICAgICAgTl8oInNob3cgb25seSBvbGQgbGluZXMgaW4gZGlmZiIp
LAorCQkJICAgICAgIFBBUlNFX09QVF9OT05FRyB8IFBBUlNFX09QVF9OT0FSRywgZGlmZl9vcHRf
bm9fY2hhciksCisJCU9QVF9BTElBUygwLCAibmV3IiwgIm5ldy1vbmx5IiksCisJCU9QVF9BTElB
UygwLCAib2xkIiwgIm9sZC1vbmx5IiksCiAKIAkJT1BUX0dST1VQKE5fKCJEaWZmIHJlbmFtZSBv
cHRpb25zIikpLAogCQlPUFRfQ0FMTEJBQ0tfRignQicsICJicmVhay1yZXdyaXRlcyIsICZvcHRp
b25zLT5icmVha19vcHQsIE5fKCI8bj5bLzxtPl0iKSwKLS0gCjIuMzUuMS40NTkuZzFkMjA3NTg1
MzYKCg==
--00000000000076e93a05d9e60ad8--
