From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: A tracking tree for the active work space
Date: Sun, 11 Mar 2007 22:31:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703112209160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910703110706m14abae25r2a965b644d8c3bbb@mail.gmail.com> 
 <7vhcsrwn8d.fsf@assigned-by-dhcp.cox.net> <9e4733910703111335j20c0acf4wa12c2d410580898b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 22:32:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQVe9-0000bR-F4
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 22:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbXCKVcB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 17:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbXCKVcB
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 17:32:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:56006 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932645AbXCKVcA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 17:32:00 -0400
Received: (qmail invoked by alias); 11 Mar 2007 21:31:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 11 Mar 2007 22:31:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18WNnxSBWAW6peGp+Fd4CxDVOrB6TFcxj6JplPQo4
	Zt2aaTjTGUNOLt
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <9e4733910703111335j20c0acf4wa12c2d410580898b@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41986>

Hi,

On Sun, 11 Mar 2007, Jon Smirl wrote:

> As for the part about 'git grep' Shawn and I have been talking off and 
> on about experimenting with an inverted index for a packfile format. The 
> basic idea is that you tokenize the input and turn a source file into a 
> list of tokens. You diff with the list of tokens like you would normally 
> do with text. There is a universal dictionary for tokens, a token's id 
> is it's position in the dictionary.

All in all, this is an interesting idea.

However, I see some problems I'd like to know solutions for:

- how to determine the optimal length of the tokens? (It is easy if you 
  tokenize on the word level, but you suggested that it is more efficient 
  to have longer phrases.)

- the search terms can be _part of_ the tokens. In fact, a search term can 
  be the postfix of one token, then a list of other tokens, and then a 
  prefix of yet another token. It might not be really cheap to construct 
  _all_ possible combinations of tokens which make up the search term...

- how do you want to cope with regular expressions? (The previous problem 
  only addresses simple, constant search terms, i.e. no true regular 
  expressions.)

- at the moment, most objects which are contained by a pack are relatively 
  cheaply transported via the pack protocol. IIUC your new pack format 
  would need _exactly_ the same dictionary to be transmitted as-is. IOW
  how do you want to make on-the-fly pack generation cheap again?

Don't get me wrong: I don't want to discourage you, but it is too easy to 
optimize for the wrong use cases (I expact a repack, or a fetch, to happen 
much more often than a grep). If you can address above-mentioned issues, 
I see no reason why the new pack format should not be used instead of the 
current one.

Ciao,
Dscho
