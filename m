Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5739B21362
	for <git@vger.kernel.org>; Thu, 23 May 2024 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486267; cv=none; b=jT1EsmkpFa+F1tLkCrSQS8jbpPR7S/U++wEQvEiVTTXDriBPN7xdrXu/XaCv3txC/OWKfDLP2ObTi5a/IrUiO+HAcuSrVgm1KbWILhzrxY/oQfS2uHblyG6nC8k07k3sqfcAvFtZNp/cQKcYm7do9i3fR7RJmi2ANPLOYN5nXTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486267; c=relaxed/simple;
	bh=33Kg85GuAoGpzwU0w4mkv3NpqdIC628tBziG1vlvqfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IOrXqSKy9QHnD48f/Tx9us0bywtafut6geIzRzCtS6UOMdnptwIxcnde0+QLC1/Prnnis5OE+altV2RKQhpIEcEAWEgq+x4BAG322WIVp8oDSH1dnMM9hwT+AtJjGthuDTev3yTmxMCE5COr05cKQ0cS+TI4Bme1yQj/DnORfHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=W53XosRG; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W53XosRG"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 214C5324DC;
	Thu, 23 May 2024 13:44:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=33Kg85GuAoGpzwU0w4mkv3NpqdIC628tBziG1v
	lvqfw=; b=W53XosRGNhWdemWxQ8TxV1CctaqPPhLtdK/DYaRXM4uKjtciwfOsei
	+QC/m3GRQEEqKX8OAc7r82YNEBYXfzilYghb3oyQPNNfhiO7ShiI5ypXzhJa48Xp
	MMg+TTnT5T3Zbhfb5gZOUIecUhbhCidMFlyC1VttndnT4HerworUU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 198FC324DB;
	Thu, 23 May 2024 13:44:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68CEB324DA;
	Thu, 23 May 2024 13:44:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/20] t: mark a bunch of tests as leak-free
In-Reply-To: <0e9fa9ca7386f527903887242008b5b0443ada69.1716465556.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 23 May 2024 14:25:15 +0200")
References: <cover.1716465556.git.ps@pks.im>
	<0e9fa9ca7386f527903887242008b5b0443ada69.1716465556.git.ps@pks.im>
Date: Thu, 23 May 2024 10:44:22 -0700
Message-ID: <xmqqwmnktocp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 177359FE-192C-11EF-B0AF-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>   - t4153: Passes since 71c7916053 (apply: plug a leak in apply_data,
>     2024-04-23).
>
>   - t7006: Passes since at least Git v2.40. I did not care to go back
>     any further than that.

Since the base commit you chose to apply this step to (which is
unknown to me) and the tip of 'master' today 4365c6fc (The sixth
batch, 2024-05-20), we must have reintroduced more leaks.

$ SANITIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=true \
  Meta/Make -j16 --test=4153,7006 test

dies with

    Test Summary Report
    -------------------
    t4153-am-resume-override-opts.sh (Wstat: 256 (exited 1) Tests: 5 Failed: 1)
      Failed test:  2
      Non-zero exit status: 1
    t7006-pager.sh                  (Wstat: 256 (exited 1) Tests: 109 Failed: 6)
      Failed tests:  14, 70-74
      Non-zero exit status: 1

Here, Meta/Make is a thin wrapper around "make", I primarily use it
for its --test=only,these,tests feature, which is an opposite of
GIT_SKIP_TESTS. (Meta/ is a separate checkout of the 'todo' branch
of this project, that keeps things like whats-cooking.txt and
miscellaneous tools I use to manage the project).

