From: Junio C Hamano <gitster@pobox.com>
Subject: Re: diffutils: C labels misdetected as functions
Date: Sun, 22 Jul 2007 14:30:00 -0700
Message-ID: <7vtzrwqg87.fsf@assigned-by-dhcp.cox.net>
References: <1184489571313-git-send-email-crquan@gmail.com>
	<4699EEA9.6070709@simon.arlott.org.uk>
	<20070720170743.GF14791@parisc-linux.org>
	<46A0F282.8070103@simon.arlott.org.uk>
	<20070720180019.GJ14791@parisc-linux.org>
	<46A1A375.3020900@simon.arlott.org.uk>
	<20070721135200.GQ14791@parisc-linux.org>
	<46A25BE0.7000104@simon.arlott.org.uk>
	<87abtogu6u.fsf@penguin.cs.ucla.edu>
	<46A3AD07.1070504@simon.arlott.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Eggert <eggert@CS.UCLA.EDU>, Matthew Wilcox <matthew@wil.cx>,
	Denis Cheng <crquan@gmail.com>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
To: Simon Arlott <simon@fire.lp0.eu>
X-From: git-owner@vger.kernel.org Sun Jul 22 23:30:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICj0H-0007lE-Ul
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 23:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755392AbXGVVaJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 17:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764305AbXGVVaI
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 17:30:08 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:64569 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762466AbXGVVaE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 17:30:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070722213004.NCTW1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 22 Jul 2007 17:30:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SlW01X00R1kojtg0000000; Sun, 22 Jul 2007 17:30:03 -0400
In-Reply-To: <46A3AD07.1070504@simon.arlott.org.uk> (Simon Arlott's message of
	"Sun, 22 Jul 2007 20:16:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53323>

Simon Arlott <simon@fire.lp0.eu> writes:

> On 22/07/07 19:38, Paul Eggert wrote:
>> 
>> Anyway, to work around your problem without changing "diff", you can
>> use "diff -u -F '^[[:alpha:]$_](|.*[^:])$'" instead of "diff -u -p".
>
> Perhaps git could do this (or similar) as a workaround? (Cc:ed)
>
>> Or you can put a single space before the labels in question: they'll
>> still stand out plenty.
>
> The code should definitely not need to be modified to work around a
> diff bug.

I think the word "bug" is just about documentation.  Promising
"show C function" and including labels and/or not showing all
functions would be a bug, but given that diff is about showing
textual differences between two text files with arbitrary kind
of contents, I do not think it is reasonable to take that "show
C function" promise too literally.

To avoid this, the description of the feature could be reworded
to "shows lines that match pattern '^[[:alpha:]$_]' on context
lines, intent of the option being that the pattern tends to
match the beginning of function in C language and help the
reader to locate the context more easily, with a caveat that the
pattern matching is not meant to capture all functions nor only
functions --- there will be false matches."

But that would be too long.  And as Paul showed, you can narrow
or widen the set of lines that are shown with the -F option.  I
do not think this deserves to be called a "bug".

You can define your own customized "function name" pattern in
your .git/config (or $HOME/.gitconfig) file to be used by the
git-diff family with recent enough git via the attributes
mechanism, but I do not think we should change the default,
unless GNU diff changes its default.  Personally I'd rather not
see it change, though.
