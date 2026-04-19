Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B97D1A9F9B
	for <git@vger.kernel.org>; Sun, 19 Apr 2026 18:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622286; cv=none; b=GiL+e29/dzsHGcRd5PDJop88d9d8wnylZ8HnBaK5k+yi/s1V/SMdrsYuTTDGmG1RkRfSep8QT+2FstS92kwuA6mY7H17+NeVBluoD4hbFCNswZRx1EFHznBtYbfW1oNzzhSE50E6cIoMsG9NsN6PfSIDZYmiQLurd/a1/Kvtdnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622286; c=relaxed/simple;
	bh=CQS3GOCb/amOvPK7JKQ+MUC8zbnLsbopa/L0UraY33U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLk8JD69ivvU20nuOedvWhIzSHq8mu3iRTK056zpQN1e+FkXM9iumyCgCHs3sLlruTfApnWwAMVadIaS4ZHCpmf3WcGo43wuJpiUav71oPy5QRbCkCsJotSph6CWqE2vAdU/BNdYpDA+sfiftpT9wGGQZxpBSSXzHvJ32m0Nhgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=TmMf/3LH; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="TmMf/3LH"
Date: Sun, 19 Apr 2026 20:11:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1776622275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FppgJCtccoerK3ih1zCmvSQQFlWFTqMrrRgr4YFPUg=;
	b=TmMf/3LHmPL4bmTKfV/o7DoVCQ+tRAfTVFFSPwSP/XOzVCKcjZcMsXgOUtvmunyGDuWIOo
	iXZlEfiALM7udXN1ybdi8/DWXBq8uImkG5lZ0+63iY+Fm4ZM1vjA2Wv6s/JyEoM4wc5dpA
	1XekYBKCNGAH2mCiNNI3PsI0byZzRb2Tsqs5nXYWWNgWcorjHdBrLaSq8sHxhBK3ca77j8
	J3f51OeAHGcHUP4vVZnnev/KAPeCj4HsrAYGy3xTU7SwlrpVyH57RFnodetQJCF6wfFSMC
	V7sS/JrcTFURyXKWNVZWLA2pkdpWHxKzDVhvCcAeFG37L1P7cVN97yO/iiolVg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, 
	Jeff King <peff@peff.net>, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH] revision.c: implement --reverse=before for walks
Message-ID: <aeUZUqSQI8FvRUco@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4685; i=mroik@delayed.space;
 h=from:subject:message-id; bh=CQS3GOCb/amOvPK7JKQ+MUC8zbnLsbopa/L0UraY33U=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBp5Rq1JG2g9NYZ47IK/t9G9Z2mb5dmEU5YZeWvf
 1yieRy65V+JAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaeUatQAKCRBIeX6hnBm+
 0VRSD/9eL45KSnrdGgq9DTkXlywAkljHXMBw4KqXoanQcn+oae8LxqiMQUWnyilV8iFP0mrs6i2
 /6Gk7JfoRZgGjmLAaXcOjMwpiwUKfTK9uMFB7l0mbKHtkWqXuN65+I5qN0+WXexxRfiKbA9t/jw
 CMg1vWcqeh/NFm3USZSpx4SQu5Lwban1QQSnZjjB08MOAYMEHZm6H5Gy82yFU7QzjruSXvmg4GD
 gZ/yI1iLHyipYlYrYoO8HPZvPRyITPcLYNsMry+MlWDz4bMCilBuDQaJx3FLRy42vI+HpYo8E9L
 VrUgMPE8viXTrphcXNDvpVWXibGq4Km+FZqnC/ZOmy2fEQe6bdDWfZEDKm3y/Nb7I36CjJWRk6v
 UPV7UdgCnoBbdmxNLl1UptQdjV1Lb+POtLlZCdPlLlxDUNGilADeTc6ZkkQJP178hN/qx2VSvkx
 s02FTFpZwWSC4x59nFHKPuUHoqDGzbMxxA5UPaOrgBofSJ3+h+qAh7tjqHHVhfZBVvqX0eZngd5
 cjhwB3LcrO9AEgbtyvtB0mIcGBJ8mMIoGEZ7h9+48W5sghT4sJxM9BAcgx4W61mtKBqM2x2MTgL
 JnyRtayAswtzcGyapeVeErpbDRKvbIpTqewIJj/jTnF8at7MdrA8/zi8vafN7d6Lq8SnmgS3U6w
 yJ60EHNQusrKMgg==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260418164736.2367523-2-mroik@delayed.space>
 <C60EE993-97DA-45F7-89DE-2F97ABB0F685@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C60EE993-97DA-45F7-89DE-2F97ABB0F685@gmail.com>
