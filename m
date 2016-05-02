From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Mon, 2 May 2016 10:45:41 -0700
Message-ID: <CAGZ79kamc6keMC2foVieBjZctrHie+wizLzZC3YDS9uBGRCVzQ@mail.gmail.com>
References: <1461079290-6523-1-git-send-email-sbeller@google.com>
	<1461079290-6523-3-git-send-email-sbeller@google.com>
	<CA+P7+xoqn3fxEZGn02ST1XV-2UpQGr3iwV-37R8pakFJy_9n0w@mail.gmail.com>
	<20160420041827.GA7627@sigill.intra.peff.net>
	<xmqqa8kcxip9.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xpFCBU1xYbtcX8jtmDDyY8p0CiJJ=bexTmi=_vwWRZi0Q@mail.gmail.com>
	<xmqqwpngukin.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZu=keNaCbt4T=CzH3i9qr+BxXw6AiWR-q1Cs4U80Jzng@mail.gmail.com>
	<1461969582.731.1.camel@intel.com>
	<CAGZ79kYx22oYobPxMkC03fGk-E9zaZZd2f+qafESkhcmFog7-w@mail.gmail.com>
	<1461970113.731.3.camel@intel.com>
	<xmqqfuu0uzn7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"peff@peff.net" <peff@peff.net>,
	"jacob.keller@gmail.com" <jacob.keller@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 19:46:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axHv5-0002lh-Q7
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 19:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbcEBRp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 13:45:57 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36691 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735AbcEBRpn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 13:45:43 -0400
Received: by mail-io0-f179.google.com with SMTP id u185so204476803iod.3
        for <git@vger.kernel.org>; Mon, 02 May 2016 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Rf+eIxgQcMFtjKVWVaz6P9U6zI4hWzP/5lJ55JoYDmk=;
        b=Cj8B/ov2MeMpqhp7dSW83xoilUYIuiaJYElZzdhNI1mcpI7M4WgAs1bucFF+gu1CE+
         t0jL+uSt1qxsh57eR+OAiS88AF8pFWHxhNQZ0eg24y+0eoMjdZuhclZUrkHhqZa3j6Gl
         ae4JNiPcoG7H9BQsxYtsgFxhoJEycP8SvR/GHLFn8Ih8U+Flm0KLVnNaC1v4Kmpsz537
         KI+jdBH1CS6kCWB65VaQWvbTcw85393RdzNYXgx0njLNFKwdQx7Bc/mOsIMQSGztwZnc
         5WPgJrTq/ULIhm1142M8rERr7la1AoEi/P7BGygNDQV6yZQyvBTZAyaEBqJbLoHNqkV+
         gsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Rf+eIxgQcMFtjKVWVaz6P9U6zI4hWzP/5lJ55JoYDmk=;
        b=XTx3UcVQfEglfsKuSKHm09yTlU8+ybUthr49lr8vBwMSrbd/nbAJILTMXsPI15ysCo
         nYA82FI/chN7NMveKTZ8eF5xA2GhY9xjek3zPhKzgMBihlCzMmj5GGVnwSQjibvktqMg
         wJCFT6VjFowiXlVoX+Nu8eFfZn9cYz1IKZYXTu7VrK3JfQOB0JBgY8ub4KKjbnkQKULq
         DnMkJ5WSOFmOOyHjZlXw75KyqklAN447D9v/DPna8fE6YU5YHgWGUDR19V8nTka3YApq
         489W4jV9s6G+4oOHWBfRXqvhXw40NxgtT9in6ECefC0Vbg8KRVB/8YohpTJi78/gPcU0
         UDIQ==
X-Gm-Message-State: AOPr4FXO0wlp6hd5NWdt0Bd9U8Ezfp6Yt9QvzMmX+I7p5Fdk5mLRUPjeKQtcIJvHR6h2PDgZxBvxMiYbe7hUV8iJ
X-Received: by 10.107.174.205 with SMTP id n74mr40908381ioo.96.1462211142201;
 Mon, 02 May 2016 10:45:42 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 2 May 2016 10:45:41 -0700 (PDT)
In-Reply-To: <xmqqfuu0uzn7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293249>

On Mon, May 2, 2016 at 10:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Keller, Jacob E" <jacob.e.keller@intel.com> writes:
>
>> True. I think the chances that it needs such a thing are quite minor,
>> and if an undocumented knob gets exposed it would have to become
>> documented and maintained, so I'd prefer to avoid it. Given that the
>> risk is pretty small I think that's ok.
>
> OK, then let's do only the "documentation" part.

The patch below looks good to me.

Thanks,
Stefan

>
> -- >8 --
> Subject: [PATCH] diff: undocument the compaction heuristic knobs for experimentation
>
> It seems that people around here are all happy with the updated
> heuristics used to decide where the hunks are separated.  Let's keep
> that as the default.  Even though we do not expect too much trouble
> from the difference between the old and the new algorithms, just in
> case let's leave the implementation of the knobs to turn it off for
> emergencies.  There is no longer need for documenting them, though.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/diff-config.txt  | 5 -----
>  Documentation/diff-options.txt | 6 ------
>  2 files changed, 11 deletions(-)
>
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index 9bf3e92..6eaa452 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -166,11 +166,6 @@ diff.tool::
>
>  include::mergetools-diff.txt[]
>
> -diff.compactionHeuristic::
> -       Set this option to enable an experimental heuristic that
> -       shifts the hunk boundary in an attempt to make the resulting
> -       patch easier to read.
> -
>  diff.algorithm::
>         Choose a diff algorithm.  The variants are as follows:
>  +
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index b513023..3ad6404 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -63,12 +63,6 @@ ifndef::git-format-patch[]
>         Synonym for `-p --raw`.
>  endif::git-format-patch[]
>
> ---compaction-heuristic::
> ---no-compaction-heuristic::
> -       These are to help debugging and tuning an experimental
> -       heuristic that shifts the hunk boundary in an attempt to
> -       make the resulting patch easier to read.
> -
>  --minimal::
>         Spend extra time to make sure the smallest possible
>         diff is produced.
> --
> 2.8.2-458-gacc1066
>
