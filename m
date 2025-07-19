Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C41620B80A
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 21:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752962021; cv=none; b=ktNeaPCP5ByYumNfZRpbvPkoGinmVd1F5F5S+NR1u5jUVbKJfKrE2apwBljTGAmHXKgI4c7B62oL96XFnrXFbCrDygj0qjcqm50rcFfElIDnHIyae0ISBtnBCM9qu1y+YAgqS6QlecKgIFgkhk0TJ2HuTQJcTy/a/BxjKXu++rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752962021; c=relaxed/simple;
	bh=kPq5yvS/N0jGRKGLslVZ0QthHmecNGARCdKLUyennfg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R5q5zTV5ckFm/zEUOQz5lkroro+baHgbPi/qKAQQqxE17eA3H8n7f6XgWc4Ed8NUffh818DXXfiKmuOKHcsietmNpfdFt8ulG349BXtmlExjeX0bQt2dmbN1E4MpQ8hQpmNo4qWBAWdMeDATiXWqcKdpf7duhRoBa00wHzpFK3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=R01myB1j; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="R01myB1j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1752962017; x=1753566817;
	i=johannes.schindelin@gmx.de;
	bh=Rn1DrkeVC4npKoD6rAGuFUFFNUgSckC1DDSBnCuUymc=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=R01myB1jU9Nbk6HTyg94Vtk9Irx83MvGrt7vcu11BHyI5+1NxdbfBkCrIxWMZOzd
	 S+EtT+Lw9ejqZErHwhnIPAhlcx/djPVdnVtenr1xQukKHpBXdDJAIPGqy6Z3BZfeV
	 YKNyGjr/Rrd0FZbBTxvDbpDaDQf83i6AisrteskkGC/ujkkeiijueoRKstN4G2fix
	 akcgkG0sJrtNh4sW/7w+OuFAt3fTV4TLabTWssryfv2ZmfzEWXYX+QeFndunojWtS
	 qCJNwCESxc8CVDIZ/rQySPc1ICF0Fkr9Q9vKWBhlbgFk37ce6NZkdFWc1iqUmva2F
	 AVvu5J4M7VSq4tHqrQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.246]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmjq-1uBJHP10MU-00WuRb; Sat, 19
 Jul 2025 23:53:37 +0200
Date: Sat, 19 Jul 2025 23:53:35 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
    Ezekiel Newren <ezekielnewren@gmail.com>, 
    Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 6/7] xdiff: conditionally use Rust's implementation of
 xxhash
In-Reply-To: <5a959c9bdad79cf972b95dcf4324135dd7c94dac.1752784344.git.gitgitgadget@gmail.com>
Message-ID: <5596e569-6632-c2b1-37af-a978de5408cd@gmx.de>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com> <5a959c9bdad79cf972b95dcf4324135dd7c94dac.1752784344.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:veqALSgacjxTthfeZz/lP6Mw2Xy0WtBJ3oUsnwr95YSXUUsU3pl
 7PK3nKzx+Gc/+zpnuO9r6HMnZSqDzTHP3YUBq6zDp1DCK35drdwhS42IEpoo/DKmpMuu55L
 L5ud9Ddlvu97AqqG5njsuP/Uc7LVmSf/UoImnQy5Ruso3s3FbourN/AwjofycWFbnqIXjiZ
 AAivHQobZ6e0C+o2OPvXg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nStT0KMTQSs=;8BHg4awKZBKmt256ly7jScg5+hT
 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
 VYoQvoGlnXrSxzvUrlAfWDNUjSkRElptvfU

Hi Ezekiel,

On Thu, 17 Jul 2025, Ezekiel Newren via GitGitGadget wrote:

> diff --git a/rust/xdiff/src/lib.rs b/rust/xdiff/src/lib.rs
> index e69de29bb2d1..96975975a1ba 100644
> --- a/rust/xdiff/src/lib.rs
> +++ b/rust/xdiff/src/lib.rs
> @@ -0,0 +1,7 @@
> +
> +
> +#[no_mangle]
> +unsafe extern "C" fn xxh3_64(ptr: *const u8, size: usize) -> u64 {
> +    let slice = std::slice::from_raw_parts(ptr, size);
> +    xxhash_rust::xxh3::xxh3_64(slice)
> +}

I know that this is a pretty small file, but I do notice that it does not
have a license header.

This reminds me of the unfortunate oversight to be careful about making
(and keeping) libgit.a's source files compatible with libgit2's license to
nurture a fruitful exchange between those two projects.

With Rust, we still have a really good chance to learn from history and
avoid that mistake: Gitoxide is a very exciting project with clear overlap
in its mission to implement Git functionality in Rust. Gitoxide is
dual-licensed under the Apache License v2 and the MIT license (see
https://github.com/GitoxideLabs/gitoxide?tab=readme-ov-file#license).

Would you mind adding a license header to that file that explicitly allows
the contents of the file to be used in Gitoxide, to get the Rust effort
started on a good foot?

Thank you,
Johannes
