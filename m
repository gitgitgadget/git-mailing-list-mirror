From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] gitweb: handle non UTF-8 text
Date: Wed, 30 May 2007 22:18:19 +0200
Organization: Dewire
Message-ID: <200705302218.19408.robin.rosenberg.lists@dewire.com>
References: <1180385254576-git-send-email-mkoegler@auto.tuwien.ac.at> <200705291121.12119.jnareb@gmail.com> <20070529215536.GA13250@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>,
	Martyn Smith <martyn@catalyst.net.nz>
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Wed May 30 22:18:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtUcL-0002Yz-SZ
	for gcvg-git@gmane.org; Wed, 30 May 2007 22:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbXE3URy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 16:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753869AbXE3URy
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 16:17:54 -0400
Received: from [83.140.172.130] ([83.140.172.130]:21403 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752746AbXE3URx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 16:17:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D81F4802817;
	Wed, 30 May 2007 22:11:26 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24016-04; Wed, 30 May 2007 22:11:26 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 5E7B3802814;
	Wed, 30 May 2007 22:11:26 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070529215536.GA13250@auto.tuwien.ac.at>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48786>

tisdag 29 maj 2007 skrev Martin Koegler:
> On Tue, May 29, 2007 at 11:21:11AM +0200, Jakub Narebski wrote:
> > On Tue, 29 May 2007, Petr Baudis wrote:
> > > On Mon, May 28, 2007 at 10:47:34PM CEST, Martin Koegler wrote:
> > 
> > >> gitweb assumes, that everything is in UTF-8. If a text contains invalid
> > >> UTF-8 character sequences, the text must be in a different encoding.
> > 
> > But it doesn't tell us _what_ is the encoding. For commit messages,
> > with reasonable new git, we have 'encoding' header if git known that
> > commit message was not in utf-8.
> > 
> > By the way, I winder why we don't have such header for tag objects
> > (i18n.tagEncoding ;-)...
> 
> Why do I need to set i18n.commitEncoding on a normal Linux systems?  We
I've asked the same question.. :(
> have a locale, which contains this information. With this, its more
> likely, that the commits can be read correctly later, if somebody
> forget to set "i18n.commitEncoding" in a repository.
No 'if'. Users are virtually guaranteed to forget this setting.

> 
> UTF-8 is not the universal, dropin solution for ISO-8859-1. It has some drawbacks:
> - Some operations are slower, eg.
> - Anything using string length/character position is more complicated.
We'll have to live with that. A nice property of valid UTF-8 is that many operations can
be performed without decoding (like looking for a substring).

> 
> For some problems, UTF-16 might be a simpler solution.
UTF-16 is also variable width (one or two code units). Most apps get away by pretending it is 
fixed width, simply because that works for most people, but then I'm not sure people in asia 
aren't really happy with that assumption either. 

> I would use i18n.commitEncoding only as last fallback. In a project
> more different encodings could be used and the guessing logic may need
> additional parameter, so I would create a own set of config parameters
> for this.

There aren't many simple ways of guessing. The UTF-8 vs other test is simple 
and very reliable for western encodings (and merely good for others, if I'm not misinformed).
The i18n.commitEncoding is just a hint. Another hint is the host's encoding.

1. if lookslike(UTF-8) => assume UTF-8 else...
2. commit's encoding is valid for the text => use it else...
3. i18n.commitEncoding ...
4. gitweb.commitencoding  ....
5. server's location charset ...
6. assume iso-8859-1

Yet another would be to have an extra option to switch encoding on-demand in the gui.

BTW, there's another thread on notes. Maybe they be used to "fix" badly encoded messages
if and when they get a final implementation.

-- robn
