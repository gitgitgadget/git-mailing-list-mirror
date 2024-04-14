Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6D5224CC
	for <git@vger.kernel.org>; Sun, 14 Apr 2024 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713107865; cv=none; b=a5/FPfXYy0UH91sXSpR0AMR+4yQ6bdA1HfaMIaUvOyCUuINzeZo+R2USbA4Iocc0NlCn82B/Lm871YlNK7VK4Cc2vTL5SUnfSOIx78GbmX/dF24J2Q6jLhedtUBGWA0a+FPSw6rlYjZb3TNNS7yrgwpmA77iTKJGO/IH8Nh2BiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713107865; c=relaxed/simple;
	bh=w5oAaAT3T20vTdRaWM38Mp+3b1HXR1Ft0uSJoDVBYXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUKmSSxNgOXkbexzmPCrEuDciwHBdNHsWaMqBLS99q4yonNf/yqLx8JzmkkVHkiNRMahHIYzvYe1VwjsoRE6mc60hiInO2sUi5N28TKzuPFhIj8SP5qfilc9kwFHP7eGqnd/xSn+0cOACfdg1Gsye5YS3A2UmajpjpRj3ILR0Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=YiPvBLNU; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="YiPvBLNU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713107845; x=1713712645; i=l.s.r@web.de;
	bh=0WcE1UZMJkD5zPB4voT/SLFYHe/5ZpfHTrR+nKZIiME=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=YiPvBLNUp1XzM19ZoJuNPVzAeZXVq/mfG+QX+Yr5RnAdq010neJebn3zdh1AJmap
	 3l4kWU6LO8GJWhCTfPF+Lgp29bzO5bKfvTduuSYNiGBvwKt0bYrWQ0tdNIkeB3Sv3
	 gfS7Wgzkp3e9CtMaCi7LvfWpOvcMXOKfUl31P8zso4JWYtJqdmiq0Ynhv8MBJBQlt
	 9oL7j769PG4picMrUnRXM8IR8CkXn4KeYLCxliw9h5waHXXwjBfvgiCM4z5zrgQz1
	 oh+fHveQoHbimE90dvTb/j4DgB07I4CCOnz9o6mpZs7v5AHYmJ3exvO3UNUXp5fpw
	 N34GhgacySmbtTTGFg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N14tM-1ssdY63VIg-012r3l; Sun, 14
 Apr 2024 17:17:24 +0200
Message-ID: <10b7fff3-7a2c-4555-9210-8000aae43583@web.de>
Date: Sun, 14 Apr 2024 17:17:23 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: free and errno, was Re: [PATCH] apply: replace mksnpath() with a
 mkpathdup() call
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
References: <df774306-f29b-4a75-a282-59db89812b9a@web.de>
 <20240404225313.GA2512966@coredump.intra.peff.net>
 <14c99998-cc4a-4581-aab3-607d7fac7edb@web.de>
 <20240405173517.GA2529133@coredump.intra.peff.net>
 <0fc77134-94fb-4d60-95b4-509c3582e20f@web.de>
 <20240407011834.GA1085004@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240407011834.GA1085004@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XQ7lTMZ/y3g0KVjEIjs3lp3cMDIus9ZdC0/AbdawTdTY4tHIUZF
 lD7/lEBsTzp3rDL5aMWlJOUu69egLN4QL0Wb5TDvXUTSSo386zPxdCreHuqKPod2ewCrXuV
 cVvkwga2aPqM12vxdqNJxUAJcti1Dr1Pw5Z2ynF12WaitHN1WyIzLXnMhVopNf6SxVueZV4
 TVIsXrdpGYvH3yT9Lavjw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kTlTAdxKUVE=;1n6uUqZM5W0WmXyOtVoqZMhIE93
 Ip5HcLPUOXXczYlzH1VjkpOy7tYIHI3AN4rgTRuBmNcOSdkcvhBemt5nw9fH6rTmFtz5UJ3OT
 qoB2xFWioznm4SdcALKnIfn0IGI8ZSdIKypYAz4Lkv4hKzaAfPmFQRVubkyv1dS4NXwFVXPOM
 xxfp4NzCxtBiWa5sRqoXGIkoBOn83GzhRB8xeWyC22t1ZY06mOsbHTOC9yfDSbfwBogwdq2qv
 yRWZevGpMA7Uc6l0+JR4TWrGzsozMj6g4hl10F9rmNFYps1dKubaeDt5SfGgtwRO2bmFBiT31
 BkmAwzwmUCQkLwF7/u5+3K9KN8hKvA7kagAViAVlHzo+oOg9Q9DI1RwUMoQeE3LtY1tSkfXim
 AjimXwb2eMErvMvgXHMz07P5CWc8yYvd9S2ewlzIg/9LRIl2mt9E56UIKTZnhIXo5a5wbWVsz
 z47kBmeughOdePMDJ2rPnAV3656PwWVY5yzzax4rA0YxLil8uzTuhl+1y5rrTAeyfAFrdseGi
 d61MqWNxuxDN5iyWpphc7oCuC0vCLYU78Vh7BTtJNStD7LZo4rZUWgqnZbmzG6kbAjYMDTHJL
 8FMTOC3cQt8I5meh5h/nn2QEiwvWStAFPo51Uq9tsyglqt8mWuATY50YW6v6ppEWSsF5IK8Gu
 zE1nZzIbuMX+ghOLnAdlu3MZmhjmDilKTU5Ic0voSuw/WCnXnK5wJOoupPXVRZRphhlBB2wkr
 9iCYeGfVM4/Rpqc9NUnwvuwUsx6+i5K8dDPQbPuLH69Uzz4Y94nbU5OqRuHeTXgB5uLrizJXz
 p3OTXNo9lT/3X7GbZ9DmjbGPPAZb/bHXRcpSRjP1pCAm4=

