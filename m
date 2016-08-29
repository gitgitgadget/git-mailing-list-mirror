Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B2821FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 21:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755468AbcH2VL1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 17:11:27 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35022 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752274AbcH2VL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 17:11:27 -0400
Received: by mail-oi0-f47.google.com with SMTP id j203so8344oih.2
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 14:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twitter.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KckBdjPK4mJCxjv8CFg+vozLlmQuSR6Lpbzi6B0ilOk=;
        b=KBrFqa9C98ODPh/H3ZnXXaVPQNdGVBN8xqS4Py1MRfGgcUWNQlxpzxCBEqwRC8G/jn
         Cc6//fqiYThbK+oRRHj22AK8yHJMKlTiarMBRYnzWCj2OJI63M8yKaGi838psP4IKrKk
         lqhpQP5Df/pDntzYb6988OZOmbAv2NTTihQbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KckBdjPK4mJCxjv8CFg+vozLlmQuSR6Lpbzi6B0ilOk=;
        b=DRUmUl7au4z7KN2WTGiZWQtPzgxal36m2Mejuxr9Waso3T4leTL42hrUaaitWhpdGt
         Dt43nfcX7Y5M+x6Wsnb9nGnlp8IT0OLqGjT5RvS7tbs3Vowhk4PmU7R2tgib3HMzHSQs
         k4khoBrptx2lXIBoK2TfBJUzsOgpAV2oFEhu6Ad1yWjlNzQp5Lnun47YpGfzCPLRjJEj
         LVkiPisF6EeljXG28ZfPJBQSswPdcakWYC2izWty8VTFcdhkcAC+vwrk3eyBWSp82JZ3
         d5uIq4OZ2z95A6bBJSacTInXKFuxl2Zw/apqaM9C60Lz8hCknCa3donpQufAtP1ANEpP
         /Smw==
X-Gm-Message-State: AE9vXwOUzhWZjoYC4Ce10sPhaMvF+eOc4bAHZj9PNZgchj2rMnq28tPuzvZYYGgqIDPq5B9mTZdNkb2dyMO3slhu
X-Received: by 10.202.97.198 with SMTP id v189mr60741oib.54.1472504594579;
 Mon, 29 Aug 2016 14:03:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.55.226 with HTTP; Mon, 29 Aug 2016 14:03:13 -0700 (PDT)
In-Reply-To: <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com>
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
 <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com>
From:   Uma Srinivasan <usrinivasan@twitter.com>
Date:   Mon, 29 Aug 2016 14:03:13 -0700
Message-ID: <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
Subject: Re: git submodules implementation question
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the reply. However, in this case....

      git clone $URL ./dir2
      git add dir2

how will "dir2" get ever get registered as a submodule? I don't see
how one can reach the "is_submodule_modified" routine for the scenario
above.

My understanding is that a sub-directory can be registered as a
submodule only with the "git submodule add ...." command. In this case
only a gitlink file is created within the sub-directory and not a .git
subdirectory. Please correct me if I am wrong.

Thanks again,
Uma

On Mon, Aug 29, 2016 at 1:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Uma Srinivasan <usrinivasan@twitter.com> writes:
>
>> git_dir = read_gitfile(buf.buf);
>> if (!git_dir)
>>
>>                 git_dir = buf.buf;
>>
>> Can anyone explain to me why we are replacing a failed reading of a
>> git file with the original sub directory name?
>
> A top-level superproject can have a submodule bound at its "dir/"
> directory, and "dir/.git" can either be a gitfile which you can read
> with read_gitfile() and point into somewhere in ".git/modules/" of
> the top-level superproject.  "dir/.git" can _ALSO_ be a fully valid
> Git directory.  So at the top of a superproject, you could do
>
>         git clone $URL ./dir2
>         git add dir2
>
> to clone an independent project into dir2 directory, and add it as a
> new submodule.  The fallback is to support such a layout.
>
