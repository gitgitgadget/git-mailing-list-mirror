From: Allan Kelly <allankelly@gmail.com>
Subject: Re: Newbie: Branch management
Date: Wed, 22 Jul 2009 22:45:51 +0100
Message-ID: <9586f3420907221445k2a8592d2ifacba57f3519f113@mail.gmail.com>
References: <446739.83600.qm@web53410.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Dr. Jennifer Nussbaum" <bg271828@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 23:46:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjdR-0004Xm-Tw
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 23:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbZGVVpz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 17:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753828AbZGVVpz
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 17:45:55 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:55681 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816AbZGVVpy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 17:45:54 -0400
Received: by fxm18 with SMTP id 18so475954fxm.37
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 14:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=L9HUu/FYx6TddLUWNHNM3RQ80IQZ9s+SB1ysv7oywcg=;
        b=AAjizHY/pZ7H16Ci2FQ/Ead7kB/KGn9kwT9pzpU2hbZG0ZyP4NPqA+7OX188MwFZD+
         muLnnxTg/3+JcbeQnws0q52cFo+hPyr4UMj2t19e3eE2vOysH9BFrV/u3CuDe0Mg4Z/5
         UjQ1Rpiq5tJTr0mxqO6cuN54j7GEaAoOxhhq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mzWeveOfzYylFTxxJ2H6+Iws+YjNaTWycV65xRrOSKnupetwTBbkwJQTwWPcOjgM0F
         KCnP/kJXflSdWd/bfrG50WEvXO9em6C8hERJro/0JU69V1AeX1FkRD92yDLHcrsmi4jy
         O+Uf5YeKzFcXBHKSl6rrA2iYRvSvSdc5alLFI=
Received: by 10.204.97.140 with SMTP id l12mr1286716bkn.133.1248299151831; 
	Wed, 22 Jul 2009 14:45:51 -0700 (PDT)
In-Reply-To: <446739.83600.qm@web53410.mail.re2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123785>

Hi Jennifer,

Like you I'm quite a new git user so I doubt I can entirely solve your
problem. However reading your mail, I recall my own initial confusion.
Like you, I maintain a main server and various work desktops.
Essentially I want my work status/environment replicated on-demand
around these desktops, with the server as the synch-point. Sounds like
you.

My observation is that the granularity of git which makes it very
malleable, is a problem when you want to do "broad brush" things like
this (and this is the typical Unix "feature-not-a-bug!"). So, I think
you need to write a few wee scripts as I have done.

I've set up very small scripts to execute a sequence of local and
ssh-based remote commands to sync things as I expect. For example,
'git add .;git commit -a -m "$MSG"; git push;' is fine but the files
in the origin server directory are out of sync for subsequent
processing & upload to the web site. This confused me a _lot_. So I
need 'ssh server_name "cd $SERVER_DIR && git checkout -f"'. Now the
server dir has the same content as my working dir.

I always call this script 'publish' and have an appropriate version in
the root of each of my working repos (the post-git compile/upload
stage differs). Then in vim I routinely execute ':./publish <project>
<commit msg> <upload Y/N>' from wherever I'm working.

If you want my (very simple!) 'publish' code then drop me a line. It
may give you a start.

HTH!

Cheers, al.

2009/7/22 Dr. Jennifer Nussbaum <bg271828@yahoo.com>:
>
> Hi,
>
> I hope its OK to ask basic questions on this list.
>
> Im a recent convert to git and having trouble with branches. I mostly=
 work on projects by myself, and what I want is that all branches of ev=
erything Im doing are in sync everywhere.
>
> I have a remote repository on my production server that serves as the=
 "main" repository. Then i work on projects on a number of different co=
mputers--my main home computer, my main work machine, several non-main =
computers :-) ...
>
> I've found it very confusing dealing with branches in this environmen=
t. If I have my "master" branch, and decide that i want a "refactoring-=
templates" branch, what Id *like* to do is create that branch, work on =
it, commit it, and when I say "git push" I want everything that's new o=
n that computer to be synced to the "main" repository. And then when I =
get to the next computer, I want to be able to say "git pull" and have =
everything on that computer by synced *from* the "main" repository.
>
> Instead I get confused by having to push branches separately, and it'=
s confusing that when I do a pull it doesnt necessarily get other branc=
hes unless I specify them directly, and so on.
>
> I've looked at the docs on branches and there's something i guess Im =
missing because this still seems very difficult. Can someone giving me =
advice on the best way to keep this kind of thing organized?
>
> Thanks!
>
> Jen
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
