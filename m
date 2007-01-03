From: Junio C Hamano <junkio@cox.net>
Subject: Re: Possible regression in git-rev-list --header
Date: Wed, 03 Jan 2007 02:10:27 -0800
Message-ID: <7vodpgpgj0.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
	<Pine.LNX.4.63.0612301955340.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v7iw9jftv.fsf@assigned-by-dhcp.cox.net>
	<7vlkkphvrb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612310211300.25709@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v64bsj0s4.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550612310345j4c882b7av51879ca1175a1c6b@mail.gmail.com>
	<Pine.LNX.4.63.0612311613180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<e5bfff550612310743t4ca1b017ubceddffafd06ac59@mail.gmail.com>
	<7vodpja0u8.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550701030121n700fab25x63278457c884a3f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 03 11:10:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2350-0001k0-5E
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 11:10:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbXACKK3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 05:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbXACKK3
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 05:10:29 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:55839 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750700AbXACKK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 05:10:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070103101028.PMV18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Wed, 3 Jan 2007 05:10:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6aAi1W00C1kojtg0000000; Wed, 03 Jan 2007 05:10:42 -0500
To: git@vger.kernel.org
In-Reply-To: <e5bfff550701030121n700fab25x63278457c884a3f7@mail.gmail.com>
	(Marco Costalba's message of "Wed, 3 Jan 2007 10:21:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35853>

"Marco Costalba" <mcostalba@gmail.com> writes:

> On 1/1/07, Junio C Hamano <junkio@cox.net> wrote:
>> "Marco Costalba" <mcostalba@gmail.com> writes:
>>
>> > On 12/31/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> >>
>> >> Further, if you rely on parsing being super-fast, why not just parse
>> >> _only_ the header information that you actually need? The header still
>> >> consists of
>> >>
>> >>         - exactly one "tree",
>> >>         - an arbitrary amount of "parent" lines,
>> >>         - exactly one "author", and
>> >>         - exactly one "committer" line
>> >>
>> >> After that may come optional headers,
>>
>> They are more like 'other' headers.  Nobody said the set of
>> headers are cast in stone forever.  The only things parsers
>> safely can assume are that the original four kinds come at the
>> beginning in the above order, and there is a blank line that
>> separates headers and the body.
>>
>
> I'm cooking the qgit parser fix, please confirm the following
> assumption is correct:
>
> 	When git-rev-list is called with --header option, after the first
> 	line with the commit sha, the following information is produced
> 	
> 	- one line with "tree"
> 	- an arbitrary amount of "parent" lines
> 	- one line with "author"
> 	- one line with "committer"
> 	- zero or more *non blank* lines with other info, as the encoding
> 	- one blank line
> 	- zero or one line with log title
> 	- zero or more lines with log message
> 	- a terminating '\0'

I think that is correct, except that rev-list does not even care
the distinction between log title and log message.

I do not think of a reason to change the order of the first four
offhand, so while it might be prudent to prepare the code to
accept them in any order if it is not too much trouble from
purist point of view, I do not think it is necessary in practice
and you should be able to depend on the order in which they
appear.  I do not think it would hurt anybody if we right now
declared that other extra headers people have talked about (such
as "notes") should always come after the first four.
