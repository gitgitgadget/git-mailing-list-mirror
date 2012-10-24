From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] tile: support GENERIC_KERNEL_THREAD and
 GENERIC_KERNEL_EXECVE
Date: Wed, 24 Oct 2012 08:02:22 +0200
Message-ID: <20121024060222.GA20007@gmail.com>
References: <20121019213548.GR2616@ZenIV.linux.org.uk>
 <5082A1F1.3080303@tilera.com>
 <20121020153401.GT2616@ZenIV.linux.org.uk>
 <20121020171643.GU2616@ZenIV.linux.org.uk>
 <5086D432.4070008@tilera.com>
 <20121023184122.GZ2616@ZenIV.linux.org.uk>
 <alpine.LFD.2.02.1210232232070.2756@ionos>
 <20121023205119.GA27729@sigill.intra.peff.net>
 <alpine.LFD.2.02.1210232307480.2756@ionos>
 <CA+55aFyYD2jvD3+TSe=GhBgg5UQt2RNFdYf6HGiKRX-xWzFmdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>, Jeff King <peff@peff.net>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Chris Metcalf <cmetcalf@tilera.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Wed Oct 24 08:02:44 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1TQu3A-0008Nw-04
	for glk-linux-kernel-3@plane.gmane.org; Wed, 24 Oct 2012 08:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757683Ab2JXGC3 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 24 Oct 2012 02:02:29 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57238 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757499Ab2JXGC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Oct 2012 02:02:27 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so147774wgb.1
        for <multiple recipients>; Tue, 23 Oct 2012 23:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7dH/4Yb1Nz1EoiX8ghhqgcIZ0gWtjdcJACnlbRPXffQ=;
        b=B47dglT0yWUyHPSofrHVb1xYULE4863RISo+I6vKBZClP7ALOcS8lLzXBMT9gguOoN
         0nDXXPlimbqU9389AjXJW+hy7W20YdNmDLx9lBFshUvZbUaPOYwKMfvmFmFx1ISIrltj
         lPd59AHsQsayDbtLgt5oc2LyZqDm5VFc/bWdDx7VSt99PLVqAcQCkds1+hv0voJgq7sF
         9KjiSJPu0cYuMDewdlAvdg0Kbv9lFvJA4tJIXDiirk/Xo5BHMyLDHHPB/EL6SsVE0e81
         esrX10ePX92/+Qt6PD4ZFy+yy0JGPA7mGdCM6NVyI0FpZsw9wvzWzG/ETM4oCqoR01Jf
         uQ0Q==
Received: by 10.180.90.201 with SMTP id by9mr3247246wib.5.1351058546344;
        Tue, 23 Oct 2012 23:02:26 -0700 (PDT)
Received: from gmail.com (2E6BC28D.catv.pool.telekom.hu. [46.107.194.141])
        by mx.google.com with ESMTPS id bn7sm2973481wib.8.2012.10.23.23.02.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Oct 2012 23:02:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+55aFyYD2jvD3+TSe=GhBgg5UQt2RNFdYf6HGiKRX-xWzFmdw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208286>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Oct 24, 2012 at 12:25 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> It is spelled:
> >>
> >>   git notes add -m <comment> SHA1
> >
> > Cool!
> 
> Don't use them for anything global.
> 
> Use them for local codeflow, but don't expect them to be 
> distributed. It's a separate "flow", and while it *can* be 
> distributed, it's not going to be for the kernel, for example. 
> So no, don't start using this to ack things, because the acks 
> *will* get lost.

I'd also add a small meta argument: that it would be actively 
wrong to *allow* 'belated' acks to be added. In practice acks 
are most useful *before* a commit gets created and they often 
have a mostly buerocratic role afterwards.

So we should encourage timely acks (which actually help 
development), and accept ack-less patches as long as they are 
correct and create no problems. More utility, less buerocracy. 
Incorrect, ack-less patches causing problems will get all the 
flames they deserve.

Thanks,

	Ingo
