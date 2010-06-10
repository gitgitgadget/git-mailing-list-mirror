From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: Git sideband hook output
Date: Thu, 10 Jun 2010 14:56:37 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC744839BF6AE@xmail3.se.axis.com>
References: <AANLkTinLWDFTn7bhcF3Vk-q9aw4lJC2vFj95M9bxLbBT@mail.gmail.com>
 <20100608214632.GN14847@spearce.org>
 <A612847CFE53224C91B23E3A5B48BAC744839BF3DD@xmail3.se.axis.com>
 <alpine.LFD.2.00.1006090934320.30664@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Jun 10 14:56:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMhJS-0004gu-JD
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 14:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758892Ab0FJM4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 08:56:45 -0400
Received: from krynn.se.axis.com ([193.13.178.10]:35435 "EHLO
	krynn.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601Ab0FJM4o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 08:56:44 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by krynn.se.axis.com (8.14.3/8.14.3/Debian-5) with ESMTP id o5ACuc9G000511;
	Thu, 10 Jun 2010 14:56:38 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Thu, 10 Jun 2010 14:56:38 +0200
Thread-Topic: Git sideband hook output
Thread-Index: AcsH2gJBmuoKTa5GTc6YTOwI+lKiqwAuzEpg
In-Reply-To: <alpine.LFD.2.00.1006090934320.30664@xanadu.home>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148865>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Nicolas Pitre
> Sent: den 9 juni 2010 15:44
> To: Peter Kjellerstedt
> Cc: Shawn O. Pearce; Scott Chacon; git list
> Subject: RE: Git sideband hook output
> 
> On Wed, 9 Jun 2010, Peter Kjellerstedt wrote:
> 
> > > -----Original Message-----
> > > From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org]
> > > On Behalf Of Shawn O. Pearce
> > > Sent: den 8 juni 2010 23:47
> > > To: Scott Chacon
> > > Cc: git list
> > > Subject: Re: Git sideband hook output
> > >
> > > Scott Chacon <schacon@gmail.com> wrote:
> > > > Prior to 6d525d where Shawn made the receive-pack process send
> > > > hook output over side band #2, how did the hook output get 
> > > > sent to the client?
> > >
> > > It was sent over stderr, which was proxied down to the client by
> > > the SSH daemon.
> > >
> > > > On older clients (before this commit) and on older servers,
> > > > the hook output just shows up without the 'remote:' prefix.
> > >
> > > Because its echoed to the tty by the SSH client, without Git ever
> > > seeing it.
> > >
> > > > After
> > > > this commit I get the 'remote:' prefix,
> >
> > This explains the messy output from hooks I have seen since
> > updating to 1.7.1...
> >
> > > Now its being parsed out of the stream by the git client, using
> > > the same code that displays the progress messages during
> > > clone/fetch.
> > >
> > > > which is kind of annoying.
> > >
> > > Depends on your perspective.  Its nice to know that the messages
> > > came from the server, rather than from your client.  :-)
> >
> > And it is very annoying that the output format has suddenly changed
> > so that the output from hooks that rely on the previous no-prefix
> > format no longer fit on an 80 char wide terminal where they used to
> > fit just fine.
> 
> Fix your hook output then.

I can do that for our hooks, but all may not have that option.

> > > > Is
> > > > there a way to suppress this to get the old output format?
> > >
> > > No.  Other than to have the hook not output anything at all.
> > >
> > > --
> > > Shawn.
> >
> > Here is +1 for giving us back the no-prefix output. I would like
> > to suggest adding a configuration option to allow users to enable
> > the "remote: " prefix if they want it.
> 
> Would be much more logical to fix the hook output, and keep hook
> developers honnest by not confusing the user with output that isn't
> local stuff.

Why should the user care whether the output is generated locally 
or remotely? Shouldn't you prefix local hook output then as well
to separate it from the output of the git commands themselves 
(and no, I am not suggesting this is added)?

> -1
> 
> 
> Nicolas

As I see it this change has taken away a little bit of freedom.
Previously I (as a hook writer) could choose to add a prefix like 
"remote:" to my hook if I wanted to, to make it more obvious that the
output came from the remote server, _or_ I could choose not to and 
have a standardized output that looked the same regardless of whether
it was a local hook or a remote one that complained about the 
formatting of a commit message. Now I no longer have that option.

And what if my hook output is localized? Now there is an English
"remote:" in front of every line... Or even worse, what if the
"remote:" string is localized in a future version of git, then I 
have no way of knowing how wide it is and cannot take measures to 
format my hook output so that it will look right.

//Peter
