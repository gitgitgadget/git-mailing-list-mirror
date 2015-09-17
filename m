From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 01/10] strbuf: Add strbuf_read_noblock
Date: Thu, 17 Sep 2015 10:26:19 -0700
Message-ID: <CAGZ79kaZOyqwbf+BpG2oPBBt5zj3=q-abk+F-HdkZPL3GzTzsw@mail.gmail.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
	<1442453948-9885-2-git-send-email-sbeller@google.com>
	<xmqqtwqtja6j.fsf@gitster.mtv.corp.google.com>
	<20150917163012.GB25837@sigill.intra.peff.net>
	<xmqq6139j84n.fsf@gitster.mtv.corp.google.com>
	<20150917171308.GA28046@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 19:26:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zccwy-0000B4-CC
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 19:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbbIQR0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 13:26:20 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:35215 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbbIQR0U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 13:26:20 -0400
Received: by ykdu9 with SMTP id u9so23606060ykd.2
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 10:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4/J/jWTmUvGa7szZFNFwWlyJuu8brZZuDIQaV7xHxHs=;
        b=SqrIbcJuOLGU+2ZmVdx4rG8PKMsw45ViivD9jTtddZ7Vl7Xg0PVmUWl+S3IjZfxnl7
         x6Xtt2fttvfkZIgYjngLCdZbwZolWQ8CAgbJtZjLdI5JJRPIQvzCXv73EYBZcEb8tmjF
         lv5j8pLLhaYMmKmUThCfg4jpfk5XlFmL8j3eFXr9Or2Nv2Lcsv69Vq+pwnJEd0SItdhR
         SU3M2WshxYqRd39BqLS2O+FJfkoV/hD1cY6yCPw9uO1JeBjLRsPAoG8EgpGSPQWg2uTC
         6XZtlAKd4QJQBnj38AYtnsftS97kT+/ypjMW4fmarbXN8g8F19kuwuR0HhOB24ub2rEZ
         0iWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4/J/jWTmUvGa7szZFNFwWlyJuu8brZZuDIQaV7xHxHs=;
        b=A9irJWP6YoiLMkvXWl5fEshGo9SuFPch5rhFRwNefZBWXuc8w1G4Mzt0B863ZNw0nq
         hEUJvT5Zduw54NWYuuPSRNuEtnjUaGvahaqHKksaYG2xXgCz+qPWj0q3Zl+1hjKK0OpO
         k6LxxgHeQNmg+OPVlBynMXZ71xoCOycf054tvxIQFiu4/blvzQ52V4jlxD6+flRut6gp
         ndI3uF7C6tML7JvQQFlfYQeluVFTpvPWJ/naelmNpQ2m2jXA1/Sonp8PkqJTHhLEPZJg
         6phGvuB/prnXCM2GaBMCuKUEdNFmTC6GD5dY5Jp6zvfLke5ATMKkF6UAL7dssa3jUpV+
         GNhQ==
X-Gm-Message-State: ALoCoQlwi8vRdrJFm9Y3KOAAvZGq+0OmGIg+hRMYApIIV2CzBV1IhDRLJggwLWGdRn2mqe5Rd/XR
X-Received: by 10.170.198.198 with SMTP id p189mr369941yke.56.1442510779269;
 Thu, 17 Sep 2015 10:26:19 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Thu, 17 Sep 2015 10:26:19 -0700 (PDT)
In-Reply-To: <20150917171308.GA28046@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278148>

On Thu, Sep 17, 2015 at 10:13 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 17, 2015 at 09:58:00AM -0700, Junio C Hamano wrote:
>
>> > Certainly anybody who does not realize their descriptor is O_NONBLOCK
>> > and is using the spinning for correctness. I tend to think that such
>> > sites are wrong, though, and would benefit from us realizing they are
>> > spinning.
>>
>> With or without O_NONBLOCK, not looping around xread() _and_ relying
>> on the spinning for "correctness" means the caller is not getting
>> correctness anyway, I think, because xread() does return a short
>> read, and we deliberately and explicitly do so since 0b6806b9
>> (xread, xwrite: limit size of IO to 8MB, 2013-08-20).
>
> I think they have to loop for correctness, but they may do this:
>
>   if (xread(fd, buf, len) < 0)
>         die_errno("OMG, an error!");
>
> which is not correct if "fd" is unknowingly non-blocking. As Stefan
> mentioned, we do not set O_NONBLOCK ourselves very much, but I wonder if
> we could inherit it from the environment in some cases.
>
> The spinning behavior is not great, but does mean that we spin and
> continue rather than bailing with an error.
>
>> > But I think you can't quite get away with leaving strbuf_read untouched
>> > in this case. On error, it wants to restore the original value of the
>> > strbuf before the strbuf_read call. Which means that we throw away
>> > anything read into the strbuf before we get EAGAIN, and the caller never
>> > gets to see it.
>>
>> I agree we need to teach strbuf_read() that xread() is now nicer on
>> O_NONBLOCK; perhaps like this?
>>
>>  strbuf.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/strbuf.c b/strbuf.c
>> index cce5eed..49104d7 100644
>> --- a/strbuf.c
>> +++ b/strbuf.c
>> @@ -368,6 +368,8 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
>>
>>               cnt = xread(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
>>               if (cnt < 0) {
>> +                     if (errno == EAGAIN || errno == EWOULDBLOCK)
>> +                             break;
>>                       if (oldalloc == 0)
>>                               strbuf_release(sb);
>>                       else
>
> If we get EAGAIN on the first read, this will return "0", and I think we
> end up in the "was it EOF, or EAGAIN?" situation I mentioned earlier.
> If we reset errno to "0" at the top of the function, we could get around
> one problem, but it still makes an annoying interface: the caller has to
> check errno for any 0-return to figure out if it was really EOF, or just
> EAGAIN.
>
> If we return -1, though, we have a similar annoyance. If the caller
> notices a -1 return value and finds EAGAIN, they still may need to check
> sb->len to see if they made forward progress and have data they should
> be dealing with.

If errno == EAGAIN, we know it is a non blocking fd, so we could encode
the length read as (- 2 - length), such that

...-2 the length read if EAGAIN was ignored
-1 for error, check errno!
0 for EOF
+1... length if we just read it or restarted it due to EINTR.

The call site should know if it is non blocking (i.e. if the <-2 case can
happen) and handle it appropriately.

Any callsite of today which is unaware of the fd being non blocking would break
by this (as we want to fix the spinning anyway eventually)




>
> -Peff
