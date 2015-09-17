From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 01/10] strbuf: Add strbuf_read_noblock
Date: Thu, 17 Sep 2015 10:20:55 -0700
Message-ID: <CAGZ79kY3ueSqVofLmo7jiRQv6R7rXmFvkoj5KouiXi+__h8_GQ@mail.gmail.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
	<1442453948-9885-2-git-send-email-sbeller@google.com>
	<xmqqtwqtja6j.fsf@gitster.mtv.corp.google.com>
	<20150917163012.GB25837@sigill.intra.peff.net>
	<xmqq6139j84n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 19:21:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zccrs-0002L2-K4
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 19:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbbIQRVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 13:21:00 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:36605 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbbIQRU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 13:20:56 -0400
Received: by ykdt18 with SMTP id t18so23413614ykd.3
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 10:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1gMCO4Y62N7kBH8TvWV8NmOB1i/61M8wDnphlMIt8h0=;
        b=DoSAiq4oelzU94ACxm1xbYJMmJJAVwqHD+hlbscL7O9atBo4jEjcHKrt0NdZd+L4zC
         ewD6Y9bAO8ZHrKi4Di7WFFh6oLYLuHF3DmWKsxyTR0MKFilI/9WYE2VhRCcoO3Y7zGDn
         wHvBW1IvmKcHqab0GE+CxIWW/koqRSGSDhIyg/wlUcV/E/+gaslE483Ty2vB5BZfCBVT
         /8panwDESK7tk3Q4ehNgr2B14bmmvjCRq7YUNCclvqak6963Yzse/VNGobWkehNTtFFG
         RCx4Xv5fCjlRhSb7M4qGZkhNW5BTHPiZ1SDx88kh2bZhnBNHn2sssDxkrZCfeL0rSI7J
         qBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1gMCO4Y62N7kBH8TvWV8NmOB1i/61M8wDnphlMIt8h0=;
        b=dEpCC+Q5akuLGcR6LSvyEX4dRTrz69/DdxtOiEs8lN2IPknpZeEy17hfxwpFRFWKYA
         DsN1xA1rVUXuJs7uOPEmtVe8Y871p//d1XqFxdGekOHKvR6QVlwDQYLQECQVni2rWRq0
         V0vNpG1m+HOtxmbYYdicnH4HtubxtP/Rlj/4HaU7bMEgcvfUYsfkXISl+iJS5u+VH6yt
         Bz+mWS5BeL1St8nJj6EtWyhDeCMqtxDfGJjRCsyxjBL2vn2/A+MdCBFt0zQmtr9qBqq6
         NI+F4OezarwK0dzMRbcClrkH4uEZIvkpYXCYTzf7RsVZlHe5HMmhVK6xsMb5htseo3Jm
         g4yg==
X-Gm-Message-State: ALoCoQk2kLfjDU66TPKGZYHPW7rzfz9cpyjygVet3bHeGt9qaloEsFfEIAJ52tri68qyb9MU/W4V
X-Received: by 10.129.90.214 with SMTP id o205mr356199ywb.32.1442510455597;
 Thu, 17 Sep 2015 10:20:55 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Thu, 17 Sep 2015 10:20:55 -0700 (PDT)
In-Reply-To: <xmqq6139j84n.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278146>

On Thu, Sep 17, 2015 at 9:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Thu, Sep 17, 2015 at 09:13:40AM -0700, Junio C Hamano wrote:
>>
>>> And your new caller that does O_NONBLOCK wants to do more than
>>> looping upon EWOULDBLOCK.  It certainly would not want us to loop
>>> here.
>>>
>>> So I wonder if you can just O_NONBLOCK the fd and use the usual
>>> strbuf_read(), i.e. without any change in this patch, and update
>>> xread() to _unconditionally_ return when read(2) says EAGAIN or
>>> EWOULDBLOCK.
>>>
>>> What would that break?
>>
>> Certainly anybody who does not realize their descriptor is O_NONBLOCK
>> and is using the spinning for correctness. I tend to think that such
>> sites are wrong, though, and would benefit from us realizing they are
>> spinning.
>
> With or without O_NONBLOCK, not looping around xread() _and_ relying
> on the spinning for "correctness" means the caller is not getting
> correctness anyway, I think, because xread() does return a short
> read, and we deliberately and explicitly do so since 0b6806b9
> (xread, xwrite: limit size of IO to 8MB, 2013-08-20).
>
>> But I think you can't quite get away with leaving strbuf_read untouched
>> in this case. On error, it wants to restore the original value of the
>> strbuf before the strbuf_read call. Which means that we throw away
>> anything read into the strbuf before we get EAGAIN, and the caller never
>> gets to see it.
>
> I agree we need to teach strbuf_read() that xread() is now nicer on
> O_NONBLOCK; perhaps like this?
>
>  strbuf.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/strbuf.c b/strbuf.c
> index cce5eed..49104d7 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -368,6 +368,8 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
>
>                 cnt = xread(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
>                 if (cnt < 0) {
> +                       if (errno == EAGAIN || errno == EWOULDBLOCK)
> +                               break;

This would need xread to behave differently too. (if EAGAIN, return)

Looking at xread to answer: "Why did we have a spinning loop in case of
EAGAIN in the first place?" I ended up with 1c15afb9343b (2005-12-19,
xread/xwrite:
do not worry about EINTR at calling sites.)

There we had lots of EAGAIN checks sprinkled through the code base, so we had
non blocking IO back then?

I think I chose to not use xread, as it contradicts everything we want
in the non
blocking case. We want to ignore any operations with a recoverable error (EAGAIN
and EINTR) and keep going with the rest of the program. In the blocking case
(as it is used currently) we can just have the checks from xread moved to
strbuf_read.

>                         if (oldalloc == 0)
>                                 strbuf_release(sb);
>                         else
