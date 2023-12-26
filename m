Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9FD4C6D
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eIM1VYVo"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A9A661D780F;
	Tue, 26 Dec 2023 15:58:25 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nrjEtfZmZ2CZ/Qlfg/rUkkMInd5hCbzn7KFw1J
	RCi4c=; b=eIM1VYVoLlfrnaTVukvjpWEfBToFmmnDvjkTnvBlNB8mWONQL1nbOy
	dI3NQUpMLxIAdzNSWTE61ZbCQAqe1hAgDC7G8sJ/FH+J3an3P0Hj2nkKQ56znAsZ
	VIzZVYf5PHcMYWUm2Gb703YGFbm9HtMs5SEeFC4PSHpdPdjDIPt1E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A069F1D780E;
	Tue, 26 Dec 2023 15:58:25 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1263D1D780D;
	Tue, 26 Dec 2023 15:58:25 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  Chandra
 Pratap <chandrapratap376@gmail.com>,  Chandra Pratap
 <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v3] Teach git apply to respect core.fileMode settings
In-Reply-To: <xmqq4jg4j28z.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	26 Dec 2023 09:35:24 -0800")
References: <pull.1620.v2.git.1703010646036.gitgitgadget@gmail.com>
	<pull.1620.v3.git.1703066893657.gitgitgadget@gmail.com>
	<82dadb69-5016-dec6-3699-4d994ea7929d@gmx.de>
	<xmqq4jg4j28z.fsf@gitster.g>
Date: Tue, 26 Dec 2023 12:58:24 -0800
Message-ID: <xmqqv88kfzpr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 82DD79CE-A431-11EE-81B4-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> As pointed out e.g. by t2016.3(git checkout -p), if the patch is to be
>> applied in reverse (`git apply -R`), then the `old_mode` is actually 0,
>> and we must use `new_mode` instead.
>
> Good finding.

Hmph, this is puzzling and I spoke way before I understand why/how
the fixup patch works X-<.

The caller of check_preimage(), check_patch(), should happen only
after reverse_patches() swapped old and new names and modes in
apply_patch(), so at this point, we should be able to consistently
use old_mode for checking, shouldn't we, even with "-R"?

