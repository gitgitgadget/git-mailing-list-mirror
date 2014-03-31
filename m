From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 2/3] patch-id: document new behaviour
Date: Mon, 31 Mar 2014 22:26:04 +0300
Message-ID: <20140331192604.GF12208@redhat.com>
References: <1396202583-2572-1-git-send-email-mst@redhat.com>
 <1396202583-2572-2-git-send-email-mst@redhat.com>
 <xmqqmwg65gp7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jrnieder@gmail.com,
	peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 21:26:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUhqG-0003rC-J4
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 21:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbaCaTZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 15:25:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54914 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946AbaCaTZs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 15:25:48 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2VJPbTo011852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 31 Mar 2014 15:25:38 -0400
Received: from redhat.com (vpn1-7-154.ams2.redhat.com [10.36.7.154])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s2VJPYCn013682;
	Mon, 31 Mar 2014 15:25:35 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmwg65gp7.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245514>

On Mon, Mar 31, 2014 at 12:08:36PM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Clarify that patch ID is now a sum of hashes, not a hash.
> > Document --stable and --unstable flags.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >
> > changes from v2:
> > 	explicitly list the kinds of changes against which patch ID is stable
> >
> >  Documentation/git-patch-id.txt | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
> > index 312c3b1..30923e0 100644
> > --- a/Documentation/git-patch-id.txt
> > +++ b/Documentation/git-patch-id.txt
> > @@ -8,14 +8,14 @@ git-patch-id - Compute unique ID for a patch
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git patch-id' < <patch>
> > +'git patch-id' [--stable | --unstable] < <patch>
> 
> Thanks.  It seems taht we are fairly inconsistent when writing
> alternatives on the SYNOPSIS line.  A small minority seems to spell
> the above as "[--stable|--unstable]", which may want to be fixed
> (outside the context of this series, of course).
> 
> >  
> >  DESCRIPTION
> >  -----------
> > -A "patch ID" is nothing but a SHA-1 of the diff associated with a patch, with
> > -whitespace and line numbers ignored.  As such, it's "reasonably stable", but at
> > -the same time also reasonably unique, i.e., two patches that have the same "patch
> > -ID" are almost guaranteed to be the same thing.
> > +A "patch ID" is nothing but a sum of SHA-1 of the diff hunks associated with a
> > +patch, with whitespace and line numbers ignored.  As such, it's "reasonably
> > +stable", but at the same time also reasonably unique, i.e., two patches that
> > +have the same "patch ID" are almost guaranteed to be the same thing.
> 
> Perhaps "nothing but" can go by now?

Sure. I was also wondering whether we should document the fact that we
are using SHA-1 internally, or just say "hashes".
In the end people can always read the source to find out so ...

> >  
> >  IOW, you can use this thing to look for likely duplicate commits.
> >  
> > @@ -27,6 +27,19 @@ This can be used to make a mapping from patch ID to commit ID.
> >  
> >  OPTIONS
> >  -------
> > +
> > +--stable::
> > +	Use a symmetrical sum of hashes as the patch ID.
> > +	With this option, reordering file diffs that make up a patch or
> > +	splitting a diff up to multiple diffs that touch the same path
> > +	does not affect the ID.
> > +	This is the default.
> > +
> > +--unstable::
> > +	Use a non-symmetrical sum of hashes, such that reordering
> > +	or splitting the patch does affect the ID.
> > +	This was the default value for git 1.9 and older.
> 
> I am not sure if swapping the default in this series is a wise
> decision.  We typically introduce a new shiny toy to play with in a
> release and then later when the shiny toy proves to be useful, start
> to think about changing the default, but not before.

Well I would claim that this is really a bugfix: --unstable
is here really just in case someone relies on the broken
behaviour.

The hash used is mostly an internal implementation detail, isn't it?
One of my motivators is to upstream
	[PATCH] diff: add a config option to control orderfile
so that I can use ordered diffs more easily, sending them to people and
not worrying about broken patch IDs.
If people have to remember to use --stable, that's of course harder.

If we keep+--unstable as default, I'd say we'll need a configuration
option to enable --stable: I can at least tell people to enable that.
We'll also need some way for people to discover what the default was.

As it is - it's simple: if --stable is there, it's the default.

> >  <patch>::
> >  	The diff to create the ID of.
