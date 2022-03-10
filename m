Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4ABC433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 19:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbiCJTmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 14:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbiCJTmL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 14:42:11 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD53188A04
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 11:41:09 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id h11so9249051ljb.2
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 11:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=opkBIxek0T84areBEcUsU257hJ/VgId3acPh/IHZzNQ=;
        b=WaNs0yi9g2P2a4r3cj+qW9CtGPS1iKz9e7bzR6d3n/hxCk6iPaq2UIJLGLMHxcIhoH
         NlXTt43Nlk5XDxBShvoKRYJPOPIFRIVnuHu2C7naqkIFBWKjmel1MmO3NlcwbEgnLRTo
         QQgKHtoaSeS9XvhYKGQRohQqudlnl6EDrSpMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=opkBIxek0T84areBEcUsU257hJ/VgId3acPh/IHZzNQ=;
        b=nOE8gScivhuDguGnwa458lOzp2uhp8R9I0/w/nYlv7LWuxWwEX5FtPoutvRKA4g/Nn
         nly6USWWRYpCo5aojBaaF3eKf3lFuxb6tzFxDUKRvOBD4JFaVJK+NXIpHogHFRsK/eHu
         mKP7gKiCoXahokmwtf1+tAejtlDCShyhlScVEBSri9jat5NL0rPgzzLqYoeAwFn8oIGY
         Bjcg0KO+EEyQH8TTgnjQMJreOaarddNLTZ39b6jIaSye33Gvzoz4ukX/BznbzTkH3pTs
         arMFz7NK30DGGxas/4s5ypnHBug82FcU9+Q4JMOLUrvTX1duxB92HTsH3Uic546yDUA4
         c21w==
X-Gm-Message-State: AOAM533uGkDm36IpISrWQ9T1UdGUoErgk7hAUX/PqLGfePEtQErBNPJi
        qooYBM/fWuJc0gaXjhaMd+n8aaO5THnYaADmQAo=
X-Google-Smtp-Source: ABdhPJxlNfV4Coc+ce6NoZORzW8g2jCOZOVqweWuTpy72KKshu/FmAJKNWeQL6sppcMgJgHaR0NRwQ==
X-Received: by 2002:a2e:b8c9:0:b0:248:57c:ac60 with SMTP id s9-20020a2eb8c9000000b00248057cac60mr3972078ljp.447.1646941267308;
        Thu, 10 Mar 2022 11:41:07 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id g1-20020a19e041000000b00443131b3efcsm1140959lfj.284.2022.03.10.11.41.06
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 11:41:06 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id s25so11243817lfs.10
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 11:41:06 -0800 (PST)
X-Received: by 2002:a05:6512:e8a:b0:443:7b8c:579a with SMTP id
 bi10-20020a0565120e8a00b004437b8c579amr3868161lfb.687.1646941266202; Thu, 10
 Mar 2022 11:41:06 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Mar 2022 11:40:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgh8emJn-+FtxN=m_SCPiP6cGKHU-5ozzV9tWBMxn+xcA@mail.gmail.com>
Message-ID: <CAHk-=wgh8emJn-+FtxN=m_SCPiP6cGKHU-5ozzV9tWBMxn+xcA@mail.gmail.com>
Subject: RFC: Using '--no-output-indicator-old' to only show new state
To:     Junio Hamano C <gitster@pobox.com>
Cc:     Git List Mailing <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000023adf105d9e26572"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--00000000000023adf105d9e26572
Content-Type: text/plain; charset="UTF-8"

So after another round of doing

     git diff | grep -v '^-'

to just show what the end result of a patch is, I decided that there
has to be a better way.

Of course, to normal people, that "better way" is probably some GUI
tool that shows diffs as "before/after" in two different frames next
to each other, but I'm a grumpy old man ("Get off my lawn") and I do
everything but read my email in a standard text-only terminal.

So this RFC is that better way for me.

It's a RFC because maybe people think this is stupid, but even more so
becasue I think it should also go with an actual new and more legible
name - which this tech demonstration does *not* do, because I suspect
people have more opinions on the option name than they have on the
trivial technical parts.

IOW, with this patch, you can do

    git show --no-output-indicator-old

and it shows the diff but without the 'old' lines. That option name is
horrible to write, though, and even with command line completion I
think it migth be worth doing as

   git show --new

or something like that.

When would you want this? The case _I_ tend to use that "grep -v '^-'"
thing is when I re-write a function, and a regular diff really is just
very messy and what I really want to see is just the end result to
verify that "yeah, this looks sane".

