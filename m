From: Charles Bailey <cbailey32@bloomberg.net>
Subject: Re: [PATCH] t4212: handle systems with post-apocalyptic gmtime
Date: Wed, 26 Mar 2014 21:22:27 +0000
Message-ID: <20140326212227.GC6991@hashpling.org>
References: <20140224073348.GA20221@sigill.intra.peff.net>
 <20140224074905.GE9969@sigill.intra.peff.net>
 <20140326110559.GA32625@hashpling.org>
 <20140326182103.GB7087@sigill.intra.peff.net>
 <20140326185153.GA12912@sigill.intra.peff.net>
 <xmqqr45oixa6.fsf@gitster.dls.corp.google.com>
 <20140326192536.GA13989@sigill.intra.peff.net>
 <20140326193359.GA14105@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 26 22:22:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSvHP-0006hM-SQ
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 22:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756491AbaCZVWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 17:22:31 -0400
Received: from avasout05.plus.net ([84.93.230.250]:47838 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756484AbaCZVWa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 17:22:30 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id iMNT1n0062iA9hg01MNUR9; Wed, 26 Mar 2014 21:22:29 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=SYp5d5hu c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=zd_RDMET5nsA:10 a=ZWHkJ8qrxXAA:10 a=N2sEI2mohSIA:10
 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10 a=BNFp--SqAAAA:8 a=Ew9TdX-QAAAA:8
 a=A1X0JdhQAAAA:8 a=ZvMF11V_muomHNdLbuUA:9 a=CjuIK1q_8ugA:10 a=Y6qChIQXU1wA:10
Received: from charles by hashpling.plus.com with local (Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1WSvHH-00021P-Qb; Wed, 26 Mar 2014 21:22:27 +0000
Content-Disposition: inline
In-Reply-To: <20140326193359.GA14105@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245230>

On Wed, Mar 26, 2014 at 03:33:59PM -0400, Jeff King wrote:
> 
> That being said, is the AIX value actually right? I did not look closely
> at first, but just assumed that it was vaguely right. But:
> 
>   999999999999999999 / (86400 * 365)
> 
> is something like 31 billion years in the future, not 160 million.
> A real date calculation will have a few tweaks (leap years, etc), but
> that is orders of magnitude off.

Well, this is embarrassing, while moving this through the corporate
firewall (aka typing on one machine while looking at another), I
munged the date. It still doesn't seem right but at least you can now
see the actual data.

I stopped the test with --immediate and found the dangling commit that
the test created and dumped it with the previous version of Git (well
a 1.8.5.5 build)

  ibm: trash directory.t4212-log-corrupt $ git log -1 --pretty=raw 1fc17e734e4487c31bdfe05bb3d15618b69c4dca
  commit 1fc17e734e4487c31bdfe05bb3d15618b69c4dca
  tree 64fd3796c57084e7b8cbae358ce37970b8e954f6
  author A U Thor <author@example.com> 999999999999999999 -0700
  committer C O Mitter <committer@example.com> 1112911993 -0700

      foo

  ibm: trash directory.t4212-log-corrupt $ git log -1 1fc17e734e4487c31bdfe05bb3d15618b69c4dca
  commit 1fc17e734e4487c31bdfe05bb3d15618b69c4dca
  Author: A U Thor <author@example.com>
  Date:   Thu Oct 24 18:46:39 1623969404 -0700

      foo

Same commit but dumped from a linux machine:

  linux: trash directory.t4212-log-corrupt $ git log -1 1fc17e734e4487c31bdfe05bb3d15618b69c4dca
  commit 1fc17e734e4487c31bdfe05bb3d15618b69c4dca
  Author: A U Thor <author@example.com>
  Date:   (null)

      foo

Charles.
