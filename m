From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Support for EBCDIC
Date: Thu, 3 Jul 2014 16:01:01 -0400
Organization: PD Inc
Message-ID: <46A5AE733A22492FBD719EE01B20B0E7@black>
References: <1404355152.86116.YahooMailNeo@web184805.mail.gq1.yahoo.com> <20140703173413.GC20571@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Jeff King'" <peff@peff.net>, "'Scott McKellar'" <mck9@swbell.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 03 22:01:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2nC0-0001N1-1c
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 22:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008AbaGCUBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 16:01:12 -0400
Received: from mail.pdinc.us ([67.90.184.27]:34997 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292AbaGCUBL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 16:01:11 -0400
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s63K11Pp030331;
	Thu, 3 Jul 2014 16:01:01 -0400
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20140703173413.GC20571@sigill.intra.peff.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Thread-Index: Ac+W5Qo1iko0QBv1R+6M++BRi63YCwAEkhEg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252877>

> -----Original Message-----
> From: Jeff King
> Sent: Thursday, July 03, 2014 13:34
> 
> On Wed, Jul 02, 2014 at 07:39:12PM -0700, Scott McKellar wrote:
> 
> > Is Git supposed to be usable in an environment where the 
> execution character set is EBCDIC?
> 
> Not really.

If the core uses specific 8bit values for the internals then there is a hope and
prayer.

E.g. "blob" would need to be char _BLOB={0x62,0x6c,0x6f,0x62} because the hash
calculation would be wrong if were {0x82,0x93,0x96,0x82} ensuring the compiler
does not change that "binary" data value.

> 
> In addition to the cases you found (and I would be surprised if there
> are not more, such as our reimplementation of ctype.h), we assume:
> 
>   - we can intermingle ASCII from string literals with user 
> data to form
>     diffs, commit objects, network protocols, etc. This is actually a
>     problem not just for EBCDIC, but for any encoding which is not an
>     ASCII-superset (like UTF-16).

And then all output would require code-page aware translation, but fix the above
first.

> 
>   - many outputs from git should be ASCII in order to 
> interoperate with
>     the outside world (object headers, network protocols, etc).
> 
> So I'd be surprised if things worked well in an EBCDIC 
> environment (but
> I have never worked with one, so maybe I do not understand all of the
> implications).

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
