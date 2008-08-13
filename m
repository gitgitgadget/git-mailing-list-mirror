From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: pack operation is thrashing my server
Date: Wed, 13 Aug 2008 07:56:10 -0700 (PDT)
Message-ID: <m363q5t152.fsf@localhost.localdomain>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
	<20080811030444.GC27195@spearce.org>
	<a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
	<87vdy71i6w.fsf@basil.nowhere.org>
	<1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
	<20080813031503.GC5855@spearce.org>
	<70550C21-8358-4BEF-A7BA-3A41C1ACB346@adacore.com>
	<alpine.LFD.1.10.0808131036590.4352@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Bosch <bosch@adacore.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 16:57:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTHmp-0005a1-5R
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 16:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbYHMO4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 10:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbYHMO4O
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 10:56:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:54224 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbYHMO4N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 10:56:13 -0400
Received: by fg-out-1718.google.com with SMTP id 19so41393fgg.17
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=DDdWHMOZ8WLF0gkXCrBjCASgUkAQq/uvrx8xNcj0Cdk=;
        b=WCnEto0pIkNfVnA+Yze3z6NAzGITrNOdWTBxza9JUcIXIH1lwNl9FLMkmBgTs/dTx/
         Qu9/8RWSZSDTKOWWuxuJx5l3Nt0He5msQ2v80WJok2er5RINMbKcLKSdjyS1L7n3rxxo
         XHJFdRW3yBaowucAxflq43FhR22MuoUq62yRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=wPWPnlYGrOJXgx89/bAnb9Z3EP/sppR3lPEAoOm6Eh2SjhOK63CTOHxLnI+xnkXdUF
         8vxXtWsrW5Qt3SHxjQWWlBDN0tjA4kqkvdwSpOvoFoIduC4p65h+SourtG6/HdO9A6K3
         iYCdc3vdIWniLy1eU6/BLGcfA0n9llPP0mJKU=
Received: by 10.86.65.11 with SMTP id n11mr61407fga.64.1218639371716;
        Wed, 13 Aug 2008 07:56:11 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.245.20])
        by mx.google.com with ESMTPS id l19sm981241fgb.7.2008.08.13.07.56.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Aug 2008 07:56:10 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m7DEu6L9020871;
	Wed, 13 Aug 2008 16:56:06 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m7DEtriV020867;
	Wed, 13 Aug 2008 16:55:53 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LFD.1.10.0808131036590.4352@xanadu.home>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92224>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 12 Aug 2008, Geert Bosch wrote:
> 
> > One nice optimization we could do for those pesky binary large objects
> > (like PDF, JPG and GZIP-ed data), is to detect such files and revert
> > to compression level 0. This should be especially beneficial
> > since already compressed data takes most time to compress again.
> 
> That would be a good thing indeed.

Perhaps take a sample of some given size and calculate entropy in it?
Or just simply add gitattribute for per file compression ratio...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
