Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5EAC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 22:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9420661247
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 22:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhHXWk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 18:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhHXWk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 18:40:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DD5C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 15:39:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y5so3168944edp.8
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 15:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=yGMkGP0ysVMgF+NsRirzf+HNEDi5txPs87Mq04TbOIE=;
        b=b26qM4JecXWVJU626HRVxjXo3tJaup7sUChIQYDAYGFnGFyYNHseAvvT+35qhn67JZ
         FygCEd6yxQyDTX1G6g8XVUw7zmMrzaVi9F9/RE5pSionCE28k5x1f0XdnaZI6hTKSPWo
         NNCpGSItBxdVCQd0zILFfBGk5t2l90y0ZQkvVJ0d4dcG8w+K+7WEy1X5wwI7R118a8CU
         M9wqGwqaS/s5ykXTuzQcNOphHw/SWpF/a00E5a43hNzYcvAhWcze5hAM9bAYnGL52Hs7
         NaA/Y6pJammYLUhIRS4We76xNttR8nRVTXMgfvlKyG0bydI3b98VysMGgTkWJo2ICdxl
         DgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=yGMkGP0ysVMgF+NsRirzf+HNEDi5txPs87Mq04TbOIE=;
        b=cKotqiXr7aqHEK9inNesFxifr3Zg5tPuCFnuXer3lLIlC7LVaBxSH+uj5h6tZTm7gZ
         DABGvOU8jdNfoTD//PV9Yz8AIe26aeEENXIzdbLTGyAZQFWJtYh0t2RBoetpGuFAUl8K
         j7d0uyteq4lmUfBXdBxHqP2wO8xGRMQmNwWdU/fppy9oo/nnVGwCmZCMkQD82ZSuuH9A
         /r/mP8GjT+9HM/tTLET/IaVbWnuz+PeCEGf1G9cqwxUk+RuQ9u5VxcvPNa+dVmpwbEEA
         9NyFVzwRT8W7dqxiRepFDo+fA6tyqNyRFuiINnkHGmGf01I5AT/qAJRlrx3hxljxgzRY
         n+Dg==
X-Gm-Message-State: AOAM533D1xwyp4OrPYqSKe67SxQuI3LWRrW10STMNL/82tFAI28/nOq4
        W+9Uq5hRH89QGK5UowK/Q/s=
X-Google-Smtp-Source: ABdhPJwnh5rQR5UrQnOGBweKbGxTJhAikBumAJs9yOuof1CsuBF4Od0vO02+zEBlzljpR23+fUX7oA==
X-Received: by 2002:a05:6402:34c8:: with SMTP id w8mr38428853edc.330.1629844779254;
        Tue, 24 Aug 2021 15:39:39 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b3sm9989278ejb.7.2021.08.24.15.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 15:39:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [RFC PATCH 13/13] bundle-uri docs: add design notes
Date:   Wed, 25 Aug 2021 00:33:04 +0200
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
 <RFC-patch-13.13-1e657ed27a-20210805T150534Z-avarab@gmail.com>
 <YSVpLjAhhS8v2dR7@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YSVpLjAhhS8v2dR7@camp.crustytoothpaste.net>
Message-ID: <87y28qcvrp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 24 2021, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2021-08-05 at 15:07:29, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Add a design doc for the bundle-uri protocol extension to go along
>> with the packfile-uri extension added in cd8402e0fd8 (Documentation:
>> add Packfile URIs design doc, 2020-06-10).
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  Documentation/technical/bundle-uri.txt  | 119 ++++++++++++++++++++++++
>>  Documentation/technical/protocol-v2.txt |   5 +
>>  2 files changed, 124 insertions(+)
>>  create mode 100644 Documentation/technical/bundle-uri.txt
>>=20
>> diff --git a/Documentation/technical/bundle-uri.txt b/Documentation/tech=
nical/bundle-uri.txt
>> new file mode 100644
>> index 0000000000..5ae9a15eaf
>> --- /dev/null
>> +++ b/Documentation/technical/bundle-uri.txt
>> @@ -0,0 +1,119 @@
>> +Bundle URI Design Notes
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +Protocol
>> +--------
>> +
>> +See `bundle-uri` in the link:protocol-v2.html[protocol-v2]
>> +documentation for a discussion of the bundle-uri command, and the
>> +expectations of clients and servers.
>> +
>> +This document is a a more general discussion of how the `bundle-uri`
>> +command fits in with the rest of the git ecosystem, its design goals
>> +and non-goals, comparison to alternatives etc.
>> +
>> +Comparison with Packfile URIs
>> +-----------------------------
>> +
>> +There is a similar "Packfile URIs" facility, see the
>> +link:packfile-uri.html[packfile-uri] documentation for details.
>> +
>> +The Packfile URIs facility requires a much closer cooperation between
>> +CDN and server than the bundle URI facility.
>> +
>> +I.e. the server MUST know what objects exist in the packfile URI it's
>> +pointing to, as well as its pack checksum. Failure to do so will not
>> +only result in a client error (the packfile hash won't match), but
>> +even if it got past that would likely result in a corrupt repository
>> +with tips pointing to unreachable objects.
>> +
>> +By comparison the bundle URIs are meant to be a "dumb" solution
>> +friendly to e.g. having a weekly cronjob take a snapshot of a git
>> +repository, that snapshot being uploaded to a network of FTP mirrors
>> +(which may be inconsistent or out of date).
>> +
>> +The server does not need to know what state the side-channel download
>> +is at, because the client will first validate it, and then optionally
>> +negotiate with the server using what it discovers there.
>> +
>> +Using the local `transfer.injectBundleURI` configuration variable (see
>> +linkgit:git-config[1]) the `bundle-uri` mechanism doesn't even need
>> +the server to support it.
>
> One thing I'm not seeing with this doc that I brought up during the
> packfile URI discussion is that HTTPS is broken for a decent number of
> Git users, and for them SSH is the only viable option.  This is true for
> users of certain antivirus programs on Windows, as well as people who
> have certain corporate proxies in their workplace.  For those people, as
> soon as the server offers a bundle URI, their connection will stop
> working.
>
> I know that you're probably thinking, "Gee, how often does that happen?"
> but judging by the number of people on StackOverflow, this is actually
> very common.  The antivirus programs that break Git are actually not
> uncommon and they are widely deployed on corporate machines, plus the
> fact that lots of companies sell TLS intercepting proxies, which are
> almost always broken in this way.  Many of these users don't even know
> what's going on, so they simply lack the knowledge to take any action or
> ask their network administrator for a fix.  For them, HTTPS just doesn't
> work with Git, while it does for a web browser.
>
> So we will probably want to make this behavior opt-in with a config
> option for SSH, or just not available for SSH at all, so that we don't
> magically break users on upgrade who are relying on the SSH protocol not
> using HTTPS under the hood[0], especially the users who won't even know
> what's wrong.

Good point, I think this sort of thing will be a non-issue with
bundle-uri, because in general it handles any sort of network / fetching
/ validation failures gracefully. I.e. with these patches you can point
at a bad URI, broken non-bundle etc. We'll just move on to a full clone.

Whereas with packfile-uri the inline PACK and the URI are things you
MUST both get, as the provided packfile-uri completes the incomplete
inline PACK. So once you say that you're willing to accept things over
https, you MUST be able to get that thing.

We'll still waste a bit of time trying though with bundle-uri. But I
think for the common case of bundle-uri helping more than not (which
presumably, the server operator has tested), it's a better default to
try https:// even if the main dialog is over ssh://.
