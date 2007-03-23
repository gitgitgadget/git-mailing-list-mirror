From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git / Subversion Interoperability
Date: Fri, 23 Mar 2007 18:13:16 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0703231758020.8105@reaper.quantumfyre.co.uk>
References: <20070322224829.GA7048@c3sl.ufpr.br> <20070323004335.GA17773@spearce.org>
 <Pine.LNX.4.64.0703230052570.2746@beast.quantumfyre.co.uk>
 <20070323012422.GC17773@spearce.org> <Pine.LNX.4.64.0703230128330.4001@beast.quantumfyre.co.uk>
 <20070323103426.GA15923@diana.vm.bytemark.co.uk> <20070323152102.GA4818@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811584-1691585828-1174673596=:8105"
Cc: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Fri Mar 23 19:13:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUoGT-0001jx-TK
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 19:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277AbXCWSNU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 14:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753276AbXCWSNU
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 14:13:20 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:49970 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753277AbXCWSNS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Mar 2007 14:13:18 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id E64B8C6084
	for <git@vger.kernel.org>; Fri, 23 Mar 2007 18:13:16 +0000 (GMT)
Received: (qmail 6202 invoked by uid 103); 23 Mar 2007 18:13:16 +0000
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/2906. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.036932 secs); 23 Mar 2007 18:13:16 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 23 Mar 2007 18:13:16 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20070323152102.GA4818@c3sl.ufpr.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42951>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811584-1691585828-1174673596=:8105
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 23 Mar 2007, Bruno Cesar Ribas wrote:

> On Fri, Mar 23, 2007 at 11:34:26AM +0100, Karl Hasselstr=F6m wrote:
>> On 2007-03-23 01:36:11 +0000, Julian Phillips wrote:
>>
>>> In particular it's how the client finds out about things like
>>> symlinks and line ending conversion. It may be necessary to provide
>>> some basic support for some of the properties in the svn:...
>>> namespace in order for the Subversion repo access library not to
>>> refuse to talk to the git server.
>>
>> Maybe the pragmatic solution would be to have built-in handling of a
>> few properties such as svn:executable and svn:ignore that have git
>> equivalents, and just emulate all other properties with files.
>
> My idea is to write the git-svnserver!!! I think it will be easier.

Almost certainly - I don't think anyone was proposing otherwise?  The repo=
=20
access library I was referring to is one of the libraries used by the=20
client - specifically the one used to talk to a remote server (I think=20
it may be called ra or something?  I'm not familiar with Subversion=20
internals).

>
> To begin coding, i plan to write basic functions [updade,commit,checkout,
> copy,merge,...] then start to implement most "complex" instructions.

Ok, but ...

I don't think that merge is a basic function in Subversion.  I believe=20
that it is all client side using diffs provided by the server into the=20
working copy, certainly it is up to the user to commit the result.=20
Unfortunately that would make it necesary to do some very nasty work=20
server side to try and autodetect merges - git-svnimport (and git-svn?)=20
already does this sort of thing.  There are noises about this changing at=
=20
some point though ...

>
> As spearce said before, the idea of this is to migrate from svn to git
> without many trouble in transition, so basic can work as the initial thou=
ght.

Which means that you have to at the very least support the basic=20
operations of the Subversion supplied svn client.  And my point was that I=
=20
wouldn't be surprised if this meant dealing with properties, since=20
subversion uses properties to expose things like the log message, commit=20
date and author for revisions and other misc. info for files.  You may not=
=20
even be able to get commit/checkout working without _some_ property=20
support.

Having said that, I don't think it would be a _bad_ thing if this work=20
went far enough that one could replace a Subversion server without any=20
users even noticing ;)

--=20
Julian

  ---
You know you're using the computer too much when:
a party sucks if theres no computers to use.
 =09-- electrofreak
---1463811584-1691585828-1174673596=:8105--
