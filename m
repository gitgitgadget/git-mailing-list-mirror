Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76513822A8
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776677611; cv=none; b=dOZUIfDQgFoptUINq3vNpT5VF98ArDjDnrW6XlccKyEkq3WT31NG4OTf1Pa752JCXZpHtpJ0XLSuGAUWsMJILmtDtKOc2QoXYDG/cxLPvKYzIjjFPS9/2HZCGUK+E7757s8fbHjpflkgnq8+pBC0Fm5aYBEJdPNJi6k4jovEMlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776677611; c=relaxed/simple;
	bh=Ym2TvuJu6zMNgenF50G/UPZPuy9D3M9sMvMlj3kLv8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKrsbdK3dSO/B1UZYM7IM1IolNAyEpp3bt0BboCtXes05bk26H/MhFRQUmkuy7Pyzh5/TJxoPfwUl4MS7QMzix6JJCxWeMkH3d9zsS0H7Gc7CUZiwXLa8sTYNCijc/1ea0yOFbgJl4DmkFuBwROsZR5yLB767ogzSJNoQGqyNnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=WzvgX0wL; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="WzvgX0wL"
Date: Mon, 20 Apr 2026 11:33:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1776677607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CNYP2AC8RwSYqx19zIHagj910mHhSpBtSyrmhVRd09w=;
	b=WzvgX0wLn+P1BSTQuzzgMcPK3yvVQjaJxeCY7yM5FIXkCUVX+BhDemejsEi0nKjYh2rLpk
	rtFLgoBi3+gK+fy/b/Gv3N64iW0J+6ChfhbVhFszEcKkRGnplJwtWrkrXY2r4woHtNzQF6
	AXDPUjJl7ujQkrVAxyIKxPOHOXKTK5cxcJm4LVDUUeeaKpzzM2QeFKu+hlXQ7IBoCdUrqp
	G8ZbhMrwjyqC+5Wo4ifqggn17QunsGkVPN98WSQAAatDA9BuaxytOfEyemxJCeGz5ZiYAJ
	ht4e9dPQ+BOV2gw2GwTwQZwaeprYBRezCcrs0+Zrd79LJ/H52h9DYUBVT/HLoQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH] revision.c: implement --reverse=before for walks
Message-ID: <aeXxC8eR0Mn3dGEn@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3686; i=mroik@delayed.space;
 h=from:subject:message-id; bh=Ym2TvuJu6zMNgenF50G/UPZPuy9D3M9sMvMlj3kLv8w=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBp5fLXO/PkPKlsf1kYuh4hIMMBQ7UaoB/aJsXRm
 C+2GJY7XPWJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaeXy1wAKCRBIeX6hnBm+
 0QNBEACmQwzI7przPZkw7WphV+cFepvUdUXXXDkU36dOhEiFMRmvDykkNVf+/yQ2gFQCabNsyS5
 eUJiJl2KBEwfray0/mE0UvkiZk4xcdIumdadqqSVeMdSpTcMIBVnwGgB+iGVcv523L++7k0c7CC
 E1h+Lal+1GpqIPGLt5rTVkK218lpcnQuufgQyVyEjXSmFcVqp9f+2FRqAMYBzpn2xL5OKGswvTz
 0lXmAp2kYMC3EAtJVrCTh4BiDASysmmAs5PzrtLwG+brgCBrX8gEkQg0EDTPC+IiTu4Gd9pPLhW
 QyQODOIs+L6HBsl9k3deoFQnJb8cVchQDx22+1dtMG6XbyiKb4uedC2YKk/wlHfako81qLm0XgE
 0lT2WsG6KtMGqUEXWft5JO8ftinvJWzRbRmA6et4r/tPzfnhkxzKhynKS593U5u5dT9PJpGUHne
 rx/lVI4YYHwRb8kvffjUvETUlJyv6jesH0Xb0SZ0h/YHn1CMwbKk6rTF9Ro/ELGwlGZ87TD1UhX
 UJLYyNIksV8sywgMG34lAUsYMlUZLst1APb0HhQNAHFLu7wyVFT044XzMzJ2vyT9ntVPlYbCX8m
 rXddM6PtF71Ib73XmMQxCHeIqOUn8fLhKkGpPxMYs+CA8MG1YCcE2WCrnf9uVxq885tPwQ6ilqG
 Mrp+gwXE35MVO3A==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260418164736.2367523-2-mroik@delayed.space>
 <C60EE993-97DA-45F7-89DE-2F97ABB0F685@gmail.com>
 <aeUZUqSQI8FvRUco@exploit>
 <CALnO6CACfSyzyguX4623Dk3y+QEM_Dbmfko8dTyM1p3JxBjZFg@mail.gmail.com>
 <aeUqSltEWIWaPDh3@exploit>
 <20260420002118.GB1238475@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420002118.GB1238475@coredump.intra.peff.net>
