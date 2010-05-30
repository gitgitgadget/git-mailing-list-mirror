From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH 3/4] revert: allow cherry-picking a range of commits
Date: Sun, 30 May 2010 08:45:52 +0200
Message-ID: <201005300845.52141.chriscool@tuxfamily.org>
References: <20100529043738.569.85482.chriscool@tuxfamily.org> <20100529044044.569.7874.chriscool@tuxfamily.org> <alpine.DEB.1.00.1005291743300.1638@bonsai2>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 30 08:55:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIcQx-0001SG-TP
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 08:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333Ab0E3GqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 May 2010 02:46:04 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:57445 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120Ab0E3GqB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 02:46:01 -0400
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id EA901818112;
	Sun, 30 May 2010 08:45:53 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-20-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.1005291743300.1638@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147986>

On Saturday 29 May 2010 17:47:10 Johannes Schindelin wrote:
Hi Dscho,

> Hi,
> 
> On Sat, 29 May 2010, Christian Couder wrote:
> > diff --git a/builtin/revert.c b/builtin/revert.c
> > index 70372dc..c281a80 100644
> > --- a/builtin/revert.c
> > +++ b/builtin/revert.c
> > @@ -545,6 +542,40 @@ static int revert_or_cherry_pick(int argc, const
> > char **argv) if (read_cache() < 0)
> >  		die("git %s: failed to read the index", me);
> >
> > +	dotdot = strstr(commit_name, "..");
> > +	if (dotdot) {
> > +		struct rev_info revs;
> > +		const char *argv[4];
> > +		int argc = 0;
> > +
> > +		argv[argc++] = NULL;
> > +		if (action != REVERT)
> > +			argv[argc++] = "--reverse";
> > +		argv[argc++] = commit_name;
> > +		argv[argc++] = NULL;
> 
> Maybe "--no-merges"?

I will have a look at it. Thanks!
 
> > +		init_revisions(&revs, NULL);
> > +		setup_revisions(argc - 1, argv, &revs, NULL);
> > +		if (prepare_revision_walk(&revs))
> > +			die("revision walk setup failed");
> > +
> > +		if (!revs.commits)
> > +			die("empty range passed");
> > +
> > +		while ( (commit = get_revision(&revs)) ) {
> 
> The style more in linet with the rest of the source code would be:
> 
> 		while ((commit = get_revision(&revs))) {

Ok.

> The rest of the patch series looks very, very good to me. I totally agree
> that we do not have to implement the --abort and --continue for now, as
> well as the HEAD-detaching business we're used to from rebase and am.

Thanks for the kind words,
Christian.