In case people care, the immediate (current) cause of this was kernel
commit fe673d3f5bf1 ("mm: gup: make fault_in_safe_writeable() use
fixup_user_fault()"), which really is a fairly messy diff, but what
matters is the much simplified end result of the
fault_in_safe_writeable() function.

But in the commit message, I put a random git commit as an example
instead, just to make it easier to see what's up when you're a git
developer, not a kernel developer.

And hey, there are probably smarter things that could be done: this
doesn't work with word-diffs, for example. Maybe people would want an
equivalent "don't show the deleted word" instead. But this is really
really simple.

And maybe there already was some better way to do this.

Comments?

(And for consistency, this obviously also allows
"--no-output-indicator-new", but I've never found _that_ particularly
useful. But GUI diff tools most certainly also tend to show the old
state on one side, so maybe it's would be reasonable to use as a
"compare the old state vs the new state" in terminals side-by-side. I
just tend to care much more about "what is the end result")

               Linus

--00000000000023adf105d9e26572
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Allow-no-output-indicator-old-new-to-disable-diff-ou.patch"
Content-Disposition: attachment; 
	filename="0001-Allow-no-output-indicator-old-new-to-disable-diff-ou.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l0le7i0p0>
X-Attachment-Id: f_l0le7i0p0

RnJvbSA5NWU5MjZjMzgyNjdlYjdlYzg5NTZlYTQ3ZGI1NWJmODA4MGZiMjgyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFRodSwgMTAgTWFyIDIwMjIgMTE6MDA6NDMgLTA4MDAKU3ViamVjdDog
W1BBVENIIDEvMl0gQWxsb3cgJy0tbm8tb3V0cHV0LWluZGljYXRvci17b2xkLG5ld30nIHRvIGRp
c2FibGUgZGlmZgogb3V0cHV0CgpUaGlzIGlzIHBhcnRpY3VsYXJseSB1c2VmdWwgaWYgeW91IHdh
bnQgdG8ganVzdCBzZWUgdGhlIGVuZCByZXN1bHQgb2YgYQpkaWZmLCB3aXRob3V0IHRoZSBvcmln
aW5hbCBsaW5lcyB0aGF0IGhhdmUgYmVlbiByZW1vdmVkIChvciB0aGUgcmV2ZXJzZSkuCgpUaGF0
J3MgYSBmYWlybHkgY29tbW9uIG1vZGVsIGluIHZhcmlvdXMgR1VJIGRpZmYgdmlld2VycywgYnV0
IGl0J3Mgbm90CnVudXN1YWwgdG8gd2FudCB0byBqdXN0IHNlZSAid2hhdCBpcyB0aGUgZW5kIHJl
c3VsdCBvZiBteSBjaGFuZ2VzIgp3aXRob3V0IHNlZWluZyAoYSkgZXZlcnl0aGluZyB0aGF0IGRp
ZG4ndCBjaGFuZ2UgYW5kIChiKSB0aGUgb2xkIHJlbW92ZWQKc3RhdGUuCgpFeGFtcGxlOgoKICAg
IGdpdCBzaG93IC0tbm8tb3V0cHV0LWluZGljYXRvci1vbGQgMDRiZjA1MmVlZgoKdG8gc2VlIGp1
c3QgdGhlIGVuZCByZXN1bHQgb2YgdGhlIGNoYW5nZXMgaW4gY29tbWl0IDA0YmYwNTJlZWYgKCJn
cmVwOgpzaW1wbGlmeSBjb25maWcgcGFyc2luZyBhbmQgb3B0aW9uIHBhcnNpbmciKS4KClRoaXMg
aXMgYSB0ZWNobm9sb2d5IHByZXNlbnRhdGlvbiwgSSB0aGluayBpdCBuZWVkcyBhIHNob3J0ZXIg
b3B0aW9uCm5hbWUgdG9vIGlmIHBlb3BsZSBhZ3JlZSB0aGF0IHRoaXMgaXMgdXNlZnVsICh0aGlz
IGJhc2ljYWxseSByZXBsYWNlcyBteQpoYWNreQoKICAgIGdpdCBkaWZmIHwgZ3JlcCAtdiAnXi0n
Cgp0aGF0IEkgdXNlIGZvciB0aGUgc2FtZSBwdXJwb3NlLCBidXQgdGhlIHZlcnkgbG9uZyBhcmd1
bWVudCBuYW1lCm9idmlvdXNseSBtYWtlcyBpdCBubyBtb3JlIGNvbnZlbmllbnQsIGFsdGhvdWdo
IHRoZSBlbmQgcmVzdWx0IGlzCnF1YWxpdGF0aXZlbHkgYmV0dGVyKS4KClNpZ25lZC1vZmYtYnk6
IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiBkaWZm
LmMgfCAxMCArKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RpZmYuYyBiL2RpZmYuYwppbmRleCAyYmQ1ZTBkODE3
Li44OTU5NTFiODQ5IDEwMDY0NAotLS0gYS9kaWZmLmMKKysrIGIvZGlmZi5jCkBAIC0xMjU0LDYg
KzEyNTQsOCBAQCBzdGF0aWMgdm9pZCBlbWl0X2xpbmVfd3NfbWFya3VwKHN0cnVjdCBkaWZmX29w
dGlvbnMgKm8sCiAJY29uc3QgY2hhciAqd3MgPSBOVUxMOwogCWludCBzaWduID0gby0+b3V0cHV0
X2luZGljYXRvcnNbc2lnbl9pbmRleF07CiAKKwlpZiAoIXNpZ24pCisJCXJldHVybjsKIAlpZiAo
by0+d3NfZXJyb3JfaGlnaGxpZ2h0ICYgd3NfcnVsZSkgewogCQl3cyA9IGRpZmZfZ2V0X2NvbG9y
X29wdChvLCBESUZGX1dISVRFU1BBQ0UpOwogCQlpZiAoISp3cykKQEAgLTQ5ODYsNiArNDk4OCwx
MCBAQCBzdGF0aWMgaW50IGRpZmZfb3B0X2NoYXIoY29uc3Qgc3RydWN0IG9wdGlvbiAqb3B0LAog
ewogCWNoYXIgKnZhbHVlID0gb3B0LT52YWx1ZTsKIAorCWlmICh1bnNldCkgeworCQkqdmFsdWUg
PSAwOworCQlyZXR1cm4gMDsKKwl9CiAJQlVHX09OX09QVF9ORUcodW5zZXQpOwogCWlmIChhcmdb
MV0pCiAJCXJldHVybiBlcnJvcihfKCIlcyBleHBlY3RzIGEgY2hhcmFjdGVyLCBnb3QgJyVzJyIp
LApAQCAtNTQ3NiwxMiArNTQ4MiwxMiBAQCBzdGF0aWMgdm9pZCBwcmVwX3BhcnNlX29wdGlvbnMo
c3RydWN0IGRpZmZfb3B0aW9ucyAqb3B0aW9ucykKIAkJCSAgICAgICAmb3B0aW9ucy0+b3V0cHV0
X2luZGljYXRvcnNbT1VUUFVUX0lORElDQVRPUl9ORVddLAogCQkJICAgICAgIE5fKCI8Y2hhcj4i
KSwKIAkJCSAgICAgICBOXygic3BlY2lmeSB0aGUgY2hhcmFjdGVyIHRvIGluZGljYXRlIGEgbmV3
IGxpbmUgaW5zdGVhZCBvZiAnKyciKSwKLQkJCSAgICAgICBQQVJTRV9PUFRfTk9ORUcsIGRpZmZf
b3B0X2NoYXIpLAorCQkJICAgICAgIDAsIGRpZmZfb3B0X2NoYXIpLAogCQlPUFRfQ0FMTEJBQ0tf
RigwLCAib3V0cHV0LWluZGljYXRvci1vbGQiLAogCQkJICAgICAgICZvcHRpb25zLT5vdXRwdXRf
aW5kaWNhdG9yc1tPVVRQVVRfSU5ESUNBVE9SX09MRF0sCiAJCQkgICAgICAgTl8oIjxjaGFyPiIp
LAogCQkJICAgICAgIE5fKCJzcGVjaWZ5IHRoZSBjaGFyYWN0ZXIgdG8gaW5kaWNhdGUgYW4gb2xk
IGxpbmUgaW5zdGVhZCBvZiAnLSciKSwKLQkJCSAgICAgICBQQVJTRV9PUFRfTk9ORUcsIGRpZmZf
b3B0X2NoYXIpLAorCQkJICAgICAgIDAsIGRpZmZfb3B0X2NoYXIpLAogCQlPUFRfQ0FMTEJBQ0tf
RigwLCAib3V0cHV0LWluZGljYXRvci1jb250ZXh0IiwKIAkJCSAgICAgICAmb3B0aW9ucy0+b3V0
cHV0X2luZGljYXRvcnNbT1VUUFVUX0lORElDQVRPUl9DT05URVhUXSwKIAkJCSAgICAgICBOXygi
PGNoYXI+IiksCi0tIAoyLjM1LjEuNDU5LmdhYmJlZjk1ZDczCgo=
--00000000000023adf105d9e26572--
