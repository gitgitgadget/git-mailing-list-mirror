From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] perf: Fix endianness argument compatibility
Date: Wed, 14 Apr 2010 11:28:43 +0200
Message-ID: <20100414092843.GD10537@elte.hu>
References: <1271147857-11604-1-git-send-email-imunsie@au.ibm.com>
 <20100413.014821.34906166.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: imunsie@au1.ibm.com, linux-kernel@vger.kernel.org,
	a.p.zijlstra@chello.nl, paulus@samba.org, acme@redhat.com,
	kosaki.motohiro@jp.fujitsu.com, mitake@dcl.info.waseda.ac.jp,
	rusty@rustcorp.com.au, fweisbec@gmail.com, ebmunson@us.ibm.com,
	Valdis.Kletnieks@vt.edu, amwang@redhat.com, tfransosi@gmail.com,
	mhiramat@redhat.com, xiaoguangrong@cn.fujitsu.com,
	jaswinderrajput@gmail.com, arjan@linux.intel.com,
	hirofumi@mail.parknet.co.jp, efault@gmx.de, tzanussi@gmail.com,
	anton@samba.org, jkacur@redhat.com, lizf@cn.fujitsu.com,
	rostedt@goodmis.org
To: David Miller <davem@davemloft.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 14 11:29:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1yux-0002NL-NC
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 11:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538Ab0DNJ3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 05:29:25 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:57146 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754254Ab0DNJ3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 05:29:24 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1O1ytv-0003py-AS
	from <mingo@elte.hu>; Wed, 14 Apr 2010 11:28:55 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id CDA013E231F; Wed, 14 Apr 2010 11:28:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100413.014821.34906166.davem@davemloft.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.5
	-2.0 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144858>


* David Miller <davem@davemloft.net> wrote:

> From: "Ian Munsie" <imunsie@au1.ibm.com>
> Date: Tue, 13 Apr 2010 18:37:33 +1000
> 
> > From: Ian Munsie <imunsie@au.ibm.com>
> > 
> > Parsing an option from the command line with OPT_BOOLEAN on a bool data
> > type would not work on a big-endian machine due to the manner in which
> > the boolean was being cast into an int and incremented. For example,
> > running 'perf probe --list' on a PowerPC machine would fail to properly
> > set the list_events bool and would therefore print out the usage
> > information and terminate.
> > 
> > This patch makes OPT_BOOLEAN work as expected with a bool datatype. For
> > cases where the original OPT_BOOLEAN was intentionally being used to
> > increment an int each time it was passed in on the command line, this
> > patch introduces OPT_INCR with the old behaviour of OPT_BOOLEAN (the
> > verbose variable is currently the only such example of this).
> > 
> > I have reviewed every use of OPT_BOOLEAN to verify that a true C99 bool
> > was passed. Where integers were used, I verified that they were only
> > being used for boolean logic and changed them to bools to ensure that
> > they would not be mistakenly used as ints. The major exception was the
> > verbose variable which now uses OPT_INCR instead of OPT_BOOLEAN.
> > 
> > Signed-off-by: Ian Munsie <imunsie@au.ibm.com>
> 
> Thanks for finding and fixing this bug.

Nice fix!

Btw., perf got the option parser from the Git project - i'm wondering how the 
Git folks solved this endianness problem?

	Ingo
