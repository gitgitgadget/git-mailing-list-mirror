Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E72A71F42D
	for <e@80x24.org>; Mon, 28 May 2018 02:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752981AbeE1ClU (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 22:41:20 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37488 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752952AbeE1ClT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 22:41:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id l1-v6so28148647wmb.2
        for <git@vger.kernel.org>; Sun, 27 May 2018 19:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=F8dszMjZD03b+F041h4BXDxPxbN2EHN5JVY+9hVIq00=;
        b=AYv5N1CJor81epxXdnBT0skYF94E0FMy0Q6FYWOnPl4UAyVyMLl8lbjk1XRAw2tLfc
         wA00qTOFFgWfj7EZZWKf5FCICMfRLAKq7VdUHHRlo8lc16psRRHxDUV33eM0qGhVSY90
         JnWFBPc5Jr1MBpHgGAgNSARkSPwxNTYztUqEEoKjgNHXKL8yQOj0iFFVXOGtC9dTh9zH
         0RMwhHhoHiCYUp74YUKad6eBfWLu7FmAYwhffcwXlKiaoVoCBXGrM0f6XjEN1IcU/4kD
         IrI5BxbTV/lPXowVgWToIm3W0ZODVe7EfW31P2Y5u7YqpinFH62jCzrMZyFkBteepnvn
         Fm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=F8dszMjZD03b+F041h4BXDxPxbN2EHN5JVY+9hVIq00=;
        b=TGrucitqtqBxm3JRGu6vvhm8lhXk7oWFw94KR9vwsJjW/l4Vu5TzvqWGn4QfAyBG4B
         jXwQq0KvzEVbLc0woIm2BjgzVwWNL304l8CgGCLuzYkdGdXz1DXegz6bl0IPZTfcOWJx
         889+qeS6xOzqh91ZEtkuwX/aH53KsU8oP1nUCqcFpHvx8c7mFGYuFd/VkLygqwwbVLAM
         n4aKqCTbQhi/t/fyoigV/NFLAWboj80WHCn0tyNhO298BdOZoI0JEO/64bzsYmjp+CUr
         8tWwY6LcuqLQmiBaozD4e+u4AR0jM1rwGlUqe1eDp0Fo4qpJHXYv8C1RZ+6NeDBjupST
         K5gg==
X-Gm-Message-State: ALKqPwecMK+ZO66dERKrz9SqlGH9iz6jPmZ1DL2HD32VP6jSP/WcRToh
        6bcWWLH4gSOCzxfJLyYnAwc=
X-Google-Smtp-Source: ADUXVKIY9r672Bf/fb6B4GNmPmU9w5MZWYvfTRwcroy1Kk06Sp1HB5dKew7TwwQdPfSjPx2/WjrFfQ==
X-Received: by 2002:a1c:1f13:: with SMTP id f19-v6mr6490511wmf.73.1527475277268;
        Sun, 27 May 2018 19:41:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 69-v6sm16568710wmi.29.2018.05.27.19.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 May 2018 19:41:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeremy Linton <lintonrjeremy@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] packfile: Correct zlib buffer handling
References: <20180525225601.22575-1-lintonrjeremy@gmail.com>
        <CACsJy8C4zNZAe6Vw-mz8r8HueYdQKs4ZhMOQYX0v7ypfHdmShg@mail.gmail.com>
        <xmqq8t86m0m3.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CNmDkxzhkdfwjVHjGF4JeUzzPHGnp1x647NxU-GxkxvA@mail.gmail.com>
        <xmqqsh6dl3gg.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 28 May 2018 11:41:15 +0900
