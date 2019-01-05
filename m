Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72268211B4
	for <e@80x24.org>; Sat,  5 Jan 2019 22:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfAEWq7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Jan 2019 17:46:59 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44035 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfAEWq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jan 2019 17:46:59 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so35197482lji.11
        for <git@vger.kernel.org>; Sat, 05 Jan 2019 14:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=e4gomOeXI6V04oR4HjVYf5xn1bX+xmNEU4zCwU/QQrc=;
        b=BWMbcNXYIlh5piTNP0dEqE88QA2GC/jF3wcbOK628KPqHM778Cp/UVLVgzzDtrE59n
         DvrYnIcwyZt9ByZRgKhYl51BGV2MGJ0li9VwOxv44vqgMcRzTIdPGNsWUjmDhzsmODbV
         NZQJugfUekEAsu+8geaMIou48FKXCZx5XUX38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=e4gomOeXI6V04oR4HjVYf5xn1bX+xmNEU4zCwU/QQrc=;
        b=q8vd1Yl8CGYttId0A3Nk7hZsc282mo+p7VXa+RD8gePAlAPYB/oTqftnF6hJLBVNsJ
         349RhFCeP6lbbRXo3NX2kvFzB+TgG6Brrj/avVlHjp1CGBrzQPe1PvwrmoV5H5fauqyb
         oQxXGiAXBhtRlzfCLnGMW3VhiMgDPgDshgblKr8ThmJv3URyTe+nBnS/lxhBJhVM+DF6
         XXngicz3yPt1sWKmV39p6eyNa4oikP0pRWiHd8845dB5oedrsJBAwWbhmPMVrRS2D8uk
         wkTGMLdP+kSKL+W3LRTr1xdJH06Gt273UeFgef9RlaXvZdAOw27Mi/pIVEpbRw6V51Jg
         I2Sw==
X-Gm-Message-State: AJcUuke2MMoZLxe8rBcoP/vfJ5bgvYPQgVkuGVx42nHYVphwOaN1r2Yi
        BSgFLlPdOYorSMmkRIVMuxoTAEyH5Ac=
X-Google-Smtp-Source: AFSGD/WMe+YJ7X3/4bOnxT7LuSwIZNsdCHsUjkfWPpA17a0T8dmLB/jE98MbfvyB3rwx0a2cb/2xbQ==
X-Received: by 2002:a2e:4442:: with SMTP id r63-v6mr31527135lja.79.1546728415682;
        Sat, 05 Jan 2019 14:46:55 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id f20-v6sm13015053ljk.33.2019.01.05.14.46.54
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 14:46:54 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id c19-v6so35248008lja.5
        for <git@vger.kernel.org>; Sat, 05 Jan 2019 14:46:54 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr8331822ljk.80.1546728414355;
 Sat, 05 Jan 2019 14:46:54 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Jan 2019 14:46:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg0NUNFjZumgC-9f=kmU3L4T+qOAgXwiDAfPaNtuFfvFg@mail.gmail.com>
Message-ID: <CAHk-=wg0NUNFjZumgC-9f=kmU3L4T+qOAgXwiDAfPaNtuFfvFg@mail.gmail.com>
Subject: Make "git log --count" work like "git rev-list"
To:     Junio Hamano C <gitster@pobox.com>
Cc:     Git List Mailing <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000b3db9d057ebdc578"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000b3db9d057ebdc578
Content-Type: text/plain; charset="UTF-8"

This is a ridiculous patch. And I understand entirely if nobody else
cares, because I don't think anybody else has ever even noticed.

It turns out that I still use "git rev-list" outside of some hard-core
scripting for one silly reason: the linux-next statistics are all
about non-merge commits, and so to do a rough comparison with
linux-next, I do

        git rev-list --count --no-merges v4.20..

to get an approximate idea of how much I've merged compared to what is
in linux-next.

(See also

        http://neuling.org/linux-next-size.html

for the graphical view of it all, even though it looks a bit odd right
now because of how linux-next wasn't being updated over the holidats
and right at the 4.19 release).

