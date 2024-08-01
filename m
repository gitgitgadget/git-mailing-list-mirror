Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295EA1B3736
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722531882; cv=none; b=JyNM29aq743EQCpgcxis6H46A+LhczLLM4UTxo4grFnzeNnQckkgN6oUYmtVNiU5WI6v17eXa43kssmdEAU7ThJwAZvnRrkaILNs9jemHVlM/oFBQ1YoEkOLPStYuyKQAes3OSFwmD5gmyC7N5d/vvPRLmdLC+Coueo6zlCa03I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722531882; c=relaxed/simple;
	bh=1dX7O9hB2A59WkKkzIM4abKOHlPa9q62+qWXPId0bEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HymzucMDnHASw08DzmCEdBHWYwuXgyyd736/hDjM7aWQ66U0H8QDdmI2NwF1Qzms2nc3/hVrGVxNZIzDBYyEqtje/qF1qJ8E/YQMEKTwOugJbk5bOtil2fqoHXejuPNZkJHiVzazLbfsQ7DTbMlLWqU4jiWtE92EatinMYEHTNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NL0EKzc5; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NL0EKzc5"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BA0E2ABD9;
	Thu,  1 Aug 2024 13:04:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1dX7O9hB2A59WkKkzIM4abKOHlPa9q62+qWXPI
	d0bEs=; b=NL0EKzc5VHL9voP3G+grsDG6Kj48DxsQNOAdsu5kw2PVzF40BBdjlc
	q5CXOOoMoRgZ8Gj13An91HiqT/J77jMUDC92jMqEe+/SgIL6SyEaSO9hEBiAdOEo
	d8ACfAj11DJopRAYKUIYtJs1IO6oID8TeSJPMP7EkjePBkCghByIw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 133AE2ABD8;
	Thu,  1 Aug 2024 13:04:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 727C72ABD7;
	Thu,  1 Aug 2024 13:04:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Ryan Hendrickson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Subject: Re: [PATCH v4] http: do not ignore proxy path
In-Reply-To: <20240801060418.GB621899@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 1 Aug 2024 02:04:18 -0400")
References: <pull.1767.v3.git.1722441675945.gitgitgadget@gmail.com>
	<pull.1767.v4.git.1722489776279.gitgitgadget@gmail.com>
	<20240801060418.GB621899@coredump.intra.peff.net>
Date: Thu, 01 Aug 2024 10:04:38 -0700
Message-ID: <xmqqo76cuqc9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 236A6E4A-5028-11EF-B8EC-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> On Thu, Aug 01, 2024 at 05:22:56AM +0000, Ryan Hendrickson via GitGitGadget wrote:
>
>> From: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
>> 
>> The documentation for `http.proxy` describes that option, and the
>> environment variables it overrides, as supporting "the syntax understood
>> by curl". curl allows SOCKS proxies to use a path to a Unix domain
>> socket, like `socks5h://localhost/path/to/socket.sock`. Git should
>> therefore include, if present, the path part of the proxy URL in what it
>> passes to libcurl.
>> 
>> Co-authored-by: Jeff King <peff@peff.net>
>> Signed-off-by: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
>
> Thanks for crediting me. I'll add my:
>
>  Signed-off-by: Jeff King <peff@peff.net>
>
> to be explicit that the proxy script is under the DCO.

OK, I'll amend it while queuing this v4.

Thanks.

>> +# The %30 tests that the correct amount of percent-encoding is applied to the
>> +# proxy string passed to curl.
>> +test_lazy_prereq SOCKS_PROXY 'test_have_prereq PERL && start_socks "$TRASH_DIRECTORY/%30.sock"'
>
> OK, I see you figured out that the lazy prereq requires giving the full
> path to the socket. :) I had forgotten that we also run the prereq in a
> subshell to avoid side effects, but you caught that, as well.

;-)

> All of this to me is good evidence that the non-lazy version you had
> originally is a better approach. But I don't think it's worth spending
> time fighting over, so I'm OK either way.

I'd be OK either way, too.

Thanks, both.
