Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F931E86E
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816693; cv=none; b=jhgk3HGw92c50z0eeORY2VQ+gkmcT4F0QDVEdq2D1i3i8H/G/7wLA+8RFiC8YbYu+pt7wqqJBLBdAMRVFCUgfehrLeij4diaWJLtXre8qAo/wY4jQXucw7jWA26XRIsdtuFu2iOosj6EAxTtUTW3JapEL7w+uZ1oU0qpM514G6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816693; c=relaxed/simple;
	bh=rESKFfA32+0lb0BhKwt0KA04NAjvPxdiBXYf62+h21o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FxkVqwlFsOOE1ABCs+rylN/0ZoX6LQSx4hsS+9p0sIyC2pV853GJBKUxd20dO5BRnHOkFTesBsDFJvHjIoDKV6v/qIj6jywGyDRlkg4URqBFBdfJWqJUs0D8QcxyMhGojv4jjuIDBr5CBxM+U/TNWS2QboifIQoV+wQ3P38Yibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=HvOxJ4q6; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="HvOxJ4q6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1761816686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TV7LeUErIO2ynU60ROCp/gTUV6key8lkDMIJqN7jzZI=;
	b=HvOxJ4q6+6rXWbr8itXiHXn27Nz+WLA7VKt+m8GLusBAAhm4gm+L2C85/ZNmfJZA2Xqdgf
	Csn/4Va3kEMseWKiXMVedFQE/wsyHUdVM5XfDQrmgfqZEAOBBW4NwKyHz5xcZ/Qkt57Vsp
	e70ytahKbiiHEitquSfZByq5WdeOYNY=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 5/8] builtin/pack-objects: simplify logic to find kept
 or nonlocal objects
In-Reply-To: <20251028-pks-packfiles-store-drop-list-v1-5-1a3b82030a7a@pks.im>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
 <20251028-pks-packfiles-store-drop-list-v1-5-1a3b82030a7a@pks.im>
Date: Thu, 30 Oct 2025 10:31:17 +0100
Message-ID: <87wm4cu462.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> +		/*
> +		 * We have already checked `last_found`, so there is no need to
> +		 * re-check here.
> +		 */
> +		if (p == last_found && last_found != (void *)1)
> +			continue;

Unrelated to the (void *)1 check, shouldn't this be in the beginning of
the loop?

-- 
Cheers,
Toon
