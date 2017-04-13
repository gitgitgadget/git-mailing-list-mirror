Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99A5920960
	for <e@80x24.org>; Thu, 13 Apr 2017 19:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755136AbdDMTRb (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 15:17:31 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33551 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbdDMTR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 15:17:29 -0400
Received: by mail-pf0-f179.google.com with SMTP id s16so32525819pfs.0
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 12:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rv2DOnBz+3i2RO3I6qpGwhweTQzOVzu9L+iTxnEbHC0=;
        b=hzAsLFlfNZy66QxK+zudGQv20PTY9CdG/ngd1qz0dEeLqy0NW4DfonMciDDZAgnHq0
         MxzbCNY60oSzxUtvElMbJcYN8uW9ofEaqED2UQtVG9MWwGeq0GzKnEofkfW65HrFq2dF
         CXO6aSWq8PNEWdtk375lf1Ou/BzF4/wfu1puhHrm1sVer1DjZAuxUN6Xv9lgPHlLpywf
         7okrXm31gKeHO8GNhsLZa694dG3YUZrClwWf1zu2pn5BZxXsNzDNXWbT2SS5QncCLGLt
         tNSXUTuSk8FEPEGsTXdXuiU/nScL0Qz0emzBb7zxPCujEg7cPHyD83wZ4Fpiiu3beCaT
         KQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rv2DOnBz+3i2RO3I6qpGwhweTQzOVzu9L+iTxnEbHC0=;
        b=D6WIvW+nQOrmh01umuuZJgMffReU3Lrg4Gt4A7oQY0C7djJS+vCkcC4JAZ6kZiuzka
         50tk3mfwikGcX0x+CeMY4BwDyNG08ENLz7hlR0Ok+YbHmqW3TQmjuHLY6RPQo3cDMepw
         0jNGfQBVN4+xXPq6qO7z9nxOFDzstmJ1+BsLj48h/FTNAzH7pU5C/4+pXuvetHmKwXxi
         ZWYBQ+Fk/ONr6FyrLQ7ffyvJQUY7VhF1Nf9Yu35BG2Ps9vrXekJZxFUInVVNarrM8/gS
         D4OdJl08VEXZUr84jJeGDTYULT2AfAPAvA2AkhlKchkcecx6HfiQ0G71AsSJFKxSVDsS
         6l0A==
X-Gm-Message-State: AN3rC/6icx+7qM3Up1TaTAiOCAJlFFsAOYJNzehz/UGso2Zb3EOTFtWS
        2lUJGBQnrDtPHVM91hEhqKEK58HabIkV
X-Received: by 10.99.119.140 with SMTP id s134mr4204071pgc.162.1492111049098;
 Thu, 13 Apr 2017 12:17:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Thu, 13 Apr 2017 12:17:28 -0700 (PDT)
In-Reply-To: <20170413190839.GE96917@google.com>
References: <20170411234923.1860-1-sbeller@google.com> <20170411234923.1860-4-sbeller@google.com>
 <20170413190839.GE96917@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Apr 2017 12:17:28 -0700
Message-ID: <CAGZ79kZktYHFnPfHQvW_7H2Ec=ftgWwqRgLHBZxQOMmy5R8y_g@mail.gmail.com>
Subject: Re: [PATCH 3/4] submodule.c: harden submodule_move_head against
 broken submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 12:08 PM, Brandon Williams <bmwill@google.com> wrote:
> On 04/11, Stefan Beller wrote:
>> Early on in submodule_move_head just after the check if the submodule is
>> initialized, we need to check if the submodule is populated correctly.
>>
>> If the submodule is initialized but doesn't look like populated, this
>> is a red flag and can indicate multiple sorts of failures:
>> (1) The submodule may be recorded at an object name, that is missing.
>> (2) The submodule '.git' file link may be broken and it is not pointing
>>     at a repository.
>>
>> In both cases we want to complain to the user in the non-forced mode,
>> and in the forced mode ignoring the old state and just moving the
>> submodule into its new state with a fixed '.git' file link.
>
> What about the case where you have marked a submodule as active but
> don't have its respective .gitdir yet?  For now i think it would be
> acceptable to complain and do nothing/ignore it, in the future we may
> want to actually clone and then check it out.

I agree. With this patch we'd complain in non-forced mode, and in
forced mode we'd also complain as we lack the object.

In both cases in the future we may want to fetch the contents instead.
