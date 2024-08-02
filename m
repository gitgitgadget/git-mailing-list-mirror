Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9664C9D
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 01:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722560842; cv=none; b=D3Z4tWtzZfAkecOojd5IVqyTWDgTbVbwW9TQaPsZHRbYEHr/BlQ2W58UNC2XJkUsVMojAHUFCYImNFHSZwcNJTckIPQkI+hbRvAu/ZP0fu0DJjuHmBaxCMdJFiW0Ol9NPuDqaOBZbxh3Z15wBKaZ71VINaIMzs4oA2uWP6eKEkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722560842; c=relaxed/simple;
	bh=Iipn7aP/7morR2j6/we349eTn9SQdNrAA4GWrMFRhKQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eLv8QIbnP/MxBbaGh+gx1KDSxI9oEdX0hwAhPAwdtkgVXS3FVPLjDdSeG3Vr9sUjFi0fDa/aD9teOE2G4pcqHwC3+5IaS54nJgYMPoVFJRAR+H6XSsbGzZmd73zO3BzeXYBDumkMbeVsw6zPe9dQ0wSJfFOGerjS5UiU+tomdHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=qna6LZlG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="qna6LZlG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25700C32786;
	Fri,  2 Aug 2024 01:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722560842;
	bh=Iipn7aP/7morR2j6/we349eTn9SQdNrAA4GWrMFRhKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qna6LZlGr5OBcZu5UO4S071O2l8gh6TLCKFUu3qEGWgIwIG/QHnGuMwhmbVDAbji2
	 KtM59L+umHcvQ+/WtY4IWgDJ3u6sWsDqQQHwg/HV75nN/q0PASsrstNUPi81cR9k8K
	 d9m0BXz9wDU+w3HX7+LykrKAtiqu5GWBQfT17cQc=
Date: Thu, 1 Aug 2024 18:07:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: quiltimport mode detection oddity
Message-Id: <20240801180706.933d797b0ae5744fdcdf47d2@linux-foundation.org>
In-Reply-To: <xmqqed77hifn.fsf@gitster.g>
References: <20240801155702.70242c31d476c46c84ee11a3@linux-foundation.org>
	<xmqqed77hifn.fsf@gitster.g>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 01 Aug 2024 17:33:48 -0700 Junio C Hamano <gitster@pobox.com> wrote:

> > hp2:/usr/src/mm> git quiltimport --series series
> > tools-separate-out-shared-radix-tree-components.patch
> > warning: tools/testing/radix-tree/generated/autoconf.h has type 100644, expected 100664
> >
> >
> >
> >
> > That patch has
> >
> > diff --git a/tools/testing/radix-tree/generated/autoconf.h a/tools/testing/radix-tree/generated/autoconf.h
> > deleted file mode 100664
> > --- a/tools/testing/radix-tree/generated/autoconf.h
> > +++ /dev/null
> > @@ -1,2 +0,0 @@
> > -#include "bit-length.h"
> > -#define CONFIG_XARRAY_MULTI 1
> 
> So, the patch removes autoconf.h file from that directory.  The
> "extended header" part between "diff --git" and "--- a/..." has
> "deleted file mode 100664" and that is where the warning comes.

yup yup.  The patch says "remove this file which has mode 100664".

The file has mode 100664.

quiltimport says it had mode 100644.  Incorrectly, I suggest.