Anyway, I've occasionally thought to myself that I should just fix
"git log" to learn that too, so that I wouldn't have to type out "git
rev-list". Because "git log" does actually take the "--count"
argument, it just doesn't honor it.

This is that patch.

                    Linus

--000000000000b3db9d057ebdc578
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-git-log-honor-the-count-argument.patch"
Content-Disposition: attachment; 
	filename="0001-git-log-honor-the-count-argument.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jqk237i80>
X-Attachment-Id: f_jqk237i80

RnJvbSBlM2JjNTM4NzQwNGJjZWZiZDg2MDgxZmJjODJhOTNmYzVjOWVmYTk5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFNhdCwgNSBKYW4gMjAxOSAxNDozOTo0MSAtMDgwMApTdWJqZWN0OiBb
UEFUQ0hdIGdpdCBsb2c6IGhvbm9yIHRoZSAnLS1jb3VudCcgYXJndW1lbnQKCiJnaXQgbG9nIiBp
cyByZWFsbHkgdGhlIGh1bWFuLWZhY2luZyB1c2VmdWwgY29tbWFuZCB0aGF0IGxvbmcgbG9uZyBh
Z28KdXNlZCB0byBzY3JpcHRlZCBhcm91bmQgImdpdCByZXYtbGlzdCIuCgpJbiBmYWN0LCBpZiB5
b3Ugd2FudCB0byB1c2UgdGhlIG9sZCBzY3JpcHRpbmcgY29kZSwgeW91IGNhbiBzdGlsbAphcHBy
b3hpbWF0ZSAiZ2l0IGxvZyIgd2l0aCBzb21ldGhpbmcgbGlrZQoKICAgZ2l0IHJldi1saXN0IC0t
cHJldHR5IEhFQUQgfCBsZXNzCgpidXQgeW91J2QgYmUgc2lsbHkgdG8gZG8gdGhhdCwgc2luY2Ug
ImdpdCBsb2ciIGlzIGNsZWFybHkgYSBtdWNoIG5pY2VyCmludGVyZmFjZSBhbmQgaXMgd2hhdCBw
ZW9wbGUgc2hvdWxkIHVzZS4KCkV4Y2VwdCBJIGZpbmQgbXlzZWxmIHN0aWxsIG9jY2FzaW9uYWxs
eSB1c2luZyAiZ2l0IHJldi1saXN0IiBzaW1wbHkKYmVjYXVzZSAiZ2l0IGxvZyIgZG9lc24ndCBk
byBvbmUgb2RkIGxpdHRsZSBxdWlyazogY29tbWl0IGNvdW50aW5nLgoKU28gaWYgeW91IHdhbnQg
dG8gY291bnQgdGhlIG51bWJlciBvZiBub24tbWVyZ2UgY29tbWl0cyBzaW5jZSB0aGUgbGFzdApr
ZXJuZWwgdmVyc2lvbiwgeW91J2QgaGF2ZSB0byBkbyBzb21ldGhpbmcgbGlrZQoKICAgZ2l0IHJl
di1saXN0IC0tY291bnQgLS1uby1tZXJnZXMgdjQuMjAuLgoKYmVjYXVzZSB3aGlsZSAiZ2l0IGxv
ZyIgYWN0dWFsbHkgc2lsZW50bHkgX2FjY2VwdHNfIHRoZSAiLS1jb3VudCIKYXJndW1lbnQsIGl0
IGRvZXNuJ3QgZG8gYW55dGhpbmcgYWJvdXQgaXQuCgpUaGlzIGxpdHRsZSBwYXRjaCBjb3BpZXMg
dGhlIHJldi1saXN0IGNvZGUgZm9yIGNvdW50aW5nIHRvICJnaXQgbG9nIi4KClNpZ25lZC1vZmYt
Ynk6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiBi
dWlsdGluL2xvZy5jIHwgMTEgKysrKysrKysrKysKIGxvZy10cmVlLmMgICAgfCAxMCArKysrKysr
KysrCiAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9idWls
dGluL2xvZy5jIGIvYnVpbHRpbi9sb2cuYwppbmRleCBlOGU1MTA2OGJkLi42MmJlZjYyZjhhIDEw
MDY0NAotLS0gYS9idWlsdGluL2xvZy5jCisrKyBiL2J1aWx0aW4vbG9nLmMKQEAgLTQxMSw2ICs0
MTEsMTcgQEAgc3RhdGljIGludCBjbWRfbG9nX3dhbGsoc3RydWN0IHJldl9pbmZvICpyZXYpCiAJ
aWYgKGNsb3NlX2ZpbGUpCiAJCWZjbG9zZShyZXYtPmRpZmZvcHQuZmlsZSk7CiAKKwlpZiAocmV2
LT5jb3VudCkgeworCQlpZiAocmV2LT5sZWZ0X3JpZ2h0ICYmIHJldi0+Y2hlcnJ5X21hcmspCisJ
CQlwcmludGYoIiVkXHQlZFx0JWRcbiIsIHJldi0+Y291bnRfbGVmdCwgcmV2LT5jb3VudF9yaWdo
dCwgcmV2LT5jb3VudF9zYW1lKTsKKwkJZWxzZSBpZiAocmV2LT5sZWZ0X3JpZ2h0KQorCQkJcHJp
bnRmKCIlZFx0JWRcbiIsIHJldi0+Y291bnRfbGVmdCwgcmV2LT5jb3VudF9yaWdodCk7CisJCWVs
c2UgaWYgKHJldi0+Y2hlcnJ5X21hcmspCisJCQlwcmludGYoIiVkXHQlZFxuIiwgcmV2LT5jb3Vu
dF9sZWZ0ICsgcmV2LT5jb3VudF9yaWdodCwgcmV2LT5jb3VudF9zYW1lKTsKKwkJZWxzZQorCQkJ
cHJpbnRmKCIlZFxuIiwgcmV2LT5jb3VudF9sZWZ0ICsgcmV2LT5jb3VudF9yaWdodCk7CisJfQor
CiAJaWYgKHJldi0+ZGlmZm9wdC5vdXRwdXRfZm9ybWF0ICYgRElGRl9GT1JNQVRfQ0hFQ0tESUZG
ICYmCiAJICAgIHJldi0+ZGlmZm9wdC5mbGFncy5jaGVja19mYWlsZWQpIHsKIAkJcmV0dXJuIDAy
OwpkaWZmIC0tZ2l0IGEvbG9nLXRyZWUuYyBiL2xvZy10cmVlLmMKaW5kZXggMTA2ODBjMTM5ZS4u
NDlmZjQ4NTMyMCAxMDA2NDQKLS0tIGEvbG9nLXRyZWUuYworKysgYi9sb2ctdHJlZS5jCkBAIC05
MTMsNiArOTEzLDE2IEBAIGludCBsb2dfdHJlZV9jb21taXQoc3RydWN0IHJldl9pbmZvICpvcHQs
IHN0cnVjdCBjb21taXQgKmNvbW1pdCkKIAlzdHJ1Y3QgbG9nX2luZm8gbG9nOwogCWludCBzaG93
biwgY2xvc2VfZmlsZSA9IG9wdC0+ZGlmZm9wdC5jbG9zZV9maWxlOwogCisJaWYgKG9wdC0+Y291
bnQpIHsKKwkJaWYgKGNvbW1pdC0+b2JqZWN0LmZsYWdzICYgUEFUQ0hTQU1FKQorCQkJb3B0LT5j
b3VudF9zYW1lKys7CisJCWVsc2UgaWYgKGNvbW1pdC0+b2JqZWN0LmZsYWdzICYgU1lNTUVUUklD
X0xFRlQpCisJCQlvcHQtPmNvdW50X2xlZnQrKzsKKwkJZWxzZQorCQkJb3B0LT5jb3VudF9yaWdo
dCsrOworCQlyZXR1cm4gMTsKKwl9CisKIAlsb2cuY29tbWl0ID0gY29tbWl0OwogCWxvZy5wYXJl
bnQgPSBOVUxMOwogCW9wdC0+bG9naW5mbyA9ICZsb2c7Ci0tIAoyLjIwLjEuMTAxLmc2MGJhNmRm
MGM0Cgo=
--000000000000b3db9d057ebdc578--
