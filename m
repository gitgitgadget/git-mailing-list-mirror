From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 1/4] notes: don't leak memory in git_config_get_notes_strategy
Date: Wed, 30 Mar 2016 14:10:08 -0700
Message-ID: <CAGZ79kZSLH_eMt0v6unHHZi0SQBHXicH_EPxy++9XdAw6fUUqg@mail.gmail.com>
References: <1459357518-14913-1-git-send-email-sbeller@google.com>
	<1459357518-14913-2-git-send-email-sbeller@google.com>
	<CAPig+cTeVgyNHa5uHUMDZ6ifxyjk2wvm=jGd9tP1+BuBKKVR+g@mail.gmail.com>
	<xmqqegarsmil.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 23:10:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alNNa-0006iR-4i
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 23:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176AbcC3VKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 17:10:11 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:34933 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964AbcC3VKK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 17:10:10 -0400
Received: by mail-io0-f174.google.com with SMTP id g185so92540565ioa.2
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 14:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=j5U4AnajF/986JfrBbF0kaOS00nYMlgwhAA+/BRImhw=;
        b=VGvWH/A/uxnxOez9jjfFX4RgTkfssft4jIvkHmT3ASrNs8cZBzPb4YKMpkCDXwDghj
         vLI5B+LGFyL2qCMGGhLno30CjYAxJFzNv4rV28s680uzKv6uroOH5riFAQU87ago/vZl
         1qxzDRe8fNwZ2tUS63svl2l4XdGIlitUJc0Bq/MKAuRuLfOjU3okVszxQYZALccj9CEe
         jRhstpuPEn3c7+z/poRjTHAOzkVRRVMYIYc+jOryHd2yDRA7UhgYJad4A7tYP9osz6Vw
         TnMyIkKnOhPM8qxbgP3+H78LB4mOXNRdXvaCRq/QV63njv+Q00r3fQXLXCC4eDkEhqlk
         jqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=j5U4AnajF/986JfrBbF0kaOS00nYMlgwhAA+/BRImhw=;
        b=IncZ9ovDCdqVPcbeJmm+x4EBEurjWGlXTEYmIhkJ+0iD9Dsl9yv/Mj89zD4yaxMEzv
         asyLfd9EcmZmiwlSI55DiV4Y4alsXreKoPs4IqlsVRTYA8HlCiXXPOrOKp/V601JsXFy
         bd9gpui4AQiSh3wAZsQNvQcj7u+9oH9jp0yipMUj9+urZdBc49d2uvXBAf0jWn7ufzud
         CaQGwO9JILUvxOSpxd52ZB355n5EhBcZkANY2tk1FLrgd97DzK7eg+dc1akFzpeGCyL9
         FxEgz+um3zoX7U7Wa/af6w9t8G+tQw7LxomZxyvScwSw0EyZsHeh4PPw6yzZAUZVJui3
         XdWw==
X-Gm-Message-State: AD7BkJIsFwDd1gkbSkNDhfbGuO3irrOXhraBGdk9v5ENJehf4s2UtB/iHe01B0TEpuuO6Cg80vxYS/mmHmNCShvJ
X-Received: by 10.107.158.138 with SMTP id h132mr11629469ioe.174.1459372208953;
 Wed, 30 Mar 2016 14:10:08 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Wed, 30 Mar 2016 14:10:08 -0700 (PDT)
In-Reply-To: <xmqqegarsmil.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290349>

On Wed, Mar 30, 2016 at 2:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> diff --git a/builtin/notes.c b/builtin/notes.c
>>> @@ -744,13 +744,14 @@ static int merge_commit(struct notes_merge_options *o)
>>>  static int git_config_get_notes_strategy(const char *key,
>>>                                          enum notes_merge_strategy *strategy)
>>>  {
>>> -       const char *value;
>>> +       char *value;
>>>
>>> -       if (git_config_get_string_const(key, &value))
>>> +       if (git_config_get_string(key, &value))
>>>                 return 1;
>>>         if (parse_notes_merge_strategy(value, strategy))
>>>                 git_die_config(key, "unknown notes merge strategy %s", value);
>>>
>>> +       free(value);
>>>         return 0;
>>>  }
>>
>> Hmm, I thought Peff's suggestion of using git_config_get_value() was
>> accepted as superior since it avoids the allocation altogether, thus
>> no need for free() and no leak.
>
> I agree that this caller can avoid taking ownership of value by
> using git_config_get_value() and that would be a cleaner solution
> here.
>
> This is a tangent, but am I the only one who finds that the naming
> of functions in config-get API is confusing?  Just wondering if we
> should rename the ones that keeps the memory ownership to the config
> subsystem with s/get/peek/ or something.
>

I demonstrated the confusion and disability to read and distinguish
between those names clearly already.

So I'd strongly favor a better naming for functions in config.c
