From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Re: git-mailinfo '-u' argument should be default.
Date: Tue, 09 Jan 2007 10:46:00 -0800
Message-ID: <7vzm8skphz.fsf@assigned-by-dhcp.cox.net>
References: <1147452362.2794.452.camel@pmac.infradead.org>
	<1168351405.14763.347.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 19:46:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Lz5-0001DT-Jk
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 19:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbXAISqE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 13:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbXAISqE
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 13:46:04 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:56336 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932354AbXAISqC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 13:46:02 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109184601.YJPL25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jan 2007 13:46:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 96lA1W0181kojtg0000000; Tue, 09 Jan 2007 13:45:11 -0500
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1168351405.14763.347.camel@shinybook.infradead.org> (David
	Woodhouse's message of "Tue, 09 Jan 2007 22:03:25 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36384>

David Woodhouse <dwmw2@infradead.org> writes:

> On Fri, 2006-05-12 at 17:46 +0100, David Woodhouse wrote:
>>  ...
> This patch:
>  1. Fixes the default not to throw away the MIME information.
>  2. Adds a '-n' option with the old behaviour, although I can't
>     actually imagine why someone might find that desirable.
>  3. Aborts if the conversion fails, allowing the user to fix it 
>     rather than silently corrupting the input. There's always the
>     new '-n' option if the user _really_ wants it corrupted. :)

Thanks.

Documentation/SubmittingPatches, and Sign-off?

I do not think you would want to make '-n' in the third point
sound so negative and make people on projects that chose to use
legacy encoding for whatever reasons feel _dirty_.  If the
natural language in project's log is limited and a legacy
encoding is sufficient, and if all the participants agree on a
legacy encoding to use because tools other than git they need to
use are more convenient with the legacy encoding rather than
UTF-8, there is no need to give a lecture to them saying they
should switch to UTF-8 and/or what they have been doing is
sub-par -- it isn't.

If the command allows straight-through (and I think it should)
but now defaults to UTF-8, you also need to update the existing
Porcelain-level tools (i.e. callers of mailinfo) so that they
pass -n when the end-user says "I want straight-through"; asking
for UTF-8 can be done by either not passing anything or
explicitly passing -u, but the point is that the callers need to
be changed anyway.  And at that point, the default of mailinfo
does not matter that much -- although it is good for consistency
to make it also default to UTF-8.

I've updated git-am yesterday to default to --utf8 (which is
overridable with --no-utf8) but did not touch mailinfo during
that process; it further needs to be told about the -n option.
I haven't touched git-applymbox yet but it should also be taught
about the new default and the override.
