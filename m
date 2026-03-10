Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D0D21E098
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 04:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773117910; cv=none; b=MspTPJ+RbL/GsLC+VFqmG+LIOAAK+M4qlfv/wjqIP8Jctq1mKfiEW/jpWf2hb/4RVQe7u4hioQLaJ0jSWRa2JUp9mB7JqUBr3g16q9gJ6Fdkqi0idQTZVX4ix0wRjbI2evpchj9hkikWaSeHH045p/fqGYIZwzEHcO9PODnuW5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773117910; c=relaxed/simple;
	bh=o+z3sIqGH6fesApuw7VmxXSGMgGpwEa56xpuR6UQCNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUSV9jPH1REB9O0x5K4gH+kQqc6dCFGxlVLCcalsnAemcKfEkmu7xpiEDPpZ8Ch2o9VYsK+n3Uw8waymWuTAvpeur6IV9hM0CGVV/HgFIXaPZvxMW/KWEE7Lnng13iyuREYup350YFwddkJ8bs6fb/fcnJCMW0hjWUh9zzEAW4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=DJAvV3d7; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="DJAvV3d7"
Date: Tue, 10 Mar 2026 05:45:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773117905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ItkdVrraA50CjB9aVgSEl1sRJdIM09URCEEN0JL6VSo=;
	b=DJAvV3d7uZMSeRt+WyPk3f/sVAZjv4a5zDW9ctITcsSVCs/S59E6EGYCI3uQ0sO3lmlgdL
	/cCybT4mjRraUfyU1aHYCiMtS/IpdY+BgPPO2t/UNQOAgkvPPHMzjmEOv4aJAL+dmsw+WL
	gPFHpHptEDAw+KVOAJGZikd80eoPQY7rlrkFbmnSZhd8tVLjTlPjkLWFDBAYR0irXObRUC
	ZgO3kb3K0EyJwK34BzWr4Jue94nURrUzhdWJhkyF3P53Zl63Y7s2l/rJ8B2D0kNdG7KHEs
	+kwuAcV+lRx+wv4LYo6RdKppPyGTHCoHfS3FfZXFa6bquaw5QirNTQfTI/nZjQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v2] apply.c: fix -p argument parsing
Message-ID: <aa-eXgsUnQRV7nvZ@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1997; i=mroik@delayed.space;
 h=from:subject:message-id; bh=o+z3sIqGH6fesApuw7VmxXSGMgGpwEa56xpuR6UQCNE=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpr6HETJzgEwtB8pO0bTj55qJcRROMUVipnjlt/
 DTtxqihQtaJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaa+hxAAKCRBIeX6hnBm+
 0aV/D/0fOeke8l6/01yVSmimOOxw4Li4Bwip89ibIxHfcAoQEsHVK2TWspRguLXaau0kstF8+wh
 xR+qR+ZQY+JULXtnoom0YE9NvDUhQ7rQPmDj/lY5RP4cMXA0jCyfieIMhSCoGZ3rSU+Blyz1JyW
 11npX5RsehSCQU/nnD3WbQZF4QoTbv+G+hjSzGmWZN5dHlSjPYLo4SKmJIcT0GiWp0PoGvvJsq2
 50erTR0tpiDA5nGWyo+NKFaqWPSSUgyZUrQxLNENkCPSOPMbUG1g38g4hH890h2iSClOHT+QYD1
 fCzrbPwZ5kzlH+vcItsOvEgY3ALdc5snDFUsMOCFzelaRYB6DHYrot+PtSMJQpWUJU7VAV5BU51
 9XjvLgkam/nG95pXee3BBDLN56d8duz5OQ7FizYIo8zD26XGU1I8wlF5XDHUXlEe2ngNvDtSqwE
 rBhWS4QGIBlU1YLYgUVlkcdYyYrpnfDBx6FjMN0FTl1JBi7U+9VItv1KX5/0jNVmprozNtMAdFg
 vsEvtxVglhWV2s2QecH8k1mgwLPKdh6H/5Mj/+FOQWpkUnARWScbe1zZi47vPcWr2wwG/kWoF1j
 bZ5SvGMRhQFzsLYolOAib8g8VjUcPHV+ktZmCng27M+8Q5TaoPn4QqdFZk3sdnQTqK2vev+jMOx
 Qaxg/i8uM0MwH+g==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260309232700.553168-1-mroik@delayed.space>
 <20260310005408.2022216-1-mroik@delayed.space>
 <xmqqwlzkxsv5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwlzkxsv5.fsf@gitster.g>
X-Spamd-Bar: --

On Mon, Mar 09, 2026 at 08:31:42PM -0700, Junio C Hamano wrote:
> Curious.  It is true that we need to parse the p_value correctly
> even when we are applying a binary patch, but the problem is not
> limited to binary patches, is it?

Using a better regex I now realize t4120 would've been more apropriate.
I will move the tests.

> Is this saying "in the directory there must be only a single file
> whose name is t?"  Wouldn't it be more readable and direct to do
> something like
> 
> 	test_path_is_dir t
> 
> or is there something more subtle going on here?

Sorry, this approach is due to the unfamiliarity of the testing
framework. I must've missed test_path_is_dir, the README is very dense
so trying to find things at a glance is not the easiest (in my opinion).

Will rewrite to use test_path_is_dir.

> > +test_expect_success 'git apply -p malformed patch' '
> > +	test_must_fail git apply -p malformed $TEST_DIRECTORY/t4103/patch
> > +'
> >
> > +test_expect_success 'git apply -p 2q patch' '
> > +	test_must_fail git apply -p 2q $TEST_DIRECTORY/t4103/patch
> > +'
> 
> If this did not fail and patch gets applied with some p_value that
> happens to be used when we fail to parse the number, then ...
> 
> > +test_expect_success 'git apply -p -1 patch' '
> > +	test_must_fail git apply -p -1 $TEST_DIRECTORY/t4103/patch
> > +'
> 
> ... it would not be clear why this step fails.  Perhaps with that
> same "unable to parse" p_value was used and this tried to create the
> same file as the previous step already created, or we detected parse
> failure.  We cannot tell.
> 
> It probably is a good idea to prepare for the worst by doing
> something silly like
> 
> 	test_when_finished "rm -f t/test/test test/test test" &&
> 
> at the beginning of each of these tests so that we would clean up
> whatever we could leave behind?  I dunno.

right, "rm -rf t test" should be enough, will add this cleanup code.

Thank you for the review :)