X-Spamd-Bar: -

On Sun, Apr 19, 2026 at 08:21:18PM -0400, Jeff King wrote:
> On Sun, Apr 19, 2026 at 10:31:37PM +0200, Mirko Faina wrote:
> 
> > > I think I mean that
> > > 
> > >     git log --reverse --reverse
> > > 
> > > shows commits in the same order as "git log"; what should
> > > 
> > >     git log --reverse=after --reverse
> > > 
> > > do? Or what about preserving the behavior of the original "git log
> > > --reverse --reverse," which I don't think is done here?
> > 
> > Yes, this is what I was getting at. Since it is no longer binary what
> > would a double reverse mean? What if "--reverse=after --reverse=before"?
> > How should that be handled?
> 
> Yeah, I agree it gets weird, and I think it is OK if we don't try to
> combine before/after reverses (either making it an error, or using the
> usual last-one-wins to have "before" override "after" in this example).
> 
> But we should keep "--reverse --reverse" working as before, as there is
> no other way to countermand a previously-given reverse option, and
> because it has always worked.

What about a triple reverse? That would mean the original reverse choice
is lost and it defaults to the historical "after", which I'm fine with,
but this will need some extra caveat in the documentation :')

> Usually we'd spell the option "--no-reverse", and it probably makes
> sense to add it (to override an earlier "--reverse=after"), but we'd
> still want to keep "--reverse --reverse" working for historical
> compatibility.

Yes, I will add a negated form as well.

> So combined with the earlier suggestions for using an enum and
> disallowing the un-stuck "--reverse after" form, we probably want
> something like (totally untested):
> 
> diff --git a/revision.c b/revision.c
> index 599b3a66c3..89a58a65b7 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2686,7 +2686,20 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  			git_log_output_encoding = xstrdup("");
>  		return argcount;
>  	} else if (!strcmp(arg, "--reverse")) {
> -		revs->reverse ^= 1;
> +		/*
> +		 * This relies on "do not reverse" being the 0 value for our
> +		 * enum, and historical "reverse after" having value 1.
> +		 */
> +		revs->reverse = !revs->reverse;
> +	} else if (!strcmp(arg, "--no-reverse")) {
> +		revs->reverse = 0;
> +	} else if (skip_prefix(arg, "--reverse=", &optarg)) {
> +		if (!strcmp(optarg, "after"))
> +			revs->reverse = REVS_REVERSE_AFTER;
> +		else if (!strcmp(optarg, "before"))
> +			revs->reverse = REVS_REVERSE_BEFORE;
> +		else
> +			die(_("unknown value for --reverse: %s"), optarg);
>  	} else if (!strcmp(arg, "--children")) {
>  		revs->children.name = "children";
>  		revs->limited = 1;

This unfortunately wouldn't work as the first condition is a prefix of
the third, so no free copy-paste for me.

Will have separate parsing for omitted and explicit forms in v2.

> Note that your original also allowed --reverse-o-matic, which we
> probably don't want (and is fixed here).
> 
> I _think_ the negation from using "--reverse" after "--reverse=before"
> should be sensible here. And "--reverse=" with two different modes just
> overrides rather than trying to be clever. But you may want to
> double-check all of the combinations.
> 
> This would all be much easier if revision.c used parse-options, of
> course, which has all of these sorts of rules baked-in. But that's a
> much bigger conversion, and probably not something you want to make a
> prerequisite for your series. ;)

I'm sure someone will be fed up enough to bring in parse-options at some
point.

> -Peff

Thank you
