From: Jan Weitzel <J.Weitzel@phytec.de>
Subject: Re: git fetch refs and tags
Date: Tue, 23 Apr 2013 13:45:52 +0200
Organization: PHYTEC Messtechnik GmbH
Message-ID: <1366717552.2899.17.camel@lws-weitzel>
References: <1366714421.2899.10.camel@lws-weitzel>
	 <CALKQrge2vHqA1HitpdJKYQu0KY5+XkFdrN_Gg254gW_ih57o=Q@mail.gmail.com>
Reply-To: J.Weitzel@phytec.de
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sitaramc@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Apr 23 13:46:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUbfb-0008T7-4L
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 13:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755714Ab3DWLpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 07:45:55 -0400
Received: from mail.visioncatalog.de ([217.6.246.34]:52642 "EHLO
	root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755703Ab3DWLpy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 07:45:54 -0400
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
	by root.phytec.de (Postfix) with ESMTP id C1C49BF0EC;
	Tue, 23 Apr 2013 13:44:20 +0200 (CEST)
Received: from [172.16.10.7] ([127.0.0.1])
          by idefix.phytec.de (Lotus Domino Release 8.5.3FP3)
          with ESMTP id 2013042313452677-164994 ;
          Tue, 23 Apr 2013 13:45:26 +0200 
In-Reply-To: <CALKQrge2vHqA1HitpdJKYQu0KY5+XkFdrN_Gg254gW_ih57o=Q@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 8.5.3FP3|November 15, 2012) at
 23.04.2013 13:45:26,
	Serialize by Router on Idefix/Phytec(Release 8.5.3FP3|November 15, 2012) at
 23.04.2013 13:45:27,
	Serialize complete at 23.04.2013 13:45:27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222145>

Am Dienstag, den 23.04.2013, 13:25 +0200 schrieb Johan Herland:
> On Tue, Apr 23, 2013 at 12:53 PM, Jan Weitzel <J.Weitzel@phytec.de> wrote:
> > Hello,
> > I have the following problem: I have 2 bare git repositories one has
> > several branches and tags.
> > If I try this in the second repository:
> > git fetch -f ../main.git refs/heads/master:refs/heads/master
> > I'm getting also tags from other branches, if I have an old object from
> > one of the other branches.
> > I would expect to have only tags pointing to master ref. (Although the
> > man pages points to the behaviour regarding dangling objects). Is there
> > a way to avoid this? I only find --no-tags which results in having no
> > tags at all. Or need I git purge to remove the old objects first?
> > My goal is to fetch only specific branches and the related tags.
> 
> AFAIK, Git should only auto-follow tags that are reachable from the
> branches you fetch (in this case master). Are you saying that you get
> tags pointing to other history that is NOT reachable from the master
> branch? (i.e. are you getting tags for which "git merge-base $tag
> master" is not equal to "git rev-parse $tag")?
> 
exactly. I reproduced it by coping a object from an other branch to the
locale repository. This results in fetching the not reachable tags.

> Re-reading the man page, I do see the following:
> 
> "if the repository has objects that are pointed by remote tags that it
> does not yet have, then fetch those missing tags. If the other end has
> tags that point at branches you are not interested in, you will not
> get them."
> 
> This can be interpreted as saying that even unreachable objects in
> your local repo that are pointed to by some remote tag will cause that
> tag to be fetched, and in effect resuscitate the
> previously-unreachable object. If this is indeed how it works, I would
> be tempted to label this a bug in the auto-following behavior, as it's
> probably not what most people would expect. In that case, yes, you
Yes my first understanding of auto-following behaviour was wrong ;)
> should be able to get your desired behavior by first purging all
> unreachable objects. Something like "git gc --prune=now" should do the
> job.
Because I run this by scripts is there a way without porcelain commands?
I saw even git prune is one.
> 
> Hope this helps,
Thanks
Jan
> 
> ...Johan
> 
