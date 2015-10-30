From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/6] Facilitate debugging Git executables in tests with
 gdb
Date: Fri, 30 Oct 2015 19:31:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510301929020.31610@s15462909.onlinehome-server.info>
References: <cover.1445865176.git.johannes.schindelin@gmx.de> <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de> <20151026191724.GE7881@google.com> <alpine.DEB.1.00.1510271036100.31610@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:31:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsESQ-0001Af-3W
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 19:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760519AbbJ3SbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 14:31:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:49406 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760516AbbJ3SbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 14:31:16 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MLA45-1ZrxL92iMD-000ICq;
 Fri, 30 Oct 2015 19:31:14 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <alpine.DEB.1.00.1510271036100.31610@s15462909.onlinehome-server.info>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:g7hzancTYzzElm9Lo0YN0ke7iFsiVtksjd2my4bUZzSa2Q8zgf2
 HbMa0ULxRWQ6g0lI+XMrybnpRxDy2MYr0524zKP98dzCGPrIYd1x0XSMJZt9VCBrIZCNrpE
 hMP3RrGOuQTF69QFAK1d8OLZJ8g6NRrCHavs3BWGI2ok6GpcNt/LTEZkpBoL8y6AXMhKqsR
 d/DKxJPf3p8trQPbB+ejg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r2K0FDc/vi4=:3CAilbE0RXKQh1Oq/GdcH3
 dzQkkkwY4azFH5sj3a5qoHIz4c32SCkrPbID+9DdsQbw1pQhwkfxYr4rD9raUrVh/60GohYhE
 qY5824rYfe6ArbidjIRaij+fKpwlG0W08D7Z2LhJfV4YZ+LYTBS3EE6lNgay1spZa++sR2LdB
 ilds1ebJ0VOiYgar/Qxwhss6knavN0pOUeiCiobSPFHXgqKMwyhv+ldmQ86KWW5LZ890W49tt
 PHxLbrI6UsMhYFKmp11q1R5FNtz4btxY0znKgknqpjxXvCH0GPS4Tn+EPqmu62t2Ep3R6IFKS
 8KQ+MZDuP8CVExU9iLK/IxCFA3/TEa5rWutwXNC3gik3dHWrZ0jsD0Vw5neTxfjrjPzhURoMW
 bp1nXlTOpE6jyoh2l0X6LVFTfnEi5taUC42Iuig+8UCnU5tMmNtv8bCuwsazqG86zfKIWd42M
 9LPI6HzfuKd/bPml+0So/z5bT48VN47gt2qsRgwtdP7N8rURIFLSkKcQNBlq0U24dgNpmItNA
 ducEixnIUzpC2FI5AOnZRL1H9cpsNeQ0pOTlEgv760HNY2kA7qfyyOYwrfKU5//O+p6G+5PTT
 /oIJFjlDuy+7EbgN7WrJ4nupsFb3P5kM9T7puxCkm3IoMYXlvg3T51AzRlxbmpkZd1W4X00Ts
 AtZfYrYbGW2fMvrrxdvhFU8/kHXcXDwQhSQKCtoKSYZfQxy01wgxpc6oisDF5rS0xrIJcHUUH
 AUkCIGGVxtBB/hC4Ln9W3MrYjMFpmTJMP0vO8xeyQ0r9bDEN5SH2/tsiKOV54q73TAvUkI8s 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280513>

Hi Jonathan,

On Tue, 27 Oct 2015, Johannes Schindelin wrote:

> On Mon, 26 Oct 2015, Jonathan Nieder wrote:
> 
> > Does the 'exec' after the fi need this as well?  exec is supposed to
> > itself print a message and exit when it runs into an error.  Would
> > including an 'else' with the if make the control flow clearer?  E.g.
> > 
> > 	if test -n "$TEST_GDB_GIT"
> > 	then
> > 		exec gdb --args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> > 	else
> > 		exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> > 	fi
> 
> I suppose you're right! The `exec` can fail easily, e.g. when `gdb` was
> not found.

Actually, after reading the patch again, I think it is better to be less
intrusive and add the error message *just* for the gdb case, as it is
right now:

-- snipsnap --
 export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
 
+if test -n "$TEST_GDB_GIT"
+then
+       exec gdb -args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
+       echo "Could not run gdb -args ${GIT_EXEC_PATH}/@@PROG@@ $*" >&2
+       exit 1
+fi
+
 exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
