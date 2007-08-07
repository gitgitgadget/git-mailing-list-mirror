From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Tue, 07 Aug 2007 15:28:05 -0700
Message-ID: <7vejif56a2.fsf@assigned-by-dhcp.cox.net>
References: <f99cem$4a4$1@sea.gmane.org>
	<Pine.LNX.4.64.0708071257350.14781@racer.site>
	<f99nm6$9vi$1@sea.gmane.org> <f99rei$ou$1@sea.gmane.org>
	<20070807143616.GO9527@spearce.org> <20070807145825.GO21692@lavos.net>
	<66DD7425-6073-4CA8-BF01-BF07213A4804@zib.de>
	<30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com>
	<07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de>
	<alpine.LFD.0.999.0708071439021.5037@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 08 00:28:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIXXI-0008J8-L3
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 00:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758707AbXHGW2J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 18:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752885AbXHGW2I
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 18:28:08 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:42550 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091AbXHGW2H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 18:28:07 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070807222807.IBGN1335.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 7 Aug 2007 18:28:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ZAU51X00R1kojtg0000000; Tue, 07 Aug 2007 18:28:06 -0400
In-Reply-To: <alpine.LFD.0.999.0708071439021.5037@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 7 Aug 2007 14:44:21 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55278>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 7 Aug 2007, Steffen Prohaska wrote:
>>
>> Is there any chance that patches would be accepted that try to
>> do so? Even if they add "b" to fopen and O_BINARY to open, which
>> both are useless on Unix?
>
> I certainly don't think it would be wrong to add O_BINARY to the open() 
> parameters (and "b" to fopen() and friends), if it makes a difference.
>
> Add a
>
> 	#ifndef O_BINARY
> 	#define O_BINARY 0
> 	#endif
>
> and it should be harmless anywhere else.

Heh, you beat me to this ---  I like it.

> @@ -2023,6 +2027,12 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
> ...
> +static void close_or_die(int fd, const char *file)
> +{
> +	if (close(fd))
> +		die("unable to close %s (%s)", file, strerror(errno));
> +}
> +

And I like this even better ;-).
