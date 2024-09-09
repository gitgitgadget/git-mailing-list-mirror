Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AC418DF73
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 23:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725923703; cv=none; b=ahfuOp3zh1pVzCSw3Y7esGwnCXf5GBWDei0tWNI28i5HiKg+9dA7a4thBYIKfVEeR626AJrocSJXU+AmybfkCGiYrmt69CH0s9/Apil/H8wDaSsTUONmyP9W2uh2Fjme3kxyooNlUkq3cWEEpj2ypnAKCS3MzPMuZ4zqtVbGeBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725923703; c=relaxed/simple;
	bh=O5S/vXqj3PvJpQMcNKRuGxvupG1Wkh1AsfRavo9x2os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUHTRJ624IF53a+Z/gEZqksYFl5+OY6EtX+o+/JJIgjXyMuyi0ES16h5XJbuNzMOtDgzNnzwCtkHeKlK9kFEBPBZvuFtm5VVxhy2bjrZbHe7EiRTCq4yjI25vPLH7eEJY23LGHzR0d1Tl8rwbNV4oMAGAOvXMx0EGSEl1VWtvQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 32221 invoked by uid 109); 9 Sep 2024 23:15:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Sep 2024 23:15:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24925 invoked by uid 111); 9 Sep 2024 23:15:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2024 19:15:00 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Sep 2024 19:14:59 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Brooke Kuhlmann <brooke@alchemists.io>
Subject: [PATCH 4/9] ref-filter: drop useless cast in trailers_atom_parser()
Message-ID: <20240909231459.GD921834@coredump.intra.peff.net>
References: <20240909230758.GA921697@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240909230758.GA921697@coredump.intra.peff.net>

There's no need to cast invalid_arg before freeing it. It is already a
non-const pointer.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index e39f505a81..4d0df546da 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -578,7 +578,7 @@ static int trailers_atom_parser(struct ref_format *format UNUSED,
 				strbuf_addf(err, _("expected %%(trailers:key=<value>)"));
 			else
 				strbuf_addf(err, _("unknown %%(trailers) argument: %s"), invalid_arg);
-			free((char *)invalid_arg);
+			free(invalid_arg);
 			return -1;
 		}
 	}
-- 
2.46.0.867.gf99b2b8e0f

