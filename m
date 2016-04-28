From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 25/29] refs: resolve symbolic refs first
Date: Thu, 28 Apr 2016 19:40:03 -0400
Organization: Twitter
Message-ID: <1461886803.4123.14.camel@twopensource.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	 <a33272db057ac6327cc0c87c002473c89ffcca6b.1461768690.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git mailing list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 29 01:40:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avvXr-0000At-0c
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 01:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbcD1XkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 19:40:10 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36110 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbcD1XkG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 19:40:06 -0400
Received: by mail-qg0-f46.google.com with SMTP id d90so36527435qgd.3
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 16:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=OLWS94ZyZAHntDqFTxkBzicyDo3ysOzxWyACqH/Jing=;
        b=Uixn3mRLJTGv6iWsvW3rmMHi0eGdEeYF4pwN91nsLKscEUlfOiOwzUPWE4ihsWqMte
         W8x8grNbWHaeWnRyVge8N/UBk9pRod3bjX4P0QJiEvMgfCJcpT24oEszdf5Ui+HVZRuX
         kJ7xTUW4jw4AWde2y2maZ619J4DoWlypqix2ASvHRJvyL1y2yWrHcTPgQ9VW5kJOlytt
         tfiAHeY69rsJwOD98bXQqy8uBxJ87Y7M5rJZEtppqglrpF355mGhGv+v0ApkbJkos+oz
         wMPXi3Da/Miox2TbYe1MbnJt6IQCO2xc/+zORjWH1/ObB5IVuvD0DtnTswfqwhQs5DyU
         eUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=OLWS94ZyZAHntDqFTxkBzicyDo3ysOzxWyACqH/Jing=;
        b=lJ9dBzHAV0B/PM5dwlR2KdVzW7vcm/Q1n4NACHhB0FY2M0BhJowQDcDRKCLw9qt1LJ
         Ke736IaTlJ/PM5pRNMq27jOyqbwx1UFWgixnEsPWHiw6Y3ng5AP3sHZdDMuwnVHOo48a
         KsfKrblmySsSLRw16zTbYJVaRMtTEqdxOC/PjHSyMh2t/PptdGMm5QERaK/b/IPGq/OQ
         1+VXq8grrIQW/gAJ3jNjOw0j8iyL3VSRDM+wa8nNnjtkbWuFaJnX984XdXZCrMiadsH9
         ZYVKgL3vavwwmIhRdRCRM8RSncvlLWkIwwrk5XIuN1y+iAiZPINtn87MhRlHtwTV7kMQ
         Raaw==
X-Gm-Message-State: AOPr4FXr9iNpQ1XA07wgibBFoRB7aE4bzrqkAJ3IewMLA/ABetCQsRKpXrjYFUW6Sa0glA==
X-Received: by 10.140.41.203 with SMTP id z69mr16651178qgz.57.1461886805193;
        Thu, 28 Apr 2016 16:40:05 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id w5sm3561852qhc.15.2016.04.28.16.40.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Apr 2016 16:40:04 -0700 (PDT)
In-Reply-To: <a33272db057ac6327cc0c87c002473c89ffcca6b.1461768690.git.mhagger@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292961>

On Wed, 2016-04-27 at 18:57 +0200, Michael Haggerty wrote:
+retry:
...
> +		if (--attempts_remaining > 0)
> +			goto retry;

could this be a loop instead of using gotos?

> +			/*
> +			 * There is a directory in the way,
> +			 * but we	 don't know of any references
> +			 * that it should contain. This might
> +			 * be a directory that used to contain
> +			 * references but is now empty. Try to
> +			 * remove it; otherwise it might cause
> +			 * trouble when we try to rename the
> +			 * lockfile into place.
> +			 */
> +			strbuf_addf(err, "there is a non-empty directory '%s' "
> +				          "blocking reference '%s'",
> +					  ref_file.buf,refname);
> +			goto error_return;

We don't actually try to remove anything here, so that comment seems
wrong?
