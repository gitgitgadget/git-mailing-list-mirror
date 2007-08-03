From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Shell script cleanups/style changes?
Date: Thu, 02 Aug 2007 17:48:26 -0700
Message-ID: <7vabt9sasl.fsf@assigned-by-dhcp.cox.net>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<7vsl71tyyq.fsf@assigned-by-dhcp.cox.net>
	<86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<20070802214103.GT29424@schiele.dyndns.org>
	<85vebxy47e.fsf@lola.goethe.zz>
	<7vwswdsfjp.fsf@assigned-by-dhcp.cox.net>
	<85ps25y1ac.fsf@lola.goethe.zz>
	<7vk5sdscfr.fsf@assigned-by-dhcp.cox.net>
	<85wswdwjll.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Schiele <rschiele@gmail.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 02:48:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGlLH-0007x6-0t
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 02:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbXHCAs2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 20:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753525AbXHCAs2
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 20:48:28 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:37642 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387AbXHCAs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 20:48:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070803004827.JTWJ26965.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 20:48:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XCoS1X00N1kojtg0000000; Thu, 02 Aug 2007 20:48:27 -0400
In-Reply-To: <85wswdwjll.fsf@lola.goethe.zz> (David Kastrup's message of "Fri,
	03 Aug 2007 02:24:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54656>

David Kastrup <dak@gnu.org> writes:

>> I happen to feel ${parameter#word} is more esoteric than $(cmd).
>> If a system does not even do the latter, then avoiding the
>> former to help such a system is a futile effort.
>
> The situation is that we currently don't avoid the former.  Robert
> said that he had prepared a patch that would do so.
> ...
> But "only a little bit of ${parameter#word}, please" seems pointless.

Absolutely.  And we started to adopt #/% substititions some time
ago.  Undoing them just feels going backwards, and we need to
judge what the merits of going backwards are.

For that discussion, /bin/sh on Solaris does not count.  There
are huge downside of rewriting scripts to work with stock
Solaris /bin/sh:

 (1) that shell does not even grok $(cmd) substitution.

     I won't accept a half-baked patch that replaces "$(" with a
     backtick and matching ")" with another backtick.  You need
     to at least make sure your interpolated variables within
     the backtick pair work sensibly, and you haven't broken
     existing nesting of command interpolations, if any.  I do
     not even want to inspect, comment on and reject that kind
     of changes.  Quite frankly, it's not worth my time.

 (2) Rewriting $(cmd) to `cmd`, and ${parameter#word} with sed
     or expr would reduce readability, at least to other people.

     Remember, I was the one who originally avoided modern
     ${parameter#word} substitutions, and older scripts had many
     more invocations of expr than we currently have.  Reading
     such a backward rewrite would not be too much of a problem
     for *me*, but other people also need to read and understand
     scripts, if only to be able to rewrite them in C.

     There may still be many old parts of the scripts that could
     be made more readable and efficient using ${parameter#word}
     substitutions. If we were to rewrite scripts, more use of
     them could be a good thing, not the other way around.

Besides, on that platform there are more reasonable shells
available via SHELL_PATH, and it is not limited to going to
bash.
