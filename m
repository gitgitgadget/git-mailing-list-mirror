From: Eugene Letuchy <eletuchy@gmail.com>
Subject: Re: [PATCH 2/2] --date=relative falls back to "short" format for 
	commits older than a year
Date: Fri, 20 Feb 2009 14:47:11 -0800
Message-ID: <fbb390660902201447q560b94f8p969889da5e2686f4@mail.gmail.com>
References: <1235165034-20299-1-git-send-email-eletuchy@gmail.com>
	 <alpine.LFD.2.00.0902201409230.21686@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, peff@peff.net, git@vger.kernel.org,
	eletuchy@facebook.com, Eugene Letuchy <eugene@facebook.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Feb 20 23:48:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from [209.132.176.167] (helo=vger.kernel.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaeAv-0003YG-Iw
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 23:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487AbZBTWrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 17:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752692AbZBTWrP
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 17:47:15 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:65449 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbZBTWrO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 17:47:14 -0500
Received: by bwz5 with SMTP id 5so3095012bwz.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 14:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xpmgfw1aTBdJZlmuHmdS1aEUdfLh31tHBbOYQ2idLFM=;
        b=V8f8QgZ4fnwav0RojabN7OztlpmR8OKUZh28LjCobXkILYoh3mfKI1YenXi+8txBZF
         n5U4IL6AJr0LIDVNSWxfwgLbQHN1kOneKt9ueTER9NBICt9yYjBFXKMKKiURSkW0Xlgw
         YcMwss4a3gZ0SPIH9/NwaTU7AZIBj/Gz/lFQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GwKhPHOn6xp3YKua3c1W14Aa3UvKJNTX2zdapBiFDlapr/tG4yZ5yBcnRATr4kiRiB
         MmJzPUeCIuAbCA0wlCPR972HR577I8AYI7nVCvkN2KpSBXNbbuBywUh/UzBatvymsC8E
         pFEeUq209djXkiONWiFdk7eX75E6rQc5W8GzQ=
Received: by 10.181.208.15 with SMTP id k15mr449431bkq.13.1235170031954; Fri, 
	20 Feb 2009 14:47:11 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0902201409230.21686@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110899>

Cool. I think git blame would need to be tweaked a bit after my patch
(at least documentation wise), since it already has a "raw timestamp"
option (-t).

On Fri, Feb 20, 2009 at 2:15 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Subject: Support 'raw' date format
>
> Talking about --date, one thing I wanted for the 1234567890 date was to
> get things in the raw format. Sure, you get them with --pretty=raw, but it
> felt a bit sad that you couldn't just ask for the date in raw format.
>
> So here's a throw-away patch (meaning: I won't be re-sending it, because I
> really don't think it's a big deal) to add "--date=raw". It just prints
> out the internal raw git format - seconds since epoch plus timezone (put
> another way: 'date +"%s %z"' format)
>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>
> Not a whole lot of testing. But
>
>        git show --date=raw v2.6.29-rc5
>
> works correctly.
>
>  Documentation/rev-list-options.txt |    4 +++-
>  cache.h                            |    3 ++-
>  date.c                             |    7 +++++++
>  3 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git i/Documentation/rev-list-options.txt w/Documentation/rev-list-options.txt
> index b9f6e4d..5076322 100644
> --- i/Documentation/rev-list-options.txt
> +++ w/Documentation/rev-list-options.txt
> @@ -13,7 +13,7 @@ include::pretty-options.txt[]
>
>        Synonym for `--date=relative`.
>
> ---date={relative,local,default,iso,rfc,short}::
> +--date={relative,local,default,iso,rfc,short,raw}::
>
>        Only takes effect for dates shown in human-readable format, such
>        as when using "--pretty". `log.date` config variable sets a default
> @@ -31,6 +31,8 @@ format, often found in E-mail messages.
>  +
>  `--date=short` shows only date but not time, in `YYYY-MM-DD` format.
>  +
> +`--date=raw` shows the date in the internal raw git format `%s %z` format.
> ++
>  `--date=default` shows timestamps in the original timezone
>  (either committer's or author's).
>
> diff --git i/cache.h w/cache.h
> index 21a6310..189151d 100644
> --- i/cache.h
> +++ w/cache.h
> @@ -696,7 +696,8 @@ enum date_mode {
>        DATE_SHORT,
>        DATE_LOCAL,
>        DATE_ISO8601,
> -       DATE_RFC2822
> +       DATE_RFC2822,
> +       DATE_RAW
>  };
>
>  const char *show_date(unsigned long time, int timezone, enum date_mode mode);
> diff --git i/date.c w/date.c
> index 950b88f..d75dff4 100644
> --- i/date.c
> +++ w/date.c
> @@ -89,6 +89,11 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
>        struct tm *tm;
>        static char timebuf[200];
>
> +       if (mode == DATE_RAW) {
> +               snprintf(timebuf, sizeof(timebuf), "%lu %+05d", time, tz);
> +               return timebuf;
> +       }
> +
>        if (mode == DATE_RELATIVE) {
>                unsigned long diff;
>                struct timeval now;
> @@ -615,6 +620,8 @@ enum date_mode parse_date_format(const char *format)
>                return DATE_LOCAL;
>        else if (!strcmp(format, "default"))
>                return DATE_NORMAL;
> +       else if (!strcmp(format, "raw"))
> +               return DATE_RAW;
>        else
>                die("unknown date format %s", format);
>  }
>



-- 
Eugene
