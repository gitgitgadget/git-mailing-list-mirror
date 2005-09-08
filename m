From: Greg KH <greg@kroah.com>
Subject: Re: git applymbox is too anal
Date: Thu, 8 Sep 2005 16:39:06 -0700
Message-ID: <20050908233906.GA7976@kroah.com>
References: <20050908232535.GA7700@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 09 01:40:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDVzG-0008Hn-TC
	for gcvg-git@gmane.org; Fri, 09 Sep 2005 01:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbVIHXjU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 19:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbVIHXjU
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 19:39:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:23018 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965076AbVIHXjU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 19:39:20 -0400
Received: from [192.168.0.10] (c-24-22-115-24.hsd1.or.comcast.net [24.22.115.24])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j88NdJw02542
	for <git@vger.kernel.org>; Thu, 8 Sep 2005 16:39:19 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1EDVz0-24t-00 for <git@vger.kernel.org>; Thu, 08 Sep 2005 16:39:06
 -0700
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050908232535.GA7700@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8228>

On Thu, Sep 08, 2005 at 04:25:35PM -0700, Greg KH wrote:
> Ick.  I'm trying to apply a bunch of patches to a git repo (the kernel
> tree), using 'git applymbox' and it's just dieing on simple patches that
> apply with fuzz.

Ok, found another one.  This time I looked at the patch itself, and it
is a bit "odd", but normal patch handles it fine.

The patch is:
--- gregkh-2.6.orig/drivers/usb/input/Makefile  2005-08-15 23:39:10.000000000 -0700
+++ gregkh-2.6/drivers/usb/input/Makefile       2005-08-16 12:31:54.000000000 -0700
@@ -39,5 +39,6 @@
 obj-$(CONFIG_USB_POWERMATE)    += powermate.o
 obj-$(CONFIG_USB_WACOM)        += wacom.o
 obj-$(CONFIG_USB_ACECAD)       += acecad.o
+obj-$(CONFIG_USB_YEALINK)      += yealink.o
 obj-$(CONFIG_USB_XPAD)         += xpad.o
 obj-$(CONFIG_USB_APPLETOUCH)   += appletouch.o

While the original drivers/usb/input/Makefile in this area is:
obj-$(CONFIG_USB_POWERMATE)     += powermate.o
obj-$(CONFIG_USB_WACOM)         += wacom.o
obj-$(CONFIG_USB_ACECAD)        += acecad.o
obj-$(CONFIG_USB_XPAD)          += xpad.o

(ignore tab issues, this was cut-and-pasted).

So, the patch shows that there was another line at the end of the file,
while in reality it isn't (this is due to me excluding a patch from the
series that I'm applying due to other reasons.)

Is this something that git can handle without me editing the patch by
hand?  :)

thanks,

greg k-h
