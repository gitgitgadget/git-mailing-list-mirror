From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 4/8] strbuf: add strbuf_read_once to read without blocking
Date: Mon, 14 Dec 2015 15:27:50 -0800
Message-ID: <CAGZ79kZK6+f972kF5jx11hjviW3cKtR7xsdw3dYXS48XnC1UqQ@mail.gmail.com>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
	<1450121838-7069-5-git-send-email-sbeller@google.com>
	<CAPig+cQUGCFZnOxjuFaYNNhLqfdS7thrUQKqNkr5=0Hr4OkyMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 00:27:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8cX6-0008PK-CW
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 00:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932852AbbLNX1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 18:27:51 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:34364 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932649AbbLNX1v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 18:27:51 -0500
Received: by mail-io0-f178.google.com with SMTP id e126so1082676ioa.1
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 15:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Nc+maD7uVHm74HAEQJfwsYbt4cWj3z28VcwoNU9MBIQ=;
        b=ZAkzmNGwF+IGTtQntedn0FzdQ1/GtxP8ICTfgHvQhdXmz3UdwDkFMh8ukaATpaMScJ
         Gb5XmMiKG5ynkQRGz2k1s7/SAKX6fp1taeFWvmhD2AWDPago/iIuW7EZ5QFzrHinoYCw
         HpVFFgWBXLPrXE7xyulFD1UNRDaxZqR2ZT8V7Qr26GDgO4oPzxZsdqyeiFwCCyVUo5XZ
         33YspDCl4hpsxyVe6mpIsawbhf7hx0vprMNohP2PBS80mNOWZXUs39mm9msGVEf7tpnR
         cO1HqGmSiBXNwQQmGflnqnJJzrI1BOi77fJNG5HyJMXfns8gMhPdHoXEB9gooDoW5Vrp
         +k4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Nc+maD7uVHm74HAEQJfwsYbt4cWj3z28VcwoNU9MBIQ=;
        b=XRha1jXA2UTtsYp458v2tL//PVyPYwY+s7PQfdcZw8+GJ0Kw18B2++pXBGg0d4H1hz
         R1UFEV/jGFJPbZ4x3hPlPuVJSN4edj0VvOZ5qSiSBML5ZIHnpcRR9VukrOFS2by8RjqH
         Niz5VVMA56vqQC3H+Jjn2+EFeG5GoO/dP9mDCG36urm9UVcIJcrWNWQ1AE5BiuRJZ3Uw
         QgkV3MEBU+Tw4Z4hWOSzttfNmmbAXKUzz0QiqSda9euqrys0b5Mm8ayCMGrxr4TsDzUC
         hoFNJXWvYHhSjApdFxYIrL0JhqZUct6q9MsAWIpDo+MPR4139OGgHaPB2F1z2lkLSWzZ
         UZfQ==
X-Gm-Message-State: ALoCoQneu5St5LWuNtbc/Ht7WAhhZBjSHJcekrdyGjy/XlzK5JTi6Le7SnZCl6EecRV0OUVOHjLClkLAPmabeLqYlu9/gZXLrLp6QmqLw/RYJW3WL4BBE9M=
X-Received: by 10.107.152.142 with SMTP id a136mr37676088ioe.110.1450135670475;
 Mon, 14 Dec 2015 15:27:50 -0800 (PST)
Received: by 10.107.8.84 with HTTP; Mon, 14 Dec 2015 15:27:50 -0800 (PST)
In-Reply-To: <CAPig+cQUGCFZnOxjuFaYNNhLqfdS7thrUQKqNkr5=0Hr4OkyMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282452>

On Mon, Dec 14, 2015 at 3:16 PM, Eric Sunshine <ericsunshine@gmail.com> wrote:
> On Mon, Dec 14, 2015 at 2:37 PM, Stefan Beller <sbeller@google.com> wrote:
>> The new call will read from a file descriptor into a strbuf once. The
>> underlying call xread_nonblock is meant to execute without blocking if
>> the file descriptor is set to O_NONBLOCK. It is a bug to call
>> strbuf_read_once on a file descriptor which would block.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> diff --git a/strbuf.h b/strbuf.h
>> @@ -367,6 +367,14 @@ extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
>>  extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
>>
>>  /**
>> + * Returns the number of new bytes appended to the sb.
>> + * Negative return value signals there was an error returned from
>> + * underlying read(2), in which case the caller should check errno.
>> + * e.g. errno == EAGAIN when the read may have blocked.
>> + */
>> +extern ssize_t strbuf_read_once(struct strbuf *, int fd, size_t hint);
>
> strbuf_read_once() is a rather opaque name; without reading the
> documentation, it's difficult to figure out what it means. I wonder if
> strbuf_read_nonblock() or something would be clearer?

Well the underlying read call can block if the fd is not marked for nonblocking,
so I would not name it _nonblock.
I just realize this same argument would make the naming moot for the previous
patch though. (xread_nonblock may block if not marked unblocking)

Currently we really want is a read once and do not try to grab as much
as possible,
but just return quickly. We do not do the non blocking setup, as we deemed that
unneeded because of the preceding poll in a higher layer to signal we have data
there to read.

Junio suggested in the discussion [4/8] maybe we can just use xread
and strbuf_read
in this series, so I am tempted to drop patches {3,4}/8 as that makes
sense to me.
For non blocking stuff we can later re introduce those helper functions though.
