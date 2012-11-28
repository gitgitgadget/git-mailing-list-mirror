From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Millisecond precision in timestamps?
Date: Tue, 27 Nov 2012 20:29:45 -0500
Organization: PD Inc
Message-ID: <EE15DF282E7C4196A32EE0818A64E35D@black>
References: <20121127204828.577264065F@snark.thyrsus.com> <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com> <7vzk22lmz9.fsf@alter.siamese.dyndns.org> <20121127230419.GA26080@thyrsus.com> <CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com> <20121128001231.GA27971@thyrsus.com> <CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com> <CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com> <20121128011750.GA23498@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'git'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 02:30:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdWTs-0001eH-VL
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 02:30:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471Ab2K1BaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 20:30:11 -0500
Received: from projects.pdinc.us ([67.90.184.26]:49883 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754323Ab2K1BaK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 20:30:10 -0500
Received: from black ([192.168.4.12])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id qAS1TvAd021828
	for <git@vger.kernel.org>; Tue, 27 Nov 2012 20:29:57 -0500
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20121128011750.GA23498@sigill.intra.peff.net>
Thread-Index: Ac3NBjZp7tkuw1ITQii555y2BJHQPQAAL/Xg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210656>

> -----Original Message-----
> From: Jeff King
> Sent: Tuesday, November 27, 2012 20:18
> 
> On Tue, Nov 27, 2012 at 05:07:34PM -0800, Shawn O. Pearce wrote:
> 
> > On Tue, Nov 27, 2012 at 4:26 PM, Felipe Contreras 
> > <felipe.contreras@gmail.com> wrote:
> > > On Wed, Nov 28, 2012 at 1:12 AM, Eric S. Raymond 
> <esr@thyrsus.com> wrote:
> > >> Shawn Pearce <spearce@spearce.org>:
> > >>> Well... if we added a fractional seconds to a commit, older 
> > >>> versions of Git will scream loudly and refuse to work 
> with the new 
> > >>> commit. That would create a fork of Git.
> > >>
> > >> So much for that idea, I guess.
> > >>
> > >> Unless..I don't know how git's database representations 
> work.  Are 
> > >> they version-stamped in any way?  If so, some slightly painful 
> > >> hackery would get around that problem.
> > >
> > > % git cat-file -p HEAD
> > >
> > > You'll see exactly how git stores commits. Changing anything in 
> > > there must be done carefully.
> > 
> > Apparently there is no room to change in these fields 
> without breaking 
> > compatibility with all current versions of Git. So its not 
> just done 
> > carefully... its deciding to make Git 2.0 that is not 
> compatible with 
> > any Git 1.x release.
> 
> There is room for new headers, and older versions of git will 
> ignore them. You could add a new "committer-timestamp" field 
> that elaborates on the timestamp included on the committer 
> line. Newer versions of git would respect it, and older 
> versions would fall back to using the committer timestamp.

Suggestion add a ms offset field. Ex:

jpyeron@black /projects/git/git
$ git cat-file -p HEAD
tree 1e24acfbfcc05aa57e8cb2cfe3ffe01cb100961d
parent e98fa647aa5673cc95b6e9be1fdc13c0afa2cb37
author Junio C Hamano <gitster@pobox.com> 1350495361 -0700
committer Junio C Hamano <gitster@pobox.com> 1350495402 -0700
mstimestamps author 0 committer 1234

Git 1.7.12.4

Signed-off-by: Junio C Hamano <gitster@pobox.com>


> 
> But I really wonder if anybody actually cares about adding 
> sub-second timestamp support, or if it is merely "because SVN has it".

Not because subversion has it but because date != git(precisedate) and some
automation using git in a larger enterprise workflow may assume that date
1354065991.1234 going in should be the same when queried.

-Jason



--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