In-Reply-To: <xmqqsh6dl3gg.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 27 May 2018 20:53:35 +0900")
Message-ID: <xmqqk1rolcxg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sun, May 27, 2018 at 1:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Duy Nguyen <pclouds@gmail.com> writes:
>>>
>>>> On Sat, May 26, 2018 at 12:56 AM, Jeremy Linton <lintonrjeremy@gmail.com> wrote:
>>>>> @@ -1416,7 +1416,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
>>>>>                 return NULL;
>>>>>         memset(&stream, 0, sizeof(stream));
>>>>>         stream.next_out = buffer;
>>>>> -       stream.avail_out = size + 1;
>>>>> +       stream.avail_out = size;
>>>>
>>>> You may want to include in your commit message a reference to
>>>> 39eea7bdd9 (Fix incorrect error check while reading deflated pack data
>>>> - 2009-10-21) which adds this plus one with a fascinating story
>>>> behind.
>>>
>>> A bit puzzled---are you saying that this recent patch breaks the old
>>> fix and must be done in some other way?
>>
>> No. I actually wanted to answer that question when I tried to track
>> down the commit that adds " + 1" but I did not spend enough time to
>> understand the old problem. I guess your puzzle means you didn't think
>> it would break anything, which is good.
>
> No it merely means I am puzzled how the posted patch that goes
> directly opposite to what an earlier "fix" did is a correct solution
> to anything X-<.

Specifically, I was worried about this assertion:

    Lets rely on the fact that the source buffer will only be fully
    consumed when the when the destination buffer is inflated to the
    correct size.

which I think is the exact bad thinking that caused troubles for us
in the past; isn't the explanation in 456cdf6e ("Fix loose object
uncompression check.", 2007-03-19) relevant here?

-	stream.avail_out = size + 1;
+	stream.avail_out = size;
	...
 		stream.next_in = in;
 		st = git_inflate(&stream, Z_FINISH);
 		if (!stream.avail_out)
-			break; /* the payload is larger than it should be */
+			break; /* done, st indicates if source fully consumed */
 		curpos += stream.next_in - in;
 	} while (st == Z_OK || st == Z_BUF_ERROR);
 	git_inflate_end(&stream);
 	if ((st != Z_STREAM_END) || stream.total_out != size) {
 		free(buffer);
 		return NULL;
 	}

With minimum stream.avail_out without slack, when !avail_out, i.e.
when we fully filled the output buffer, it could be that we had
correct input that deflates to the correct size, in which case we
are happy---st would say Z_STREAM_END, we would leave the loop
because it is neither OK nor BUF_ERROR, and total_out would report
the size we expected.  Or the input zlib stream may have ended with
bytes that express "this concludes the stream", and the input bytes
before that was sufficient to construct the original payload fully,
and we may have just fed the bytes before that "this concludes the
stream" to git_inflate().

In such a case, we haven't consumed all the avail_in.  We may
already have all the correct output, i.e. !avail_out, but because we
haven't consumed the "this concludes the stream", st is not
STREAM_END in such a case.  

Our existing while() loop, with one-byte slack in avail_out, would
have let us continue and the next iteration of the loop would have
consumed the input without producing any more output (i.e. avail_out
would have been left to 1 in both of these final two rounds) and we
would have exited the loop.  After calling inflate_end(), we would
have noticed STREAM_END and correct size and we would have been
happy.

The updated code would handle this latter case rather badly, no?  We
leave the loop early, notice st is not STREAM_END, and be very
unhappy, because this patch did not give us to consume the very end
of the input stream and left the loop early.

>> This yields two problems, first a single byte overrun won't be detected
>> properly because the Z_STREAM_END will then be set, but the null
>> terminator will have been overwritten.

Because we compare total_out and size at the end, we would detect it
as an error in this function, no?  Then zlib overwriting NUL would
not be a problem, as we would free the buffer and return NULL, no?

>> The other problem is that
>> more recent zlib patches have been poisoning the unconsumed portions
>> of the buffers which also overwrites the null, while correctly
>> returning length and status.

Isn't that a bug in zlib, though?  Or do they do that deliberately?

I think a workaround with lower impact would be to manually restore
NUL at the end of the buffer.

