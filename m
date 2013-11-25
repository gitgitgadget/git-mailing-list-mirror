From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] commit-slab: declare functions "static inline"
Date: Mon, 25 Nov 2013 12:12:00 -0800
Message-ID: <20131125201200.GN4212@google.com>
References: <878uwc2r7c.fsf@thomasrast.ch>
 <89b534b37f5689a675f0f97d3627a0668ce2a71d.1385409724.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Nov 25 21:12:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl2Vu-0005kp-O8
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 21:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756842Ab3KYUMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 15:12:06 -0500
Received: from mail-yh0-f48.google.com ([209.85.213.48]:63168 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754934Ab3KYUMF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 15:12:05 -0500
Received: by mail-yh0-f48.google.com with SMTP id f73so3206462yha.35
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 12:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=srwjbDWlO4Rkq8rgNeB/EtZgAUq0g1cj8wwfE69eV4I=;
        b=hZAJnmTXOH/xghQp9zmX8RvEomc0iuFXNA3n2XQokgJt6AyYje0cj4REJY7vpqRSSz
         tbn3MRtky9XF3DOVLg6TVDuKPXFs0St5ar7d/tGh6ti2sxa6WHvQbHOUUN+AlX+KKg1T
         QOU4rHK/JPBuHs29F1zEEtTIkVEANDiQSm8d8ydmJciP3lr93Jzr2iW1u6JaiKMB0h2o
         YpzmisrlVXND3lMOmeu3FxCpbaIjEr0UQJwmCUaX5eBN0zq5U9RBNNA4C45A2gIEpQMl
         6tZaK513Cy5/u+eVsZe00uWoazaHKcCwdThbOxjVDiwcotPBz6a07VRIID22iy2PTkD9
         4Zkw==
X-Received: by 10.236.35.71 with SMTP id t47mr1609818yha.72.1385410323685;
        Mon, 25 Nov 2013 12:12:03 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id v45sm77763194yha.2.2013.11.25.12.12.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Nov 2013 12:12:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <89b534b37f5689a675f0f97d3627a0668ce2a71d.1385409724.git.tr@thomasrast.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238338>

Thomas Rast wrote:

> This shuts up compiler warnings about unused functions.

If that is the only goal, I think it would be cleaner to use

	#define MAYBE_UNUSED __attribute__((__unused__))

	static MAYBE_UNUSED void init_ ...

like was done in the vcs-svn/ directory until cba3546 (drop obj_pool,
2010-12-13) et al.

I haven't thought carefully about whether encouraging inlining here
(or encouraging the reader to think of these functions as inline) is a
good or bad change.

[...]
> @@ -98,4 +98,16 @@ struct slabname {							\
>  									\
>  static int stat_ ##slabname## realloc
>  
> +/*
> + * Note that this seemingly redundant second declaration is required
> + * to allow a terminating semicolon, which makes instantiations look
> + * like function declarations.  I.e., the expansion of

Micronit: this reads more clearly without the "Note that".  That is,
the comment can get the reader's attention more easily by going right
into what it is about to say without asking for the reader's
attention:

	/*
	 * This seemingly redundant second declaration is required to ...

Thanks,
Jonathan
