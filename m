Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933921EA84
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 23:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775344183; cv=none; b=gWw7hF95bc/1C1gzC2inkIGixKuGGcSfx3tF/N8rzoHjWnNT8sN3t7aAFiwc3sj30TF4ywXvORSFYsyeS8tHm3dDLf15JHyUlJS3WfLdnRmxwlK4gbKb4UVRoDyMcdqZQ6fpahxHKO5FFOP5gDIXw2GQl3r2i3FwIxLLOZZ9DDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775344183; c=relaxed/simple;
	bh=UpkQVdrNFb2UVafLgsE6lCFeA2n+8m2aI8HWNoKyjEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuWI+Fua4+EXnjiHVgueF3u11Zz5DkQWIZsfx7cQCtrYnEVkZxyimqZz0DpnCu1Nm3cPrZVC1DvpCWLkQW9swSyZduicLgMeDsfkYOzurZWf3ECQtcsgWIRfp/NsMEo7pgeYZFNBWE/BfxEQ5wu5O+lkVLD4jdmEJgqftdGqyVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TrDams2p; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TrDams2p"
Received: (qmail 246320 invoked by uid 106); 4 Apr 2026 23:09:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=UpkQVdrNFb2UVafLgsE6lCFeA2n+8m2aI8HWNoKyjEM=; b=TrDams2ph7tFK24AOeqK9+mDacwoVdqtx5HYmZgiihQm8qrox0LchfEyDP6TRdgh2y0T//YjWsaUim74Yle6s/qKBED9gbthHLUzXKhtH3dOdBix9cIM3XQIBEGo9TbGmgvLzpdL64n1HmqF1vMinDXG34giRvsCbemMFXDM+/i491GVl10+PRqBZXh0PgduuTS2PwBOSGIWpk6XLkNWOimH/6CExm2LwszW4hJyCBRGO/SjMGcuTmLJsym0UmjQ4eOxdWuHPZeo6nkWPPiBMmk+AaUmw8u1HK4oko523pT1AEFp+nmn+IAGTYf0i8SU4axB1X7yjfAF6yIMdLdyFw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Apr 2026 23:09:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 397885 invoked by uid 111); 4 Apr 2026 23:09:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Apr 2026 19:09:39 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 4 Apr 2026 19:09:39 -0400
From: Jeff King <peff@peff.net>
To: Tian Yuchen <cat@malon.dev>
Cc: Justin Tobler <jltobler@gmail.com>,
	Luca Stefani <luca.stefani.ge1@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] git diff --no-index segfaults on large files (NULL object
 database)
Message-ID: <20260404230939.GA1360412@coredump.intra.peff.net>
References: <CAO0HQ0X_pQmew5tJReOL=u+CMxCjAQynx8JfjykoYAUE59YNzw@mail.gmail.com>
 <d6c63949-1998-4cde-8cb0-902fd7db988c@malon.dev>
 <CAO0HQ0VEJsG6MYrp_bSTuU09PDsypGPrM0XazvM8er0kB32Gqg@mail.gmail.com>
 <4be492cf-347b-4fa5-9bdd-83e7ea8abd92@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4be492cf-347b-4fa5-9bdd-83e7ea8abd92@malon.dev>

On Sun, Apr 05, 2026 at 01:07:27AM +0800, Tian Yuchen wrote:

> On 4/5/26 00:53, Luca Stefani wrote:
> > Thanks for looking into it.
> > Locally, I simply check against null storage and it works just fine,
> > flags is always 0 in my experiments so a check against
> > INDEX_WRITE_OBJECT also worked.
> > 
> > diff --git a/object-file.c b/object-file.c
> > index f0b029ff0b..68303aa99c 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1654,7 +1654,8 @@ int index_fd(struct index_state *istate, struct
> > object_id *oid,
> >    } else if ((st->st_size >= 0 &&
> >        (size_t)st->st_size <=
> > repo_settings_get_big_file_threshold(istate->repo)) ||
> >       type != OBJ_BLOB ||
> > -    (path && would_convert_to_git(istate, path))) {
> > +    (path && would_convert_to_git(istate, path)) ||
> > +    !(flags & INDEX_WRITE_OBJECT)) {
> >    ret = index_core(istate, oid, fd, xsize_t(st->st_size),
> >    type, path, flags);
> >    } else {
> > 
> > Luca.
> 
> That looks good, almost exactly what I was about to send. I was mistaken—
> there isn’t a hash_write_object flag after all ;-)
> 
> It looks like this is your first time posting on the Git mailing list. Would
> you consider contributing this (as a patch)?s

Alternatively, should the odb transaction system be more forgiving here,
and act as a noop when there is no odb?

Bisecting the segfault yields ce1661f9da (odb: add transaction
interface, 2025-09-16). Before then, we passed around the
object_database itself, saw that its transaction field was NULL, and
returned immediately. After that commit, we pass the object_databse to
odb_transaction_begin(), which narrows it to odb->sources (which is
NULL) while passing to object_file_transaction_begin(). And then that
function looks at source->odb to go back to the object_database! But
the source being NULL, it segfaults.

Immediately after that commit, the switch from taking an odb to a source
is not helpful, though I think eventually it is used to set
transaction->base.source. But should the whole thing check for a NULL
source and return early? Or otherwise establish some kind of noop
transaction?

I haven't thought about the implications (nor even really looked at odb
transaction code before). But doing it that way would fix not only this
bug, but also other potential bugs throughout the code base when callers
start a noop transaction.

+cc Justin (author of ce1661f9da) for any thoughts.

-Peff
