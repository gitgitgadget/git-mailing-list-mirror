From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Error using git-remote-hg
Date: Tue, 13 May 2014 15:24:51 -0500
Message-ID: <53727f93801d_7146f9d300dd@nysa.notmuch>
References: <ACDAFE7C-6615-4E44-AE6C-C12CD001EF4F@lltech.fr>
 <53711AA5.4040001@web.de>
 <53712309a8d5e_2ea6e1f2f888@nysa.notmuch>
 <23A431B4-FCD5-4E8A-A854-30ED30A09D5F@lltech.fr>
 <537233CC.3050904@web.de>
 <xmqq61l9powd.fsf@gitster.dls.corp.google.com>
 <20140513184800.GF9051@wst420>
 <53726e0355875_4aa4b312f892@nysa.notmuch>
 <20140513193911.GG9051@wst420>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Charles Brossollet <chbrosso@lltech.fr>, git@vger.kernel.org
To: William Giokas <1007380@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 22:35:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJQX-0004zu-Ck
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020AbaEMUfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:35:50 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:51745 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbaEMUfs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:35:48 -0400
Received: by mail-ob0-f176.google.com with SMTP id wo20so1049595obc.21
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=sRyZ8J1vYYdklTmHpokHZwwO6yu5mmzZfNsbw9po+LA=;
        b=j7+mp1x6p2WXGQUu0fYpQCI4LPZj4UdS5JmJ+Myh1/lZAqjHnwS6MUZI6J7WYtwo6o
         0ZCGHEISwusxHj77/zIoQGvwvd6m0teIibcMPOIRcgvX/qsWUHvHhMvRuVOEq0A4WLRW
         8U5LmJS/gXP9d8G/Jm55kuF3gC7FvXLXnb+ilZE99vhLomTIyXEUebtM7Y51u9x0ySxs
         pV5leeIXla6TvOIsUZJtgItlNa5MMwtOg+3mEbx+/ZQHPJHX8JpbygblVvWQ82UT55ZM
         15vtQv+6t6xISH+33c7F+pEQnsLG60WtfLF1FpdJrUsi2EFwDY0Ig0lmg7dfzdcANuyU
         hGiA==
X-Received: by 10.182.126.137 with SMTP id my9mr14953858obb.61.1400013347652;
        Tue, 13 May 2014 13:35:47 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id zv18sm27830585obb.27.2014.05.13.13.35.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 May 2014 13:35:47 -0700 (PDT)
In-Reply-To: <20140513193911.GG9051@wst420>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248830>

William Giokas wrote:
> On Tue, May 13, 2014 at 02:09:55PM -0500, Felipe Contreras wrote:
> > William Giokas wrote:
> > > On Tue, May 13, 2014 at 10:30:26AM -0700, Junio C Hamano wrote:
> > 
> > > >     Why do we "import changegroup" unconditionally, even though it
> > > >     is only used in the new codepath meant only for version 3.0 or
> > > >     higher, not inside the "if" block that decides if we need that
> > > >     module? 
> > 
> > > changegroup is prefectly /okay/ to import unconditionally, though as you
> > > say it will never be used.
> > 
> > As you say, it's perfectly OK.
> 
> But wrong. Yes, it works, but it's not how it should be done when we
> have a code review such as this. It should simply not be done and makes
> no sense to do with an 'if <check ver>; else' kind of thing later in the
> application.

That's exactly how it should be done. Maybe this visualization helps

  from mercurial import hg, ui, bookmarks, ...        # for hg >= 3.0
  from mercurial import node, error, extensions, ...  # for hg >= 3.0
  from mercurial import changegroup                   # for hg >= 3.0

  if check_version(3, 0):
      cg = changegroup.getbundle(repo, 'push', ...    # for hg >= 3.0
  else:
      cg = repo.getbundle('push', heads=list(p_revs)  # for hg < 3.0

Eventually the code would become:

  from mercurial import hg, ui, bookmarks, ...        # for hg >= 3.0
  from mercurial import node, error, extensions, ...  # for hg >= 3.0
  from mercurial import changegroup                   # for hg >= 3.0

  cg = changegroup.getbundle(repo, 'push', ...        # for hg >= 3.0

The fact that at some point 'import changegroup' was not needed is
irrelevant.

Primarily we want to support the current version of Mercurial.
Secondarily we want to support older versions. That's why we add the
repo.getbundle() code (ass an addendum to the core part).

> > > We can also be even more explicit with what we import by doing something
> > > like::
> > > 
> > >   try:
> > >       from mercurial.changegroup import getbundle
> > > 
> > >   except ImportError:
> > >       def getbundle(__empty__, **kwargs):
> > >           return repo.getbundle(**kwargs)
> > 
> > We could try that, but that would assume we want to maintain getbundle()
> > for the long run, and I personally don't want to do that. I would rather
> > contact the Mercurial developers about ways in which the push() method
> > can be improved so we don't need to have our own version. Hopefully
> > after it's improved we wouldn't have to call getbundle().
> 
> Assuming that mercurial <3.0 will not change, then this should never
> need to change.

But it should. Otherwise the code will keep having more and more hacks
and it will become less and less maintainable.

That's why we don't have code for hg 1.0; because it would require too
many hacks, and nobody cared anyway.

Just like nobody cares about hg 1.0, eventually nobody will care about
hg 2.0.

> Changes in 'getbundle' upstream would require changes either way.

I doubt we will see any more changes in getbundle, at least not until
4.0, and hopefully by then we wouldn't be using it anyway. I am willing
 to bet we won't see those changes.

> > Moreover, eventually there will be a Mercurial 4.0, even 5.0, and at
> > some point we would want to remove the hacks for older versions. When we
> > do so we would want the import to remain unconditionally, and remove the
> > 'check_version(3, 0)' which is already helping to explain what the code
> > is for without the need of comments.
> 
> The same exact thing can be done with this. In fact, it would probably
> allow us to have better future-proofing with regards to new versions of
> mercurial, there would just be different try:except statements at the
> beginning.

No, your code doesn't show that this is for versiosn <= 3.0,
'check_version(3, 0)' does.

Plus, when we remove this code my version makes it straight forward:

-    if check_version(3, 0):
-        cg = changegroup.getbundle(repo, 'push', ...
-    else:
-        cg = repo.getbundle('push', heads=list(p_revs), ...
+    cg = changegroup.getbundle(repo, 'push', ...

Not so with your code:

-
-try:
-    from mercurial.changegroup import getbundle
-
-except ImportError:
-    def getbundle(__empty__, **kwargs):
-        return repo.getbundle(**kwargs)
+from mercurial import getbundle
 
 import re
 import sys
@@ -1036,7 +1030,7 @@ def push_unsafe(repo, remote, ...
     if not checkheads(repo, remote, p_revs):
         return None
 
-    cg = getbundle(repo, 'push', heads=list(p_revs), ...
+    cg = changegroup.getbundle(repo, 'push', ...


> > > I was really sad to see that, and didn't have time to really look at it
> > > because of work and other projects, but I hope this presents a better
> > > solution than the current patch.
> > 
> > Either way Junio doesn't maintain this code, I do. And it's not
> > maintained in git.git, git's maintained out-of-tree (thanks to Junio's
> > decisions).
> 
> I still see it in git.git, and I will contribute this upstream for as
> long as it is in the tree.

And what happens when it's eventually removed?

> If you want to use the patch that I sent to this list, feel free.

I don't believe this is the way to go, so I won't.

-- 
Felipe Contreras
