From: Ingo Molnar <mingo@elte.hu>
Subject: Re: error: Unable to append to
	.git/logs/refs/remotes/origin/master: Permission denied
Date: Wed, 29 Apr 2009 09:32:56 +0200
Message-ID: <20090429073256.GB22129@elte.hu>
References: <20090428073138.GA9094@elte.hu> <20090429032943.GB8826@coredump.intra.peff.net> <20090429040719.GA14912@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 29 09:33:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz4IF-0004pU-R5
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 09:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738AbZD2HdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 03:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753613AbZD2HdH
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 03:33:07 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:52356 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508AbZD2HdG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 03:33:06 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1Lz4Hq-00087I-Js
	from <mingo@elte.hu>; Wed, 29 Apr 2009 09:33:05 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 735C43E2138; Wed, 29 Apr 2009 09:32:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090429040719.GA14912@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117861>


* Jeff King <peff@peff.net> wrote:

> On Tue, Apr 28, 2009 at 11:29:43PM -0400, Jeff King wrote:
> 
> > Note the repeated use of "hopefully". :) Maybe the earlier 
> > message is too hidden to rely on. We might be able to get by 
> > with checking "errno" for ENOTDIR after trying to lock the ref 
> > and using a different message, but I don't know how portable 
> > that will be.
> 
> Hmm, that actually doesn't work. errno is properly EACCESS in your 
> example, but the D/F problem doesn't actually set errno, since it 
> is git itself, and not a failed syscall, that determines that 
> "foo/bar" is not available because "foo" exists (and git must do 
> it, because "foo" may be a packed ref).
> 
> So I think we would need to simulate the errno setting, like the 
> patch below. That should generate the hint only when it would 
> actually be useful.

it wasnt hard to figure out what's going on. So this was more of a 
FYI, not really a bug report. Maybe if someone tries to pull into a 
read-only repo the same could happen? My particular breakage (of a 
single ref being root-owned - the rest was mingo owned) is atypical 
enough to be ignored.

If there's no easy/clean solution then please ignore my report.

	Ingo
