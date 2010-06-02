From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 5/8] revert: allow cherry-picking more than one commit
Date: Wed, 2 Jun 2010 07:57:01 +0200
Message-ID: <201006020757.01726.chriscool@tuxfamily.org>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org> <20100531194240.28729.9164.chriscool@tuxfamily.org> <20100601090317.GB32320@progeny.tock>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 07:57:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJgx4-0006DE-RY
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 07:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307Ab0FBF5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 01:57:14 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:46035 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828Ab0FBF5N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 01:57:13 -0400
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E795181806A;
	Wed,  2 Jun 2010 07:57:02 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-20-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <20100601090317.GB32320@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148203>

On Tuesday 01 June 2010 11:03:17 Jonathan Nieder wrote:
> Christian Couder wrote:
> > --- a/builtin/revert.c
> > +++ b/builtin/revert.c
> > @@ -520,8 +516,33 @@ static int do_pick_commit()
> >  	return 0;
> >  }
> >
> > +static void prepare_revs(struct rev_info *revs)
> > +{
> > +	int argc = 0;
> > +	int i;
> > +	const char **argv = xmalloc((commit_argc + 4) * sizeof(*argv));
> > +
> > +	argv[argc++] = NULL;
> > +	argv[argc++] = "--no-walk";
> > +	if (action != REVERT)
> > +		argv[argc++] = "--reverse";
> > +	for (i = 0; i < commit_argc; i++)
> > +		argv[argc++] = commit_argv[i];
> > +	argv[argc++] = NULL;
> > +
> > +	init_revisions(revs, NULL);
> > +	setup_revisions(argc - 1, argv, revs, NULL);
> > +	if (prepare_revision_walk(revs))
> > +		die("revision walk setup failed");
> > +
> > +	if (!revs->commits)
> > +		die("empty commit set passed");
> > +}
> 
> Tiny one-time leak.  Maybe avoiding it will make debugging tools
> happier.

I added a "free(argv)".

Thanks,
Christian.
