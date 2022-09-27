Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C717C6FA83
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 19:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiI0TTP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 15:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiI0TTM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 15:19:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751E3EFF6D;
        Tue, 27 Sep 2022 12:19:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v28so3651208wrd.3;
        Tue, 27 Sep 2022 12:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=LI28KEyglkt9mSQRsK1ycWtz6zlci0uaNakhI4R5LKM=;
        b=B+OWy5Sx+bkeoAb73Q5bMGDXVzm6ePnTOCy3GGRy6kvrHUFB62bjCvgL8OtnMeMLpQ
         0C5MA+NMCJptjmtI9aKzUfib3hMVpAbIi6W0rE0IHZ7sHbcUF5w/g2UZrhAFn16lia1l
         S0qJSy5eFyfnW2ObkBk1iCGxCxWCfAud4k//YEamTh6SqDwSwGOcZW7Albwv6wFijxW/
         qOFwJUTdizb5QdVSINSG9om+KWCiNVGkJ/qbstjxzvtCOW8Mukc/++uHHjaE/cBAEihC
         z4rVqFYxycXDuhaFbEnuNT9lN6mLQQhQdLf3aGzqqJtRP3/wo6BqyzW4eVmpFH6AyrhI
         tpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=LI28KEyglkt9mSQRsK1ycWtz6zlci0uaNakhI4R5LKM=;
        b=bvX+9zAjFjqrt10AzgIGMljqnUB22yHHzW1UAQWeKWH/F5YgZArLN6XHP2c+Uq7P0u
         e4+4As2k4g/KcTw7NC7UorLAAbO56Sipl2loE3aXAB+ygF5lbIMHLo4FVQhI4dgq/XWt
         yCJgMnQDkuluYoUhVxxrUu/5G/ZiWvEMCtywxBp9bwC3ztInExTpa+w2HQl0F80iU7sY
         JZEiTGZ81CS2PVgrXJJOWjuzDRkdmBMmRiMCWIJA3CZYwqFLb91roMq2iFaDTvnY4uD5
         bBIgoqIoAjEyhvVWfIWD7XxK8J8vJvpq6NJcgLNo5FV7hZOB3hH9PYliJyX8Pafrg7ER
         a/5w==
X-Gm-Message-State: ACrzQf1LGrA959NkmF5QBiNx+cWgfhg8/KQZNwwJBbw0wiVV1t7q4pxb
        vVhOzmVx7XH8Q3IrLKSypUcBhl0/k/o=
X-Google-Smtp-Source: AMsMyM6nFrnm9w+FxUFClBeMsHE/SKFFOvKwNnmJWsd83MbnYuEkFVw/Fiei0Yuql0qz3nsPclPBZg==
X-Received: by 2002:a5d:65ce:0:b0:228:d8b6:d1 with SMTP id e14-20020a5d65ce000000b00228d8b600d1mr18105988wrw.486.1664306349887;
        Tue, 27 Sep 2022 12:19:09 -0700 (PDT)
Received: from [192.168.43.80] ([31.221.140.113])
        by smtp.gmail.com with ESMTPSA id j10-20020adfe50a000000b0022cc5c03d07sm382707wrm.53.2022.09.27.12.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 12:19:09 -0700 (PDT)
Sender: Alejandro Colomar <alx.mailinglists@gmail.com>
Message-ID: <c8287618-30c4-f14b-8ad7-898fee99d944@gmail.com>
Date:   Tue, 27 Sep 2022 21:19:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: readpassphrase(3) in glibc, and agetpass() (Was: Is getpass(3) really
 obsolete?)
Content-Language: en-US
To:     Zack Weinberg <zack@owlfolio.org>,
        Theo de Raadt <deraadt@openbsd.org>, rsbecker@nexbridge.com,
        'linux-man' <linux-man@vger.kernel.org>, tech@openbsd.org,
        Florian Weimer <libc-alpha@sourceware.org>, git@vger.kernel.org
References: <a0371f24-d8d3-07d9-83a3-00a4bf22c0f5@gmail.com>
 <73ac38a2-c287-4cc1-4e9c-0f9766ac4c0c@gmail.com>
 <00d501d7ccbe$0169c340$043d49c0$@nexbridge.com>
 <63238.1635515736@cvs.openbsd.org>
 <6d8642e9-71f7-4a83-9791-880d04f67d17@www.fastmail.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <6d8642e9-71f7-4a83-9791-880d04f67d17@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Zack,

