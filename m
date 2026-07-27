Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C400D3F39FA
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146259; cv=none; b=NyswVVxf3xbBwUBsas9IHpbMMI1IS+1R7sLza5f8ocikqZBn3U9zS+wPE3gT9drvBcDkZd7Fyp6rbn57e3Mn+/d90rgmXV6mNL3q+4UcA4mWKe53mfdl1ucdPIdUujBugGgss62pT2VzwFE3bR+CvM85jd179jztDbPzm7bYdJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146259; c=relaxed/simple;
	bh=k7ohJ3pzrcmutu3S1TQEDcO3cGWYfwseykx6/M6KuTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hChYU/XES3krV/ovb4ObbTcEnJjtwfJB1c90sJ61CFRb0anZCVWS8VQLMpsBk/9p63E7HxB41B0ks+GgKc+0ZSW1sbf3fcExto0I+b1TdCNcVjTR09Hv+ze4X5zOnQ3UqquQ1+5+kTRocIajNL4Y+HGhv/lg6lRzr7nlV5/JOB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VN6O38KO; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VN6O38KO"
Received: (qmail 69099 invoked by uid 106); 27 Jul 2026 09:57:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=k7ohJ3pzrcmutu3S1TQEDcO3cGWYfwseykx6/M6KuTg=; b=VN6O38KO6OIE9zPN4jLIobeI5e+cex65lYbKW8N1ouFlWMW/Rl0qvj5LFTqqlhFsnw3b6o/mG/5wI4Q8fzDTRx5GrCJCNKOyAz3G90jFLSk/c8hKPNhrDlco8MpiCnUMuak/2e1uOOHU+GWOvSzZKrV+vLuoDMreaIM+1fx578Yd+JekNgwOukb62NoyywJh+zn10gBxfYmtVxfy9b9DANiD9f+wOVv1CsHJY+FcnpSa1g0LQssxeoH+VmajwJfaLKqdF2qKOMQ1BOtsY0BAaCKMLbVCJk3YBWarxluAoVI8SqeTQeMDjs6dOTFajcqJ1ACTeQW9Nle8TmJqgYYC0A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Jul 2026 09:57:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 77865 invoked by uid 111); 27 Jul 2026 09:57:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Jul 2026 05:57:41 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 27 Jul 2026 05:57:35 -0400
From: Jeff King <peff@peff.net>
To: Alan Stokes <alan@source.dev>
Cc: git@vger.kernel.org
Subject: Re: Assertion failure with git cat-file --batch-command
Message-ID: <20260727095735.GA1153453@coredump.intra.peff.net>
References: <CAFZW3h0K6vi15HhMEX30Ab+pjRc3mQr2Myv9KJUH=MWzsvt0FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFZW3h0K6vi15HhMEX30Ab+pjRc3mQr2Myv9KJUH=MWzsvt0FQ@mail.gmail.com>

On Mon, Jul 27, 2026 at 10:30:43AM +0100, Alan Stokes wrote:

> I first observed this in 2.43.0, but it still seems to be present in
> 2.54.0.

Yeah, I think this has been there since --batch-command was added.

> Note that if I ask git cat-file --batch-command to include the
> objecttype in the output it is fine (which gives me a workaround). Or
> if I use git cat-file --batch.
> 
> IIUC git only fetches the metadata that it needs for each object, and
> that is determined from the format. For --batch I guess the type is
> always requested, since it is needed to print the object contents. But
> for --batch-command that doesn't seem to happen.

Yes, exactly. In the normal --batch code path we have this code:

        /*
         * If we are printing out the object, then always fill in the type,
         * since we will want to decide whether or not to stream.
         */
        if (opt->batch_mode == BATCH_MODE_CONTENTS)
                data.info.typep = &data.type;

But for command mode, we don't do the same. This makes your case work:

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1458dd76d6..78eab9723d 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -690,6 +690,7 @@ static void parse_cmd_contents(struct batch_options *opt,
 			     struct expand_data *data)
 {
 	opt->batch_mode = BATCH_MODE_CONTENTS;
+	data->info.typep = &data->type;
 	batch_one_object(line, output, opt, data);
 }
 

but there's a slight catch. That expand_data is used for every request,
not just the current one. In normal --batch mode, every request wants
the same data (the user-specified format plus the object contents). But
in command mode, some may be "contents" requests and some may just be
"info". The code above turns on type-checking for every request, making
the "info" ones pay to look up the type.

A type lookup isn't all that expensive, but it might matter for some
formats (e.g., just "%(objectname)" does an existence check and nothing
else, so we never even access the object data).

I guess saving and restore data->info.typep would work.

> I'm not sure what the correct fix is - always request the type in
> --batch-command, or perhaps only if a "contents" command is issued?

Yeah, in general if you are asking about "contents" I'd expect you to
get the full name/type/size triple. But it's not wrong to ask for less,
and certainly we should never hit a BUG(). So I think we'd want a fix
along the lines above.

Do you want to try your hand at a patch? It would need to do the
save/restore, and most importantly add a new test to t1006.

-Peff
