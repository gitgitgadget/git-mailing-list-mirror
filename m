Received: from mta0.migadu.com (out-18.mta0.migadu.com [91.218.175.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D57E46A5F4
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787928823; cv=none; b=WZCEUWKYGHP3+4LzK4WD9lfhUYM8G7rL9EEXzkgzwSG8caTwI4/mdqt2/SLokV6YTLrBuJXsEApLIzgc6w5zBv4l/3aRN0/p+78pNcE1Cwij7IZ/O+VYiUsqj+arLyr147225h7LgLLIY83QfFaJlzzPKSCX7qRxpT6Ir/9Xwdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787928823; c=relaxed/simple;
	bh=zZfoDDvbudc+CljyE8Ucwhjfs2WXfaY+ouNO6x4DtOA=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uSsVP/hVuoWkWi4IdPdYQs48MzfSeMtEgl6Mjw6n6sErsKN7QHzJuIv3xnIRjTqVclsKI+9+NgrtkLoV867Pyjc0nx9ZKR9ZPoUYS0zJkB/ZxYlNH2PFbeFGFU/kjnNUbfuwU3WSlaY16EEcILCahYSI6DhIwWdT5QmBomGyiI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ymvVMkEz; arc=none smtp.client-ip=91.218.175.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ymvVMkEz"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zZfoDDvbudc+CljyE8Ucwhjfs2WXfaY+ouNO6x4DtOA=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787928819; v=1; x=1788533619;
 b=ymvVMkEzpKIxgTDCI5WHJ/IVewHp4rTg8JGRGPgw06yxhkhyCPdVaujfwUYFabaYiCIYfXXZ
 gyEBGAPAh4lXdj79fz+I5Iajc7LzIceIjAq8mnEycrdXUeqIRDnlSyW83GoFtpODtygK6ik7xnu
 AXHS3WsmDej7IAVUwk+o2Nlc=
X-Envelope-To: git@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 9f6d50523237c700;
	Fri, 28 Aug 2026 14:53:39 +0000
X-Mizu-Trace-ID: 9f6d50523237c700
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 6/8] odb/source: support writing alternates when
 creating the database
In-Reply-To: <20260825-pks-odb-write-alternates-at-creation-time-v1-6-911513ba95c3@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
 <20260825-pks-odb-write-alternates-at-creation-time-v1-6-911513ba95c3@pks.im>
Date: Fri, 28 Aug 2026 16:53:30 +0200
Message-ID: <8733vyuwid.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Add the ability to write alternates when creating the object database.
> This change allows us to remove the `write_alternates()` callback in a
> subsequent patch.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-files.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  odb/source.h       | 18 +++++++++++---
>  setup.c            |  4 ++-
>  3 files changed, 89 insertions(+), 6 deletions(-)
>
> diff --git a/odb/source.h b/odb/source.h
> index ea8675247e..86b82fab3b 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -5,6 +5,7 @@
>  #include "object.h"
>  #include "odb.h"
>  #include "odb/transaction.h"
> +#include "strvec.h"

I see `struct strvec;` is already defined below
odb_source_type_to_name(). Can we not include this and put the new
struct below the strvec definition?

-- 
Laters,
Toon
