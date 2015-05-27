From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/WIP PATCH 04/11] upload-pack-2: Implement the version 2 of upload-pack
Date: Wed, 27 May 2015 13:45:55 -0700
Message-ID: <CAGZ79kb6rsxpiXKg+eaVc+5bgUgPSaq+ocd-UHa=_K+rLxreTQ@mail.gmail.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-5-git-send-email-sbeller@google.com>
	<20150527063558.GB885@peff.net>
	<CAGZ79kYaoViDrz9TKXWebif4mfyUjzJ6b3id8ozTqtwsmjAC1A@mail.gmail.com>
	<20150527203451.GD14309@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 27 22:46:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxiDB-0004pz-O8
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 22:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbbE0Up6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 16:45:58 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:36539 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbbE0Up4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 16:45:56 -0400
Received: by qcxw10 with SMTP id w10so9331080qcx.3
        for <git@vger.kernel.org>; Wed, 27 May 2015 13:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OZ+53BJ6FqbRJIES0pQzzedwGNQG5xxuZONZ7Hawc5c=;
        b=JsFR7WGH6N/BywRlOYMiMagYAT0HTCmE0T4W0rNAg9UkDOJxvCPMRMUQK+dAlq4xce
         qFdwUwfvPxrUW5Dzgp2wMzlpnjZERX6oiPP2AZeyWIMTKuWVYDWKCJyhFsIkNpV9NIZo
         FNNJ2oOPE9s8oBliAq18Yj/DTPCRpB4ouW4praMYP6jZucBU5ofeohUAX54DcivieBZx
         w0rrDUyGRWVRn5fnQQ1LaHRVYGq8uiqYNUr41we2SfSmlQQZX28S/LBrntkiMk86qZBP
         lv4c0u9UXp/ok6zeFh1rX8aKQo4EjNnu16MYDgQVcRJijLT7XtH9Ysi3N9Ae2TickDFL
         zVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=OZ+53BJ6FqbRJIES0pQzzedwGNQG5xxuZONZ7Hawc5c=;
        b=AQfuxSLhsLbFXKReHkv2Om5mqaAwRv+iVk93JA4HB9YA3D3KEhHcoTa16ZyFrSxY4U
         ZJr0N/ejU1wFuvs/OusB+K4n9PxKkPygD2cd4ca9M3XJ5kTV6Db12ICMszdo6dxE9gtq
         Q5YJhbZC+JSG7YDCKIy5o/3cL0caNeRnN/Es1Hxp3hK/icPHAFY5szLwEo5dVuJFiUzJ
         7bCNB1MRt+u7EFKK1kYhHYC9AYi7sDXg2huvCKFFam+14rRqOx8P9O4Q+wE3bnShlCbL
         Quny/MAM8RA5aMMot/DKSjYhY24ApKPa25Pl8bvOsro9htg9L5n+7R2EICGK2xL5RaaW
         +t2Q==
X-Gm-Message-State: ALoCoQnVkBOvaa/HAxz4z4hnf6RNO2gJYAOpaG86xjy7fbKBrPzdG1+xugtWBGCp8V/zvcVgyHHP
X-Received: by 10.55.22.143 with SMTP id 15mr14242379qkw.85.1432759555834;
 Wed, 27 May 2015 13:45:55 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Wed, 27 May 2015 13:45:55 -0700 (PDT)
In-Reply-To: <20150527203451.GD14309@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270090>

On Wed, May 27, 2015 at 1:34 PM, Jeff King <peff@peff.net> wrote:
> On Wed, May 27, 2015 at 10:40:37AM -0700, Stefan Beller wrote:
>
>> > If we are upload-pack-2, should we advertise that in the capabilities? I
>> > think it may make things easier later if we try to provide some
>> > opportunistic out-of-band data. E.g., if see tell git-daemon:
>> >
>> >   git-upload-pack repo\0host=whatever\0\0version=2
>> >
>> > how do we know whether version=2 was understood and kicked us into v2
>> > mode, versus an old server that ignored it?
>>
>> So in my vision we would call git-upload-pack-2 instead of having a "version=2".
>> and if git-upload-pack-2 doesn't exist, the whole conversation is
>> over, the client
>> it is left to make up some good error message or retry version 1.
>
> I'd like for that to be a starting point for us, and then to be able to
> add-on "hints" to ease the transition path in whatever way we want. We
> may even not do that in the long run, but I want to leave the door open
> if we can.
>
>> But I think advertising both which versions the server could deal
>> with, as well as
>> the currently expected version is a good thing.
>>
>> capability: can_speak=1,2
>> capability: speaking_now=2
>
> I was thinking just "speaking_now=2", but it probably makes sense to do
> both. I do not think using it to "downgrade" will ever be particularly
> useful (certainly not from v2 to v1, since to understand the flag both
> sides must be v2 in the first place). But advertising that via the v1
> conversation will be a good way to tell the other side that upgrade is
> possible.

If for some reason we discover a flaw in the current version, which
makes it unusable
(a buffer overflow?, some stupid abuse which makes the capability list huge),
you may want to force downgrading (and in the very distant future when we are
current on version 4 and have dropped version 1 already, you can only downgrade
to 2 and 3, so I can see value in it.

Another idea to make it all more future proof:
"capability: speaking_now=2" must be sent as the first line, so then
you can adapt
on the client side easily for which version you are listening.

>
>> > Also, do we need the capability noise-word?
>>
>> I thought it opens up a new possible door in the future.
>> As we ignore anything not starting with "capability" for now, you
>> could introduce
>> your foo and bar ping pong easily and still be version 2 compatible.
>>
>> S: capability: thin
>> S: capability: another-capability
>> S: ping-pong foo
>> S: done
>> C: (not having understood ping-pong) just answering with capability: thin
>> C: done, let's proceed to refs advertisement
>>
>> The alternative client would do:
>>
>> C: ping-pong: foo-data1a
>> S: ping-pong: foo-data1b
>> C: ping-pong: foo-data2a
>> C: capability: thin
>> ...
>
> Right, but I think (and please correct me if there's a case I'm missing)
> that the behavior is the same whether it is spelled "ping-pong" or
> "capability:ping-pong". That is, the rule for "capability:" is "if you
> do not understand it, ignore it and do not mention it in your
> capabilities; the server is required to assume you were written before
> that capability was invented". But that is _also_ the rule for
> ping-pong, I think.

The rules are the same, right. But the allowed characters are limited
(in theory)
as the regular expressions given for the capabilities don't allow for
binary data
for example, but only well formed ASCII text, space separated.
The "ping-pong" keyword could introduce a binary stream there
including line feeds. (Today it sounds like a stupid idea though)

>
>> > Eric mentioned the underflow problems here, but I wonder even more:
>> > what's wrong with the global ends_with() that we already provide?
>>
>> I was missing knowledge we have that, and apparently I was thinking it's
>> faster to come up with my own version than to look for it. :)
>
> Makes sense. :)
>
> -Peff
