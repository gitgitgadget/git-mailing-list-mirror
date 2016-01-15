From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/6] shortlog: match both "Author:" and "author" on stdin
Date: Fri, 15 Jan 2016 18:19:30 -0500
Message-ID: <CAPig+cQXDn+iR29vKzSRAUBYgXzTiR5MykKAtvCcF0SE7J4kUg@mail.gmail.com>
References: <20160115170627.GA20983@sigill.intra.peff.net>
	<20160115170823.GA21102@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 16 00:20:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKDf6-0002Ix-65
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jan 2016 00:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbcAOXTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 18:19:32 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36769 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbcAOXTb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 18:19:31 -0500
Received: by mail-vk0-f67.google.com with SMTP id e64so7249860vkg.3
        for <git@vger.kernel.org>; Fri, 15 Jan 2016 15:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ZWg6tpndLJ+ixjgkXNVtt8BwJogBlpJIcewjsinaOFU=;
        b=nBZ2UQzWdxa+AQ3nM6h1qrtGABkNLjqPJtMENndq6kqQFcGplAgcTRxXicfkhbePLo
         X0/dDTBTAEljXR02ZPwkjZUOCgHph1HU5Ko8N9eX3l8wsR/8/5YYTZWDn842TLjq39TA
         iH+rSfeYONI9Tux3v+360bcI4XcbQGjSfawBJC53XlKfDcQIacT9SMhrJ5cfLZhVbGH2
         y902dHb7X6EB4B90SrR0ybF6CZSL5rGUgiirqGwyvjDpBLM8ded8o67Thnx0Qt5cMxN1
         hUAoqjzKi3dGCD1wvAgWJGcYv4ZeR45KkNX4JEtV9IYuEOPmWfU7yZnJv2KjSVJX6zrf
         F8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ZWg6tpndLJ+ixjgkXNVtt8BwJogBlpJIcewjsinaOFU=;
        b=gLSZxN4eyiE/do5U94LqHzZYOzf2rV530aLf+xl0wThG1KOiL+Zzo0/3fWsObUZhjT
         BABr8Xm3qtZpQzkXNbpYRBtEaZ4Qt8mhZzugf83uV02TOGV8lFGtSmLCGUyUOW284KLD
         Fs3xEe8xtUzc71wG52rjFbkOUeRzOSubvKg+MSe1ObrcdE+bj2o7CwO20E0mia2QU2w8
         Fv64ECKKE6xJNFlhvDTREzAemCv7i1U5MEz4EpCxb9a3zSR6tvq4+jKbB8tU3Gw+oypv
         PRJ8Jw+TwnasFNkNx+gtYTf9Kb9QMvn+SaNY+xydHBq8DGyQ+M8efsTZshtunfUj4akZ
         nqqQ==
X-Gm-Message-State: ALoCoQmm+n/4KcXORtgvpTZKjfQvcIiFgCQwHAXgSJ0N/5NBF19XIHWCrvzEvm7SESfV7YXSeybSVMadwLW2E5mNY5jwkxrrMw==
X-Received: by 10.31.47.135 with SMTP id v129mr9569566vkv.115.1452899971007;
 Fri, 15 Jan 2016 15:19:31 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Fri, 15 Jan 2016 15:19:30 -0800 (PST)
In-Reply-To: <20160115170823.GA21102@sigill.intra.peff.net>
X-Google-Sender-Auth: hmsWISV41-uA5uCj66JoOF7YrdM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284230>

On Friday, January 15, 2016, Jeff King <peff@peff.net> wrote:
> The original git-shortlog could read both the normal "git
> log" output as well as "git log --format=raw". However, when it was
> converted to C by b8ec592 (Build in shortlog, 2006-10-22),
> the trailing colon became mandatory, and we no longer
> matched the raw output.
>
> Given the amount of intervening time without any bug
> reports, it's probable that nobody cares. But given that
> it's easy to fix, and that the end result is hopefully more
> obvious and flexible (it could now easily accomodate matching
> "Committer"), let's just make it work.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> @@ -89,13 +89,34 @@ static void insert_one_record(struct shortlog *log,
> +/*
> + * If header is "author", match candidate against the regex /[Aa]uthor:? /,
> + * and return a pointer to the remainder of the string in out_value.
> + */
> +static int match_ident_header(const char *candidate, const char *header,
> +                             const char **out_value)
> +{
> +       const char *v;
> +
> +       if (tolower(*candidate++) != tolower(*header++))
> +               return 0;

Presumably, this will never be invoked as match_ident_header("", "",
...) so we don't have to worry about it accessing beyond end-of-string
when it gets past this conditional. Does it deserve an
assert(*candidate) at the top of the function, though, or is that
overkill?

> +       if (!skip_prefix(candidate, header, &v))
> +               return 0;
> +       if (*v == ':')
> +               v++;
> +       if (*v++ != ' ')
> +               return 0;
> +       *out_value = v;
> +       return 1;
> +}
