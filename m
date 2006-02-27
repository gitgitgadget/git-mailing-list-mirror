From: Aubrey <aubreylee@gmail.com>
Subject: Re: Quick question: how to generate a patch?
Date: Tue, 28 Feb 2006 01:02:57 +0800
Message-ID: <6d6a94c50602270902k2c06aaffw7e70268b0753ef64@mail.gmail.com>
References: <6d6a94c50602270657m453cc581p6ec290c20879de25@mail.gmail.com>
	 <Pine.LNX.4.64.0602270801280.22647@g5.osdl.org>
	 <6d6a94c50602270818k5f82bb8ft68a19899db3db636@mail.gmail.com>
	 <Pine.LNX.4.64.0602270830330.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 18:03:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDlmB-0004DB-5i
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 18:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWB0RC7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 12:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWB0RC6
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 12:02:58 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:43676 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751498AbWB0RC6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 12:02:58 -0500
Received: by wproxy.gmail.com with SMTP id i11so1197424wra
        for <git@vger.kernel.org>; Mon, 27 Feb 2006 09:02:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R955e0hkq7YYWUFtHp5Bh77u8Shp/gvvZlc7y0ktr6sg93uTxVvMvRwqF66tgq9sHwQ+gKdnkx6V2atlskmGLxxnKRnn7TZbeG/9p7YL/DQ8EseONmA0pUkivODetrDtz0f75sqHSXKCAVkTZ6DWXbrgbH6JkRnUNucFOvgSvjk=
Received: by 10.65.196.17 with SMTP id y17mr5197758qbp;
        Mon, 27 Feb 2006 09:02:57 -0800 (PST)
Received: by 10.65.185.6 with HTTP; Mon, 27 Feb 2006 09:02:57 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602270830330.22647@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16863>

> It really should "just have worked". Can you show what the diff actually
> looked like, and your exact command history?

=================================================================
aubrey@linux:/checkout/uboot/patch/work/drivers> git diff
----snip----
diff --git a/drivers/sk98lin/skxmac2.c b/drivers/sk98lin/skxmac2.c
diff --git a/drivers/sk98lin/u-boot_compat.h b/drivers/sk98lin/u-boot_compat.h
diff --git a/drivers/sk98lin/uboot_drv.c b/drivers/sk98lin/uboot_drv.c
diff --git a/drivers/sk98lin/uboot_skb.c b/drivers/sk98lin/uboot_skb.c
diff --git a/drivers/sl811.h b/drivers/sl811.h
diff --git a/drivers/sl811_usb.c b/drivers/sl811_usb.c
diff --git a/drivers/sm501.c b/drivers/sm501.c
diff --git a/drivers/smc91111.c b/drivers/smc91111.c
diff --git a/drivers/smc91111.h b/drivers/smc91111.h
index cf08582..e5742ba 100644
--- a/drivers/smc91111.h
+++ b/drivers/smc91111.h
@@ -185,6 +185,8 @@ typedef unsigned long int           dword;

 #ifdef CONFIG_ADNPESC1
 #define        SMC_inw(r)      (*((volatile word
*)(SMC_BASE_ADDRESS+((r)<<1))))
+#elif CONFIG_BLACKFIN
+#define SMC_inw(r)      ({ word __v = (*((volatile word
*)(SMC_BASE_ADDRESS+(r)))); __builtin_bfin_ssync(); __v;})
 #else
 #define        SMC_inw(r)      (*((volatile word *)(SMC_BASE_ADDRESS+(r))))
 #endif
@@ -192,6 +194,8 @@ typedef unsigned long int           dword;

 #ifdef CONFIG_ADNPESC1
 #define        SMC_outw(d,r)   (*((volatile word
*)(SMC_BASE_ADDRESS+((r)<<1))) = d)
+#elif CONFIG_BLACKFIN
+#define SMC_outw(d,r)   {(*((volatile word *)(SMC_BASE_ADDRESS+(r)))
= d);__builtin_bfin_ssync();}
 #else
 #define        SMC_outw(d,r)   (*((volatile word *)(SMC_BASE_ADDRESS+(r))) = d)
 #endif
@@ -232,6 +236,8 @@ typedef unsigned long int           dword;

 #ifdef CONFIG_XSENGINE
 #define        SMC_inl(r)      (*((volatile dword *)(SMC_BASE_ADDRESS+(r<<1))))
+#elif CONFIG_BLACKFIN
+#define SMC_inl(r)      ({ dword __v = (*((volatile dword
*)(SMC_BASE_ADDRESS+(r))));__builtin_bfin_ssync(); __v;})
 #else
 #define        SMC_inl(r)      (*((volatile dword *)(SMC_BASE_ADDRESS+(r))))
 #endif
@@ -247,6 +253,8 @@ typedef unsigned long int           dword;

 #ifdef CONFIG_XSENGINE
 #define        SMC_outl(d,r)   (*((volatile dword
*)(SMC_BASE_ADDRESS+(r<<1))) = d)
+#elif CONFIG_BLACKFIN
+#define SMC_outl(d,r)   {(*((volatile dword *)(SMC_BASE_ADDRESS+(r)))
= d);__builtin_bfin_ssync();}
 #else
 #define        SMC_outl(d,r)   (*((volatile dword
*)(SMC_BASE_ADDRESS+(r))) = d)
 #endif
diff --git a/drivers/smiLynxEM.c b/drivers/smiLynxEM.c
diff --git a/drivers/status_led.c b/drivers/status_led.c
diff --git a/drivers/sym53c8xx.c b/drivers/sym53c8xx.c
diff --git a/drivers/ti_pci1410a.c b/drivers/ti_pci1410a.c
diff --git a/drivers/tigon3.c b/drivers/tigon3.c
diff --git a/drivers/tigon3.h b/drivers/tigon3.h
diff --git a/drivers/tsec.c b/drivers/tsec.c
diff --git a/drivers/tsec.h b/drivers/tsec.h
----snip----
=================================================================
>
> If it was something like
>
>         git clone remote-repo localdir
>         cd localdir
>         vi somefile
>         git diff
>
Yes, exactly right.

> then you did everything right, and if it gives any diff other than your
> changes to "somefile", something is buggy. Need more info.
>
> Does "git diff" and "git diff HEAD" give different results, btw?

Yes. the two commands give the same results.

I'm using git-1.2.3

Regards,
-Aubrey
