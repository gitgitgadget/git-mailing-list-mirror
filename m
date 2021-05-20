Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730DAC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 17:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4439C613CA
	for <git@archiver.kernel.org>; Thu, 20 May 2021 17:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbhETRtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 13:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbhETRtE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 13:49:04 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0880BC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 10:47:42 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id v14so9654467pgi.6
        for <git@vger.kernel.org>; Thu, 20 May 2021 10:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gfyHOA5Xm5XG9KTIiFroQ0jF7l8ia7kNwdpZkFqYRAc=;
        b=qaKsP8B7lT+KvWQCLw6966lFOCEs4jiuXzDqRFpdVBI0LaSxHGwEwZTtTIbgdYaIy4
         57lBzOn5K2gcXlP7+TxF/Rs4uZtJFh51pwCLRc3e1I4oxynvPYMxJACi9y+E1a1Oeq5t
         Q1a+nOG8lewl+1/+h47ve3PNoakiJcNScJSdRf7Z5btIldVbGAPB3AEUbtg1tniCoPWw
         BtIEk553MdB+/PRH57IQj7HC8EjtKKhaTbmMqBsyEvpAvi2WMcFSEU8Bco6kAn94d1MR
         buaKWkF8HoYaBezUshZTnamy0ruazW3e4v1WJfF+Ru5/W58CjP2GhF+1WRbLQ6dunoL3
         SUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gfyHOA5Xm5XG9KTIiFroQ0jF7l8ia7kNwdpZkFqYRAc=;
        b=k/Uug+Jy4SZkenohzq9TOs3or/V/7cdUWLEYatt6IClTV9bpHEIessu0PIlBOkNV+t
         Ir/OjXVeYTDVAnwNsvMTrxCtvxuvx8mlYaONMaw2o+5DHOKX58bvG7G7AYFe+mPGZZ4J
         QfsYRmpjKQFRH2S1PUu0vPpn/NbByp3SBo5mzJppn8Tpq4Ngqa+xX64YsPr4d7bmXc3T
         OcaYMUQ3rbIHuiMWCWmexTvIx1hl0PlyvH3jNQsYzG+cVPCKemD7uDRgZN71rqxRSxOA
         O34b7NBOnUOxAVZ1aIoV85gMYgX2bRPOi4wDuOJBmqlg83tsTtZV8a+ZXsdFeA3bFw4F
         zxvw==
X-Gm-Message-State: AOAM532IshBv9G6I4ynmf2D+0x2wc8oeCDiAwV1JxY1M9uYhGMkfoGr9
        E6qY8/+oAnFyVPgXA3ZN/yA=
X-Google-Smtp-Source: ABdhPJwJ4xWUih7ZzjTcNIacr4bZmg4z2izsQ9j9qW9HDonc2ClRONt8SjLCkCMBKrNOjgCGmNfhgg==
X-Received: by 2002:aa7:8d46:0:b029:2de:75aa:1964 with SMTP id s6-20020aa78d460000b02902de75aa1964mr5584808pfe.61.1621532861417;
        Thu, 20 May 2021 10:47:41 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4edd:d685:2ff9:b567])
        by smtp.gmail.com with ESMTPSA id p11sm2449005pgn.65.2021.05.20.10.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 10:47:40 -0700 (PDT)
Date:   Thu, 20 May 2021 10:47:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: RFC: error codes on exit
Message-ID: <YKaguiSjewjpvOj5@google.com>
References: <YKWggLGDhTOY+lcy@google.com>
 <YKZj/s/9dp4Oo7aB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKZj/s/9dp4Oo7aB@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Wed, May 19, 2021 at 04:34:24PM -0700, Jonathan Nieder wrote:

>> One kind of signal we haven't been able to make good use of is error
>> rates.  The problem is that a die() call can be an indication of
[... list of some categories snipped ...]
> I've run into this problem, too. If you run a website that runs Git
> commands on behalf of users and try to get metrics on failing exit
> codes, it's hard to tell the difference between "the repo is broken",
> "Git has a bug", "the user (or other caller) asked for something
> stupid", and "some transient error occurred".
>
> But I'm not sure that even Git can always tell the difference between
> those things. Some real-world examples I've run into:
>
>   - "rev-list $oid" can't find object $oid. Is the repo corrupt? Or is
>     the caller unreasonable to ask for that object? Or was there a race
>     or other transient error which made the object invisible?
>
>   - upload-pack is writing out a packfile, but gets EPIPE. Did the
>     network drop out? Or is a Git bug causing one side to break
>     protocol?
>
> Some rough categorization may help, but a lot of those need to propagate
> the specific errors back to the caller. For instance, the rev-list
> example could be FAILED_PRECONDITION in your terminology. But really, we
> want to tell the caller "the object you asked for doesn't exist". And
> then it can decide if that was user error (somebody hitting a URL for an
> object that we have no reason to think exists), or a sign of problems
> elsewhere in the system (if we just got $oid from Git, we expect it to
> be there).
>
> So it seems like the most useful thing is specific error codes for
> specific cases.

As a bit of precedent: in the server we have both of these: we have
application-specific error codes like AUTHENTICATOR_EXPIRED, and we
have generic codes that those map to like UNAUTHENTICATED.  The
application-specific codes tend to be useful for ad hoc queries as
part of incident response, versus the generic codes that have been
more useful for defining an SLO (because they are about "how do I want
to respond to this error" instead of about the cause).

More specifically for the "missing object" case: it's common enough
for a user to ask for an object that doesn't exist that we indeed call
it FAILED_PRECONDITION, which has worked well.  We have other
monitoring in place for checking that all repositories pass fsck and
that fetching an object after pushing it succeeds.  (In general, this
kind of case is very common in monitoring any service that has state.)

>                 And that gets very daunting to think about annotating
> and communicating about each such case (we don't even pass that level of
> detailed information inside the program in a machine-readable way;
> scraping stderr is the best way to figure this stuff out now).

This feels like good news to me: it sounds like if we add
application-specific codes like MISSING_OBJECT to Git, then it would
be useful to both of us.

The mapping to HTTP-status-style generic codes could then wait for
later, to be submitted if and when others have interest.  (I.e., that
part is easy to keep maintained internally.)

So I'm feeling encouraged. :)

> I dunno. Maybe a rougher categorization would help your case, but not
> mine. But I'm a bit skeptical that we'll have enough coverage of various
> conditions to be useful, and that it won't turn into a headache trying
> to categorize everything.

Two more points I want to emphasize:

 1. We don't have to be exhaustive: as Felipe suggested, it's fine for
    some errors (even most error paths!) to use a code such as
    UNKNOWN.  I care more about coverage of commonly occuring errors
    than categorizing everything, especially because this sets up a
    feedback loop that can lead to improved coverage over time.

 2. By focusing on the practical and ignoring everything else, I think
    we can avoid this becoming an unbounded taxonomy exercise.  That's
    part of the appeal of code.proto /
    https://github.com/abseil/abseil-cpp/blob/HEAD/absl/status/status.h
    for me: by using a preexisting list of codes based on "here is
    what a user would be expected to do in response to this error",
    they make the error classification decision relatively simple.  I
    think we can maintain that kind of simplicity with a Git-specific
    enum, too, so I think this is doable (and I'd make sure to be
    available over time to help answer questions about the
    classification as the project gets used to it).

Thanks,
Jonathan
