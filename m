From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] delete_ref(): fix uninitialized value, found by
 valgrind
Date: Wed, 4 Feb 2009 10:57:32 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902041056200.22763@intel-tinevez-2-302>
References: <cover.1233684745u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0902031912290.9822@pacific.mpi-cbg.de> <7v7i467ndd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 10:59:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUeX9-0008QP-Bl
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 10:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbZBDJ5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 04:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbZBDJ5h
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 04:57:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:44790 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751978AbZBDJ5g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 04:57:36 -0500
Received: (qmail invoked by alias); 04 Feb 2009 09:57:34 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp026) with SMTP; 04 Feb 2009 10:57:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/PE0tJRfLPn5pBr7bo0d3ekAXMEuywsMohD70/qR
	SEm3o36/ZpsxrX
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7v7i467ndd.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108329>

Hi,

On Tue, 3 Feb 2009, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > The variable 'err' was not necessarily initialized before it was used.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  refs.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/refs.c b/refs.c
> > index b13e01b..ded7ec4 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -929,7 +929,7 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
> >  int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
> >  {
> >  	struct ref_lock *lock;
> > -	int err, i = 0, ret = 0, flag = 0;
> > +	int err = 0, i = 0, ret = 0, flag = 0;
> >  	struct stat loginfo;
> >  	int log = !lstat(git_path("logs/%s", refname), &loginfo);
> 
> Sorry, I do not see it.
> 
> There are two uses of "err" in this function, both of which looks like:
> 
> 	if (err && errno != ENOENT)
> 
> but both of these places have
> 
> 	err = unlink(...)
> 
> immediately before it.

I should know better by now than to base my work on the tip of my Git 
tree.  Sure enough I have an attempt at resolving the "deleting a branch 
deletes its reflog, too" issue, which has that bug.

Sorry for the noise,
Dscho
