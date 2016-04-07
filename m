From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Thu, 07 Apr 2016 14:47:04 -0400
Organization: Twitter
Message-ID: <1460054824.5540.2.camel@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
	 <1459980722-4836-4-git-send-email-dturner@twopensource.com>
	 <5705FC59.2050801@kdbg.org> <alpine.DEB.2.20.1604071614250.2967@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Apr 07 20:47:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoExW-0004yT-2p
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 20:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbcDGSrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 14:47:09 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33982 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793AbcDGSrI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 14:47:08 -0400
Received: by mail-qg0-f50.google.com with SMTP id c6so71262504qga.1
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 11:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Vr6n2afoL0wnL7wyVA83Kd9/wEiOxWfw0YTx/Y3uRd8=;
        b=GKbYjYcyBf/n7GWv834QGClMjZRd4DwcpR/HYOEoePXP0KSHSauLNg+l5G/jnhRb0r
         +t1GxrRG8v9IsWUssZXdwgJtL8ULPgyhCdmJLzXtO1A5Q6V10u4GlhxA52XMdpxd3YO6
         aoCIgWYUCPNx6QZux+xeiwT0gcicAMrla5W0WhKInqWx6YPhRhk5A779oZ6BhNa8EnOY
         Q5jK0m43qWrtgQQ58/7DCVpdw83+yfT3i9lPz79eht3nf0pDwKh77MfdEs75/As8Oxlq
         c3ZemuaSlA8ey88RqghfQGEsut5Szjsv6etCu2wtSri3+BmK6vPnXuAEtc9AcSUXyvYU
         nwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Vr6n2afoL0wnL7wyVA83Kd9/wEiOxWfw0YTx/Y3uRd8=;
        b=ea/Oke8AaIp1mPW9y5i2RbJe5rlEJChSOB6L37AsxVhS44rqniFPVbUrL/R6VrHbWA
         BwwN+XPRS/jq5fDiVlKXTTN0ebDGvtmKkLXRK9iyW5W2LSPXBu2eeGemcyPXWnEr9nsF
         456aQFLPbuyoEUZYU5dYofkSuvzjze6+CNJmXdn+heuf1AKDq2tw0L5PitB91dHsq1i1
         zpOJeVNjMx959LQhMK1832l7wkgznzQ5wNTkHDMogjeBLLtBZAHJBiPuFLE9TPRSaD7w
         JaQwG/5RrADLlQxAvSI/KdPc82WNM3YL8EdzRFBFlSgvFUdaF4daBc4RT3PC9wohkgDj
         Ngow==
X-Gm-Message-State: AD7BkJJl9booq5yGWMdvG3Fsi1eo583CaXqG0pnmayyHqm1rzZ2Kgm1OocnkLRKpzNADPQ==
X-Received: by 10.140.248.8 with SMTP id t8mr6300517qhc.50.1460054825665;
        Thu, 07 Apr 2016 11:47:05 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id y123sm3979031qka.0.2016.04.07.11.47.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 11:47:04 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1604071614250.2967@virtualbox>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290945>

On Thu, 2016-04-07 at 16:14 +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 7 Apr 2016, Johannes Sixt wrote:
> 
> > Am 07.04.2016 um 00:11 schrieb David Turner:
> > > +static void share_index(struct index_state *istate, struct shm
> > > *is)
> > > +{
> > > +	void *new_mmap;
> > > +	if (istate->mmap_size <= 20 ||
> > > +	    hashcmp(istate->sha1,
> > > +		    (unsigned char *)istate->mmap + istate
> > > ->mmap_size - 20)
> > > > > 
> > > +	    !hashcmp(istate->sha1, is->sha1) ||
> > > +	    git_shm_map(O_CREAT | O_EXCL | O_RDWR, 0700, istate
> > > ->mmap_size,
> > > +			&new_mmap, PROT_READ | PROT_WRITE,
> > > MAP_SHARED,
> > > +			"git-index-%s", sha1_to_hex(istate
> > > ->sha1)) < 0)
> > 
> > Builds which have NO_MMAP set require that MAP_PRIVATE is set. So I
> > would
> > guess that at this point you leave those builds behind. Unless we
> > declare
> > such systems as hopelessly outdated and remove NO_MMAP and
> > compat/mmap.c or
> > you support index-helper only when NO_MMAP is not set.
> 
> I vote for the latter: support index-helper only when NO_MMAP is
> unset.

Will fix, thanks.
