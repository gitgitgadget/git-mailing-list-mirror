From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 13:10:30 +0300
Message-ID: <4DB93D16.4000603@cs.helsinki.fi>
References: <20110427225114.GA16765@elte.hu> <7voc3r5kzn.fsf@alter.siamese.dyndns.org> <20110428062717.GA952@elte.hu> <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com> <20110428093703.GB15349@elte.hu> <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?=" <fweisbec@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Apr 28 12:10:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFOBD-0007hN-0s
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 12:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758294Ab1D1KKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 06:10:33 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:37582 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab1D1KKc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 06:10:32 -0400
Received: from l227.local ([192.100.124.156])
  (AUTH: PLAIN penberg, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by mail.cs.helsinki.fi with esmtp; Thu, 28 Apr 2011 13:10:31 +0300
  id 0008D06F.4DB93D17.00004FF9
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172344>

On 4/28/11 12:50 PM, Erik Faye-Lund wrote:
>> Alas, i have not seen these sha1 hash buffers being allocated unaligned (in my
>> very limited testing). In which spots are they allocated unaligned?
>
> Like I said above, it can happen when allocated on the stack. But it
> can also happen in malloc'ed structs, or in global variables. An array
> is aligned to the size of it's base member type. But malloc does
> worst-case-allignment, because it happens at run-time without
> type-information.

I'd be very surprised if malloc() did "worst case alignment" - that'd 
suck pretty badly from performance point of view. However, if you want 
*guarantees* about the alignment, there's memalign() for heap allocations.

Stack allocation alignment is a harder issue but I doubt it's as bad as 
you make it out to be. On x86, for example, stack pointer is almost 
always 8 or 16 byte aligned with compilers whose writers have spent any 
time reading the Intel optimization manuals.

So yes, your statements are absolutely correct but I strongly doubt it 
matters that much in practice unless you're using a really crappy 
compiler...

			Pekka
