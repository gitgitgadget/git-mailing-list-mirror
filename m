From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 03:05:47 -0700 (PDT)
Message-ID: <m3ej71r6ob.fsf@localhost.localdomain>
References: <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil>
	<20080611213648.GA13362@glandium.org>
	<alpine.DEB.1.00.0806112242370.1783@racer>
	<20080611230344.GD19474@sigill.intra.peff.net>
	<alpine.LFD.1.10.0806111918300.23110@xanadu.home>
	<loom.20080612T042942-698@post.gmane.org>
	<6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com>
	<4851F6F4.8000503@op5.se>
	<20080613055800.GA26768@sigill.intra.peff.net>
	<48521EDA.5040802@op5.se> <20080613074257.GA513@sigill.intra.peff.net>
	<7vtzfxwtt0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Andreas Ericsson <ae@op5.se>,
	Wincent Colaiuta <win@wincent.com>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 12:06:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K76BC-0001N3-CA
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 12:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757030AbYFMKFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 06:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756988AbYFMKFv
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 06:05:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:28343 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264AbYFMKFu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 06:05:50 -0400
Received: by ug-out-1314.google.com with SMTP id h2so50450ugf.16
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 03:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=yAQWvT0nVUErUQyn1G4OEhxCN6JIiJb2Hqp9XDZthgA=;
        b=mImpPDIJowyiagFB2Q9Yeo0bz1oz2L2irkrfRx/BVD6beA8qegy2f8aSM2/TCyKaT5
         SbvkC0118ORQUGeG0U6L8m7X5SfiUozu8EMgn+XJu4wcPuMLaoqx1zsJTD8C7MGQ/diQ
         NwnXEBguMGaC3lFeGgW+lFd56AzbQfyUGcl0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Tc1mCh4yqvb+bfWVg0f12feINKfzeR1v+6uPmvtpQSIpkbWSmG9IKzO3H0IIOtkNFk
         0zoKpEwr2EHxl/btcrvqclOh2NaTj59ZIv8yP9tzvF6OWt/GrXClXiXlbjubIdUaX9La
         ZgDEW30WG+P0pQv4KGLPWh45mZZgY08yH0g18=
Received: by 10.66.245.2 with SMTP id s2mr733965ugh.23.1213351549169;
        Fri, 13 Jun 2008 03:05:49 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.221.64])
        by mx.google.com with ESMTPS id 23sm306545ugf.54.2008.06.13.03.05.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Jun 2008 03:05:47 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5DA5hSj006455;
	Fri, 13 Jun 2008 12:05:44 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5DA5eMD006452;
	Fri, 13 Jun 2008 12:05:40 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vtzfxwtt0.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84860>

Junio C Hamano <gitster@pobox.com> writes:

>  * We however chose to take advantage of the auto reclamation behaviour of
>    reflog, and for most practical purposes, it is a good thing.

By the way, this makes stashes a bit similar to using $TMPDIR to store
files with 'tmpwatch' (or equivalent) enabled.  Is this a good analogy?

[...]
> But let's not talk nor think about per-branch stash for now.  How does the
> "keep" thing sound to people?

This looks nice, although I'd rather not use any magic.  I'm only
afraid that people would notice that some stash / stash entry should
have been "kept" when it is too late.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
