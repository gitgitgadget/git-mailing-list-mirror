Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF22C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 22:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE2F6124C
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 22:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbhKJWRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 17:17:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54236 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbhKJWOV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 17:14:21 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0888D15B97E;
        Wed, 10 Nov 2021 17:11:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ENWA8YwRcaSr
        Z1BDoWrWaoTs7t/oofQW1ri98gzcxOw=; b=UnuFeBrZQGf7lI15mE3wsA3tkZ+g
        QyYLVJ7+BKTHkzWkCz/UUGzr+MuYRH1sMTmbfMqT3TsoJB8imtD4LzoYVtqw/JNR
        SpAa9uA/GPeZKPXE7puwPYzHveH8ky9pXe/aD2iiJGw+llzde5JZZErLv8VaJsRc
        fxgdSCTgd2A120A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 00F5115B97D;
        Wed, 10 Nov 2021 17:11:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 46B5F15B97B;
        Wed, 10 Nov 2021 17:11:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, fs@gigacodes.de
Subject: Re: [PATCH] RelNotes: mention known crasher when ssh signing with
 OpenSSH 8.7
References: <YYtgD8VT/0vuIHRX@coredump.intra.peff.net>
        <20211110093912.4382-1-carenas@gmail.com> <xmqqczn7y9kh.fsf@gitster.g>
Date:   Wed, 10 Nov 2021 14:11:29 -0800
In-Reply-To: <xmqqczn7y9kh.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        10 Nov 2021 13:39:26 -0800")
Message-ID: <xmqqmtmbwtim.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 28191754-4273-11EC-B925-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
>
>> As discussed[1] earlier, make sure there are no surprises when ssh-key=
gen
>> crashes on some users of OpenSSH 8.7 that are trying ssh signing.
>>
>> [1] https://lore.kernel.org/git/xmqqsfycs21q.fsf@gitster.g/
>>
>> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
>> ---
>>  Documentation/RelNotes/2.34.0.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/RelNotes/2.34.0.txt b/Documentation/RelNote=
s/2.34.0.txt
>> index effab2ea4b..54dcc7240d 100644
>> --- a/Documentation/RelNotes/2.34.0.txt
>> +++ b/Documentation/RelNotes/2.34.0.txt
>> @@ -8,6 +8,9 @@ Backward compatibility notes
>> =20
>>   * The "--preserve-merges" option of "git rebase" has been removed.
>> =20
>> + * The upcoming ssh signing feature is broken if used together with
>> +   OpenSSH 8.7, avoid using it if you cannot update to OpenSSH 8.8
>> +   (or stay at 8.6)
>
> That may be correct, but it is NOT a backward compatibility note.

So, here is what I plan to do.

diff --git c/Documentation/RelNotes/2.34.0.txt w/Documentation/RelNotes/2=
.34.0.txt
index effab2ea4b..6ed8b92e10 100644
--- c/Documentation/RelNotes/2.34.0.txt
+++ w/Documentation/RelNotes/2.34.0.txt
@@ -77,7 +77,10 @@ UI, Workflows & Features
  * "git fsck" has been taught to report mismatch between expected and
    actual types of an object better.
=20
- * Use ssh public crypto for object and push-cert signing.
+ * In addition to GnuPG, ssh public crypto can be used for object and
+   push-cert signing.  Note that this feature cannot be used with
+   ssh-keygen from OpenSSH 8.7, whose support for it is broken.  Avoid
+   using it unless you update to OpenSSH 8.8.
=20
  * "git log --grep=3Dstring --author=3Dname" learns to highlight hits ju=
st
    like "git grep string" does.
