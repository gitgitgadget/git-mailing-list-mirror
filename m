From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Why so much time in the kernel?
Date: Fri, 16 Jun 2006 10:49:39 -0400
Message-ID: <9e4733910606160749t4d7a541ev72a67383e96d86da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 16 16:49:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrFdo-0004XE-Pd
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 16:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWFPOtk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 10:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWFPOtk
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 10:49:40 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:62367 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751412AbWFPOtj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 10:49:39 -0400
Received: by nz-out-0102.google.com with SMTP id s18so930370nze
        for <git@vger.kernel.org>; Fri, 16 Jun 2006 07:49:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZY1uBSFvlD3WfLE2JZ+XZWBwPJc3JdUvzeYbl65Rx3UDuzCI7F2mqQ30HCvS798CD+uPqJei8ClxrbrYLYm644IsIWm49aOTbc0KqHmimRh2u1i5y40GGBCwbp3qBnN4BNO0YWh49DRcaJMXFPF8QDXOvRYjqPTk1ik9EcoytPo=
Received: by 10.36.38.13 with SMTP id l13mr591762nzl;
        Fri, 16 Jun 2006 07:49:39 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Fri, 16 Jun 2006 07:49:38 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21943>

I'm still working on importing Mozilla CVS. I'm at the phase now where
all of the changeset have been identified. The scripts are pulling the
changesets one at a time out of CVS and putting them into git. I've
been running this phase for 2 days now on a 3GB machine and it still
isn't finished.

I am spending over 40% of the time in the kernel. This looks to be
caused from forks and starting small tasks, is that the correct
interpretation? Is the number of process that have been run recorded
any where? 1.4% of the time is spend in the dynamic linker.

Checking with oprofile I see this:

  18262372 41.0441 /home/good/vmlinux
  5465741 12.2841 /usr/bin/cvs
  4374336  9.8312 /lib/libc-2.4.so
  3627709  8.1532 /lib/libcrypto.so.0.9.8a
  2494610  5.6066 /usr/bin/oprofiled
  2471238  5.5540 /usr/lib/libz.so.1.2.3
   945349  2.1246 /usr/lib/perl5/5.8.8/i386-linux-thread-multi/CORE/libperl.so
   933646  2.0983 /usr/local/bin/git-read-tree
   758776  1.7053 /usr/local/bin/git-write-tree
   642502  1.4440 /lib/ld-2.4.so
   472903  1.0628 /nvidia
   379254  0.8524 /usr/local/bin/git-pack-objects

and breaking down the kernel number:

3467889  18.9893  copy_page_range
2190416  11.9941  unmap_vmas
1156011   6.3300  page_fault
887794    4.8613  release_pages
860853    4.7138  page_remove_rmap
633243    3.4675  get_page_from_freelist
398773    2.1836  do_wp_page
344422    1.8860  __mutex_lock_slowpath
280070    1.5336  __handle_mm_fault
241713    1.3236  do_page_fault
238398    1.3054  __d_lookup
236654    1.2959  vm_normal_page


-- 
Jon Smirl
jonsmirl@gmail.com
