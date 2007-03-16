From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: cleaner/better zlib sources?
Date: Fri, 16 Mar 2007 16:51:17 +0100
Message-ID: <200703161651.17478.Josef.Weidendorfer@gmx.de>
References: <20070316060841.19946.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: torvalds@linux-foundation.org, git@vger.kernel.org
To: linux@horizon.com
X-From: git-owner@vger.kernel.org Fri Mar 16 17:16:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSF68-0005mL-HZ
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 17:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965440AbXCPQQF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 12:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965449AbXCPQQE
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 12:16:04 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:39416 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965440AbXCPQQD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Mar 2007 12:16:03 -0400
X-Greylist: delayed 1482 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Mar 2007 12:16:03 EDT
Received: from dhcp-3s-59.lrr.in.tum.de (dhcp-3s-59.lrr.in.tum.de [131.159.35.59])
	by mail.in.tum.de (Postfix) with ESMTP id 615D928E9;
	Fri, 16 Mar 2007 16:51:19 +0100 (MET)
User-Agent: KMail/1.9.6
In-Reply-To: <20070316060841.19946.qmail@science.horizon.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42371>

On Friday 16 March 2007, linux@horizon.com wrote:
> Er, it's a little hard to see, but zlib spends the bulk of its time
> in inflate_fast().  This is the fast path, invoked as long as there's
> at least 6 bytes of input and 258 bytes of output space available.

Hmm...

When running "git log >/dev/null" a few times on my Pentium-M here,
I get the following from oprofile:

CPU: PIII, speed 1600 MHz (estimated)
Counted CPU_CLK_UNHALTED events (clocks processor is not halted) with a unit mask of 0x00 (No unit mask) count 100000
Counted INST_RETIRED events (number of instructions retired) with a unit mask of 0x00 (No unit mask) count 400000
samples  %        samples  %        image name               app name                 symbol name
12816    19.6492  3221     19.0772  libz.so.1.2.3            git-log                  inflate_table
12186    18.6833  3640     21.5589  libz.so.1.2.3            git-log                  inflate
5228      8.0155  1395      8.2623  libz.so.1.2.3            git-log                  inflate_fast
3855      5.9104  738       4.3710  libc-2.5.so              git-log                  strlen
3782      5.7985  1361      8.0609  git-log                  git-log                  pretty_print_commit
2022      3.1001  600       3.5537  libc-2.5.so              git-log                  vfprintf

inflate_fast() is definitly below inflate().

Josef
