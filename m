Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10BDD1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 20:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbdBHUvN (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 15:51:13 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:36807 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbdBHUvL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 15:51:11 -0500
Received: by mail-io0-f182.google.com with SMTP id j13so424057iod.3
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 12:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lb67risvXp2Dg6HriVbt9V3UcD+Pucvvcu0io90TP1s=;
        b=r4lC6rBj5zCS1W5JA/yzrtBA+jtbSruXXQZ6q9y3EAn+Um1wBJ4ITv/N6OFwhcc7UX
         2lZ5RW6qfl090b2F1gOw6Cd2LSHD9JY7URsj8S6UmV6tmtQlij/Xtc9oL6Tc0fAjbyAh
         p/6PtfURfDuB17PjIjDOCuyb+SN9AyAoAs3HKz1S0EQxQb20v1nYUelo4ZqcplfrVh3J
         uqnWS+Lu1TOAw5ml5caP8IhLPz1lzQLR41HWGLEhb0EnMQ2gzZ/Iunyic6RJAfN/7xLL
         MqXjZyt4FHhAY5VDOZ7+47RTW6wCmyYrLj97H6OVudschJ1eskA8MACP7ngOlgIdyU4w
         H4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lb67risvXp2Dg6HriVbt9V3UcD+Pucvvcu0io90TP1s=;
        b=rSVeJtEcfCFAoDiRPZnrFvco3wUrgiAPJwh9iUwzWS/ZLAEtYMaCpNnX9PYAZDTjXN
         q0IDFQDwPq4i/Cim9vRR/r+As4xii37CpziXIG+ZlBa8HMgOKZT0dYJKgyZGswHXEnnP
         q6eQ8OP2ro9+Y7oI3li98XVGGMKuT4vPJSgK4Kf5WzBIeoVGHSXci+DCudgOaUK2PBKu
         qCXjwVqJIgnhr6/RQe6CkArIN83ElUlIGnWTKDBXt72GNQcwZF3j9d2DC35fKE6CSfjG
         VjvVCCgqeWHa3aAZETsclIkMtETfXiVy2cRdbkjI+qXjlFNISrUAFdnXoW78G8uRl11Q
         0aRw==
X-Gm-Message-State: AMke39lspzW6x2wrYq7fC8gDRhTGkMaFlaqOcuMx+O0CLSxEJdhdBIUdsoRRJMlLIVtR6/FSBSvdcgHhd1BpQ8m4
X-Received: by 10.107.16.14 with SMTP id y14mr67252ioi.164.1486587060613; Wed,
 08 Feb 2017 12:51:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 8 Feb 2017 12:51:00 -0800 (PST)
In-Reply-To: <xmqqpoiswo0l.fsf@gitster.mtv.corp.google.com>
References: <20170208010954.19478-1-sbeller@google.com> <xmqqpoiswo0l.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Feb 2017 12:51:00 -0800
Message-ID: <CAGZ79kaszczpnu+VEV3y+61qgji-0+vRFVLk8Q1+BbSDgiHz1Q@mail.gmail.com>
Subject: Re: [PATCH] push options: fail properly in the stateless case
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 8, 2017 at 10:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> When using non-builtin protocols relying on a transport helper
>> (such as http), push options are not propagated to the helper.
>>
>> Fix this by propagating the push options to the transport helper and
>
> The description up to this point is VERY readable and sensible.  But
> that makes the title sound a bit strange.

Yes, the title was there first and then I massaged the commit message
until it was readable. Originally I thought the issue is with stateless
protocols, but that is wrong. The underlying issue is just the transport
helper communication lacking.

> I read it as if it were
> saying "stateless case can never support push-options so fail if the
> caller attempts to use one", but that does not seem to be what is
> going on.

Indeed the subject is wrong.

>
>> adding a test that push options using http fail properly.
>
> Sounds sensible.  What end-user visible effect does this fix have?
> IOW, what feature do we use "push-option" for?

The Gerrit world started using push options for having a better git
experience, not needing to navigate to the web UI, e.g.:

    # push for review and set me as a reviewer:
    git push --push-option reviewer=sbeller@google.com  ssh://gerrit...

    # same with http, it looks like it worked, but the push option
    # never made it to the server
    git push --push-option reviewer=sbeller@google.com  http://gerrit...

    # This patch will make the second command fail, reporting
    # the http helper not supporting push options.

>
> Ahh, OK, so you need to describe that there are two issues in order
> to be understood by the readers:
>
>  (1) the helper protocol does not propagate push-option
>  (2) the http helper is not prepared to handle push-option
>
> You fix (1), and you take advantage of the fact (2) to ensure that
> (1) is fixed in the new test.
>
> With such an understanding, the title makes (sort of) sense and you
> wouldn't have to be asked "what end-user visible effect/benefit does
> this have?"

Your analysis is correct.

>
>> +'option push-option <c-string>::
>> +     Transmit this push option.
>> +
>
> There is no "c-string" in the current documentation used or
> defined.  The closest thing I found is
>
>     ... that field will be quoted in the manner of a C string ...
>
> in git-status page, but I do not think you send the value for an
> push-option after running quote_c_style(), so I am puzzled.

When implementing push options, we discussed that and according to
Documentation/git-push:

    The given string must not contain a NUL or LF character.

>
> I'd rather see 'option push-option <string>' as the bullet item, and
> in its description say how arbitrary values (if you allow them, that
> is) can be used, e.g. "Transmit <string> encoded in such and such
> way a the value of the push-option".

okay.
