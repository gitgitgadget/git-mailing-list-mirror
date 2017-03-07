Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AEA51FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 23:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbdCGXqq (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 18:46:46 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33285 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933223AbdCGXqo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 18:46:44 -0500
Received: by mail-pf0-f182.google.com with SMTP id w189so6660985pfb.0
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 15:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C3CE2oEAbn1BfAIUJJmW/EwCYvU7wIfEHkG40XHk0nU=;
        b=Nm3MM+nE0p0zp41YXnYUOW3xRAI8LMJ7j2Wam48F61NhtZi0TCs9jnyOGRom1YzY3/
         qMMSksubSo9ZxbW4eV97wTiS+VL7Fixi+CdcmbH7gQe5/ZeQWIKgPn3iJFUlFNMCIaXs
         hP6mrB2UOXd+4jnFaW16/CdDsvUzV3P4GT4lwBobblH8QVYGjHLYZxI3muMlPPEK3snO
         djeGkU6kFGJObgA8LQfli88Crl+PEsyf7ysbSct/uYXxf57RROgr8vT4748ucSu4Ipy3
         QQTgqNED5rm432HoQ4edVCSzBSFNRy4ZbvN2EdAu5zPKE0bsWjVvBou2csd4b8vlhcWM
         Vqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C3CE2oEAbn1BfAIUJJmW/EwCYvU7wIfEHkG40XHk0nU=;
        b=ldRlF+WC5iBfF7O0cfOzXdUwH3fEgeRjF37upTlloclyPzJkRcsq0zH7AKLCCWLzt7
         IpM6Y44naBedUwkBHSGgoibk9rM7rok4MS8Oj+jEjKhClymzEEoC76J0rCoiFRK92WWx
         HEn9UsdoOgXxtuJQnM0gLkzCFw7NAYttBnRsDW1O8KjamHXY7zdqS+RRZ0n0Yc+sBwas
         NEh9n8BlU5NfvQSvBiHyjOiiVBM6jS86y0iAPllkhqwxuNqMl5FL6OHTVZHlZe0vSYbe
         iQw2X69En2lR8TLzVRZWDe60T8gnLTDXdLfTBR7jSG11WyAtPQqQWwscEnjJfvMF1ytD
         7yJA==
X-Gm-Message-State: AMke39nxpOMlAvCrLTzBbiGnV7Gy6aySWlr2tvQF7wsqcFDajRHFJ0p7w8lmAL8rQlxPC4RmBRrNznlSY00TzAgt
X-Received: by 10.84.128.74 with SMTP id 68mr4118398pla.111.1488929849436;
 Tue, 07 Mar 2017 15:37:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Tue, 7 Mar 2017 15:37:28 -0800 (PST)
In-Reply-To: <xmqqfuio674n.fsf@gitster.mtv.corp.google.com>
References: <20170302004759.27852-1-sbeller@google.com> <20170306205919.9713-1-sbeller@google.com>
 <20170306205919.9713-16-sbeller@google.com> <xmqqfuio674n.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 7 Mar 2017 15:37:28 -0800
Message-ID: <CAGZ79kbdJa54YyKPHR9ycuJBVtyNY_2yaD7_5RPPu++Awiz5cA@mail.gmail.com>
Subject: Re: [PATCH 15/18] read-cache, remove_marked_cache_entries: wipe
 selected submodules.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        David Turner <novalis@novalis.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 7, 2017 at 2:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>

>> +             submodule_move_head(sub->path, "HEAD", NULL, \
>
> What is this backslash doing here?

I am still bad at following coding conventions, apparently.
will remove.

>> @@ -532,8 +550,13 @@ void remove_marked_cache_entries(struct index_state *istate)
>>
>>       for (i = j = 0; i < istate->cache_nr; i++) {
>>               if (ce_array[i]->ce_flags & CE_REMOVE) {
>> -                     remove_name_hash(istate, ce_array[i]);
>> -                     save_or_free_index_entry(istate, ce_array[i]);
>> +                     const struct submodule *sub = submodule_from_ce(ce_array[i]);
>> +                     if (sub) {
>> +                             remove_submodule_according_to_strategy(sub);
>> +                     } else {
>> +                             remove_name_hash(istate, ce_array[i]);
>> +                             save_or_free_index_entry(istate, ce_array[i]);
>> +                     }
>
> I cannot readily tell as the proposed log message is on the sketchy
> side to explain the reasoning behind this, but this behaviour change
> is done unconditionally (in other words, without introducing a flag
> that is set by --recurse-submodules command line flag and switches
> behaviour based on the flag) here.  What is the end-user visible
> effect with this change?

submodule_from_ce returns always NULL, when such flag is not given.
From 10/18:

+const struct submodule *submodule_from_ce(const struct cache_entry *ce)
+{
+       if (!S_ISGITLINK(ce->ce_mode))
+               return NULL;
+
+       if (!should_update_submodules())
+               return NULL;
+
+       return submodule_from_path(null_sha1, ce->name);
+}

should_update_submodules is always false if such a flag is not set,
such that we end up in the else case which is literally the same as
the removed lines (they are just indented).

>  Can we have a new test in this same patch
> to demonstrate the desired behaviour introduced by this change (or
> the bug this change fixes)?

This doesn't fix a bug, but in case the flag is given (in patches 17,18)
this new code removes submodules that are no longer recorded in
the tree.
