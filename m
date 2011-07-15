From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git commit generation numbers
Date: Fri, 15 Jul 2011 16:10:23 -0700
Message-ID: <CA+55aFzE-okH9gaEyuSFdorK-7v3odpsk65ZTqCMHFz80n65ug@mail.gmail.com>
References: <20110714183710.GA26820@sigill.intra.peff.net> <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
 <20110714190844.GA26918@sigill.intra.peff.net> <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
 <20110714200144.GE26918@sigill.intra.peff.net> <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
 <20110714203141.GA28548@sigill.intra.peff.net> <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
 <20110715074656.GA31301@sigill.intra.peff.net> <CA+55aFzS3KDNvKt-dXvYpuAQwFwD3+GCj8y8bRQCycPvrynT8Q@mail.gmail.com>
 <20110715194807.GA356@sigill.intra.peff.net> <CA+55aFx0KyAZRsy7gZ3Z4woWC-uWcLu11gcUrR+9MJR5NOSkrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015175cfc464104c904a823c231
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 16 01:10:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhrX3-0002kR-6h
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 01:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585Ab1GOXKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 19:10:48 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35812 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752839Ab1GOXKr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2011 19:10:47 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p6FNAjfB003019
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 15 Jul 2011 16:10:46 -0700
Received: by wyg8 with SMTP id 8so1096355wyg.19
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 16:10:43 -0700 (PDT)
Received: by 10.216.237.131 with SMTP id y3mr968996weq.87.1310771443205; Fri,
 15 Jul 2011 16:10:43 -0700 (PDT)
Received: by 10.216.158.65 with HTTP; Fri, 15 Jul 2011 16:10:23 -0700 (PDT)
In-Reply-To: <CA+55aFx0KyAZRsy7gZ3Z4woWC-uWcLu11gcUrR+9MJR5NOSkrA@mail.gmail.com>
X-Spam-Status: No, hits=-102.887 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177241>

--0015175cfc464104c904a823c231
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Jul 15, 2011 at 2:17 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> For example, for the "git tag --contains" thing, what's the
> performance effect of just skipping tags that are much older than the
> commit we ask for?

Hmm.

Maybe there is something seriously wrong with this trivial patch, but
it gave the right results for the test-cases I threw at it, and passes
the tests.

Before:

   [torvalds@i5 linux]$ time git tag --contains v2.6.24 > correct

   real	0m7.548s
   user	0m7.344s
   sys	0m0.116s

After:

   [torvalds@i5 linux]$ time ~/git/git tag --contains v2.6.24 > date-cut-off

   real	0m0.161s
   user	0m0.140s
   sys	0m0.016s

and 'correct' and 'date-cut-off' both give the same answer.

The date-based "slop" thing is (at least *meant* to be - note the lack
of any extensive testing) "at least five consecutive commits that have
dates that are more than five days off".

Somebody should double-check my logic. Maybe I'm doing something
stupid. Because that's a *big* difference.

                     Linus

--0015175cfc464104c904a823c231
Content-Type: text/x-patch; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gq5rg4na0

