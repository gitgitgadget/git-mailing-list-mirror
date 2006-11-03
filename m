X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git bug? + question
Date: Fri, 3 Nov 2006 10:46:55 +0100
Message-ID: <20061103094655.GA16721@diana.vm.bytemark.co.uk>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <7v4pthmew1.fsf@assigned-by-dhcp.cox.net> <20061103074857.GA15972@diana.vm.bytemark.co.uk> <7v3b90gbfv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 09:47:40 +0000 (UTC)
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v3b90gbfv.fsf@assigned-by-dhcp.cox.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30808>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfvdt-0000P0-1T for gcvg-git@gmane.org; Fri, 03 Nov
 2006 10:47:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752751AbWKCJrI convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 04:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752765AbWKCJrI
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 04:47:08 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:14605 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1752751AbWKCJrF
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 04:47:05 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GfvdX-0004dl-00; Fri, 03 Nov 2006 09:46:55 +0000
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 2006-11-03 00:51:32 -0800, Junio C Hamano wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> > On 2006-11-02 18:40:30 -0800, Junio C Hamano wrote:
> >
> > > I still need to remember to process "master" first, so all
> > > things considered, this is a regression in usability for my
> > > workflow.
> >
> > Where does this constraint come from?
>
> Because I'll have to have the per-branch configuration that would
> say something like this:
>
>       [remote."gitster"]
>               url =3D gitster.example.com:/home/junio/git.git/
>               fetch =3D heads/maint:remotes/gitster/maint
>               fetch =3D heads/master:remotes/gitster/master
>               fetch =3D heads/next:remotes/gitster/next
>               fetch =3D +heads/pu:remotes/gitster/pu
>
>       [branch."master"]
>               remote =3D gitster
>               merge =3D heads/master
>       [branch."maint"]
>               remote =3D .
>               merge =3D remotes/gitster/maint
>       [branch."next"]
>               remote =3D .
>               merge =3D remotes/gitster/next
>       ...
>
> This requires that by the time we update maint, next and pu branches
> with what is in the upstream, their corresponding remotes/gitster/*
> branches are already up-to-date and do not have to be re-fetched,
> and processing master first is what guarantees it.

Ahh, here is where our workflows differ: I would want to have "remote
=3D ." for all the branches, and use "git fetch" to update the remotes.
(I guess this is only natural; my workflow requires less state in the
head of the user, and so is easier for beginners, while yours is
slightly more efficient in terms of number of commands that have to be
given.)

Hmm. How about changing the meaning of "remote" slightly? Like this:

      [remote."gitster"]
              url =3D gitster.example.com:/home/junio/git.git/
              fetch =3D heads/master:remotes/gitster/master
              fetch =3D heads/next:remotes/gitster/next
      [branch."master"]
              remote =3D gitster
              merge =3D remotes/gitster/master
      [branch."next"]
              remote =3D gitster
              merge =3D remotes/gitster/next

This would mean: When the user says "git pull" in master, use the
remote gitster to fetch updates to remotes/gitster/master, then merge
remotes/gitster/master into master.

With this scheme, "git pull" would never fetch any other branches than
those about to be merged; to fetch more in one go, use "git fetch".

I realize this would break existing configs quite badly, so don't take
it too seriously.

--=20
Karl Hasselstr=F6m, kha@treskal.com
