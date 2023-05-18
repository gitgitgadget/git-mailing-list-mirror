Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD53C7EE22
	for <git@archiver.kernel.org>; Thu, 18 May 2023 09:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjERJ6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 05:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjERJ6a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 05:58:30 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78DC1A4
        for <git@vger.kernel.org>; Thu, 18 May 2023 02:58:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f427118644so17694805e9.0
        for <git@vger.kernel.org>; Thu, 18 May 2023 02:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684403908; x=1686995908;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zlSMFETE8+xEAvIwTXBk+Clr1ULX+9eT4YQ3APLtfOo=;
        b=A681oFXu6PUxkVcWag/SptjTWYepaBWUmHbmRqzu+Nm+gsoI1m+Q/zhgQbC4fVkUUG
         kHtMg2ShGNmNyYXdsGo3ydw6E+8Nxi7h7Cu5PYb/5TalsmPC5HG26CqUlknPa47SEuwV
         7iJBsgjmsTIh4ZM5WE5rJl4wBxpxtqj+HIbGHYgtlyKA2UL0Vnr0vPOXZaQq9JQ3yE0G
         SkUpXVAIb2osF+dcDWTZiw6C6A8uTjhn/xzX9fcDjwzk6TypPG0ekB3YU3vF1b34L5rm
         i123bZbmbjGIi9JB+RalVd1BxzsJVlPKMHmfmGIJ2L2AEZf2ikavuO1VHujfEE+KOPWZ
         jETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684403908; x=1686995908;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlSMFETE8+xEAvIwTXBk+Clr1ULX+9eT4YQ3APLtfOo=;
        b=EhXeztfy/LffISMnftD7q3UVjqJFQOj58gWfKC+6F0uJPiR7XDjUXq9P7p6gSafoez
         4lK8OB9ThlJJAErR3BsSxuaZC1RYlLXVM2yBxIjjfnbnrAhhYS7aX3pSEG8oNtqjorW0
         4EtTUl280HLmjSQ0dR1qIz6qi/wGRJ0OA0NJ4CyFX1L90tk0wBnWJl+oPoEX+VPdAZGZ
         SWhfnBQXGDKAkMu1KPB5KWldjcWGZK053KyB5/FIMdo4mekMxoIpvZFZ0YvdyJzplNJp
         gsdiJscVIWLdwJpht7L+Je0d35JE7koUtWw/q10wJDJZlDPopLZw0FFsUzFFo/k1eTQY
         W7ag==
X-Gm-Message-State: AC+VfDyFbcg1/c52xdeeUDbzA0poRyUs0Lt54YNwc5dVBow6JwVctTpK
        66fDY2fE10ZZnchMNMt9kuloQ0oNGTE=
X-Google-Smtp-Source: ACHHUZ4kZAcHl7VZ9AEQB2ySbzZwsrIqoULMtSj1HAgp5Z+LW2ZW/BRkZe7Dw+OZqddIkivhotHc0g==
X-Received: by 2002:a05:600c:2295:b0:3f4:2266:8cef with SMTP id 21-20020a05600c229500b003f422668cefmr1112519wmf.31.1684403908059;
        Thu, 18 May 2023 02:58:28 -0700 (PDT)
Received: from [192.168.1.195] ([90.255.142.254])
        by smtp.googlemail.com with ESMTPSA id k16-20020a5d6290000000b003063938bf7bsm1609007wru.86.2023.05.18.02.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 02:58:27 -0700 (PDT)
Message-ID: <10523968-0f02-f483-69c4-24e62e839f70@gmail.com>
Date:   Thu, 18 May 2023 10:58:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] sequencer: beautify subject of reverts of reverts
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
 <3f5e4116-54e6-9753-f925-ed4a9f6e3518@gmail.com> <ZGSlqAPwaLhgWm6v@ugly>
 <2d416834-ef3e-01a2-6be0-9e88bc0de25e@gmail.com> <ZGUIqBU0+Vr5LSBF@ugly>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZGUIqBU0+Vr5LSBF@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/05/2023 18:02, Oswald Buddenhagen wrote:
> On Wed, May 17, 2023 at 12:20:03PM +0100, Phillip Wood wrote:
>> I'm saying that reverting a commit with a subject line
>>
>>     Revert "Revert "Revert some subject""
>>
>> should result in the new commit having the subject
>>
>>     Revert "Revert "Revert "Revert some subject"""
>>
>> (i.e. at that point we stop trying to be clever) rather than
>>
>>     Revert "Reapply "Revert some subject""
>>
> right.
> how about filing that under GIGO and extending the comment?
> i mean, when you actually run into this situation, you should be 
> re-thinking your life choices rather than stressing about git producing 
> a somewhat suboptimal commit message template ...

Given that it is simple to handle this case and Junio is expecting a 
re-roll of this topic[1] then I think it would be worth just adding 
those three lines.

Best Wishes

Phillip

[1] https://lore.kernel.org/git/xmqqa5y3ssss.fsf@gitster.g/

> regards,
> ossi

