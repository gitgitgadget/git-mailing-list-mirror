From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] config: Add --quoted option to produce machine-parsable output
Date: Mon, 21 May 2007 11:03:36 -0700
Message-ID: <7vejladpfr.fsf@assigned-by-dhcp.cox.net>
References: <20070520225953.GK4085@planck.djpig.de>
	<11797696193384-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon May 21 20:04:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqCF7-0001k5-A3
	for gcvg-git@gmane.org; Mon, 21 May 2007 20:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756493AbXEUSDi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 14:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760825AbXEUSDi
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 14:03:38 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:44809 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756493AbXEUSDh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 14:03:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070521180336.FMRT19731.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 21 May 2007 14:03:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1u3c1X0081kojtg0000000; Mon, 21 May 2007 14:03:36 -0400
In-Reply-To: <11797696193384-git-send-email-frank@lichtenheld.de> (Frank
	Lichtenheld's message of "Mon, 21 May 2007 19:46:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48033>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> This option will enclose key names in quotes (") if they
> contain a subsection and then escape " and \. It will also
> escape line breaks in values. Together this should produce
> an easily parsable output.
>
> Affects --list and --get-*
>
> Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
> ---
>  builtin-config.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 files changed, 83 insertions(+), 9 deletions(-)
>
>  Will add asciidoc documentation and test cases if people think that this is
>  a good idea.
>
>  I'm writing C about once a year, so I really don't mind being told if it's
>  crap ;)

We probably would want to make this compatible with the quoting
rules various fo "host" language have.  quote.c has host
language support to implement {perl,python,tcl}_quote_print()
for single string values or keys, so we should extend that idea.

In your application, what you are trying to do is to show a
"hash" (key => value) in a notation that is friendly to the host
language.

Git.pm could simply do:

	my $eval = `git config --perl --get-regexp 'gitcvs\..*'`;
	my $cfg = eval "$eval";

if you code your "perl" notation to produce:

	+{
		'gitcvs.ext.enabled' => 'false',
                'gitcvs.logfile' => '/var/log/gitcvs.log',
	}

in order to read things in.

Hmm?
