Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB8084D08
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 06:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918919; cv=none; b=knxNjBwmgA0u9yam7OyfRLyzDtQY1OMOk/p1ge8ow1St8D573XEUl0RICx7AAzlcEFZu5BAREQ1ej/PjHyGKR5EbwVX9KZ6IlI1BM1l4FiVcACgopZjCvaeMGgA04StAS8LKDyCJ9vdfu4WHYzRk9yYk5i/aCO99Rdr2qAVxEes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918919; c=relaxed/simple;
	bh=huFzN37RAAQehRFRm4Ii4xJs7QcpS7awEK1jmBVFpMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cO5kEnpTrnEjQ2EB51M1D1GBoYoABonM3T7RJVs9hMqtiukf82LbKikO82oEJp+EK50cgIsfWen/jsEaItq00ehj3Tdv9Qtufq26qwHjLPbYUtKGvpismUyy6mC3YEF530tKyy86W9XUrZKahhf53E0blVKTHsVeZKtPuz8chdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4bST9T1gP0zRpKm;
	Thu, 26 Jun 2025 08:21:49 +0200 (CEST)
Message-ID: <df3f9190-79cd-49d6-934c-a67a2c0c9f0d@kdbg.org>
Date: Thu, 26 Jun 2025 08:21:48 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] t4018: add tests for javascript export type
 function declarations
Content-Language: en-US
To: "Derick W. de M. Frias" <derick.william.moraes@gmail.com>
Cc: git@vger.kernel.org
References: <4deb24c2-98f2-40f8-b50c-c74485ebc10d@kdbg.org>
 <20250623090538.154858-1-derick.william.moraes@gmail.com>
 <20250623090538.154858-5-derick.william.moraes@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250623090538.154858-5-derick.william.moraes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Many of the cases are not valid tests. In particular the word "ChangeMe"
must occur *only once* and *after* the line with "RIGHT" and there must
be at least one unchanged line before it. (I wonder how these tests
could have passed. Do we have a flaw in the test driver?)

> diff --git a/t/t4018/javascript-dotexpors-async-anonymous-function b/t/t4018/javascript-dotexpors-async-anonymous-function
> new file mode 100644
> index 0000000000..9f970a2343
> --- /dev/null
> +++ b/t/t4018/javascript-dotexpors-async-anonymous-function
> @@ -0,0 +1,3 @@
> +exports.RIGHT = async function(a, b) {
> +    return a + b; // ChangeMe
> +};

Here.

> diff --git a/t/t4018/javascript-dotexports-anonymous-function b/t/t4018/javascript-dotexports-anonymous-function
> new file mode 100644
> index 0000000000..2fa9775c95
> --- /dev/null
> +++ b/t/t4018/javascript-dotexports-anonymous-function
> @@ -0,0 +1,3 @@
> +exports.RIGHT = function(a, b) {
> +    return a + b; //ChangeMe
> +};

Here.

> diff --git a/t/t4018/javascript-dotexports-arrow-function-3 b/t/t4018/javascript-dotexports-arrow-function-3
> new file mode 100644
> index 0000000000..cc3f1ec017
> --- /dev/null
> +++ b/t/t4018/javascript-dotexports-arrow-function-3
> @@ -0,0 +1 @@
> +exports.RIGHT = a => a+1; //ChangeMe

Here.

And many more. You see the pattern.

> +++ b/t/t4018/javascript-module-dotexports-generator-function
> @@ -0,0 +1,5 @@
> +module.exports.RIGHT = function* ChangeMe() {
> +
> +    yield 1;
> +    yield 2;
> +}
> \ No newline at end of file

An incomplete last line, again. Please look at the patch text that you
are going to submit. Don't depend on reviewers' to notice such obvious
glitches.

I haven't found enough time for a complete review, yet. Please submit a
patch series that does not depend on an earlier round.

Splitting the test cases in separate patches is a good idea. I think you
have chosen a split that excercises different hunk header patterns. But
in this case, it would also be feasible and helpful to exclude the
pattern from the earlier patch and add the pattern and the corresponding
test cases in the same commit.

-- Hannes

