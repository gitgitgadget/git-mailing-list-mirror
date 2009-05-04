From: "Sohn, Matthias" <matthias.sohn@sap.com>
Subject: RE: [JGIT PATCH v3] Replace inefficient new String(String) constructor to silence FindBugs
Date: Mon, 4 May 2009 23:23:51 +0200
Message-ID: <366BBB1215D0AB4B8A153AF047A2878003073DC3@dewdfe18.wdf.sap.corp>
References: <1241193272-20247-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>, "Yann Simon" <yann.simon.fr@gmail.com>,
	"Robin Rosenberg" <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 04 23:24:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M15eG-00040D-Mi
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 23:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573AbZEDVYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 17:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753570AbZEDVYA
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 17:24:00 -0400
Received: from smtpde03.sap-ag.de ([155.56.68.140]:53425 "EHLO
	smtpde03.sap-ag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379AbZEDVX7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 May 2009 17:23:59 -0400
Received: from mail.sap.corp
	by smtpde03.sap-ag.de (26) with ESMTP id n44LNs9s011269
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 May 2009 23:23:54 +0200 (MEST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <1241193272-20247-1-git-send-email-spearce@spearce.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [JGIT PATCH v3] Replace inefficient new String(String) constructor to silence FindBugs
Thread-Index: AcnKdSTdGl4VY3fVSCeMv3DsgnmI2ACiLCxQ
X-OriginalArrivalTime: 04 May 2009 21:23:53.0585 (UTC) FILETIME=[A00EBE10:01C9CCFE]
X-Scanner: Virus Scanner virwal04
X-SAP: out
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118264>

Shawn O. Pearce [mailto:spearce@spearce.org] wrote :
 
> FindBugs keeps reporting that our usage of new String(String)
> is not the most efficient way to construct a string.
> 
> http://thread.gmane.org/gmane.comp.version-
> control.git/113739/focus=113787
> > I had a specific reason for forcing a new String object here.
> >
> > The line in question, p, is from the packed-refs file and
> > contains the entire SHA-1 in hex form at the beginning of it.
> > We've converted that into binary as an ObjectId, it uses 1/4 the
> > space of the string portion.
> >
> > The Ref object, its ObjectId, and its name string, are going to be
> > cached in a Map, probably long-term.  We're better off shedding the
> > 80 bytes of memory used to hold the hex SHA-1 then risk substring()
> > deciding its "faster" to reuse the char[] then to make a copy of it.
> 
> Another way to force this new unique String instance with its own
> private char[] is to use a StringBuilder and append onto it the
> ref name.  This shouldn't be a warning for FindBugs, but it would
> accomplish the same goal of producing 1 clean copy, with no extra
> transient temporary array.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> CC: Yann Simon <yann.simon.fr@gmail.com>
> CC: Matthias Sohn <matthias.sohn@sap.com>
> ---
> 
>  A less ugly version ?

I agree, this looks better than the previous proposal but still a simple
String copy constructor looks even simpler.

I tried the alternative approach Robin proposed using FindBugs filter 
mechanisms to suppress the undesired warning. I will post that in my 
next mail.

--
Matthias
