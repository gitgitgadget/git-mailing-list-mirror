From: Joshua Shrader <jshrader83@gmail.com>
Subject: Re: Automating svn<->git gateway
Date: Mon, 11 Oct 2010 16:33:47 -0400
Message-ID: <AANLkTikp1e72RQs3QQTqyg2m4Vk6rjz=Sv33iHAxDKoP@mail.gmail.com>
References: <20101011193007.GA30870@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Oct 11 22:33:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5P4F-0000ei-Q2
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 22:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736Ab0JKUdt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 16:33:49 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61693 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315Ab0JKUdt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Oct 2010 16:33:49 -0400
Received: by gyg13 with SMTP id 13so935639gyg.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 13:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pIHrIVRwqwXPdePulFiOsRwSBFYPE8JTwveumjIUPSU=;
        b=AT1uKMXcBTmD/oB97TRe0GIt7bxkWbmosjjsm86olqf5LBcOACGg28GaHff+E2VWdP
         qj9BnRQNixv/gURwSV6DZ/uSYO+CCcaRbXesDC/1kFpVFyH+upwNPRS5H9lI8WMSOG9n
         5bQMm1/5UUd9efR6WeFb5VrnkRqPAmsDeBDQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kN+GKohmlmaYdan+z8//pza5LD2B8tCmjFpoJaM0HUehO0u+DbzXy1nJrKNUPpYo2v
         YarS36j/wOxuO7/KcLp3gwjvEvwz6CEMevBx7itTA5wNZBNvXvteIy1019Gb2beuvtks
         7JPtEIm0dPrnG4jVOEthQJBsUolUVE8ri0k/o=
Received: by 10.42.117.68 with SMTP id s4mr1830572icq.344.1286829227987; Mon,
 11 Oct 2010 13:33:47 -0700 (PDT)
Received: by 10.42.171.6 with HTTP; Mon, 11 Oct 2010 13:33:47 -0700 (PDT)
In-Reply-To: <20101011193007.GA30870@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158786>

Check out the article and third-to-last comment (as of today) at
http://blog.emmanuelbernard.com/2010/05/git-how-my-life-has-improved-si=
nce-last-month-when-i-used-svn/comment-page-1/#comment-2248

The comment (by Josh) is mine, and details how I've approached this
problem.  It's worked very well for us, and follows from a workflow
presented in Jon Loeliger's "Version Control with Git."  I haven't
messed with any hooks, but I'd imagine that wouldn't be too difficult.
 Right now, we keep a couple legacy maintenance SVN branches sync'd up
with their corresponding Git branches.  The one thing that we haven't
attempted (and don't plan on) is creating a new branch in Git that we
want to duplicate in SVN.  We're only syncing branches that existed in
SVN prior to our move to Git.  Any new branches are "Git-only."

On Mon, Oct 11, 2010 at 3:30 PM, Jan Hudec <bulb@ucw.cz> wrote:
> Hello Folks,
>
> I want to set up a gateway between subversion and git, which would ke=
ep the
> master synchonized with subversion trunk, both ways, and allow workin=
g with
> any additional branches independent of subversion. For users it shoul=
d behave
> as any other shared git repository accessed by push and pull. And it =
needs to
> be automatic.
>
> Did anybody try to set up something like this?
>
> Background:
>
> At $work, we are considering switch from subversion to git. However t=
o avoid
> big disruptions in the work, we need to do it gradually. So the idea =
is to
> switch to git one by one. The people who already switch need to be ab=
le to
> test the final workflow with git, while other people still commit to =
the
> subversion repository.
>
> This basically rules out everybody just using git-svn, because indivi=
dual
> conversions are incompatible (or is there some way to make them compa=
tible?),
> so the people couldn't easily share their working branches.
>
> That leaves me with creating one git-svn repository and having everyb=
ody
> clone from that. Keeping the repository up-to-date from subversion si=
de seems
> trivial (just 'git svn fetch' to it from subversion's post-commit hoo=
k).
>
> The trickier part is exporting changes pushed from the git side to
> subversion. My plan is to write a post-receive hook, that will
> 'git svn dcommit' to svn trunk.
>
> I suppose I will have to get the rewritten commit back from subversio=
n and
> merge it back to the master. I have not yet tested whether when dcomm=
iting
> a merge will properly keep the second parent in the rewritten commit =
or not.
> I can do extra merge if it does not at the cost of slightly uglier hi=
story.
>
> Thanks,
> Jan
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 Jan 'Bulb' Hudec <bulb@ucw.cz>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
