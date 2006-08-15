From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 5/6] On Solaris nanosleep() is not in libc but in librt
Date: Tue, 15 Aug 2006 13:18:17 +0200
Message-ID: <81b0412b0608150418g3fc8efd7n51f1095a98a3d08f@mail.gmail.com>
References: <20060815090031.5223.27458.stgit@leonov.stosberg.net>
	 <20060815090129.5223.17174.stgit@leonov.stosberg.net>
	 <7vzme670dm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Dennis Stosberg" <dennis@stosberg.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 13:18:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCwwF-0006yv-KN
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 13:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWHOLSU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 07:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbWHOLSU
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 07:18:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:18843 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030236AbWHOLST (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 07:18:19 -0400
Received: by nf-out-0910.google.com with SMTP id x30so292016nfb
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 04:18:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bCXDvpjxcs8j7N9lGPeFUgX1RAnRGWPMsiJvS2vdYXTZofXMeZRGU8Tov5zGL2LS2xGCa+aEyXORD52O2PudCVQFwx049gVHKYLoCZrvjDlKSqzBCLsT6mLTNoPLCHtrberiUtWqYIgT4KZOo7yvmqABm+cwY992Mk/70bUohM4=
Received: by 10.49.43.2 with SMTP id v2mr1150656nfj;
        Tue, 15 Aug 2006 04:18:18 -0700 (PDT)
Received: by 10.78.160.12 with HTTP; Tue, 15 Aug 2006 04:18:17 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vzme670dm.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25455>

On 8/15/06, Junio C Hamano <junkio@cox.net> wrote:
> > -# Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
> > -# Patrick Mauritz).
> > +# Define NEEDS_SOCKET if linking with libc is not enough for socket()
> > +# (SunOS, Patrick Mauritz).
> > +#
> > +# Define NEEDS_RT if linking with libc is not enough for nanosleep() (SunOS)
>
> Ah, nanosleep(2) was my fault, and we should be able to just use
> straight sleep(3) there.  The purpose of the loop is to wait
> until the next filesystem timestamp granularity, and the code
> uses subsecond sleep in the hope that it can shorten the delay
> to 0.5 seconds on average instead of a full second.

Was it not SunOS where sleep was implemented by means of SIGALRM?
Besides, we still can shorten the delay by using select(2).
