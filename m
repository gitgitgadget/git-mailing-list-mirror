From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH 10/12] MINGW: config.mak.uname: drop USE_NED_ALLOCATOR
Date: Tue, 29 Apr 2014 11:48:14 +0400
Message-ID: <20140429074814.GA23421@seldon>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-11-git-send-email-marat@slonopotamus.org>
 <CABPQNSZD5jz1A8=zQvU4dYvNb-5M+TV50Uj+oVbWJs3YWBytHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 09:48:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf2mC-0006Rh-Hj
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 09:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755831AbaD2HsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 03:48:20 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:56058 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755760AbaD2HsS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 03:48:18 -0400
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Wf2ly-00067N-QO; Tue, 29 Apr 2014 11:48:14 +0400
Content-Disposition: inline
In-Reply-To: <CABPQNSZD5jz1A8=zQvU4dYvNb-5M+TV50Uj+oVbWJs3YWBytHw@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247527>

On Mon, Apr 28, 2014 at 05:23:25PM +0200, Erik Faye-Lund wrote:
> On Mon, Apr 28, 2014 at 3:51 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> > nedalloc was initially added in f0ed82 to fix slowness of standard WinXP
> > memory allocator. Since WinXP is EOLed, this point is no longer valid.
> >
> > The actual reason behind this commit is incompatibility of malloc.c.h
> > with MinGW-W64 headers. Alternative solution implies updating nedalloc
> > to something newer.
> 
> Did you measure that malloc on newer Windows-versions are actually
> faster? AFAIK, malloc does a lot more inside the CRT than in the
> kernel...

Windows 8, msysGit.

git repack -adf on msysgit/git (best of 3 runs)

+ nedalloc: 10.5s
- nedalloc: 11s

git repack -adf on torvalds/linux (best of 3 runs)

+ nedalloc: 3m 24s
- nedalloc: 3m 47s

We need to make a decision: drop nedalloc, update nedalloc to later release,
patch nedalloc to make it work under MinGW-W64 or disable nedalloc under
MinGW-W64 (still leaving it enabled under MinGW).

P.S. Waiting for "Resolving deltas" when cloning torvalds/linux is a pain,
perhaps someone should run gprof on it.
