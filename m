From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fail if tag name and keywords is not within "printable ASCII"
Date: Sat, 09 Jun 2007 18:33:50 -0700
Message-ID: <7vwsycbnk1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
	<81b0412b0706091452q2957540dy95fbf13ebd89ca1f@mail.gmail.com>
	<7vfy50d67q.fsf@assigned-by-dhcp.cox.net>
	<200706100235.24358.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 03:33:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxCJX-00043M-Oq
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 03:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036AbXFJBdx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 21:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752921AbXFJBdx
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 21:33:53 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:45028 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbXFJBdw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 21:33:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070610013353.VLGE12207.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 9 Jun 2007 21:33:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9dZq1X0041kojtg0000000; Sat, 09 Jun 2007 21:33:51 -0400
In-Reply-To: <200706100235.24358.johan@herland.net> (Johan Herland's message
	of "Sun, 10 Jun 2007 02:35:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49650>

Johan Herland <johan@herland.net> writes:

> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>
> On Sunday 10 June 2007, Junio C Hamano wrote:
>> "Alex Riesen" <raa.lkml@gmail.com> writes:
>> > And what is so special about 0x7f?
>> 
>> It is DEL, but as the code uses uchar, it probably also error on
>> 0x80 or higher, if the intent is "printable ASCII".
>
> Is this better?

I said "*if* the intent is to limit to printable ASCII".

It is still unclear what use cases the "keywords" need to
support (e.g. do we want to have "pick tags that have keyword
that matches this pattern"?  if so, what kind of pattern
language do we want to use?  Glob?  Regexp?  Would it be more
convenient if the keywords are treated case insensitively?  Is
there a useful use case if you are allowed to use people's names
as keywords?  Is it reasonable to assume that the keywords can
be split with a comma?  Do we want to allow a comma as part of
keywords?  If so, how would we quote a comma that is inside a
keyword?  etc.).  It depends on the answers to these questions
if "printable ASCII" is a good set.

As a general rule, if you make the initially allowed set of
values too wide, it gets _extremely_ hard to tighten it later.
So if we are to stick to printable ASCII (iow, "no people's
names or names of location as keywords"), I would even suggest
to limit the valid set further, say "^[-A-Za-z0-9_+.]+$", at
least initially.
