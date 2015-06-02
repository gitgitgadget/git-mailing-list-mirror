From: Zenaan Harkness <zen@freedbms.net>
Subject: git branch <refspec>
Date: Tue, 2 Jun 2015 19:45:47 +1000
Message-ID: <CAOsGNSTtWnawxmpL7SByUBZ-XUNdDd5nKNuudGQi-S3BjCHcdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 11:46:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzilf-0007at-IM
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 11:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbbFBJpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 05:45:51 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34655 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755306AbbFBJps (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 05:45:48 -0400
Received: by oifu123 with SMTP id u123so121477469oif.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 02:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=eaz3J5Ltf7LIxlCTA67UNaCJBsDoOIeVuOc2L97SNRA=;
        b=ayDJPJEzYXAbDQ8jExvx9Wxmjv/A5u3kNB/V1TGkMbDbPKsZTvj1p9P3hjQY2xhgdm
         pi04pDpcoaMWgc8/60YzNYLE45liyS6era6wgqikLUXKKaqqPu+E7Wupof80UTBjiKaU
         d0raK1uUy9k0C1aewuTjoabxW97eBE7xoHAJvTjRxD6kjLs72kgw38XrgIXY05tlurJJ
         TbEf96+qwf4ixxuP8ddMCFI4ZD083AeQYrQ9NPk7oBs9oPEC3FUwxTHt37OPnUKJ0x+1
         OBuzMye16fMJj5oKQ9vXukI3ocqjeJ+6AGoQBU6IglDF11WQQ2zRWYt/CAB10foeb9hL
         VFDg==
X-Received: by 10.182.24.5 with SMTP id q5mr21439902obf.8.1433238347612; Tue,
 02 Jun 2015 02:45:47 -0700 (PDT)
Received: by 10.182.121.198 with HTTP; Tue, 2 Jun 2015 02:45:47 -0700 (PDT)
X-Google-Sender-Auth: dxBKCa3SklkNmGz6GyVZYTsdWwQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270512>

<refspec> - git's guilty little secret. Let's milk the guilt.

git branch <refspec> ought work in a similar way to
git fetch <refspec>

One syntax to rule them all. Or something.

I just learned how git fetch uses refspecs and how this can just as
well apply to tags to create "remote tags" (refs/rtags/remote_name/*),
finally grokking the ridiculously simple yet powerful refspec concept
- it really is generic.

And now combining two remotes such as postgresql and postgresql-xc
(which share substantial code and parent commits), or (a bit out of
date now, but) the openmoko-kernel and linux mainline, becomes
simpler/saner when "inventing" rtags as explained here:
http://stackoverflow.com/questions/22108391/git-checkout-a-remote-tag

Some remotes in this example:
git://git.postgresql.org/git/postgresql.git
https://github.com/postgres-x2/postgres-x2.git
git://postgres-xc.git.sourceforge.net/gitroot/postgres-xc/postgres-xc

(rtags also makes it "reasonable" to store a few other related repos
in the one local mirror, even when they don't share a parent commit
(e.g. postgresql-docs, -website etc) - where git fetch gives a
friendly little warning to this effect "warning: no common commits".
Git does after all store content, so it's entirely natural for a
mirror junkie to store related content in one "mirror" repo - where
there are no common commits, git could auto parallelize fetch, as long
as this could be ensured to be not brittle.)

This indicates some "rtags" porcelain might be in order, especially to
complement --mirror (since 1.6.0) and soon "git checkout --to=path"
(2.5.0).
E.g. git remote rename OLDNAME NEWNAME does not auto rename
refs/rtags/OLDNAME/ - thankfully there's a little warning though. Also
rtags ought be recognized as tags when not fully qualified by path,
for git merge <commit-ish> etc - try local tags then also rtags when
searching for a tag name.

My main wishlist though is for some porcelain for "git branch
<refspec>" - to my current mind that would make a lot of sense - learn
one LHS:RHS concept, and apply it all over the place.

Thanks for listening,
Zenaan
