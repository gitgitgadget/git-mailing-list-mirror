From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: CRLF problems with Git on Win32
Date: Wed, 9 Jan 2008 22:05:04 +0300
Message-ID: <20080109190504.GF23659@dpotapov.dyndns.org>
References: <20080109150310.GC23659@dpotapov.dyndns.org> <C3AAB6C3.10C6B%jefferis@gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Jan 09 20:27:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCgZm-0004gE-BG
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 20:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbYAIT0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 14:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752234AbYAIT0Y
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 14:26:24 -0500
Received: from smtp03.mtu.ru ([62.5.255.50]:56501 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026AbYAIT0X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 14:26:23 -0500
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id 2701E1870A23;
	Wed,  9 Jan 2008 22:26:22 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-188-167.pppoe.mtu-net.ru [85.141.188.167])
	by smtp03.mtu.ru (Postfix) with ESMTP id 2D2871870A98;
	Wed,  9 Jan 2008 22:26:19 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JCgEa-0000c5-BG; Wed, 09 Jan 2008 22:05:04 +0300
Content-Disposition: inline
In-Reply-To: <C3AAB6C3.10C6B%jefferis@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70005>

Hi Gregory,

On Wed, Jan 09, 2008 at 05:37:07PM +0000, Gregory Jefferis wrote:
> 
> If LF text files checked in on Windows get turned into CRLF files on
> checkout by default then I think plenty of people would be surprised and
> probably unhappy.

LF text cannot be checked in with autocrlf=safe without marking that there
is no CRLF conversation for this file. So, what you describe is impossible.
IOW, you *always* get back what you put in the repository.

> Similarly I think it would be a bad thing if a binary
> file that looked like LF only text got mangled on checkout by LF->CRLF
> conversion - although I agree that it would be possible to recover from this
> situation with a bit of juggling.

Again, you can't do that with autocrlf=safe. Yes, it is possible that
someone else on Unix to put a file like this, but it is a rare event and
easy to recover. So, it is a very small price to pay for cross-platform
projects, and those who use the same platform are not affected at all!

> The only way to prevent collateral damage is to
> consult .gitattributes on checkout (as Dmitry seemed to be assuming above)

Yes, I assumed this. Isn't it how it is implemented now?

static int crlf_to_worktree(const char *path, const char *src, size_t len,
                            struct strbuf *buf, int action)
{
	char *to_free = NULL;
	struct text_stat stats;

	if ((action == CRLF_BINARY) || (action == CRLF_INPUT) ||
	    auto_crlf <= 0)
		return 0;

If crlf=false for some file then action will be CRLF_BINARY, and
crlf_to_worktree will not convert LF to CRLF. Did I miss somthing?

Dmitry
