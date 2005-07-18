From: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.12 hangs on boot
Date: Mon, 18 Jul 2005 14:58:58 +0200
Message-ID: <20050718125857.GF8459@wotan.suse.de>
References: <200506221813.50385.gluk@php4.ru> <Pine.LNX.4.58.0506241446440.11175@ppc970.osdl.org> <200507181527.16652.gluk@php4.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	admin@list.net.ru, Git Mailing List <git@vger.kernel.org>,
	ak@suse.de
X-From: git-owner@vger.kernel.org Mon Jul 18 15:00:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuVDL-0007cE-H3
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 14:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVGRM7F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jul 2005 08:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVGRM7F
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jul 2005 08:59:05 -0400
Received: from mail.suse.de ([195.135.220.2]:51865 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261365AbVGRM7D (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2005 08:59:03 -0400
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 7C179EEF1;
	Mon, 18 Jul 2005 14:59:02 +0200 (CEST)
To: "Alexander Y. Fomichev" <gluk@php4.ru>
Content-Disposition: inline
In-Reply-To: <200507181527.16652.gluk@php4.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Can you please test if this patch fixes it?

-Andi


Don't compare linux processor index with APICID

Fixes boot up lockups on some machines where CPU apic ids
don't start with 0

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux.orig/arch/x86_64/kernel/smpboot.c
+++ linux/arch/x86_64/kernel/smpboot.c
@@ -211,7 +211,7 @@ static __cpuinit void sync_master(void *
 {
 	unsigned long flags, i;
 
-	if (smp_processor_id() != boot_cpu_id)
+	if (smp_processor_id() != 0)
 		return;
 
 	go[MASTER] = 0;
