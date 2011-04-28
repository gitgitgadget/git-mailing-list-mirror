From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 11:38:37 +0200
Message-ID: <20110428093837.GA15847@elte.hu>
References: <20110427225114.GA16765@elte.hu>
 <BANLkTim7bbFiSsj3PRr-_yM5gh1txYQR5w@mail.gmail.com>
 <20110428091110.GA14431@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 11:39:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFNgl-0007sY-3P
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 11:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757942Ab1D1Ji7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 05:38:59 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:58528 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131Ab1D1Ji6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 05:38:58 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1QFNgF-0002Mu-6V
	from <mingo@elte.hu>; Thu, 28 Apr 2011 11:38:44 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 47D0D3E236B; Thu, 28 Apr 2011 11:38:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110428091110.GA14431@elte.hu>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.3.1
	-2.0 BAYES_00               BODY: Bayes spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172335>


* Ingo Molnar <mingo@elte.hu> wrote:

> > Another thing is that so far this optimization was only with
> > GCC, and we do not know whether it helps or harms to compilers.
> > So, maybe placing this code under 'ifdef __GNUC__' makes more
> > sense than pushing this change on other compilers too.
> 
> Well, given that 90%+ of Git development is done with GCC (and probably the 
> user share is similarly high as well):
> 
>  aldebaran:~/git> git log --pretty=oneline -i --grep gcc | wc -l
>  127
>  aldebaran:~/git> git log --pretty=oneline -i --grep llvm | wc -l
>  1

I left out:

   aldebaran:~/git> git log --pretty=oneline -i --grep clang | wc -l
   5

Still well within the 90%+ figure.

Thanks,

	Ingo
