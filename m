From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH][GSoC] parse-options: Add OPT_SET_INT_NONEG.
Date: Wed, 12 Mar 2014 17:47:19 +0700
Message-ID: <CACsJy8Dq5QyZdzCtew0qF37qThH8+05iTrD-ZOeBgbEukmCY5Q@mail.gmail.com>
References: <1394535016-9424-1-git-send-email-yshuiv7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Yuxuan Shui <yshuiv7@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 11:48:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNghb-0006pm-Bb
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 11:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656AbaCLKrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 06:47:53 -0400
Received: from mail-qa0-f45.google.com ([209.85.216.45]:33952 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633AbaCLKrt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 06:47:49 -0400
Received: by mail-qa0-f45.google.com with SMTP id hw13so9651339qab.18
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 03:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GiCylKcjeXFbox53CCLOtEa7TOY09DJO3S6q4BTRpco=;
        b=vWauY46CD62Ex53DsWejIh6xU/F36lcoIM9K6/fK2h8e7+Qfbf70VB5ygBG5OAvxFX
         9slbepVfjoRRW9rEO8AmPIycFEJJ/FOb3KSFzK+AVitaTyvBgUnj9fnIaHSKM6MPPv4h
         6Cjl7ClYGKDAMD8JL3V5FPRdayx/v7+aSR0WnjH5bI6MkpCaPIQKErAzLTzoMzBu481+
         s7hmaAZk1kNxypabpnLyobLJBHv5FSYsEa209kk5ZNTTGtjw2O6BeihsLq7BmLTMJ2UP
         yYZGcQJGNFSWxqHNKYBlipBg7Df3kTuUfUxxfZGRYsXurYigjxnCfIYGGh6NOGVxIx6G
         nvNw==
X-Received: by 10.140.93.244 with SMTP id d107mr13407064qge.41.1394621269101;
 Wed, 12 Mar 2014 03:47:49 -0700 (PDT)
Received: by 10.96.215.102 with HTTP; Wed, 12 Mar 2014 03:47:19 -0700 (PDT)
In-Reply-To: <1394535016-9424-1-git-send-email-yshuiv7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243931>

By convention, no full stop in the subject line. The subject should
summarize your changes and "add ..NONEG" is just one part of it. The
other is "convert to use ...NONEG". So I suggest "parse-options:
convert to use new macro OPT_SET_INT_NONEG()" or something like that.

You should also explain in the message body (before Signed-off-by:)
why this is a good thing to do. My guess is better readability and
harder to make mistakes in the future when you have to declare new
options with noneg.

On Tue, Mar 11, 2014 at 5:50 PM, Yuxuan Shui <yshuiv7@gmail.com> wrote:
> Reference: http://git.github.io/SoC-2014-Microprojects.html

I think this project is actually two: one is convert current
{OPTION_SET_INT, ... _NONEG} to the new macro, which is truly a micro
project. The other is to find OPT_...(..) that should have NONEG but
does not. This one may need more time because you need to check what
those options do and if it makes sense to have --no- form.

I think we can focus on the {OPTION_..., _NONEG} conversion, which
should be enough get you familiar with git community.

> diff --git a/parse-options.h b/parse-options.h
> index d670cb9..7d20cf9 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -125,6 +125,10 @@ struct option {
>                                       (h), PARSE_OPT_NOARG }
>  #define OPT_SET_INT(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, \
>                                       (h), PARSE_OPT_NOARG, NULL, (i) }
> +#define OPT_SET_INT_NONEG(s, l, v, h, i)  \
> +                                     { OPTION_SET_INT, (s), (l), (v), NULL, \
> +                                     (h), PARSE_OPT_NOARG | PARSE_OPT_NONEG, \
> +                                     NULL, (i) }
>  #define OPT_BOOL(s, l, v, h)        OPT_SET_INT(s, l, v, h, 1)
>  #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
>                                       (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}

To avoid the proliferation of similar macros in future, I think we
should make a macro that takes any flags, e.g.

#define OPT_SET_INT_X(s, l, v, h, i, flags) {  ....., PARSE_OPT_NOARG
| PARSE_OPT_ ## flags, NULL, (i) }

and we can use it for NONEG like "OPT_SET_INT_X(...., NONEG)". We
could even redefine OPT_SET_INT() to use OPT_SET_INT_X() to reduce
duplication.

While we're at NONEG, I see that builtin/grep.c has this construct "{
OPTION_INTEGER...NONEG}" and builtin/read-tree.c has "{
OPTION_STRING..NONEG}". It would be great if you could look at them
and see if NONEG is really needed there, or simpler forms
OPT_INTEGER(...) and OPT_STRING(...) are enough.

You might need to read parse-options.c to understand these options.
Documentation/technical/api-parse-options.txt should give you a good
overview.

You could also think if we could transform "{ OPTION_CALLBACK.... }"
to OPT_CALLBACK(...). But if you do and decide to do it, please make
it a separate patch (one patch deals with one thing).

That remaining of your patch looks good.
-- 
Duy
