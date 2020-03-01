Return-Path: <SRS0=kadj=4S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF1EC3F2D1
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 22:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E56724697
	for <git@archiver.kernel.org>; Sun,  1 Mar 2020 22:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jvzoz5yC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgCAWFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Mar 2020 17:05:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38467 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgCAWFh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Mar 2020 17:05:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id u9so3010378wml.3
        for <git@vger.kernel.org>; Sun, 01 Mar 2020 14:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=e9rctuTdeDYWDK8wtgPRNnBEXTDXvzsPNGafbUgYsb8=;
        b=Jvzoz5yCvT4rRZVr+cvgkVj+b0EEWNIWQql7iWeg3mwLFZdvsjFzVC1qydEj1o7tqJ
         HTvEhm7hHN/hNQ3gzai0BaMoAQnP+dcVL5xIsqj3bEQDcT0HqvzCwq2a1FDJSkdtjWgx
         9TQjUbOGb9y9NopC96Pkpo8BD01gllOP7hQKikv7qOscwbhFt0Jg9cbUSggjd69oQHpO
         Z6Ow5ldZyIwX6kLNATAoOI19ZswDQLfdzxLRzMI+YnPMZkf76b5uwUc4jmkygyz1LI1m
         n4N55AWFxfVBpmygtZDgQ+RKt8Btz6dHcL4pWVHfWvZqI3s7oD/KlOl9GISrR5NgpCu0
         0F1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e9rctuTdeDYWDK8wtgPRNnBEXTDXvzsPNGafbUgYsb8=;
        b=WDdKm/6/v6lF86zINrWb5tRq2FXHnYDgQPt7zXvV4Tc6VkQJgz5aUARl5d/FZ4ynj4
         fXCRNsBtHVRP0hfBbUujG4uYpLPbpeQ8ljhFdDXqNLMLQGdm7kkAsT1YXMW/tsIR0jYN
         IZmy7ra+fAYAVajNz+iUFXehkfWa8YIsqnBSIRakHBuWPqYhkfoGmkfhD5TVj7mDq47N
         O+H/pL55rC2wDHMqY4Gw0RDhp6Z5Ph2S6jhqj/uhqkYNXSkWt+VLALShfy4wlvyWGlYI
         2WUpNhdo6i/CcwUymEKRUH6T/DOtR7ESCaibkicfL+omlncmxtZtl8qW2FMgYINFztYh
         k9dg==
X-Gm-Message-State: APjAAAV1bkqeCvUvMNUM/WCRAA/ee/W5l+X8wRAWGwCtiYROMiRc4xYH
        JxFLQQZZ6V8WTAeGhWgtiUs=
X-Google-Smtp-Source: APXvYqyMa+06169veRLj0icCw+cYet7aRPMv1zkSuB3boiOMdcMzo4AWKanOpeEHFdqcdpm7NZVhZw==
X-Received: by 2002:a7b:c249:: with SMTP id b9mr15959335wmj.74.1583100334411;
        Sun, 01 Mar 2020 14:05:34 -0800 (PST)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id n13sm12950910wmd.21.2020.03.01.14.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 14:05:33 -0800 (PST)
Date:   Sun, 1 Mar 2020 23:05:31 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     J Wyman <jwyman@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] remote.c: fix handling of push:remote_ref
Message-ID: <20200301220531.iuokzzdb5gruslrn@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Sun, 01 Mar 2020 21:52:15 +0100
References: <20200228172455.1734888-1-damien.olivier.robert+git@gmail.com>
 <20200228182349.GA1408759@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200228182349.GA1408759@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First I apologize for sending the patch too soon, I forgot to put the RFC
flag, this is not a complete patch, and I do intend to fix the tests. I was
aware of this issue since my patch about push:track, but since I don't use
push:remoteref this was a low priority to fix. Last friday I was sick and
could not work, so I took the opportunity to scratch this itch.

From Jeff King, Fri 28 Feb 2020 at 13:23:49 (-0500) :
> Just to back up a minute to the user-visible problem, it's that:
>   git config push.default matching
>   git for-each-ref --format='%(push)'
>   git for-each-ref --format='%(push:remoteref)'
> prints a useful tracking ref for the first for-each-ref, but an empty
> string for the second. That feature (and remote_ref_for_branch) come
> from 9700fae5ee (for-each-ref: let upstream/push report the remote ref
> name, 2017-11-07). Author cc'd for guidance.

