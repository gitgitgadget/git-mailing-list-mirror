From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: CRLF problems with Git on Win32
Date: Wed, 9 Jan 2008 18:03:10 +0300
Message-ID: <20080109150310.GC23659@dpotapov.dyndns.org>
References: <04EF2652-9AA8-4976-903F-DBE4E7AA13D7@zib.de> <C3AA823B.10C50%jefferis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Gregory Jefferis <jefferis@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 16:03:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCcTC-0000TQ-Mb
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 16:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbYAIPDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 10:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbYAIPDT
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 10:03:19 -0500
Received: from smtp03.mtu.ru ([62.5.255.50]:53182 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbYAIPDS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 10:03:18 -0500
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id 47DBE187269A;
	Wed,  9 Jan 2008 18:03:12 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-188-167.pppoe.mtu-net.ru [85.141.188.167])
	by smtp03.mtu.ru (Postfix) with ESMTP id 142E418726C7;
	Wed,  9 Jan 2008 18:03:11 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JCcSV-0000Bk-0C; Wed, 09 Jan 2008 18:03:11 +0300
Content-Disposition: inline
In-Reply-To: <C3AA823B.10C50%jefferis@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69996>

On Wed, Jan 09, 2008 at 01:52:59PM +0000, Gregory Jefferis wrote:
> 
> crlf=safe [i.e. munging CRLFs only if there are no bare LFs] sounds
> appealing to me as well because it looks like munging that is always
> reversible.  However there could still be problems at checkout.  To be
> really safe, it seems to me that it must be 1) reversible in practice and 2)
> ALWAYS reversed unless we explicitly ask for no gnuming at checkout.  Why?
> 
> Re point (1) to be reversible in practice, we need to know who we've munged.
> Otherwise when gnuming blindly at checkout we might damage some innocent
> bystander file that only ever had LFs in the first place.

If you work on Windows and you have clrf=safe, you cannot put a text
file that has only LFs, because naked LF is not allowed. If you want
to have naked LF in some file, you have to say that explicitly in
.gitattributes.

If you work on cross platform project, and somebody else put a file with
bare LFs, which is not text though heauristic wrongly detected it as
text then you can remove this file from your working directory, correct
.gitattributes and checkout this file again. The idea of crlf=safe is
that information is never lost. It is always fully reversible, and if
you put something into the repostory, you always get back exactly the
same unless you changed your .gitattributes.

> Re (2) well if we happen to munge a file on checkin that is actually binary,
> it must be gnumed on the way out otherwise it will be broken for the user.

Of course, it will, because the same heuristic will detect it as text,
and convert it back. So as long as you stay on the same platform and
with the same .gitattributes, you always get back exactly what you
put.

Dmitry
