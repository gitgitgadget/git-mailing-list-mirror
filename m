From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH 3/4] revert: allow cherry-picking a range of commits
Date: Sun, 30 May 2010 08:41:15 +0200
Message-ID: <201005300841.15606.chriscool@tuxfamily.org>
References: <20100529043738.569.85482.chriscool@tuxfamily.org> <20100529044044.569.7874.chriscool@tuxfamily.org> <7vmxvi4tkq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 30 08:44:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIcFm-0007EN-Qp
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 08:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308Ab0E3Gl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 May 2010 02:41:26 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:47092 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248Ab0E3GlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 02:41:25 -0400
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E488D818054;
	Sun, 30 May 2010 08:41:17 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-20-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <7vmxvi4tkq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147985>

On Saturday 29 May 2010 17:27:01 Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > This makes it possible to pass a range of commits like A..B
> > to "git cherry-pick" and to "git revert" to process many
> > commits instead of just one.
> >
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
> > +
> > +		init_revisions(&revs, NULL);
> 
> The goal of the series is a worthy one, but I would imagine people would
> want to run these while on "maint":
> 
>     git cherry-pick master~2..master
>     git cherry-pick master^ master
> 
> or even
> 
>     git cherry-pick -2 master
> 
> How about enumerating the commits with an equivalent of
> 
>     git rev-list --no-walk "$@"
> 
> as an alternative implementation?

I agree that it would be nice, but I am not sure it would allow using "-2 
master" as arguments because "--no-walk" seems to take over "-2": 

$ git rev-list --no-walk -2 master
81fa024cd8e336ba257f13fe7724b95baacfa3ad
$

> The current behaviour would fall out just as a natural special case
> because
> 
>     git rev-list --no-walk $commit == $commit
> 
> Hmm?

Yes, I will provide an updated patch series using the equivalent of '--no-walk 
"$@"' but arguments like "-2 master" will not work.

Thanks,
Christian.


 
