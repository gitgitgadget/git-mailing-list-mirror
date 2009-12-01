From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH/RFC] Allow curl to rewind the RPC read buffer
Date: Tue, 1 Dec 2009 18:51:54 +0200 (EET)
Message-ID: <alpine.DEB.2.00.0912011843320.5582@cone.home.martin.st>
References: <25718488.post@talk.nabble.com> <20091127234110.7b7e9993.rctay89@gmail.com> <alpine.DEB.2.00.0912011208160.5582@cone.home.martin.st> <alpine.DEB.2.00.0912011232450.5582@cone.home.martin.st> <20091201160150.GB21299@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org,
	Nicholas Miell <nmiell@gmail.com>, gsky51@gmail.com,
	Clemens Buchacher <drizzd@aon.at>,
	Mark Lodato <lodatom@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 01 17:52:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFVxL-0002Ph-61
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 17:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891AbZLAQvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 11:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753890AbZLAQvv
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 11:51:51 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:41659 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753632AbZLAQvu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 11:51:50 -0500
Received: from dsl-tkubrasgw1-ffc4c100-75.dhcp.inet.fi (88.193.196.75) by jenni2.inet.fi (8.5.014)
        id 4A77709104711C8C; Tue, 1 Dec 2009 18:51:54 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <20091201160150.GB21299@spearce.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134225>

On Tue, 1 Dec 2009, Shawn O. Pearce wrote:

> Martin Storsj? <martin@martin.st> wrote:
> > When using multi-pass authentication methods, the curl library may need
> > to rewind the read buffers used for providing data to HTTP POST, if data
> > has been output before a 401 error is received.
> 
> In theory, since the cURL session stays active, we would have
> received the 401 authentication error during the initial
> "GET $GIT_DIR/info/refs?service=git-$service" request, and the subsequent
> "POST $GIT_DIR/git-$service" requests would automatically include the
> authentication data.
> 
> That's theory.  Reality doesn't always agree with my theories.  :-)

As Tay said - his "maintain curl sessions" patch should make this 
redundant in most cases. But in case request pattern gets changed or if 
the curl session for some other reason isn't able to authenticate on the 
first try, this is a quite non-intrusive way of ensuring that these 
requests can be restarted.

// Martin
