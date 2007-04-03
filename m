From: James Cloos <cloos@jhcloos.com>
Subject: Re: Distribution of longest common hash prefixes
Date: Tue, 03 Apr 2007 13:04:54 -0400
Message-ID: <m3r6r1jsmq.fsf@lugabout.jhcloos.org>
References: <20070402145857.GA13293@bohr.gbar.dtu.dk>
	<Pine.LNX.4.64.0704020817250.6730@woody.linux-foundation.org>
	<86bqi6kae7.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0704020938470.6730@woody.linux-foundation.org>
	<86y7laitlz.fsf@blue.stonehenge.com>
	<86r6r2isva.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Eriksen <s022018@student.dtu.dk>,
	merlyn@stonehenge.com (Randal L. Schwartz)
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 19:09:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYmVE-0007dj-RW
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 19:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965641AbXDCRJA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 13:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965654AbXDCRJA
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 13:09:00 -0400
Received: from atl.uu.jhcloos.net ([207.210.96.115]:52460 "EHLO
	atl.uu.jhcloos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965641AbXDCRI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 13:08:59 -0400
Received: by atl.uu.jhcloos.net (Postfix, from userid 10)
	id ABEF5BB482; Tue,  3 Apr 2007 17:08:58 +0000 (UTC)
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 432F93C032B; Tue,  3 Apr 2007 17:05:17 +0000 (UTC)
In-Reply-To: <86r6r2isva.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "Mon\, 02 Apr 2007 10\:33\:13 -0700")
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAMnRFWHRUaXRsZQAvbWF4dG9y
 L2Nsb29zL2luY29taW5nLzIwMDQvMDIvUFdHL0pIQzE2LnBuZyJMlEwAAAAadEVYdFNvZnR3YXJl
 AEdOT01FIEljb24gRWRpdG9ynioKbAAAAHFJREFUeJzFk8EKwCAMQ1/ED9cvzw6iuM0N9WIvDTWE
 1KjAxmKnLBEBjLcEIBCeI2nccy5YKrjxwbbvAvZ37zlo4GB9iRMC/cq/AppItwmMyJ5I98wd9G7P
 xxgrSKlYS2lMrOcV13o95aVSKA7E5ndGXG+IIzcl4BNfAAAAAElFTkSuQmCC
Copyright: Copyright 2007 James Cloos
X-Hashcash: 1:23:070403:torvalds@linux-foundation.org::geXi0qbFG3zLzXpP:000000000000000000000000000000008abr
X-Hashcash: 1:23:070403:git@vger.kernel.org::CsKE2d3fyFS/ntRH:000000000000000000000000000000000000000000InI3
X-Hashcash: 1:23:070403:s022018@student.dtu.dk::5F07v5MCDPU0qTjP:000000000000000000000000000000000000000M989
X-Hashcash: 1:23:070403:merlyn@stonehenge.com::1fUuMzBSBKiIfEbF:0000000000000000000000000000000000000000Vlo3
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.0 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43630>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Randal> git-rev-list --objects HEAD | sort | perl -lne '
Randal>   substr($_, 40) = "";
Randal>   if (defined $p) {
Randal>     ($p ^ $_) =~ /^(\0*)/;
Randal>     $common = length $1;
Randal>     if (defined $pcommon) {
Randal>       $count[$pcommon > $common ? $pcommon : $common]++;
Randal>     } else {
Randal>       $count[$common]++; # first item
Randal>     }
Randal>   }
Randal>   $p = $_;
Randal>   $pcommon = $common;
Randal>   END {
Randal>     $count[$common]++; # last item
Randal>     print "$_: $count[$_]" for 0..$#count;
Randal>   }
Randal> '

With that version the kernel gives:

0: 
1: 
2: 
3: 565
4: 288450
5: 139080
6: 10699
7: 700
8: 32
9: 2

Adding in  $_ = unpack("B*",pack("H*",$_));
to the script, to do the work on bits, gives:

14: 
15: 565
16: 14723
17: 66765
18: 107838
19: 99124
20: 67367
21: 39238
22: 21503
23: 10972
24: 5591
25: 2927
26: 1472
27: 709
28: 382
29: 166
30: 98
31: 54
32: 20
33: 6
34: 2
35: 4
36: 
37: 2

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
