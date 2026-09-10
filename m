Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082BD476CC8
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041951; cv=none; b=nCc3/BC536p/jiYY4lCUYHBNDH8L8115IEMv9tsu+iSkZuF6qp0DMkqQLQD1Ej0EJ9vGl+PjqWtNXovUABlO4F4yuEnmJ0e3g2XAhuemvPUkLB4ELU22j+FP+jirg0A5YmtF1E9RB0jbKJd7EuGm3GYxWzzUr7qoimsFZ4x9NVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041951; c=relaxed/simple;
	bh=JOyyVoEF7L1AgwXowDkMnwwlpVQ4rR27H/Bh/+I+X/Q=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdUleyOQMR13J1kyhxiK0YRcYQVidWnAu4fTX6o3GQamjHR52kfOrCObmg0YeZEMlMEp5eKKmsVi1Vx91vWjmtK+W9UBRkVt+daa/gi+FkWcVKeOqqI7SVqT+/Tykv0kyPcNN41AnMJdcaXEeKCVA3nEjtIZAJxXTxhwSSZLw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from [2001:3b0:22:ba05:3c99:5d75:c899:ae5e] (helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <mh@glandium.org>)
	id 1x4dX8-0000000GwOk-0G7T;
	Thu, 10 Sep 2026 12:05:38 +0000
Received: from glandium by goemon with local (Exim 4.98.2)
	(envelope-from <mh@glandium.org>)
	id 1x4dX2-0000000BVUC-0QWj;
	Thu, 10 Sep 2026 21:05:32 +0900
Date: Thu, 10 Sep 2026 21:05:31 +0900
From: Mike Hommey <mh@glandium.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	gitster@pobox.com, ps@pks.im
Subject: Re: [PATCH v3] Move rust gitcore crate to a different subdirectory
Message-ID: <nqxjptlfu47fcxdep2djdv4tjtltsjacp35mncwjygv47nauru@vvx5464kcjm5>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <20260209224847.1416916-1-mh@glandium.org>
 <20260909013858.1729643-1-mh@glandium.org>
 <aqHMDErmQ0BdQlVD@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqHMDErmQ0BdQlVD@fruit.crustytoothpaste.net>

On Wed, Sep 09, 2026 at 09:13:49PM +0000, brian m. carlson wrote:
> On 2026-09-09 at 01:38:58, Mike Hommey wrote:
> > Having `Cargo.toml` at the top-level of the repository implies that one
> > can run `cargo build` directly, but this doesn't produce anything useful
> > on its own.
> > 
> > Additionally, when including the git source as a submodule of a Rust
> > project, it prevents the git source from being included at all in the
> > crate package because cargo skips directories that contain a Cargo.toml,
> > assuming that everything in the directory is relevant to the crate.
> 
> So what I understand is that you have a project which has Git as a
> submodule and you want to include the Git source code into the crate
> package for that project.  In other words, you're vendoring Git to use
> its C components, but not its Rust components.

Indeed.

> If that's the case, how do you plan that to work in a few releases when
> Git 3.0 comes out and the Rust components become mandatory?

Assuming the crate doesn't grow to the point of adding a dependency on
libgit-rs or libgit-sys, I'm thinking of publishing the gitcore crate to
crates.io in a namespaced manner (although if it could be published by
the git project that would be even better).

Mike
