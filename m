From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv4 1/4] notes: don't leak memory in git_config_get_notes_strategy
Date: Fri, 1 Apr 2016 13:30:39 -0400
Message-ID: <CAPig+cRNVoNAwLV5J0Epmdgo=t79ab-=mPLDH4kTxJjnuQ6miA@mail.gmail.com>
References: <1459470946-16522-1-git-send-email-sbeller@google.com>
	<1459470946-16522-2-git-send-email-sbeller@google.com>
	<CAPig+cQ=83k-of=jP1r6bYqsYrUhiDKhR3_Bm-SfYndn+sL=Dg@mail.gmail.com>
	<xmqqh9fljojo.fsf@gitster.mtv.corp.google.com>
	<xmqq4mbljm76.fsf@gitster.mtv.corp.google.com>
	<20160401171424.GA20345@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 01 19:30:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am2uI-00070t-Ue
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 19:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbcDARam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 13:30:42 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34437 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbcDARak (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 13:30:40 -0400
Received: by mail-yw0-f180.google.com with SMTP id d68so37776739ywe.1
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 10:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=4XPzOJRb8aUSZXyEH65oEbcRjpUdFAJkqFwRDOhIRb4=;
        b=gJOSpbLqvk6hW0oLPYMZ8Wk9zmDeKfhRUaBPu83qPQgF7B9UrD45UmDDhQkYs2xBxv
         XZlEIAb0qHN9LVVsyo2GCsCcvi9aTWZLNjqxUJKk4WB6LjveIIM9gsx0ng3dMbu7Dvbk
         EJ6jPvbbca62wWegWYH1M11a9j+VUpMvXL+VBUetlVAIAUtHrzHO1y8WpK6y/jI9CX6M
         Dgohm9cVQEtOLLF7/hKCKmjQrTrlV3jQu5NWb1YEQjjr9z2UIoJnrkmOAeFvW39et2wd
         hPgbGi49E246y6RqexvIhfbqpFgX2OuZHGAwzPmu1qZq+G897xxAVyjoxO07mmlKA36f
         aYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=4XPzOJRb8aUSZXyEH65oEbcRjpUdFAJkqFwRDOhIRb4=;
        b=IIpfXt4ul1D5jkBhbu6QmbirJxUYB4RtjyAhg1/73BhypzDQh7M2fMdsC1tuwQ5Doi
         72A0QP4ObY9L26HudxXgzf1ApGG1KalHVhrlsb07zmhkAu3z40TKHRZ965Rvy6QlGko9
         4gqut8bANDlKqH0ePdFelDx/Xm7TbtA3elp/0e6K3w3Ca/eMxGcNXkV9/1BGE/hcY+5f
         AcQR6/xE4YVWkKRGhXnmqfDIWBcYM7puJ4Qqt8U0Xz+JKg+2ifSDb0AvjLGq4tukJ+vA
         xMUVywK9hJ8O+/FenXexSdLQr6UbFIP6BVGLS/80eFWDusBZ2YLf8S6pRF17VJU1yZtc
         jjtw==
X-Gm-Message-State: AD7BkJIAUM7TCryZ8KRY59bylk6JbaNkiF6R+96waDhj4vfXDZFYO2uJKnqSZzpcZpWlIqA0H6MGrx5r81tLRg==
X-Received: by 10.31.47.135 with SMTP id v129mr2397010vkv.115.1459531839907;
 Fri, 01 Apr 2016 10:30:39 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Fri, 1 Apr 2016 10:30:39 -0700 (PDT)
In-Reply-To: <20160401171424.GA20345@sigill.intra.peff.net>
X-Google-Sender-Auth: mmLzCLonWEHL26Pn_yAPsvw9KT0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290567>

On Fri, Apr 1, 2016 at 1:14 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 01, 2016 at 10:03:25AM -0700, Junio C Hamano wrote:
>> From: Stefan Beller <sbeller@google.com>
>> Date: Thu, 31 Mar 2016 11:04:03 -0700
>> Subject: [PATCH] notes: don't leak memory in git_config_get_notes_strategy
>>
>> This function asks for the value of a configuration and
>> after using the value does not have to retain ownership
>> of the value.  git_config_get_string_const() however is
>> a function to get a copy of the value, but we forget to
>> free it before we return.
>>
>> Because we only need to peek the value without retaining
>> a pointer to it, use git_config_get_value() to peek into
>> the value cached in the config API layer.
>>
>> As git_config_get_value() does not insist the value to be
>> a string, we'd need to do the "nonbool" check ourselves.

Nicer commit message.

> Unfortunately, I don't think this is quite right. In the original, we
> relied on git_config_get_string_const to notice a non-string value, at
> which point it would die:
>
>   $ git -c notes.mergeStrategy notes merge whatever
>   error: Missing value for 'notes.mergeStrategy'
>   fatal: unable to parse 'notes.mergeStrategy' from command-line config
>
> But in your patch:
>
>> +     if (!value)
>> +             return config_error_nonbool(key);
>
> We just return an error from git_config_get_notes_strategy(). If this
> were a callback to git_config(), that would be fine (as we would
> auto-die then in the caller), but it's not. It is called directly for a
> specific key. One of the callers treats a non-zero return as "we don't
> have that variable", and the other ignores the return value completely.
>
> So I think you'd want something more like:
>
>   if (!value) {
>         config_error_nonbool(key);
>         git_die_config(key);
>   }

Yep, I had noted the bit about having to die() manually when reviewing
the earlier patch, but it slipped from memory when composing the reply
to the current version of the patch.

> This is why I wondered if the minor "do not allocate" tweak was worth
> the trouble, when git_config_get_string() just handles this for us.

Which again suggests a new function which does this work but doesn't
copy the string (despite the already quite large set of similar
functions).
