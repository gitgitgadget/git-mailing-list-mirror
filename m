Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF60F27B51C
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 23:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323490; cv=none; b=ZccerNhVV/16sRWd4RUXluixbKAUz6SNtd40ouKKoyXoqbFBwoC1B+8VX7wDe1OjxrEihNMMJrrtY19s5u+QVfnMiSruIb0deJt2t/ousZuLYcEIqwMMh3EaUJMVIPw+qmMZSN4vuFLZrf9v085Vy8sNRU7GfrTGII7gsvwC7Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323490; c=relaxed/simple;
	bh=VL3aXKCrMU/yc6YVICeLphgT0XeprHGTrEhUUklaaPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJLwJ1lf88rwKUY+q5UFLBSi/BAsuVQW7KO1/Y67VcRU6RmHXx9vSldG874iSvCZy1iCtIhYDl6ESEkk55rehtQZa4GsnSHIKe/zeLDtWJpn/CM41jT+yZlAEti99ozx10hkkGYKZL5zvU5svltTfuqutMZ+FanKWI7uSDgz50M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TF3+lKE6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TF3+lKE6"
Received: (qmail 134896 invoked by uid 109); 19 Sep 2025 23:11:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VL3aXKCrMU/yc6YVICeLphgT0XeprHGTrEhUUklaaPw=; b=TF3+lKE6bZPyMSzRB2DvVBVtzcCUx9oxS9DvuiyoTd3PLprTKvN/weuPJf8RVIkf0QNiZaBJU5UB7zfXlBRacwScTGIu/rP9jC0BsMI2iowB1ZwHebKRUbNtziz++pwnynLizEDKpBmP50LeuadChRKUSHpz8laOItMDQorS/SvOu8aKweAGrnER4LxzrxfopAxoafWqJo6rYVKqwtNG4zxujjbT2MdFakoNRA8wXbp0qawWenjf9D7UBci8XTnDHBkDzLAjAtObcyreaKJHxP13R3gTml6C5Twx0WzGKrA3KKdQIdjYIHVvg5dwY9+FPqGUmvNeibMl0LvrRr/0mw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Sep 2025 23:11:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 211721 invoked by uid 111); 19 Sep 2025 23:11:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Sep 2025 19:11:27 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Sep 2025 19:11:27 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Lauri Niskanen <ape@ape3000.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 5/6] treewide: pass strvecs around for
 setup_revisions_from_strvec()
Message-ID: <20250919231127.GB936044@coredump.intra.peff.net>
References: <20250919223351.GA3906184@coredump.intra.peff.net>
 <20250919225048.GE594545@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919225048.GE594545@coredump.intra.peff.net>

On Fri, Sep 19, 2025 at 06:50:48PM -0400, Jeff King wrote:

> diff --git a/shallow.h b/shallow.h
> index 9bfeade93e..59d54d48e7 100644
> --- a/shallow.h
> +++ b/shallow.h
> @@ -36,8 +36,8 @@ void rollback_shallow_file(struct repository *r, struct shallow_lock *lk);
>  
>  struct commit_list *get_shallow_commits(struct object_array *heads,
>  					int depth, int shallow_flag, int not_shallow_flag);
> -struct commit_list *get_shallow_commits_by_rev_list(
> -		int ac, const char **av, int shallow_flag, int not_shallow_flag);
> +struct commit_list *get_shallow_commits_by_rev_list(struct strvec *argv,
> +						    int shallow_flag, int not_shallow_flag);
>  int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
>  			  const struct oid_array *extra);
>  

Sorry, I missed a hdr-check complaint here. It needs:

diff --git a/shallow.h b/shallow.h
index 59d54d48e7..ad591bd139 100644
--- a/shallow.h
+++ b/shallow.h
@@ -7,6 +7,7 @@
 #include "strbuf.h"
 
 struct oid_array;
+struct strvec;
 
 void set_alternate_shallow_file(struct repository *r, const char *path, int override);
 int register_shallow(struct repository *r, const struct object_id *oid);

on top.

-Peff
