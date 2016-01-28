From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv4 1/2] submodule: port resolve_relative_url from shell to C
Date: Thu, 28 Jan 2016 14:11:06 -0800
Message-ID: <CAGZ79kYbYEgW+O-wxp0LeT6W5XweV8e0jWzYDRS6vunnOJBKng@mail.gmail.com>
References: <xmqqtwm1e0ps.fsf@gitster.mtv.corp.google.com>
	<1453948237-9860-1-git-send-email-sbeller@google.com>
	<1453948237-9860-2-git-send-email-sbeller@google.com>
	<xmqqzivpl5uo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 23:11:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOumW-0001Kj-9q
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 23:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755818AbcA1WLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 17:11:10 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:36686 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbcA1WLI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 17:11:08 -0500
Received: by mail-io0-f172.google.com with SMTP id g73so71299163ioe.3
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 14:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/fU3At3w5opBsgyujdkkNbCuUJcw+XvUcfJZAeKjvbE=;
        b=nNxZ9m36g/Fi7Dc+coIBBN5/KZqhqemlaSYB0RTkC/hL0pxr9hoIVISF03mqqUecwI
         XbcDJZlDtenNRDVciA0jLTU8+/4YokvmD5bI4PTsi6U8KBOCkgT3XPxOMXdG8Oshuuqr
         CBHm+c3tC5r9I3xlpj8LXKRQJmgKEm8ZpLqGzug8KlPS93nZteeMMCArpq4JJf6gwZhB
         enFO8TmBC6ICWbIrYEVgCAX4gRWY2ia0fdE5agJy4AZ5Gy3/u7Iuu4iyLSV2pwLNqEsC
         9imedp1pNHCKnWuvoRWUrjMoHDKSubShhkxUqLlm+/kxbI+VegGCbdq8hPr40QB3C7Fb
         OFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/fU3At3w5opBsgyujdkkNbCuUJcw+XvUcfJZAeKjvbE=;
        b=ZQzXVxXynQyEeIqmQyC0qhsINJyyBClrYX0t6z0J1S1tF+yJ6ANlbeS+HIihzAVOx4
         bRgIhmNCeAGUbAeIwpMqgKTPsgcBHH/u/axgLiOl9kBtIQeb3Fx0I3MWecCbrE7OZNaS
         xSYE9dA065TztsqUs94k9aGnlnUAP/Guzdg/T5EHv+bck3IIuW+6w/+qp5NpL/m+KWdj
         czDVbxPGL+l95XP4AtNS1CobD2zGdycSR5e+je7Zo38ZZXUOoMZqie6piGQIetKKLXfJ
         QaFX+4qegAE99mYfP51k3i91ygDVkTsM8r0pRVlbm1mGSYmsCRA7qjzQeORQCqHMxpuA
         gmsQ==
X-Gm-Message-State: AG10YORahkCzfQJk9kj3HJCoqxVlnh/woHJQwANsPqgDYSwi+LFb3wbbEwDVhGkGnOcBgr9mnkojuNWy4PWSXGSR
X-Received: by 10.107.168.149 with SMTP id e21mr3318078ioj.96.1454019066315;
 Thu, 28 Jan 2016 14:11:06 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Thu, 28 Jan 2016 14:11:06 -0800 (PST)
In-Reply-To: <xmqqzivpl5uo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285039>

On Thu, Jan 28, 2016 at 2:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +static char *relative_url(const char *remote_url,
>> +                             const char *url,
>> +                             const char *up_path)
>> +{
>> +     int is_relative = 0;
>> +     int colonsep = 0;
>> +     char *out;
>> +     char *remoteurl = xstrdup(remote_url);
>> +     struct strbuf sb = STRBUF_INIT;
>> +     size_t len = strlen(remoteurl);
>> +
>> +     if (is_dir_sep(remoteurl[len]))
>> +             remoteurl[len] = '\0';
>> +
>> +     if (!url_is_local_not_ssh(remoteurl) || is_absolute_path(remoteurl))
>> +             is_relative = 0;
>> +     else {
>> +             is_relative = 1;
>> +             /*
>> +              * Prepend a './' to ensure all relative
>> +              * remoteurls start with './' or '../'
>> +              */
>> +             if (!starts_with_dot_slash(remoteurl) &&
>> +                 !starts_with_dot_dot_slash(remoteurl)) {
>> +                     strbuf_reset(&sb);
>> +                     strbuf_addf(&sb, "./%s", remoteurl);
>> +                     free(remoteurl);
>> +                     remoteurl = strbuf_detach(&sb, NULL);
>> +             }
>> +     }
>> +     /*
>> +      * When the url starts with '../', remove that and the
>> +      * last directory in remoteurl.
>> +      */
>> +     while (url) {
>> +             if (starts_with_dot_dot_slash(url)) {
>> +                     url += 3;
>> +                     colonsep |= chop_last_dir(&remoteurl, is_relative);
>> +             } else if (starts_with_dot_slash(url))
>> +                     url += 2;
>> +             else
>> +                     break;
>> +     }
>> +     strbuf_reset(&sb);
>> +     strbuf_addf(&sb, "%s%s%s", remoteurl, colonsep ? ":" : "/", url);
>> +
>> +     if (starts_with_dot_slash(sb.buf))
>> +             out = xstrdup(sb.buf + 2);
>> +     else
>> +             out = xstrdup(sb.buf);
>> +     strbuf_reset(&sb);
>> +
>> +     free(remoteurl);
>
> This is a rather strange place to put this free(), as you are done
> with it a bit earlier, but it's OK.  I briefly wondered if the code
> becomes easier to follow with fewer free(remoteurl) if this local
> variable is made into a strbuf, but I didn't seriously think it
> through.

Right. As I did not touch that particular free with the resend, I wondered
how it came there, too. And I think I had it at the end of the function and
then realized the return just after the current position would leak it, so
I moved it minimally up. If I'll resend again, I'll move it up to where
it was last used.

>
> Otherwise looking good.
>
> Thanks.

Thanks,
Stefan
