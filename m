Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1DC320970
	for <e@80x24.org>; Fri, 14 Apr 2017 20:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbdDNUMZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 16:12:25 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36171 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751854AbdDNUMY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 16:12:24 -0400
Received: by mail-pg0-f41.google.com with SMTP id g2so47029562pge.3
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 13:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Mbml6nz6yeMcvsQqwSnsdX8F8HIgDB5vLFfFQ4rXv+E=;
        b=r778STWWGf99aDBC00L4dpukGNgiB6+0TNBrvybhnoUqi1uP2eAEVkQCy9wBx6Kgi4
         9NTIqhjx86be9dlDbKAiAxkiLO9xz/5kPYoDZIGHsu7eehaLqS1DElIs+FML6mkPiflA
         Oz0KjmzteN38M2Ohpn0UN12/sUcJNe+som1bwH+NZsgLm/7CHndKd2v0qX+4PXgU4brf
         WZz4S//i5QBNOsgbcR0lco4Vpsy5wwcnXa7Zy7NgiRdnLHw/YaPeZrctai6SH+lNQgfE
         kZkgvI7vcY8ZK9v+iRi3UWekgjttdy9Ucr6Et9BhtL3h2718HZWKpL/gJO132xHemBl+
         IjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mbml6nz6yeMcvsQqwSnsdX8F8HIgDB5vLFfFQ4rXv+E=;
        b=oujTWspZpn/3BHEtGMdGAtMfrpEyFitDzuuBxo0nt5v3gROQu1jUSrjOJK1knKFSlt
         wNeYQuqjxbvTY/+VBejJk6WtffX4d2h4Tg9fEHZg+0f2aZUaEJ3tE7H/xEpOkhG82J8o
         9vcNH5LuZZtIV3stci9mKfb9sVDl+h6Vjd7hTxmjTPC7+pAVvhO1nTGpU9AH3hfYI3kR
         cBAS9QM1QAScVHIyKpSAZ1sONqLw4hTOU0fZa+FyvmjykZT8dpG2HHsjfSZHlQlQTpzV
         RpOfSW8ny7RE4z/3nRBULIAa4Pywp+V7rVbhMeb4mN6/Ue7s24IYXR5aTeFDjLEa2Rwr
         JARQ==
X-Gm-Message-State: AN3rC/5/LOcqV2gnOZLYS9+6G5JBHTtZgYbzYIsmbSbmJQCQ7bz5NGQ8
        djU4DEb32lRrSk7LQqGZK4LguOwN/h5C
X-Received: by 10.98.72.88 with SMTP id v85mr8766504pfa.8.1492200743300; Fri,
 14 Apr 2017 13:12:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Fri, 14 Apr 2017 13:12:22 -0700 (PDT)
In-Reply-To: <15b87ca2-98c4-edfc-1e7e-7a25c28bd8da@google.com>
References: <20170411234923.1860-1-sbeller@google.com> <20170411234923.1860-2-sbeller@google.com>
 <15b87ca2-98c4-edfc-1e7e-7a25c28bd8da@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 14 Apr 2017 13:12:22 -0700
Message-ID: <CAGZ79kYQpVKc1GGj4hxw6t-6eDo8zPjwf=CtEPFTc9b4St1EOQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] entry.c: submodule recursing: respect force flag correctly
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2017 at 11:28 AM, Jonathan Tan <jonathantanmy@google.com> wrote:

>> @@ -282,12 +283,11 @@ int checkout_entry(struct cache_entry *ce,
>>                                         unlink_or_warn(ce->name);
>>
>>                                 return submodule_move_head(ce->name,
>> -                                       NULL, oid_to_hex(&ce->oid),
>> -                                       SUBMODULE_MOVE_HEAD_FORCE);
>> +                                       NULL, oid_to_hex(&ce->oid), 0);
>
>
> Should we be consistent (with the "else" block below and with the existing
> code) to use "state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0" instead of 0? (I
> glanced briefly through the code and SUBMODULE_MOVE_HEAD_FORCE might have no
> effect anyway if "old" is NULL, but it's probably still better to be
> consistent.)

ok, will do.

>>
>> +       if (o->reset)
>> +               flags |= SUBMODULE_MOVE_HEAD_FORCE;
>
>
> It seems to me that this is independent of the entry.c change, and might be
> better in its own patch. (Or if it is not, maybe the subject should be
> "entry, unpack-trees: propagate force when submodule recursing" or something
> like that, containing the names of both modified components.)

eh. I realize the patch evolved after writing the commit message initially.
Maybe:

  fix all submodule_move_head force flags

  Audit all callers of  submodule_move_head and make sure the
  force flag is handled correctly.


>
> Also, you mentioned in the parent message that this patch is required for
> patch 3. Is only the entry.c part required, or unpack-trees.c, or both?
>
>> +
>>         switch (sub->update_strategy.type) {
>>         case SM_UPDATE_UNSPECIFIED:
>>         case SM_UPDATE_CHECKOUT:
>> -               if (submodule_move_head(ce->name, old_id, new_id,
>> SUBMODULE_MOVE_HEAD_DRY_RUN))
>> +               if (submodule_move_head(ce->name, old_id, new_id, flags))
>>                         return o->gently ? -1 :
>>                                 add_rejected_path(o,
>> ERROR_WOULD_LOSE_SUBMODULE, ce->name);
>>                 return 0;
>> @@ -308,6 +312,7 @@ static void unlink_entry(const struct cache_entry *ce)
>>                 case SM_UPDATE_CHECKOUT:
>>                 case SM_UPDATE_REBASE:
>>                 case SM_UPDATE_MERGE:
>> +                       /* state.force is set at the caller. */
>
>
> I don't understand the relevance of this comment - it is indeed set there,
> but "state" is not used there until after the invocation to unlink_entry so
> it doesn't seem related.

Well we would have wanted to put
  state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0
here, but state is not passed into this function, so just make a comment
why we keep it at force all the time.

Thanks,
Stefan
