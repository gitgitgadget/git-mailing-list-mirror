From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH 5/5] struct sockaddr_storage->ss_family is not portable
Date: Fri, 12 Mar 2010 09:24:01 +0200 (EET)
Message-ID: <alpine.DEB.2.00.1003120922040.29993@cone.home.martin.st>
References: <20100311163715.GE7877@thor.il.thewrittenword.com> <alpine.DEB.2.00.1003111838260.29993@cone.home.martin.st> <20100312045654.GH7877@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Fri Mar 12 08:24:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpzEF-0000fq-Ou
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 08:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142Ab0CLHYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 02:24:11 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:55669 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754989Ab0CLHYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 02:24:09 -0500
Received: from dsl-tkubrasgw1-ffc4c100-75.dhcp.inet.fi (88.193.196.75) by jenni2.inet.fi (8.5.014)
        id 4B17EA3D03FC5A50; Fri, 12 Mar 2010 09:24:02 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <20100312045654.GH7877@thor.il.thewrittenword.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142029>

On Fri, 12 Mar 2010, Gary V. Vaughan wrote:

> On Thu, Mar 11, 2010 at 06:40:37PM +0200, Martin Storsj? wrote:
> > On Thu, 11 Mar 2010, Gary V. Vaughan wrote:
> > 
> > > Many of our supported platforms do not have this declaration, for
> > > example solaris2.6 thru 2.7.  Lack of ss_family implies no IPV6
> > > support, so we can wrap all the ss_family references in an ifndef
> > > NO_IPV6, and assume sockaddr_in otherwise.
> > 
> > While this probably is ok as such, you can actually do the same without 
> > accessing the sockaddr_storage->ss_family; just cast it to (const struct 
> > sockaddr*) and use ->sa_family instead, that should work just as well, as 
> > far as I know.
> 
> At least on aix-5.2 it won't be reliable unless you juggle compiler
> switches just right (I didn't check anywhere else, but the precedent
> for the bit ordering of the struct members being different is already
> set):
> 
> #if defined(COMPAT_43) && !defined(_KERNEL)
> struct sockaddr {
>         ushort_t        sa_family;      /* address family */
>         char            sa_data[14];    /* up to 14 bytes of direct
> address */
> };
> 
> 
> #else
> struct sockaddr {
>         uchar_t         sa_len;         /* total length */
>         sa_family_t     sa_family;      /* address family */
>         char            sa_data[14];    /* actually longer; address value */
> };
> #endif

Yes, but if the sockaddr struct can be arranged in different ways, the 
other ones (sockaddr_in, sockaddr_storage, sockaddr_in6) must also be 
defined coherently - you're always supposed to be able to cast an 
sockaddr_in (or any other of them) to a sockaddr and read the sa_family 
field. As far as I know, at least.

// Martin
