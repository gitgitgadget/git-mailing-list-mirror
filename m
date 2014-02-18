From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/5] notes-utils: handle boolean notes.rewritemode correctly
Date: Tue, 18 Feb 2014 09:41:51 +0100
Message-ID: <87vbwcstgw.fsf@fencepost.gnu.org>
References: <cover.1392565571.git.john@keeping.me.uk>
	<be9b384ec77fc39b939b8c5505862a6e1c641faa.1392565571.git.john@keeping.me.uk>
	<87txbzvxgq.fsf@fencepost.gnu.org>
	<20140218074632.GA29804@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 18 09:42:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFgFo-0001cU-OI
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 09:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474AbaBRImI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 03:42:08 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:59884 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754417AbaBRImG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 03:42:06 -0500
Received: from localhost ([127.0.0.1]:58924 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WFgFh-00067b-EV; Tue, 18 Feb 2014 03:42:05 -0500
Received: by lola (Postfix, from userid 1000)
	id 0A7CEE0487; Tue, 18 Feb 2014 09:41:51 +0100 (CET)
In-Reply-To: <20140218074632.GA29804@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 18 Feb 2014 02:46:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242282>

Jeff King <peff@peff.net> writes:

> On Sun, Feb 16, 2014 at 05:22:45PM +0100, David Kastrup wrote:
>> 
>> config.c:#undef config_error_nonbool
>> config.c:int config_error_nonbool(const char *var)
>
> You could always look in the commit history:
>
>   $ git log -S'#define config_error_nonbool' cache.h
>
> or search the mailing list:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/211505
>
>> Presumably this was done so that the uses of config_error_nonbool can be
>> recognized as returning -1 unconditionally.
>
> Yes, it helps prevent false positives in gcc's flow analysis
> (specifically, -Wuninitialized warnings).
>
>> But is that worth the obfuscation?
>
> Yes?

gcc's flow analysis works with the same data as humans reading the
code.  If there is no information content in the function call, it makes
more sense to either making it void.

One can always explicitly write

  (config_error_nonbool("panic-when-assailed"), -1)

for shortcircuit use inside of an expression even when
config_error_nonbool is a function returning a void expression: comma
operators do not try type coercion on their first argument.

Shrug.  This one has likely been discussed to death already.  Sometimes
it's more convenient to avoid getting a question asked in the first
place rather than having a stock answer for it.

-- 
David Kastrup
