Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E270A3BBE8
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 05:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711690719; cv=none; b=T7NvrZysvABgvVwgxYs6eMq+P4QC6t5LX01yEBI3BUPxEuD3F48I/tqjmEQtrGO22eEVr+co1P5z2fK08EGRb+sSRtPimabA23xmKqAo59uUyRr+PgnmqFPr22vjDL7oSvTqtdRpoXE3lj6v4PJXmtDsGD6CTW0B9gKEM8d8w+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711690719; c=relaxed/simple;
	bh=7BCqGdzTEjQ/A5+e5WhPLokce111gLqkuWqWN57IoT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pGRt6jXLSLDzt3I+my8sKpaUidrHTJMqlXU+XaH7aTDAIBiW7hu9ZC+UD0lg76DqjzdkLitt0nWD8xo6xPH9O6F1LTXUKCwuJJREKdFIGk0NASve/Qoe5/95Ay//sX/pCz+F8DGecrkyYYNG70CA8EWs5cNmVnIRA2quXndx6oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yIgPVet/; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yIgPVet/"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 78E562C833;
	Fri, 29 Mar 2024 01:38:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7BCqGdzTEjQ/A5+e5WhPLokce111gLqkuWqWN5
	7IoT4=; b=yIgPVet/T1HHCIBJazJpHbmZT4pKn/qPe5VvQAHvl48C0OtTKlXMuT
	ubUvnw8bRQE+RN0HSgliNKHZbqA0qcw3XBkPqYiWiIeN/J9MsbKugeLn1kb0qDaO
	B5wS0f6GCxGehnEuizjePaQ/jV0dJ/a5HLcOLEeZdAvYVB8sNKRXU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 71C0C2C832;
	Fri, 29 Mar 2024 01:38:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 072EB2C831;
	Fri, 29 Mar 2024 01:38:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] do not set GIT_TEST_MAINT_SCHEDULER where it does not
 matter
In-Reply-To: <CAPig+cStHRX-wZKwdcO33wCjd4UU3MO-rVisyOFZ1vPbGaN51Q@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 28 Mar 2024 22:43:48 -0400")
References: <xmqqmsqhsvwk.fsf@gitster.g>
	<CAPig+cStHRX-wZKwdcO33wCjd4UU3MO-rVisyOFZ1vPbGaN51Q@mail.gmail.com>
Date: Thu, 28 Mar 2024 22:38:32 -0700
Message-ID: <xmqqsf09vbqf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9543F380-ED8E-11EE-806D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> Clearly the idea was to protect the scheduler-configuration of the
> person running the test in the event that the test author forgot to
> set GIT_TEST_MAINT_SCHEDULER to one of the legitimate "testing values"
> before invoking a "destructive" command, such as `git maintenance
> start`. By defaulting to `none:exit 1`, the problem would be caught
> and reported before any damage could be done to the configuration of
> the person running the tests.

Yeah, if the variable were exported.  So I am OK with a fix in the
opposite direction.

