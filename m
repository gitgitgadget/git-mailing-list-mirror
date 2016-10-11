Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DEB21F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 18:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754209AbcJKSqC (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 14:46:02 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35491 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753613AbcJKSqA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 14:46:00 -0400
Received: by mail-oi0-f66.google.com with SMTP id d132so2004454oib.2
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 11:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=A/Tohqq9Zoh4/o6b1YBQuD1dVPDO0iJV1gdq6ggRvAc=;
        b=ldY2poMUOHQYdgOEO8gKhRFLTo3Ig/JZSfcaNmvxUyOLnCT/n93me/mu+bHhUA6+dP
         z+O8AjjutZ5ELjNie/1GHH/jsLgEF0vSVfoeicRM8Cd2jH76Hq4lR1eYjGTYSR3ySrUK
         XJ2+nxt2G5pFjyBWJ1smcKDMAMOjZSRmayZDzTjwqP4BHjipWQXDISEt15v2zx+ZDA0y
         8w/KTXIUrG1QvpdrY/oJx87/UKn/Hx8M51FB9azD9Ji9KWUMzLbFXnn8HCte8CF+KQmZ
         3whPeuNZRdSjFMGCrHdesgfmB4FN51groe/recw8++LgZ8ioxKx6gyu48pmR810wotn3
         p5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=A/Tohqq9Zoh4/o6b1YBQuD1dVPDO0iJV1gdq6ggRvAc=;
        b=Xp7VabrLYEp8k2HcYPhQFhS/ylKPl5Sv27nQ3frAr4z7BlSy98jVEkGkOisKYTUaY+
         5CHDs6T4GrMdSaTJxoKrDzqtMal0npG/Ji29QE7u1whT15E5u4aIc/6pJg41JhCuEjr/
         4ftgN8JP5p5LJRmzflWRzYwK7ANAYSbm0e6EE73z+Y3vQj2LXxU3LscbJTMmt+gIbxT4
         ieFQEmUj9kQa3Sk1SS6kJy31dR06nuVC2AtRtQi+XLnefgezp9GfnnCRXh8YgqG5dWNX
         1ePYQtn/fULCDUWju9mt+TexuUqzBzj1BQge0vO+4PmIJL8M3nKzwTguojf/HU4whDAQ
         g/7A==
X-Gm-Message-State: AA6/9RmHME+1j7IUbtjgTegi4yNzJ31WjoGkUI6D63tIpaquALcSCANjCCGzWY5HpkvsxMtS3J2YhfbMXKK04w==
X-Received: by 10.202.4.17 with SMTP id 17mr3749658oie.91.1476211559310; Tue,
 11 Oct 2016 11:45:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.21.198 with HTTP; Tue, 11 Oct 2016 11:45:58 -0700 (PDT)
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Oct 2016 11:45:58 -0700
X-Google-Sender-Auth: x8AD58yGQ6GjdLIDko3QEXBcO5Y
Message-ID: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
Subject: Allow "git shortlog" to group by committer information
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a113c088a9b5a01053e9b49cc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a113c088a9b5a01053e9b49cc
Content-Type: text/plain; charset=UTF-8

In some situations you may want to group the commits not by author,
but by committer instead.

For example, when I just wanted to look up what I'm still missing from
linux-next in the current merge window, I don't care so much about who
wrote a patch, as what git tree it came from, which generally boils
down to "who committed it".

So make git shortlog take a "-c" or "--committer" option to switch
grouping to that.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

--001a113c088a9b5a01053e9b49cc
Content-Type: text/plain; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iu5u8dz10

IGJ1aWx0aW4vc2hvcnRsb2cuYyB8IDE1ICsrKysrKysrKysrKy0tLQogc2hvcnRsb2cuaCAgICAg
ICAgIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2J1aWx0aW4vc2hvcnRsb2cuYyBiL2J1aWx0aW4vc2hvcnRsb2cu
YwppbmRleCBiYTBlMTE1NGEuLmM5NTg1ZDQ3NSAxMDA2NDQKLS0tIGEvYnVpbHRpbi9zaG9ydGxv
Zy5jCisrKyBiL2J1aWx0aW4vc2hvcnRsb2cuYwpAQCAtMTE3LDExICsxMTcsMTUgQEAgc3RhdGlj
IHZvaWQgcmVhZF9mcm9tX3N0ZGluKHN0cnVjdCBzaG9ydGxvZyAqbG9nKQogewogCXN0cnVjdCBz
dHJidWYgYXV0aG9yID0gU1RSQlVGX0lOSVQ7CiAJc3RydWN0IHN0cmJ1ZiBvbmVsaW5lID0gU1RS
QlVGX0lOSVQ7CisJc3RhdGljIGNvbnN0IGNoYXIgKmF1dGhvcl9tYXRjaFsyXSA9IHsgIkF1dGhv
cjogIiwgImF1dGhvciAiIH07CisJc3RhdGljIGNvbnN0IGNoYXIgKmNvbW1pdHRlcl9tYXRjaFsy
XSA9IHsgIkNvbW1pdDogIiwgImNvbW1pdHRlciAiIH07CisJY29uc3QgY2hhciAqKm1hdGNoOwog
CisJbWF0Y2ggPSBsb2ctPmNvbW1pdHRlciA/IGNvbW1pdHRlcl9tYXRjaCA6IGF1dGhvcl9tYXRj
aDsKIAl3aGlsZSAoc3RyYnVmX2dldGxpbmVfbGYoJmF1dGhvciwgc3RkaW4pICE9IEVPRikgewog
CQljb25zdCBjaGFyICp2OwotCQlpZiAoIXNraXBfcHJlZml4KGF1dGhvci5idWYsICJBdXRob3I6
ICIsICZ2KSAmJgotCQkgICAgIXNraXBfcHJlZml4KGF1dGhvci5idWYsICJhdXRob3IgIiwgJnYp
KQorCQlpZiAoIXNraXBfcHJlZml4KGF1dGhvci5idWYsIG1hdGNoWzBdLCAmdikgJiYKKwkJICAg
ICFza2lwX3ByZWZpeChhdXRob3IuYnVmLCBtYXRjaFsxXSwgJnYpKQogCQkJY29udGludWU7CiAJ
CXdoaWxlIChzdHJidWZfZ2V0bGluZV9sZigmb25lbGluZSwgc3RkaW4pICE9IEVPRiAmJgogCQkg
ICAgICAgb25lbGluZS5sZW4pCkBAIC0xNDAsNiArMTQ0LDcgQEAgdm9pZCBzaG9ydGxvZ19hZGRf
Y29tbWl0KHN0cnVjdCBzaG9ydGxvZyAqbG9nLCBzdHJ1Y3QgY29tbWl0ICpjb21taXQpCiAJc3Ry
dWN0IHN0cmJ1ZiBhdXRob3IgPSBTVFJCVUZfSU5JVDsKIAlzdHJ1Y3Qgc3RyYnVmIG9uZWxpbmUg
PSBTVFJCVUZfSU5JVDsKIAlzdHJ1Y3QgcHJldHR5X3ByaW50X2NvbnRleHQgY3R4ID0gezB9Owor
CWNvbnN0IGNoYXIgKmZtdDsKIAogCWN0eC5mbXQgPSBDTUlUX0ZNVF9VU0VSRk9STUFUOwogCWN0
eC5hYmJyZXYgPSBsb2ctPmFiYnJldjsKQEAgLTE0OCw3ICsxNTMsOSBAQCB2b2lkIHNob3J0bG9n
X2FkZF9jb21taXQoc3RydWN0IHNob3J0bG9nICpsb2csIHN0cnVjdCBjb21taXQgKmNvbW1pdCkK
IAljdHguZGF0ZV9tb2RlLnR5cGUgPSBEQVRFX05PUk1BTDsKIAljdHgub3V0cHV0X2VuY29kaW5n
ID0gZ2V0X2xvZ19vdXRwdXRfZW5jb2RpbmcoKTsKIAotCWZvcm1hdF9jb21taXRfbWVzc2FnZShj
b21taXQsICIlYW4gPCVhZT4iLCAmYXV0aG9yLCAmY3R4KTsKKwlmbXQgPSBsb2ctPmNvbW1pdHRl
ciA/ICIlY24gPCVjZT4iIDogIiVhbiA8JWFlPiI7CisKKwlmb3JtYXRfY29tbWl0X21lc3NhZ2Uo
Y29tbWl0LCBmbXQsICZhdXRob3IsICZjdHgpOwogCWlmICghbG9nLT5zdW1tYXJ5KSB7CiAJCWlm
IChsb2ctPnVzZXJfZm9ybWF0KQogCQkJcHJldHR5X3ByaW50X2NvbW1pdCgmY3R4LCBjb21taXQs
ICZvbmVsaW5lKTsKQEAgLTIzOCw2ICsyNDUsOCBAQCBpbnQgY21kX3Nob3J0bG9nKGludCBhcmdj
LCBjb25zdCBjaGFyICoqYXJndiwgY29uc3QgY2hhciAqcHJlZml4KQogCWludCBub25naXQgPSAh
c3RhcnR1cF9pbmZvLT5oYXZlX3JlcG9zaXRvcnk7CiAKIAljb25zdCBzdHJ1Y3Qgb3B0aW9uIG9w
dGlvbnNbXSA9IHsKKwkJT1BUX0JPT0woJ2MnLCAiY29tbWl0dGVyIiwgJmxvZy5jb21taXR0ZXIs
CisJCQkgTl8oIkdyb3VwIGJ5IGNvbW1pdHRlciByYXRoZXIgdGhhbiBhdXRob3IiKSksCiAJCU9Q
VF9CT09MKCduJywgIm51bWJlcmVkIiwgJmxvZy5zb3J0X2J5X251bWJlciwKIAkJCSBOXygic29y
dCBvdXRwdXQgYWNjb3JkaW5nIHRvIHRoZSBudW1iZXIgb2YgY29tbWl0cyBwZXIgYXV0aG9yIikp
LAogCQlPUFRfQk9PTCgncycsICJzdW1tYXJ5IiwgJmxvZy5zdW1tYXJ5LApkaWZmIC0tZ2l0IGEv
c2hvcnRsb2cuaCBiL3Nob3J0bG9nLmgKaW5kZXggNWEzMjZjNjg2Li41ZDY0Y2ZlOTIgMTAwNjQ0
Ci0tLSBhL3Nob3J0bG9nLmgKKysrIGIvc2hvcnRsb2cuaApAQCAtMTMsNiArMTMsNyBAQCBzdHJ1
Y3Qgc2hvcnRsb2cgewogCWludCBpbjI7CiAJaW50IHVzZXJfZm9ybWF0OwogCWludCBhYmJyZXY7
CisJaW50IGNvbW1pdHRlcjsKIAogCWNoYXIgKmNvbW1vbl9yZXBvX3ByZWZpeDsKIAlpbnQgZW1h
aWw7Cg==
--001a113c088a9b5a01053e9b49cc--
