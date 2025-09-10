Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF72255F53
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518687; cv=none; b=EOcyS8iAW2u3Ik7ab8ObVT/R0LrwPsrCjCYozN6cfTlfqUm0C2ebnbTsUPnJdp4iMM5JK2YRCZGH++OYF3GPzmmIyOB7nQhfm4u6jyBGnNGOUmH7j2cHfFERpSeC8aSaBvDoZYReH+ajtwD8CuFLRmHZVMd8LpD+GQCQgj0rJE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518687; c=relaxed/simple;
	bh=7R+DTLbz4gDLosuO/ZC/+EaZvJ88gpM+dvfbSswz7MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTlHeFQ+Ckz+DA2JANyNbwBVuYRbKW0eruJvbsJXXB7Yl4aQ3zPd3H24XzSFXzXuzPZtHtXec/hxQk1pd7j2yf/l+o6x+T3750kPk8D/lKrPiKgxL3s8g8OcKvSc8de2z96Llz6xBnv9ycpJT3lPTnw4YuJ6MXyHuuaf6KAjqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dQ7qtV8n; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dQ7qtV8n"
Received: (qmail 41590 invoked by uid 109); 10 Sep 2025 15:38:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=7R+DTLbz4gDLosuO/ZC/+EaZvJ88gpM+dvfbSswz7MM=; b=dQ7qtV8nIi5kMJma8IFzTIkxRlp5zMPzlYhqivOztT6iFiRozky9ePrYuemz8KQ5hPpDfi0YdtKOUtpzpva3k18+e+VpK7TPl9BQ2Io80p8xo+ayAJht6oVQ3gCDHzhIk48u6J5mFOpt/fFQBmZy7SLeGM6vDqTaQJ/pi43A1tCfWjS82MUCgjQMzbHzYg688tJh5zMQiKt/bHDdXaA7UU2CRKgNvOz9KYCxKOzmrMz1wUd0D74r/GblsY88vmi/cYWlhpcaJVHehpNEy6/YdbHN3Sv6L8mLAp0YhCtKZPmVDs9d0ksW03cuR+DNuQU2sVEOoKrgkRaxRISpMyTO+Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Sep 2025 15:38:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 67679 invoked by uid 111); 10 Sep 2025 15:37:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Sep 2025 11:37:59 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Sep 2025 11:37:59 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] odb: drop deprecated wrapper functions
Message-ID: <20250910153759.GA562601@coredump.intra.peff.net>
References: <20250910-b4-pks-odb-drop-wrappers-v1-1-6ed660cb1eec@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250910-b4-pks-odb-drop-wrappers-v1-1-6ed660cb1eec@pks.im>

On Wed, Sep 10, 2025 at 03:12:17PM +0200, Patrick Steinhardt wrote:

> diff --git a/odb.h b/odb.h
> index 3dfc66d75a..e8b9dff948 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -475,37 +475,4 @@ static inline int odb_write_object(struct object_database *odb,
>  	return odb_write_object_ext(odb, buf, len, type, oid, NULL, 0);
>  }
>  
> -/* Compatibility wrappers, to be removed once Git 2.51 has been released. */
> -#include "repository.h"

When merged to 'jch', this patch breaks the build. The issue is that
code added by ps/packfile-store was subtly depending on this include to
have access to the definition of "struct repository":

  pack-objects.c: In function ‘prepare_in_pack_by_idx’:
  pack-objects.c:89:51: error: invalid use of undefined type ‘struct repository’
     89 |         struct packfile_store *packs = pdata->repo->objects->packfiles;
        |                                                   ^~

The fix is probably just:

diff --git a/pack-objects.c b/pack-objects.c
index 668c113667..5b70aa400e 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -4,6 +4,7 @@
 #include "pack-objects.h"
 #include "packfile.h"
 #include "parse.h"
+#include "repository.h"
 
 static uint32_t locate_object_entry_hash(struct packing_data *pdata,
 					 const struct object_id *oid,

either in the merge, or possibly in that other topic as a preparatory
step (I didn't look at how close it is to graduating to 'next').

-Peff