Yes exactly.
 
> I wonder if %(upstream:remoteref) has similar problems, but I suppose
> not (it doesn't have this implicit config, so we'd always either have a
> remote ref or we'd have no upstream at all).

And the code is different. upstream:remoteref uses branch->merge_name[0].
This is due to the fact that the branch struct stores different things for
merge branches than for push branches (which hurt my sense of symmetry :)).

> > In all these cases, either there is no push remote, or the remote_ref is
> > branch->refname. So we can handle all these cases by returning
> > branch->refname, provided that remote is not empty.
> In the case of "upstream", the names could be different, couldn't they?

Yes of course. Moreover there is also the case of 'nothing' where we should
not return the branch name (so what we should test for in the other cases
is not the existence of `remote` but of `branch->push_remote_ref`.)

> We'd want some test coverage to make sure this doesn't regress. There
> are already some tests covering this feature in t6300. And indeed, your
> patch causes them to fail when checking a "simple" push case (but I
> think I'd argue the current expected value there is wrong). That should
> be expanded to cover the "upstream" case, too, once we figure out how to
> get it right.

Yes, I'll do both simple and upstream for tests I think.

> > diff --git a/remote.c b/remote.c
> > index 593ce297ed..75e42b1e36 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -538,6 +538,11 @@ const char *remote_ref_for_branch(struct branch *branch, int for_push,
> >  					*explicit = 1;
> >  				return dst;
> >  			}
> > +			else if (remote) {
> > +				if (explicit)
> > +					*explicit = 1;
> > +				return branch->refname;
> > +			}
> 
> Saying "*explicit = 1" here seems weird. Isn't the whole point that
> these modes _aren't_ explicit?

Well pushremote_for_branch also set explicit=1 if only remote.pushDefault
is set, so I followed suit.

> It looks like our only caller will ignore our return value unless we say
> "explicit", though. I have to wonder what the point of that flag is,
> versus just returning NULL when we don't have anything to return.

I think you looked at the RR_REMOTE_NAME (ref-filter.c:1455), here the
situation is handled by RR_REMOTE_REF, where explicit is not used at all.
So we could remove it.


So it remains the problem of handling the 'upstream' case.
The ideal solution would be to not duplicate branch_get_push_1.
In most of the case, this function finds `dst` which is exactly the
push:remoteref we are looking for. 

Then branch_get_push_1 uses
		ret = tracking_for_push_dest(remote, dst, err);
which simply calls
	ret = apply_refspecs(&remote->fetch, dst);

The only different case is
	case PUSH_DEFAULT_UPSTREAM:
		return branch_get_upstream(branch, err);
which returns
	branch->merge[0]->dst

So we could almost write an auxiliary function that returns push:remoteref
and use it both in remote_ref_for_branch and branch_get_push_1 (via a
further call to tracking_for_push_dest) except for the 'upstream' case
which is subtly different.

In the 'upstream' case, the auxiliary function would return
branch->merge_name[0]. So the question is: can
tracking_for_push_dest(branch->merge_name[0]) be different from
branch->merge[0]->dst?

Now branch->merge is set in `set_merge`, where it is constructed via
		if (dwim_ref(ret->merge_name[i], strlen(ret->merge_name[i]),
			     &oid, &ref) == 1)
And I don't understand dwim_ref enough to know if there could be
differences in our setting from tracking_for_push_dest in corner cases.


Another solution could be as follow: we already store `push` in
`branch->push_tracking_ref`. So the question is: can we always easily convert
something like refs/remotes/origin/branch_name to refs/heads/branch_name
(ie essentially reverse ètracking_for_push_dest`), or are there corner cases?


Otherwise a simple but not elegant solution would be to copy paste the
code of branch_get_push_1 to remote_ref_for_branch, simply removing the
calls to `tracking_for_push_dest` and using remote->branch_name[0] rather
than remote->branch[0]->dst for the upstream case.



-- 
Damien Robert
http://www.normalesup.org/~robert/pro
