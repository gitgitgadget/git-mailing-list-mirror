From: Jeff King <peff@peff.net>
Subject: Re: can we prevent reflog deletion when branch is deleted?
Date: Thu, 14 Nov 2013 06:09:38 -0500
Message-ID: <20131114110937.GA11597@sigill.intra.peff.net>
References: <20130601050355.GA23408@sigill.intra.peff.net>
 <CALkWK0kcJH0t4i0BAPmMkNWwNzeJNdmg_wbt3ao-=R31kJ5noA@mail.gmail.com>
 <20130601090934.GA13904@sigill.intra.peff.net>
 <CALkWK0mwAc0bFon7B7nw1Nbvcwdf8m2_531qtrN-r28r9F+70Q@mail.gmail.com>
 <CAMK1S_hPups3SCwxhHRYWBJzpPreNVUfNdx1+_Hjy2_d0MMpaA@mail.gmail.com>
 <CALkWK0=SqCh-82F4ud+AxuzzEezyMWqMvc6HAPoxOk32vUND7A@mail.gmail.com>
 <528416EA.1070307@gmail.com>
 <87bo1nmn6w.fsf@linux-k42r.v.cablecom.net>
 <20131114080735.GB16327@sigill.intra.peff.net>
 <5284AC6E.4030208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <tr@thomasrast.ch>,
	Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 12:09:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vgunz-0007dp-7t
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 12:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab3KNLJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 06:09:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:39051 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752883Ab3KNLJm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 06:09:42 -0500
Received: (qmail 6134 invoked by uid 102); 14 Nov 2013 11:09:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Nov 2013 05:09:42 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Nov 2013 06:09:38 -0500
Content-Disposition: inline
In-Reply-To: <5284AC6E.4030208@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237822>

On Thu, Nov 14, 2013 at 04:26:46PM +0530, Sitaram Chamarty wrote:

> > I do not know about any particular debate in git circles, but I assume
> > Sitaram is referring to this incident:
> > 
> >   https://groups.google.com/d/msg/jenkinsci-dev/-myjRIPcVwU/t4nkXONp8qgJ
> > 
> > in which a Jenkins dev force-pushed and rewound history on 150 different
> > repos. In this case the reflog made rollback easy, but if he had pushed
> > a deletion, it would be harder.
> 
> I don't know if they had a reflog on the server side; they used
> client-side reflogs if I understood correctly.
> 
> I'm talking about server side (bare repo), assuming the site has
> core.logAllRefUpdates set.

Yes, they did have server-side reflogs (the pushes were to GitHub, and
we reflog everything). Client-side reflogs would not be sufficient, as
the client who pushed does not record the history he just rewound (he
_might_ have it at refs/remotes/origin/master@{1}, but if somebody
pushed since his last fetch, then he doesn't).

The "simplest" way to recover is to just have everyone push again
(without --force). The history will just silently fast-forward to
whoever has the most recent tip. The downside is that you have to wait
for that person to actually push. :)

I think they started with that, and then eventually GitHub support got
wind of it and pulled the last value for each repo out of the
server-side reflog for them.

-Peff