X-Spamd-Bar: -

On Sun, Apr 19, 2026 at 08:06:24AM -0400, Ben Knoble wrote:
> > -`--reverse`::
> > +`--reverse[=(after|before)]`::
> >    Output the commits chosen to be shown (see 'Commit Limiting'
> >    section above) in reverse order. Cannot be combined with
> > -    `--walk-reflogs`.
> > +    `--walk-reflogs`. `when` can either be `after` or `before`, if
> 
> “When” is not mentioned prior to here, so it’s explanation leaves the reader wondering what it refers to.

Yes, when I first wrote it it said `--reverse[=when]` but forgot to
change the text after deciding to give the valid inputs instead. Will
fix in v2.

> The original handles multiple reverse options inverting each other…
> 
> > +    } else if (starts_with(arg, "--reverse")) {
> > +        if (!skip_prefix(arg, "--reverse=", &optarg)) {
> > +            if (argc < 2) {
> > +                revs->reverse = 1;
> > +                return 1;
> > +            } else {
> > +                optarg = argv[1];
> > +            }
> > +        }
> > +
> > +        if (!strcmp(optarg, "after")) {
> > +            revs->reverse = 1;
> > +        } else if (!strcmp(optarg, "before")) {
> > +            revs->reverse = 2;
> > +        } else {
> > +            revs->reverse = 1;
> > +            return 1;
> > +        }
> > +
> > +        return optarg == argv[1] ? 2 : 1;
> 
> …which I don’t see here.
> 
> I’m not familiar with this parsing code though so I can’t add much about the test other than to say it is a bit hard to follow :/

Given that it is no longer binary handling multiple reverse can't simply
be inverting bits, it wouldn't make sense. This is done before the walk
itself, so even from the POV of the user it wouldn't make much sense to
reverse multiple times as the order of the applied options before this
patch (commit limiting options then reverse) doesn't change.

This doesn't break any tests so I assumed it was fine.

> >    } else if (!strcmp(arg, "--children")) {
> >        revs->children.name = "children";
> >        revs->limited = 1;
> > @@ -4525,19 +4543,35 @@ struct commit *get_revision(struct rev_info *revs)
> > {
> >    struct commit *c;
> >    struct commit_list *reversed;
> > +    int max_count = revs->max_count;
> > +
> > +    if (revs->reverse && !revs->reverse_output_stage) {
> > +        if (revs->reverse == 3) {
> > +            BUG("allowed values for reverse are 0, 1 and 2");
> > +            revs->reverse = 1;
> > +        }
> 
> Is this possible? I guess I can see from the expanded bit width that it’s a valid input, and there’s no protection stopping other callers accidentally adding this.

Current code should never generate a 3, but in case it happens I assume
the user wants to use the original behaviour of reverse, so I set the
value accordingly instead of stopping the program and notify that
there's a bug.

Should this be changed?

> I haven’t looked, but it would be nice if we could use an enum instead. Unfortunately that would probably take up more space in the struct, and I suppose the bit-packing is done intentionally for performance. 

Could define new macros so that the readers don't have to mentally keep
track of which value rapresents what. I didn't think that was
necessary, should I change it?

> > 
> >    if (revs->reverse_output_stage) {
> > +        if (revs->reverse == 2 && revs->max_count == 0)
> > +            return NULL;
> > +
> >        c = pop_commit(&revs->commits);
> > +        if (revs->reverse == 2)
> > +            revs->max_count--;
> 
> Hm. Why do we decrement here? Again, not an area I’m familiar with, but a bit surprising. 

get_revision() (in revision.c) handles the reverse option and updates
the "struct git_graph". get_revision() then calls
get_revision_internal(), which handles commit boundaries and max_count,
here is where it gets decreased. Since max_count gets decreased
everytime get_revision_internal() is called, if we were to leave
max_count as is before the walk (in get_revision() at line 4558), the
walk would stop before reaching the root commit. This is why the current
--reverse option is applied only after commit limiting options. So
instead we set max_count at -1 walking the whole history and storing it
in 'reversed'. Now we're in "reverse_output_stage = 1", and in this
state we never call get_revision_internal() again, instead we pop
commits from 'reversed'. Because of this we have to handle max_count
outside get_revision_internal(), so we decrement it in the snippet of
code you referenced.

A bit verbose but hopefully it'll get my point across.

Thank you
