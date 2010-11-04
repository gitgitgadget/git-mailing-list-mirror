From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH v6 00/16] daemon-win32
Date: Thu, 4 Nov 2010 10:58:47 +0200 (EET)
Message-ID: <alpine.DEB.2.00.1011041053120.31519@cone.home.martin.st>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com> <877hgunmdc.fsf@fox.patthoyts.tk> <AANLkTin2BCxDoKhDCSgSRG1eVUGVeQh6Bq_=FfAe0M_M@mail.gmail.com> <AANLkTim4_5dgPGcw5B3U-3UH63REL4QWsWPV=mDSJJ6D@mail.gmail.com>
 <AANLkTin6_RLBJZKDaDViZ2_v7_LKpyoyvofowArx9sas@mail.gmail.com> <AANLkTinS2PLD3qwHpf491J3bDjXO8PxF96KdF=fz9a8o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463810048-1231527688-1288861127=:31519"
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org,
	gitster@pobox.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 09:59:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDvev-0002RV-Oj
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 09:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926Ab0KDI64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 04:58:56 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:45062 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753342Ab0KDI6z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 04:58:55 -0400
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Nov 2010 04:58:54 EDT
Received: from dsl-tkubrasgw1-ffc4c100-75.dhcp.inet.fi (88.193.196.75) by kirsi1.inet.fi (8.5.122)
        id 4C2999BC049DAB28; Thu, 4 Nov 2010 10:58:47 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <AANLkTinS2PLD3qwHpf491J3bDjXO8PxF96KdF=fz9a8o@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160697>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463810048-1231527688-1288861127=:31519
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 4 Nov 2010, Erik Faye-Lund wrote:

> On Thu, Nov 4, 2010 at 1:06 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> > On Wed, Nov 3, 2010 at 11:58 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> >> On Wed, Nov 3, 2010 at 11:18 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> >>> On Wed, Nov 3, 2010 at 10:11 PM, Pat Thoyts
> >>> <patthoyts@users.sourceforge.net> wrote:
> >>>> Erik Faye-Lund <kusmabite@gmail.com> writes:
> >>>>
> >>>>>Here's hopefully the last iteration of this series. The previous version
> >>>>>only got a single complain about a typo in the subject of patch 14/15, so
> >>>>>it seems like most controversies have been settled.
> >>>>
> >>>> I pulled this win32-daemon branch into my msysgit build tree and built
> >>>> it. I get the following warnings:
> >>>>
> >>>>    CC daemon.o
> >>>> daemon.c: In function 'service_loop':
> >>>> daemon.c:674: warning: dereferencing pointer 'ss.124' does break strict-aliasing rules
> >>>> daemon.c:676: warning: dereferencing pointer 'ss.124' does break strict-aliasing rules
> >>>> daemon.c:681: warning: dereferencing pointer 'ss.124' does break strict-aliasing rules
> >>>> daemon.c:919: note: initialized from here
> >>>> daemon.c:679: warning: dereferencing pointer 'sin_addr' does break strict-aliasing rules
> >>>> daemon.c:675: note: initialized from here
> >>>> daemon.c:691: warning: dereferencing pointer 'sin6_addr' does break strict-aliasing rules
> >>>> daemon.c:682: note: initialized from here
> >>>>
> >>>
> >>> Yeah, I'm aware of these. I thought those warnings were already
> >>> present in the Linux build, but checking again I see that that's not
> >>> the case. Need to investigate.
> >>>
> >>
> >> OK, it's the patch "daemon: use run-command api for async serving"
> >> that introduce the warning. But looking closer at the patch it doesn't
> >> seem the patch actually introduce the strict-aliasing violation, it's
> >> there already. The patch only seems to change the code enough for GCC
> >> to start realize there's a problem. Unless I'm misunderstanding
> >> something vital, that is.
> >>
> >> Anyway, here's a patch that makes it go away, I guess I'll squash it
> >> into the next round.
> >>
> >
> > Stuffing all of sockaddr, sockaddr_in and sockaddr_in6 (when built
> > with IPv6 support) in a union and passing that around instead does
> > seem to fix the issue completely. I don't find it very elegant, but
> > some google-searches on the issue seems to reveal that this is the
> > only way of getting rid of this. Any other suggestions, people?
> >
> 
> Just for reference, this is the patch that fixes it. What do you think?
> 
> diff --git a/daemon.c b/daemon.c
> index 941c095..8162f10 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -902,9 +903,15 @@ static int service_loop(struct socketlist *socklist)
> 
>  		for (i = 0; i < socklist->nr; i++) {
>  			if (pfd[i].revents & POLLIN) {
> -				struct sockaddr_storage ss;
> +				union {
> +					struct sockaddr sa;
> +					struct sockaddr_in sai;
> +#ifndef NO_IPV6
> +					struct sockaddr_in6 sai6;
> +#endif
> +				} ss;
>  				unsigned int sslen = sizeof(ss);
> -				int incoming = accept(pfd[i].fd, (struct sockaddr *)&ss, &sslen);
> +				int incoming = accept(pfd[i].fd, &ss.sa, &sslen);
>  				if (incoming < 0) {
>  					switch (errno) {
>  					case EAGAIN:
> @@ -915,7 +922,7 @@ static int service_loop(struct socketlist *socklist)
>  						die_errno("accept returned");
>  					}
>  				}
> -				handle(incoming, (struct sockaddr *)&ss, sslen);
> +				handle(incoming, &ss.sa, sslen);
>  			}
>  		}
>  	}

As you say yourself, it's not elegant at all - sockaddr_storage is 
intended to be just that, an struct large enough to fit all the sockaddrs 
you'll encounter on this platform, with all fields aligned in the same way 
as all the other sockaddr structs. You're supposed to be able to cast the 
sockaddr struct pointers like currently is done, although I'm not familiar 
with the strict aliasing stuff well enough to know if anything else would 
be required somewhere.

I didn't see any of these hacks in the v7 patchset - did the warning go 
away by itself there?

FWIW, the actual warning itself isn't directly related to any of the code 
worked on here, gcc just happens to realize it after some of these 
changes. I'm able to trigger the same warnings on the current master, by 
simply doing this change:

diff --git a/daemon.c b/daemon.c
index 5783e24..467cea2 100644
--- a/daemon.c
+++ b/daemon.c
@@ -670,7 +670,6 @@ static void handle(int incoming, struct sockaddr 
*addr, int 
        dup2(incoming, 1);
        close(incoming);
 
-       exit(execute(addr));
 }
 
 static void child_handler(int signo)


// Martin
---1463810048-1231527688-1288861127=:31519--