On 10/29/21 16:53, Zack Weinberg via Libc-alpha wrote:
> On Fri, Oct 29, 2021, at 9:55 AM, Theo de Raadt wrote:
>> <rsbecker@nexbridge.com> wrote:
>>> On October 29, 2021 7:29 AM, Alejandro Colomar wrote:
>>>> On 10/29/21 13:15, Alejandro Colomar wrote:
>>>>> Hi,
>>>>>
>>>>> As the manual pages says, SUSv2 marked it as LEGACY, and POSIX doesn't
>>>>> have it at all.  The manual page goes further and says "This function
>>>>> is obsolete. Do not use it." in its first lines.
> ...
>> The community finally had the balls to get rid of gets(3).
>>
>> getpass(3) shares the same flaw, that the buffer size isn't passed.
>> This has been an issue in the past
> 
> I was about to post exactly the same thing.  getpass(3) is not deprecated because there's a better replacement, it's deprecated because it's _unsafe_.  The glibc implementation wraps getline(3) and therefore  doesn't truncate the passphrase or overflow a fixed-size buffer, no matter how long the input is, but portable code cannot rely on that.  And come to think of it, using getline(3) means that prefixes of the passphrase may be left lying around in malloc's free lists.
> 
> (getpass also cannot be made thread safe, due to recycling of a static buffer, but a program in which multiple threads are racing to prompt the user for passwords would be a UX disaster anyway, so I don't think that's a critical flaw the way it is for e.g. strtok(3).)
> 
> The Linux manpage project's documentation is, as I understand it, for Linux with glibc _first_, but not _only_; it should not describe this function as not-deprecated just because glibc has patched its worst problems and doesn't offer any better API.
> 
>> readpassphrase(3) has a few too many features/extensions for my taste, but
>> at least it is harder to abuse.
> 
> I am inclined to agree that readpassphrase has too many knobs, and I can't think of any legitimate present-day use for several of them, which is not a good property for an API handling security-critical data.  Also, it relies on the caller to size the buffer for the passphrase, and therefore risks truncating people's passphrases.
> 
> With my libxcrypt hat on I've thought a bit about replacements for getpass.  The conclusion I came to is that the easy changes are all putting lipstick on a pig, and if I was going to work on this at all I was going to design a privilege-separated authentication service that could be asked to take over a tty, read a passphrase, check it, and return just success or failure to the caller.  Neither the passphrase itself, nor any strings derived from it, would ever be in the caller's address space.  But this is obviously well out of scope for the C library.
> 
> zw

I happen to be working on replacing getpass(3) in shadow-utils.  As 
there is no replacement in glibc, I'm making the code depend on libbsd 
on GNU systems.

I developed a function similar to getpass(3), but which allocates a 
buffer (similar to asprintf(3)).  I only allocate once, and bail out if 
the password exceeds PASS_MAX, so no leaks in allocated memory (modulo 
bugs that I may have not noticed).

I also enforce both clearing and freeing the memory, by requiring a 
specific clean-up function.

The prototypes for the function and the clean-up are:

```
void erase_pass(char *p);
[[gnu::malloc(erase_pass)]] char *shdw_getpass(const char *prompt);

```

And the implementation is:

```
#include "prototypes.h"

#include <limits.h>
#include <readpassphrase.h>
#include <stdio.h>
#include <stdlib.h>


#if !defined(PASS_MAX)
#define PASS_MAX  BUFSIZ
#endif


char *
agetpass(const char *prompt)
{
	char    *p;
	size_t  len;

	p = malloc(PASS_MAX);
	if (p == NULL)
		return NULL;

	if (readpassphrase(prompt, p, PASS_MAX, 0) == NULL)
		goto fail;

	len = strlen(p);

	if (len == 0)
		return p;

	if (p[len - 1] != '\n')
		goto truncated;

	p[len - 1] = '\0';

	return p;

truncated:
	memzero(p, PASS_MAX);
fail:
	free(p);
	return NULL;
}


void
erase_pass(char *p)
{
	if (p != NULL)
		memzero(p, PASS_MAX);
	free(p);
}
```


Would you mind implementing readpassphrase(3) in glibc so that it's 
easier to use something safe and portable without resorting to 
compatibility libraries?  Also, I'd like some review of this function, 
if you think the API could be improved.  Maybe agetpass() would be a 
simple almost-drop-in replacement for getpass(3), so if you like it for 
glibc, let's discuss it.

I chose a predefined buffer size to not have to pass a buffer size all 
the time, which could be error-prone.  I also allocated the buffer 
internally, to make it easier to replace getpass(3).  It may be 
desirable to use existing buffers, and pass them through a pointer, but 
for shadow-utils, it was simpler to keep the getpass(3) API.

I don't know what was the practice with PASS_MAX regarding the NUL byte, 
but to avoid creating a buffer of a power of two plus one, I decided 
that the NUL byte would be within PASS_MAX.  Another solution would be 
to declare PASS_MAX to be something like BUFSIZ-1, and then use 
PASS_MAX+1, but I opted for simplicity.

What are your thoughts?

Cheers,

Alex
