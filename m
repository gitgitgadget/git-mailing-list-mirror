From: "Alexander Y. Fomichev" <gluk@php4.ru>
Subject: Re: 2.6.12 hangs on boot
Date: Tue, 19 Jul 2005 15:53:12 +0400
Message-ID: <200507191553.12741.gluk@php4.ru>
References: <200506221813.50385.gluk@php4.ru> <200507181527.16652.gluk@php4.ru> <20050718125857.GF8459@wotan.suse.de>
Reply-To: "Alexander Y. Fomichev" <gluk@php4.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	admin@list.net.ru, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 19 13:55:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Duqfk-0006kO-R5
	for gcvg-git@gmane.org; Tue, 19 Jul 2005 13:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVGSLx6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jul 2005 07:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVGSLx6
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jul 2005 07:53:58 -0400
Received: from village.ehouse.ru ([193.111.92.18]:2052 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S261204AbVGSLx4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2005 07:53:56 -0400
Received: from [193.111.92.114] (helo=breuss-254.ws.ehouse.ru)
	by mail.ehouse.ru with esmtp
	(Exim 3.22) id 1Duqew-0004G3-00 ; Tue, 19 Jul 2005 15:53:14 +0400
To: Andi Kleen <ak@suse.de>
User-Agent: KMail/1.8.1
In-Reply-To: <20050718125857.GF8459@wotan.suse.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Monday 18 July 2005 16:58, Andi Kleen wrote:
> Can you please test if this patch fixes it?
>
> -Andi
>
>
> Don't compare linux processor index with APICID
>
> Fixes boot up lockups on some machines where CPU apic ids
> don't start with 0
>
> Signed-off-by: Andi Kleen <ak@suse.de>
>
> Index: linux/arch/x86_64/kernel/smpboot.c
> ===================================================================
> --- linux.orig/arch/x86_64/kernel/smpboot.c
> +++ linux/arch/x86_64/kernel/smpboot.c
> @@ -211,7 +211,7 @@ static __cpuinit void sync_master(void *
>  {
>  	unsigned long flags, i;
>
> -	if (smp_processor_id() != boot_cpu_id)
> +	if (smp_processor_id() != 0)
>  		return;
>
>  	go[MASTER] = 0;

No, sorry, the same result -- hangs just after:

Booting processor 2/1 rip 6000 rsp ffff8100dff7df58
Initializing CPU#2

(hmm... as i can see one string above [and if i understand correctly]
boot_cpu_id == 0 in my case: 
CPU 1: Syncing TSC to CPU 0 )

-- 
Best regards.
        Alexander Y. Fomichev <gluk@php4.ru>
        Public PGP key: http://sysadminday.org.ru/gluk.asc
