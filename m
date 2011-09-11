From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: "git archive" seems to be broken wrt zip files
Date: Sat, 10 Sep 2011 21:58:08 -0700
Message-ID: <CA+55aFx43OxExGNrJs+AyKNtdr+KCZZoE=iaQTz8uHoUSrQv0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 11 07:00:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2c9g-0000cE-O7
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 07:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163Ab1IKE6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 00:58:33 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54192 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751050Ab1IKE6c (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2011 00:58:32 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p8B4wTrK011817
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Sat, 10 Sep 2011 21:58:31 -0700
Received: by wyh22 with SMTP id 22so2568998wyh.19
        for <git@vger.kernel.org>; Sat, 10 Sep 2011 21:58:28 -0700 (PDT)
Received: by 10.216.193.18 with SMTP id j18mr1030831wen.76.1315717108178; Sat,
 10 Sep 2011 21:58:28 -0700 (PDT)
Received: by 10.216.174.8 with HTTP; Sat, 10 Sep 2011 21:58:08 -0700 (PDT)
X-Spam-Status: No, hits=-102.991 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf-20110901g
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181165>

So I wouldn't ever have noticed on my own, but now that I've tried
github for the kernel, somebody else reported that the downloaded zip
file (seriously? the kernel as a zip file?) is corrupt.

And it doesn't really seem to be a github issue. I can re-create it
with a simple

   git archive --format=zip HEAD -o ../kernel.zip

on my kernel repository: the end result does not unzip correctly:

   mkdir temp-directory
   cd temp-directory
   unzip kernel.zip
   ...
     inflating: virt/kvm/iommu.c
     inflating: virt/kvm/irq_comm.c
     inflating: virt/kvm/kvm_main.c
   finishing deferred symbolic links:
     arch/microblaze/boot/dts/system.dts -> ../../platform/generic/system.dts
     drivers/scsi/aic94xx/aic94xx_reg.h -> /*^J * Aic94xx SAS/SATA
driver hardware registers definitions.[ rest of the file ]
   symlink error: File name too long

iow, for some reason that "drivers/scsi/aic94xx/aic94xx_reg.h" file
seems to have been encoded as a symlink.

Anybody seen this?

                          Linus
