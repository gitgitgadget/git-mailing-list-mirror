Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D713D3172D
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 20:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705608033; cv=none; b=VJi5Ozwj2+OwqZanHKbqH+8g70zWK231qYocUQqeruYGGnkqC9A0D6pM4wk1Q+/4dK565rcG3fMY4Cwk4F5X2qeJ1ItpW4SIr+s02IWWqO04QIEDw7NADLoNWAduzZ2V8Mxy+0JtUG2F2cDWsY8NYu3y4ZJrq9PuE4y2HuQXcBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705608033; c=relaxed/simple;
	bh=ldlFQoARfZdYF+x7u59kUExjKbCq0hxKyjrY2gnom8o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m8k0+O1iLhY7kKylRLtxr/mJtYTQl5dCS4yTAa4nbMkAaRupYdfgJO9iSdpZ39AFmVMJUsgZ3jbjU2IFcWItFujYYwZKAUn36FHZe+FEEGTHDQWvlsgsKlKrxz/5Z9tB4jVDIeM+7h4aoQMuAuraG1qr+UzoljY+16QHDSweu9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=j0G7L9p/; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j0G7L9p/"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 35C1037EA8;
	Thu, 18 Jan 2024 15:00:31 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ldlFQoARfZdYF+x7u59kUExjKbCq0hxKyjrY2g
	nom8o=; b=j0G7L9p/m36vYvZv+nC7NHbXerABIVdSkqToSun36qrUDuxSu4eFNc
	aO6QjafRny1XV1tdwsgbT+ExccHZtXY3nRMufvGErtIje4w5AaoczRUP1Zhblw0x
	L2on2l2nMXcN7K3MKUd+Uw7sNQxze29HUOO2goVyVNsgF24T8EROo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E07E37EA7;
	Thu, 18 Jan 2024 15:00:31 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AC5E937EA6;
	Thu, 18 Jan 2024 15:00:27 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 00/12] Group reffiles tests
In-Reply-To: <ZakNqm0zyw8IiIhB@tanuki> (Patrick Steinhardt's message of "Thu,
	18 Jan 2024 12:38:18 +0100")
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
	<xmqqv87rsan6.fsf@gitster.g> <ZakNqm0zyw8IiIhB@tanuki>
Date: Thu, 18 Jan 2024 12:00:26 -0800
Message-ID: <xmqqmst2qun9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 39B03080-B63C-11EE-9BB9-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I think it depends. If we use the REFFILES prereq for the files-specific
> tests, then we should likely also use the REFTABLE prereq for the
> reftable-specific tests.

Correct.  I've assumed that as a given; while introducing any new
implementation of a subsystem that has widespread impact, we would
test things with the original and new implementations.  It happened
while we were moving "ort" to replace "recursive" as an internal
tree merge machinery, for example.  linux-TEST-vars job that is
available both in GitHub and GitLab CI is an example of a separate
job that runs everything with non-default configurations, and "use
reftable as the default backend" GIT_TEST_REFTABLE knob may be an
appropriate thing to set there.

> But that raises the question of whether we want to add a CI job that
> exercises code with the reftable backend for every major platform
> (Linux, macOS, Windows). If so then your proposal would be fine with me
> as we make sure that things work alright on all of them. But if we think
> that this would be too expensive then I'd like to at least have very
> basic test coverage on all platforms by always running these
> backend-specific tests.
>
> Patrick
