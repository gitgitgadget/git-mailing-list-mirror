Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0057DC433EF
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 16:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDEB16101E
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 16:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240665AbhJPQ1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 12:27:50 -0400
Received: from mout.web.de ([212.227.15.4]:51935 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240663AbhJPQ1o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 12:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1634401522;
        bh=5R2fvaPeCqFirHkJZ1cX2Eap/rM2wYION8yuWctNppI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jkBd3cciGEI8VQs404GC2Y2o3ZbCJJtkRcNeZw4T1D7LG2c2h5qVnVgiuRJZ0/9tO
         JJUSDQZ0k9cPVXhay+el9qnM3BAMLAcA0vzK2y7CVyp9J7VpDkUCNZ07ZSN45+r4HN
         W+3pV7QObNxyN7q/piCFCBY82aYi9PsPiniRXDCM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0Mg1Nl-1mPrqW3Tb3-00NRbV; Sat, 16 Oct 2021 18:25:21 +0200
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
To:     Junio C Hamano <gitster@pobox.com>,
        Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20211015161356.3372-1-someguy@effective-light.com>
 <20211015161356.3372-3-someguy@effective-light.com>
 <xmqq4k9i5a4n.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <eddcbe66-b172-90b7-309e-e9ce5b5b44a4@web.de>
Date:   Sat, 16 Oct 2021 18:25:20 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq4k9i5a4n.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W1qS/wEEv9Y3LTJaQVujARKwJOde4KYujvcID+MKM8p7Qvu4bvA
 ZDClRU6aPk7FkmwZ53y0Rl2zRsUr/e/O3dLUXQRlD1zPmJBAdfyKeB4zkDEgz00Q4ZPCae+
 G9X78sTCPul8qVXMkCgdmMWZ04wFDrx73RUYU2Re9Wb1v5G7yzJIvpKM320Wcb3OC/PcyVd
 W9RyqSPVSQyQIp4HDWVyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tH9YHooI3WA=:hN/6Q2sj99FDmpQtsxcXnS
 lmXIXRKWklgQ11F6/Xm8MBUfMZlYQRUqxaTRJvYPVUTAjIzGKn0crfXKR0sn8NHwXFY6WH1lk
 ok+DpoKYstEfk2wiMfo7lMslTum1U9nmLDDMzj1VFCqKiymVIU0CWNZ4qIAz4A2PZ2QlDX2c6
 EerhghmrTquSubuX/z5LJlZ5mBy0myWCSB1817TMfQkaojK1CA+FyafTMo7BsT7b/UkPJg0xT
 q1QaLVKDymR2bRMQjwY/YTKMvelZUBS/8ORTCYcXzBIDmrIYTzZ6QW1EepXzwj4wD2cK2Q4X8
 pSHT10hFQOCof+XrnrYseTsawwS2seR6q2jMEKqkVvgo16SKShVy1mtEIKopxMBdIS8p+Odd7
 CIOdnih8WHTjTBwcD+NgjvBdSAmyvNt2+8Mm/G4AuEZTVgviGLFBKY91pOWnEjM9dq1sVPKGf
 F3I0L/V7ZPuvZr/v9Y8YxOkDDnlxDovSfdn01JE9fYTaQVQp9BfiQfXewe8uWeBPt3RIr6nC9
 2iEVlh+f6qMInxSSNWyd2oubDhqRDkmNixDU9u6C7gYjJbOQsd/pvBGakGeM24h7RryXhjyjz
 z/uRonp4U3P6TB/EDAhHVgYLnb+YyPVGeFzCUkUTte+C4ePyUmronChMWcvXcGD8u1gHfX3su
 KcPfK5/LPoXKTJy9cU1O54LmKYVYXZHdOOD9GC2NuNoeD0nX/+wJXHX+yTC2d4UPT2ZoMGOqx
 +bRWRN0NoS5hxbzngJ/FD30C/cJTv4YJHtRcuRdhjOYJtY+gZXeY3wVNeDHF2gbKzSHihioQA
 iQggMHjl0D3C4cq7nfYRd64gxx3aj0ByYvu/5jykQ8tlTn33mx5qRzt0opt7tL+9c9iOO6g8F
 zLJiWvT57ONTbvpOZIJKp/CSjhB/CGl7s5i8Pew8hAxdyLJeOBT7qdVOgw1jGcc8S+zNimCw6
 TsSMoUsgnOc2KM//dd4/gNebEyVYCKnUThYoq08Y1iWhlmCtExwJSsox86m4VBwEV5cOyJAA8
 KIMXnFvcl0/jvZZ8S22Fnf1vBIvG1KxkMlcVIUJ36gvCXGtX3a6QiH11RdUyf2sBkA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.10.21 um 22:03 schrieb Junio C Hamano:
> Hamza Mahfooz <someguy@effective-light.com> writes:
>
>> If we attempt to grep non-ascii log message text with an ascii pattern,=
 we
>
> "with an ascii pattern, when Git is built with and told to use pcre2, we=
"
>
>> run into the following issue:
>>
>>     $ git log --color --author=3D'.var.*Bjar' -1 origin/master | grep ^=
Author
>>     grep: (standard input): binary file matches

I get no error message on macOS 11.6, but this result, with the underlined
part in red:

   Author: ??var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
            ^^^^^^^^^^^^^^^^^^

So the pattern matches the second byte of a two-byte character, inserts a
color code in the middle and thus produces invalid output in this case.

>>
>> So, to fix this teach the grep code to use PCRE2_UTF, as long as the lo=
g
>> output is encoded in UTF-8.
>
>> -	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->patte=
rn) &&
>> -	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
>> +	if ((!opt->ignore_locale && !has_non_ascii(p->pattern)) ||
>> +	    (!opt->ignore_locale && is_utf8_locale() &&
>> +	     has_non_ascii(p->pattern) && !(!opt->ignore_case &&
>> +					    (p->fixed || p->is_fixed))))
>
> That's a mouthful.  It is not obvious what new condition is being
> added.  I had to flip the order to see the only difference is, that
>
>> -	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->patte=
rn) &&
>> -	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
>> +	if ((!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->patt=
ern) &&
>> +	    !(!opt->ignore_case && (p->fixed || p->is_fixed))) ||
>> +	    (!opt->ignore_locale && !has_non_ascii(p->pattern)))
>
> ... in addition to the case where the original condition holds, if
> we do not say "ignore locale" and the pattern is ascii-only, we
> apply these two option flags.  And that matches what the proposed
> log message explained as the condition the problem appears.
>
> So,... looks good, I guess.
>
> Thanks, will queue.
>
>
> Addendum.
>
> If we were reordering pieces in the condition, I wonder if there is
> a better way to reorganize it, though.  The original is already
> barely explainable with words, and with this new condition added, I
> am not sure if anybody can phrase the condition in simple words to
> others after staring it for a few minutes.  I can't.
>
> But straightening it out is best left as a future clean-up patch,
> separate from this series.
>

It can be written as:

	literal =3D !opt->ignore_case && (p->fixed || p->is_fixed);
	if (!opt->ignore_locale) {
		if (!has_non_ascii(p->pattern) ||
		    (is_utf8_locale() && !literal))
			options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
	}

Literal patterns are those that don't use any wildcards or case-folding.
If the text is encoded in UTF-8 then we enable PCRE2_UTF either if the
pattern only consists of ASCII characters, or if the pattern is encoded
in UTF-8 and is not just a literal pattern.

Hmm.  Why enable PCRE2_UTF for literal patterns that consist of only
ASCII chars?

The old condition was (reformatted to better match the new one):

	if (!opt->ignore_locale) {
		if (is_utf8_locale() && has_non_ascii(p->pattern) && !literal)
			options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
	}

Intuitively I'd say the condition should be:

	if (!opt->ignore_locale && is_utf8_locale()) {
		if (has_non_ascii(p->pattern) || !literal)
			options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
	}

If both input and pattern are encoded in UTF-8, enable PCRE2_UTF if we
have to match non-ASCII characters or do more than just literal
matching.

For literal patterns that consist only of ASCII characters we don't need
the cost and complication of PCRE2_UTF.

Makes sense?

Ren=C3=A9
