From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] perf: Fix endianness argument compatibility
Date: Wed, 14 Apr 2010 05:52:52 -0400
Message-ID: <20100414095252.GA17884@coredump.intra.peff.net>
References: <1271147857-11604-1-git-send-email-imunsie@au.ibm.com>
 <20100413.014821.34906166.davem@davemloft.net>
 <20100414092843.GD10537@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Miller <davem@davemloft.net>, git@vger.kernel.org,
	imunsie@au1.ibm.com, linux-kernel@vger.kernel.org,
	a.p.zijlstra@chello.nl, paulus@samba.org, acme@redhat.com,
	kosaki.motohiro@jp.fujitsu.com, mitake@dcl.info.waseda.ac.jp,
	rusty@rustcorp.com.au, fweisbec@gmail.com, ebmunson@us.ibm.com,
	Valdis.Kletnieks@vt.edu, amwang@redhat.com, tfransosi@gmail.com,
	mhiramat@redhat.com, xiaoguangrong@cn.fujitsu.com,
	jaswinderrajput@gmail.com, arjan@linux.intel.com,
	hirofumi@mail.parknet.co.jp, efault@gmx.de, tzanussi@gmail.com,
	anton@samba.org, jkacur@redhat.com, lizf@cn.fujitsu.com,
	rostedt@goodmis.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Apr 14 11:53:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1zHj-0004SR-Gh
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 11:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873Ab0DNJxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 05:53:22 -0400
Received: from peff.net ([208.65.91.99]:33866 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754869Ab0DNJxV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 05:53:21 -0400
Received: (qmail 23723 invoked by uid 107); 14 Apr 2010 09:53:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Apr 2010 05:53:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Apr 2010 05:52:52 -0400
Content-Disposition: inline
In-Reply-To: <20100414092843.GD10537@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144863>

On Wed, Apr 14, 2010 at 11:28:43AM +0200, Ingo Molnar wrote:

> > > Parsing an option from the command line with OPT_BOOLEAN on a bool data
> > > type would not work on a big-endian machine due to the manner in which
> > > the boolean was being cast into an int and incremented. For example,
> > > running 'perf probe --list' on a PowerPC machine would fail to properly
> > > set the list_events bool and would therefore print out the usage
> > > information and terminate.
> [...]
>
> Nice fix!
> 
> Btw., perf got the option parser from the Git project - i'm wondering how the 
> Git folks solved this endianness problem?

We didn't. We pass only actual ints for the value field in all cases. We
don't use C99 bools at all. We do use bit-fields, but the compiler
catches the error, since OPT_BOOLEAN tries to take its address.

-Peff
