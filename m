From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fast-import and core.autocrlf option
Date: Sun, 22 Jul 2007 20:51:37 -0700
Message-ID: <7vwswrojzq.fsf@assigned-by-dhcp.cox.net>
References: <a1bbc6950707221559m63fb1295jc26b1327e71687e3@mail.gmail.com>
	<Pine.LNX.4.64.0707230039560.14781@racer.site>
	<20070723034514.GZ32566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 05:51:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICoxS-000744-R7
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 05:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393AbXGWDvj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 23:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753173AbXGWDvj
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 23:51:39 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:61521 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbXGWDvi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 23:51:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070723035139.WHFA1393.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 22 Jul 2007 23:51:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Srrc1X00q1kojtg0000000; Sun, 22 Jul 2007 23:51:37 -0400
In-Reply-To: <20070723034514.GZ32566@spearce.org> (Shawn O. Pearce's message
	of "Sun, 22 Jul 2007 23:45:14 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53383>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> On Sun, 22 Jul 2007, Dmitry Kakurin wrote:
>> 
>> > It looks to me that CR/LF conversion does not happen during
>> > fast-import even if I have core.autocrlf set to 'input'.
>> > Is this a bug or is there a reason for that?
>> 
>> fast-import works on blobs only.  So it is expected.  Besides, it would 
>> slow down fast-import tremendously if you wanted to introduce that 
>> behaviour.  Therefore I suggest just rolling your own dos2unix instead of 
>> trying to play cute games with fast-import.
>
> Right, in fast-import we only process blobs as raw blobs.
> Its rare that we have a file path associated with the blob data
> at the time that we are actually processing the blob itself.  E.g.
> applications can send us blobs up front, before they even start to
> send us commits and path information.

Don't the front-ends usually have path information already when
they feed you a blob data, especially most of them operate on
per-file history?  If that is the case,...

> So if we were to offer the CRLF->LF conversion feature in fast-import
> it would need to be an option supplied at the time the 'data'
> command issued, rather than based upon the gitattributes system
> that is normally used for working tree operations.

... the "option" could be "this came from such and such path"
instead of "this is DOS data, please apply crlf".
