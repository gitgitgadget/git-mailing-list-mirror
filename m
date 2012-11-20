From: Timur Tabi <timur@freescale.com>
Subject: git-fetch does not work from .git subdirectory
Date: Tue, 20 Nov 2012 16:24:22 -0600
Organization: Freescale
Message-ID: <50AC0316.7090002@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 20 23:24:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TawFE-0007Oe-Gq
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 23:24:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700Ab2KTWY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 17:24:27 -0500
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:14974
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752271Ab2KTWY0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Nov 2012 17:24:26 -0500
Received: from mail125-co1-R.bigfish.com (10.243.78.233) by
 CO1EHSOBE001.bigfish.com (10.243.66.64) with Microsoft SMTP Server id
 14.1.225.23; Tue, 20 Nov 2012 22:24:25 +0000
Received: from mail125-co1 (localhost [127.0.0.1])	by
 mail125-co1-R.bigfish.com (Postfix) with ESMTP id 69EE9540175	for
 <git@vger.kernel.org>; Tue, 20 Nov 2012 22:24:25 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:70.37.183.190;KIP:(null);UIP:(null);IPV:NLI;H:mail.freescale.net;RD:none;EFVD:NLI
X-SpamScore: 4
X-BigFish: VS4(z37d4lzzz1de0h1202h1d1ah1d2ahzz8275bhz2dh2a8h668h839hd25he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h1504h1537h153bh162dh1631h1155h)
Received: from mail125-co1 (localhost.localdomain [127.0.0.1]) by mail125-co1
 (MessageSwitch) id 1353450264510665_29562; Tue, 20 Nov 2012 22:24:24 +0000
 (UTC)
Received: from CO1EHSMHS030.bigfish.com (unknown [10.243.78.231])	by
 mail125-co1.bigfish.com (Postfix) with ESMTP id 7AD68A80072	for
 <git@vger.kernel.org>; Tue, 20 Nov 2012 22:24:24 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by CO1EHSMHS030.bigfish.com
 (10.243.66.40) with Microsoft SMTP Server (TLS) id 14.1.225.23; Tue, 20 Nov
 2012 22:24:24 +0000
Received: from tx30smr01.am.freescale.net (10.81.153.31) by
 039-SN1MMR1-002.039d.mgd.msft.net (10.84.1.15) with Microsoft SMTP Server
 (TLS) id 14.2.318.3; Tue, 20 Nov 2012 22:24:23 +0000
Received: from [10.82.123.3] (efes.am.freescale.net [10.82.123.3])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id qAKMOMQw027881	for
 <git@vger.kernel.org>; Tue, 20 Nov 2012 15:24:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Firefox/16.0 SeaMonkey/2.13.1
X-OriginatorOrg: freescale.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210118>

I was under the impression that git commands which affect repository (as
opposed to the local file system) work from any subdirectory inside the
repository.  For example:

[b04825@efes linux.cq-test]$ git log -1
commit f35d179fde24be5e1675b1df9f7a49b8d95561b2
Author: Timur Tabi <timur@freescale.com>
Date:   Wed Oct 31 15:56:20 2012 +0200
...
[b04825@efes linux.cq-test]$ cd .git
[b04825@efes .git]$ git log -1
commit f35d179fde24be5e1675b1df9f7a49b8d95561b2
Author: Timur Tabi <timur@freescale.com>
Date:   Wed Oct 31 15:56:20 2012 +0200
...

It appears, however, that git-fetch does not work this way:

[b04825@efes linux.cq-test]$ git fetch upstream master
From ../linux-2.6
 * branch            master     -> FETCH_HEAD
[b04825@efes linux.cq-test]$ cd .git
[b04825@efes .git]$ git fetch upstream master
fatal: '../linux-2.6.git' does not appear to be a git repository
fatal: The remote end hung up unexpectedly

This makes it complicated because git hooks run from the .git directory on
normal repositories, but they run from the top-level directory on bare
repositories.  Apparently, you need to be in the top-level directory for
git-fetch to run in any kind of repository.

-- 
Timur Tabi
Linux kernel developer at Freescale
