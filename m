Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC29C285406
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768821365; cv=none; b=Fp4M8x76Fb1qPNpKh6LCpI5/8cvd2ibpMjpvvsifpgCVIhMOyBBtHXSfMCfZn6PLnfPAl3biITrBGK9d5G2rWn88EzFqSjvThvxte9IF4EZ8yBOiajXJiny3PpasRbirLrIzgDvxF1lSHfqLwIKiIm6O+GRzA/peKm0CYMY+zRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768821365; c=relaxed/simple;
	bh=Y0LQkhvagwx5tgVgEEC2r17nde6T/fPUM/FD0zRst7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t39TDoNXWb7qfbnR44t0ev2Bpw37iySmiNJPkSIeGjkMqrayvVNG2dOunFvPsGF5XvlQx18prA56fTOXcT9FXo8qogfwJmRIBVuWWptAgBHvcSn4XfkMIrKmznrF+kUskRxlDrEB2T2DnnidxY7ifqqNOUwnU9aJNs1QbUm7wwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4dvnvG6GgGz7QVX9
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 12:15:54 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4dvnv55qDczRnmQ;
	Mon, 19 Jan 2026 12:15:45 +0100 (CET)
Message-ID: <1ce18cac-f988-4741-b9dd-6c1cf2d4e6af@kdbg.org>
Date: Mon, 19 Jan 2026 12:15:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] revision: add --maximal option
To: Derrick Stolee <stolee@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2032.git.1768703645125.gitgitgadget@gmail.com>
 <1da38e88-3f61-43df-9c75-5716d715bf80@kdbg.org>
 <b46885b1-5781-43d8-8751-d85048c45e5e@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <b46885b1-5781-43d8-8751-d85048c45e5e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 18.01.26 um 19:27 schrieb Derrick Stolee:
> On 1/18/26 4:05 AM, Johannes Sixt wrote:
>> Am 18.01.26 um 03:34 schrieb Derrick Stolee via GitGitGadget:
>> > The option name is too generic IMHO. How about "--starting-point",
>> "--topmost-only"?  It's function is somewhat parallel to --boundary, but
>> at the positive end of the revision range. Perhaps we can use that as
>> inspiration.
> 
> My perspective is skewed, because "maximal" is a concrete term in the
> world of partially-ordered sets (such as commit history ordered by
> reachability across child-to-parent relationships). It's important to
> distinguish from "starting points" because the inputs to the command
> are a list of starting points, not all of which are maximal within the
> set. In fact, if some positive starting points are reachable from the
> negative starting points, then they are already excluded.

AFAICS, we don't have options named after graph- or set-theoretical
terms, but tend to stick to terms established in the Git ecosystem. I
assume that "maximal" isn't a meaning that an average Git user would
associate with the operation that is performed here.

But even if we decide to use "maximal", the option must be named
something other than *just* "--maximal"; this is simply too generic.
Perhaps "--only-maximal" or "--maximal-only".

Other ideas:
- --hide-reachable
- --range-head
- --range-head-only
- --most-recent
- --most-recent-only

> [--maximal]'s interaction with
> --boundary is trivial because no boundary commits would be included as
> they are necessarily reachable from a maximal commit.

So, --boundary --maximal shows only the maximal commits? That sounds
unexpected. Boundary commits are shown with additional mark-up; they
don't need to be suppressed. But in a first iteration it's probably
better to just make the two options incompatible.

-- Hannes

