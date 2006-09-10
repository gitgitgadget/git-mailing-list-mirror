From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 14:00:13 -0400
Message-ID: <9e4733910609101100u515ae6e3seababd5780db715d@mail.gmail.com>
References: <9e4733910609100756r1ece1e22m38054536a2909dd4@mail.gmail.com>
	 <20060910161007.8846.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, paulus@samba.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sun Sep 10 20:00:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMTbP-00040L-2S
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 20:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWIJSAQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 14:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWIJSAP
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 14:00:15 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:58835 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932336AbWIJSAO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 14:00:14 -0400
Received: by py-out-1112.google.com with SMTP id n25so1818854pyg
        for <git@vger.kernel.org>; Sun, 10 Sep 2006 11:00:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HXgO9AgrVB6HtSdWMI1CtieNn2EGNwqLM7geBALbym/mKZ+BMqcuizJCiNLdPN9rBJhsAPvXnssivNRzXxPIeQafxUxkAG2pEcTK1nGR93lJVJuog0zVrqetyxc4hTg+quIaFCL6brN2bfVGqq5WivSpOOHqZIMcWoe2uretPUQ=
Received: by 10.35.50.1 with SMTP id c1mr7202401pyk;
        Sun, 10 Sep 2006 11:00:13 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Sun, 10 Sep 2006 11:00:13 -0700 (PDT)
To: "linux@horizon.com" <linux@horizon.com>
In-Reply-To: <20060910161007.8846.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26803>

On 10 Sep 2006 12:10:07 -0400, linux@horizon.com <linux@horizon.com> wrote:
> Actually, Linux has one of the fastest forks around, 100-200 us on
> modern x86.  For large executables, the shared page tables patch (is it
> merged yet?) might help.

Here is the opfile of the kernel

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

At the time this was measured parsecvs was executing millions of git
command using system(command). 40% of the CPU was in the kernel, it
stayed that way for hours.

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

Maybe we are looking at the wrong thing, it may be fast to fork a
process, is it fast for the process to exit?


-- 
Jon Smirl
jonsmirl@gmail.com
