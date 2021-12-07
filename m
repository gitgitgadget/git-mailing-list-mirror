Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383ACC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhLGSHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbhLGSHq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:07:46 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AACEC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 10:04:15 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y13so60112223edd.13
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 10:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=OoQISFyY3ENEH75x9nx8YMNV6tTIyN1Fq46Y1ut8lMA=;
        b=egRTTq1gJQvYtHiu9osBWiyKZAhHiG1fP4x7IoFgLkhrWdqCHNWQlSfU33dVuWSwud
         AOSnzauPoiHeKc3MYnzG6NQtg1TM26tpWDb4CG9TEwikvOEJdjPr/kk1q1zj9bX19PUH
         CqsBgizEqqwd+U+6KFn2/Gku4LDCK+E56qfQnGmFr8E+Za1l/uUKOHZ5/AtZCi8E+ow8
         R1oCy0H1lIK1oS4l9yhiZseg8fERCIM6QRQKWMRrgXSU374cV861y+/6xLczwqv/HGzE
         DWFWhX800pzV4kJrUgM11FkBK9JlTmp7ag4J74KTstMuZVnq54y7Rh0ndg+KFCmRWWkI
         qCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=OoQISFyY3ENEH75x9nx8YMNV6tTIyN1Fq46Y1ut8lMA=;
        b=w6w6/y9ZkjSgr7WA7iGmUu56aPVQlHVN+FvsYqVM4XcnrbY2dq3JZiAXJpqrndWfJw
         vSYIKSOUmIMch6NfFQubRREpnx7aC0eWQE9hZXP6CSrPpDaQdPbFltFMcUxgdP+0SkyQ
         +b+9oYomp5jnQ0O+HmZtfPtakezDuQR0Fe1QmonEURi2/3qWIK8dts2OMp+uEV9GzZDL
         gj13GgaBHbhmwkroD/RcrsyFA0qUkfYkm21FODaWhfep6gDRfJMclm4Ti7bmJBRTVPcl
         sx+O4JcT1rMyc2tKmhuaDcoLyla1HgxF3tSk6o0fiE51JWPyHI8MSvX1Tp1MA6V5hAaM
         4Eiw==
X-Gm-Message-State: AOAM532w5Lz051bvQAzFop0HSj7gIa9XxtQtAlI59iAQZxtFKLcJuqhb
        EDm9Eswd6j5qQBqkoErsCxCRpeEnpQ6VLQ==
X-Google-Smtp-Source: ABdhPJxyZgWA5pMHRFpuk/yhreZ8BMUbbIZ+wWPzQ7eFhvxI8A0S1qMZeKW9SEWmNzwG/Fr1eksoDg==
X-Received: by 2002:a50:9e0f:: with SMTP id z15mr11371999ede.278.1638900253757;
        Tue, 07 Dec 2021 10:04:13 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id he17sm141734ejc.110.2021.12.07.10.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 10:04:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1muep1-001EyH-FH;
        Tue, 07 Dec 2021 19:04:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, gitster@pobox.com
Subject: Re: [PATCH v5 0/2] Conditional config includes based on remote URL
Date:   Tue, 07 Dec 2021 18:56:40 +0100
References: <211206.86zgpdpmyy.gmgdl@evledraar.gmail.com>
 <20211207174617.1118046-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211207174617.1118046-1-jonathantanmy@google.com>
Message-ID: <211207.86k0ggnvfo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 07 2021, Jonathan Tan wrote:

>> I read through this and came up with the below as a proposed squash-in
>> just while reading through it. These may or may not help. Changes:
>> 
>>  * There was some needless "$(pwd)" in the tests
>
> Ah, thanks for catching that.
>
>>  * Inlining the "remote_urls" in the struct makes its management easier;
>>    and the free/NULL checks just check .nr now, and string_list_clear() can be
>>    unconditional.
>
> I don't think we can do this - nr might still be 0 after a scan if we
> don't have remote URLs for some reason, so we still need to distinguish
> between not-scanned and scanned-with-zero-URLs.

You mean so that we don't double-free? The way string_list_clear()
protects against that, but maybe there's something else.

Whatever it is (if there's anything) it could use test coverage then :)

>>  * Created a include_by_remote_url() function. Makes the overall diff smaller
>>    since you don't need to add braces to everything in include_condition_is_true()
>
> Ah, good idea. I'll do this.
>
>> Other comments (not related to the below):
>> 
>>  * It would be nice if e.g. the "includeIf.hasconfig:remote.*.url globs" test
>>    were split up by condition, but maybe that's a hassle (would need a small helper).
>> 
>>    Just something that would have helped while hacking on this, i.e. now most of it
>>    was an all-or-nothing failure & peek at the trace output
>
> What do you mean by condition? There seems to only be one condition
> (whether the URL is there or not), unless you were thinking of smaller
> subdivisions.

Maybe I'm just misunderstanding the intent here, but aren't you trying
to guard against the case of having a ~/.gitconfig that includes
~/.gitconfig.d/for-this-url, and *that* file in turns changes the
remote's "url" in its config, followed by another "include if url
matches" condition therein?

I.e. I read (more like skimmed) the documentation & test at the end as
forbidding that, but maybe that's OK?

>>  * Your last test appears to entirely forbid recursion. I.e. we die if you include config
>>    which in turn tries to use this include mechanism, right?
>> 
>>    That's probably wise, and it is explicitly documented.
>> 
>>    But as far as the documentation about this being a forward-compatible facility, do we
>>    think that this limitation would apply to any future config key? I.e. if I include based
>>    on "user.email" nothing in that to-be-included can set user.email?
>> 
>>    That's probably OK, just wondering. In any case it can always be expanded later on.
>
> We can decide later what the future facility will be, but I envision
> that we will not allow included files to set config that can affect any
> include directives in use. So, for example, if I have a user.email-based
> include, none of my config-conditionally included files can set user.email.

I didn't look deeply at the implementation at all, but why would this be
a problem?

You parse ~/.gitconfig, it has user.name=foo, then right after in that
file we do:

    [includeIf "hasconfig:user.name:*foo*"]
    path = ~/.gitconfig.d/foo

Now the top of  ~/.gitconfig.d/foo we have:

    [user]
    name = bar
    [includeIf "hasconfig:user.name:*bar*"]
    path = ~/.gitconfig.d/bar

Why would it matter that we included on user.name=foo before?

Doesn't that only matter *while* we process that first "path" line? Once
we move past it we update our configset to user.name=bar once we hit the
"name" line of the included file.

Then when we get another "hasconfig:user.name" we just match it to our
current user.name=*bar*.

No?

Anyway, I think it's fine to punt on it for now or whatever, just
curious...
