Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E4F6166D
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574975; cv=none; b=uPusRAjrSzG4NjUPOCjIjTxN6r5zgj/AYHnK6szxaOUWUyMy0PBIzlWhFgfWejSVFwoul7770E4e9kv36kYqsjxVHCFDtk5+dCWQ0E3LhjxAqBionXdaszAUYuGt+IXXTHBkkOH+wEBf7X4QDNlFhVE2gauvcIhiowpRcqb8grM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574975; c=relaxed/simple;
	bh=VOi5bIPXHwEkgsr2mQcgLZ+3cMb0GTyWcW6ifPoZxgY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=psp8UGLQL5WyqQg6DJEGTGcBvxcv5GP2we31qDp5K7zgNxcPRvAm4estz0PHH54iQSnEngMkjcjDiO5gR9RLI5XlraGFwHmuAv8ZF8YwAIwcYfyXmrpmM9GhYhQG20AqlPOoyBQCJqNt3xVkJB349OFvA83E8A5QTIYqV0zZ+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=odvoHN4K; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="odvoHN4K"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B9E61CEC07;
	Mon,  4 Mar 2024 12:56:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VOi5bIPXHwEkgsr2mQcgLZ+3cMb0GTyWcW6ifP
	oZxgY=; b=odvoHN4KgoF00/mLXxfllTRUPEGtFxmulerhME+mxMOInkaIAhTnpS
	U4HCQBDxKSM3EDotLQBI1CbTF+Y7sJAYBGPDXCPMpXyp0+GxqL08ylxHy3ddMg4m
	hdRkcyBbT7RiIeFOOs2v3FvywhFLcyz93EOaZc4Ysh8kV78RFZ2/k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 946681CEC06;
	Mon,  4 Mar 2024 12:56:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 074621CEC00;
	Mon,  4 Mar 2024 12:56:11 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] sequencer: allow disabling conflict advice
In-Reply-To: <6a31efcc-c6c2-4729-80b9-eecff4ec9e31@gmail.com> (Phillip Wood's
	message of "Mon, 4 Mar 2024 10:27:30 +0000")
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
	<3df4790a-7ee1-4c72-a3da-ba8a48d546b8@gmail.com>
	<6a31efcc-c6c2-4729-80b9-eecff4ec9e31@gmail.com>
Date: Mon, 04 Mar 2024 09:56:10 -0800
Message-ID: <xmqqy1axq3t1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7CC3356A-DA50-11EE-B674-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... So we probably do need a new config variable but
> I think it should have a generic name - not be sequencer specific so
> we can extend its scope in the future to "git merge", "git am -3",
> "git stash" etc.

A very good point.  Thanks for your careful thinking.