Am 07.04.24 um 03:18 schrieb Jeff King:
> On Sat, Apr 06, 2024 at 07:45:17PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> I calmed down a bit now.  And ask myself how widespread the issue actua=
lly
>> is.  Used the following silly Coccinelle rule to find functions that us=
e
>> errno after a free(3) call:
>>
>> @@
>> @@
>> - free(...);
>>   ...
>>   errno
>>
>> Found only a handful of places, and they all set errno explicitly, so
>> they are fine.
>
> Is that enough, though? Imagine I have:
>
>   int foo(const char *x)
>   {
>      char *y =3D xstfrmt("something/%s", x);
>      int fd =3D open(y, ...);
>      free(y);
>      return fd;
>   }
>
> Then errno is important if some caller of foo() checks errno after foo()
> returns an error. And that caller might not even be in the same file.

Yes.

> In other words, it really depends on the contract of foo() with respect
> to errno. And I don't think there is a way in C to specify that
> contract in away that the compiler can understand.

The context attribute of sparse could be used, I guess.  We'd have to
duplicate the declaration of all library functions, though, to tag them
with a may_have_changed_errno attribute.  And we'd need to clear it on
success, so we'd have to modify all callers.  On the flip side it would
allow detecting consecutive errno changes, e.g. by two I/O functions
with no error checking in between.  But the implementation effort seems
way too high.

It would be easier if the error information was in one place instead of
one bit in the return value (NULL or less than 0) and the rest in errno.

>> No idea how to match any use of errno except assignment.  And no idea h=
ow
>> to find indirect callers of free(3) that use errno with no potential
>> assignment in between.
>
> Yeah, I guess the indirect callers of free() are really the flip-side.
> My example was indirect users of errno. ;)

Indeed.

>>> The other reason is that macros (especially of system names) can creat=
e
>>> their own headaches.  We could require xfree() everywhere as a
>>> complement to xmalloc (or maybe even just places where the errno
>>> preservation seems useful), but that's one more thing to remember.
>>
>> An xfree() to go along with xmalloc()/xrealloc()/xcalloc()/xstrdup() wo=
uld
>> fit in nicely and might be easier to remember than free() after a while=
.
>> Having to convert thousands of calls is unappealing, though.
>
> My biggest concern with it is that we'd have to remember to use it, and
> there's not good compiler enforcement. But I guess coccinelle can help
> us there.q

Yes, converting all free(3) calls is easy with Coccinelle, and the same
semantic patch can be used to enforce the use of xfree().  Still the
initial diff would be huge (2000+ changed lines in 300+ files).

> My secondary concern is that it might make people think that xmalloc()
> and xfree() are always paired, and thus you can do clever things in one
> as long as the other matches it. But we sometimes free memory from
> system routines like getline(). Maybe a scary comment would be enough?

Amazing foresight!  Currently we only use getline(3) (which can act like
realloc(3)) in contrib/credential/, though.  Any others?

The "x" prefix doesn't promise exclusivity (hermetic seal?), but it
certainly suggests there are some shared feature between the allocator
functions and xfree(), while they only have in common that the are
wrapped.  We could call the latter errno_preserving_free() instead or so.

I'm more worried about the overhead.  For a 0-1% slowdown (in the case of
git log) git_free() or xfree() give us accurate error numbers on all
platforms.  Non-misleading error codes are worth a lot (seen my share of
cursed messages), but xfree() is only necessary in the error handling
code.  The happy path can call free(3) directly without harm.

But how to classify call sites accordingly?  It's easy for programmers
once they know it's necessary.  Is there a way in C, macro or Coccinelle
to have our cake and only eat it if really needed?  I don't see any. :-|

>> Found four places that did not expect free(3) to mess up their errno by
>> running the test suite with that.  Patch below.
>
> These are perhaps worth fixing (though not if we come up with a
> universal solution). But I'd be surprised if they are the only ones. By
> its nature, this problem only manifests when there are actual errors,
> and our test suite is mostly checking happy paths. So I'd assume there
> are a ton of "if (ret < 0) { free(foo); return -1; }" spots that are
> simply not exercised by the test suite at all.

Makes sense.

Ren=C3=A9