IGNvbW1pdC5jIHwgICA0MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0KIDEgZmlsZXMgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9jb21taXQuYyBiL2NvbW1pdC5jCmluZGV4IGFjMzM3YzdkN2RjMS4uMGQzM2Mz
M2E2NTIwIDEwMDY0NAotLS0gYS9jb21taXQuYworKysgYi9jb21taXQuYwpAQCAtNzM3LDE2ICs3
MzcsNTYgQEAgc3RydWN0IGNvbW1pdF9saXN0ICpnZXRfbWVyZ2VfYmFzZXMoc3RydWN0IGNvbW1p
dCAqb25lLCBzdHJ1Y3QgY29tbWl0ICp0d28sCiAJcmV0dXJuIGdldF9tZXJnZV9iYXNlc19tYW55
KG9uZSwgMSwgJnR3bywgY2xlYW51cCk7CiB9CiAKKyNkZWZpbmUgVklTSVRFRCAoMSA8PCAxNikK
Kworc3RhdGljIGludCBpc19yZWN1cnNpdmVfZGVzY2VuZGFudChzdHJ1Y3QgY29tbWl0ICpjb21t
aXQsIHN0cnVjdCBjb21taXQgKnRhcmdldCkKK3sKKwlpbnQgc2xvcCA9IDU7CisJcGFyc2VfY29t
bWl0KHRhcmdldCk7CisJZm9yICg7OykgeworCQlzdHJ1Y3QgY29tbWl0X2xpc3QgKnBhcmVudHM7
CisJCWlmIChjb21taXQgPT0gdGFyZ2V0KQorCQkJcmV0dXJuIDE7CisJCWlmIChjb21taXQtPm9i
amVjdC5mbGFncyAmIFZJU0lURUQpCisJCQlyZXR1cm4gMDsKKwkJY29tbWl0LT5vYmplY3QuZmxh
Z3MgfD0gVklTSVRFRDsKKwkJcGFyc2VfY29tbWl0KGNvbW1pdCk7CisJCWlmIChjb21taXQtPmRh
dGUgKyA1KjI0KjYwKjYwIDwgdGFyZ2V0LT5kYXRlKSB7CisJCQlpZiAoLS1zbG9wIDw9IDApCisJ
CQkJcmV0dXJuIDA7CisJCX0gZWxzZQorCQkJc2xvcCA9IDU7CisJCXBhcmVudHMgPSBjb21taXQt
PnBhcmVudHM7CisJCWlmICghcGFyZW50cykKKwkJCXJldHVybiAwOworCQljb21taXQgPSBwYXJl
bnRzLT5pdGVtOworCQlwYXJlbnRzID0gcGFyZW50cy0+bmV4dDsKKwkJd2hpbGUgKHBhcmVudHMp
IHsKKwkJCWlmIChpc19yZWN1cnNpdmVfZGVzY2VuZGFudChwYXJlbnRzLT5pdGVtLCB0YXJnZXQp
KQorCQkJCXJldHVybiAxOworCQkJcGFyZW50cyA9IHBhcmVudHMtPm5leHQ7CisJCX0KKwl9Cit9
CisKK3N0YXRpYyBpbnQgaXNfZGVzY2VuZGFudChzdHJ1Y3QgY29tbWl0ICpjb21taXQsIHN0cnVj
dCBjb21taXQgKnRhcmdldCkKK3sKKwlpbnQgcmV0ID0gaXNfcmVjdXJzaXZlX2Rlc2NlbmRhbnQo
Y29tbWl0LCB0YXJnZXQpOworCWNsZWFyX2NvbW1pdF9tYXJrcyhjb21taXQsIFZJU0lURUQpOwor
CXJldHVybiByZXQ7Cit9CisKIGludCBpc19kZXNjZW5kYW50X29mKHN0cnVjdCBjb21taXQgKmNv
bW1pdCwgc3RydWN0IGNvbW1pdF9saXN0ICp3aXRoX2NvbW1pdCkKIHsKIAlpZiAoIXdpdGhfY29t
bWl0KQogCQlyZXR1cm4gMTsKKwogCXdoaWxlICh3aXRoX2NvbW1pdCkgewogCQlzdHJ1Y3QgY29t
bWl0ICpvdGhlcjsKIAogCQlvdGhlciA9IHdpdGhfY29tbWl0LT5pdGVtOwogCQl3aXRoX2NvbW1p
dCA9IHdpdGhfY29tbWl0LT5uZXh0OwotCQlpZiAoaW5fbWVyZ2VfYmFzZXMob3RoZXIsICZjb21t
aXQsIDEpKQorCQlpZiAoaXNfZGVzY2VuZGFudChjb21taXQsIG90aGVyKSkKIAkJCXJldHVybiAx
OwogCX0KIAlyZXR1cm4gMDsK
--0015175cfc464104c904a823c231--
