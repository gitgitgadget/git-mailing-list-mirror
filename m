From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Error using git-remote-hg
Date: Tue, 13 May 2014 17:16:10 -0500
Message-ID: <537299aa9c153_34aa9e53046c@nysa.notmuch>
References: <ACDAFE7C-6615-4E44-AE6C-C12CD001EF4F@lltech.fr>
 <53711AA5.4040001@web.de>
 <53712309a8d5e_2ea6e1f2f888@nysa.notmuch>
 <23A431B4-FCD5-4E8A-A854-30ED30A09D5F@lltech.fr>
 <537233CC.3050904@web.de>
 <xmqq61l9powd.fsf@gitster.dls.corp.google.com>
 <20140513184800.GF9051@wst420>
 <53726e0355875_4aa4b312f892@nysa.notmuch>
 <20140513193911.GG9051@wst420>
 <53727f93801d_7146f9d300dd@nysa.notmuch>
 <20140513210158.GH9051@wst420>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Charles Brossollet <chbrosso@lltech.fr>, git@vger.kernel.org
To: William Giokas <1007380@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 00:27:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkLAQ-0002DZ-2i
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 00:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbaEMW1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 18:27:13 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:42473 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174AbaEMW1J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 18:27:09 -0400
Received: by mail-oa0-f49.google.com with SMTP id eb12so1205134oac.22
        for <git@vger.kernel.org>; Tue, 13 May 2014 15:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=wNtGuOentc4+/uRx5r1+CU1KhRZ5HE7Tej/P+C8+fks=;
        b=lwme35gntdSRcUIoR7q3WbY7lQqq16oaqJDl8wzlVrkVC5304Wct6jUzVNpqkXmkkL
         Re4vhee7gWtRt/+lto3OXG3YPVBxfx4Hr4xUNqgGbbmKGLbwLp96tOBkn/Xt0aL7+nrE
         LiFqnzUi0BlE805gf6MhVDjkH6K/lQGDRoxX3dRDHnUTQeDTHKP35OndE6XIfkQwHL67
         cFKNT0kbNayKFx11gab1vEhGjLA7vA3GHajtLgoVOxb0OB61nAREE1NNsksfMEtP2frc
         LKgxkvugdTAbYuC1gkZ+A5OhD8zF9wzaVPhl9d5luudKKD++Stz3XV48H2iANw3RulPp
         Ov6Q==
X-Received: by 10.60.17.132 with SMTP id o4mr45337259oed.34.1400020028046;
        Tue, 13 May 2014 15:27:08 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id js4sm64005512oeb.3.2014.05.13.15.27.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 May 2014 15:27:07 -0700 (PDT)
In-Reply-To: <20140513210158.GH9051@wst420>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248874>

William Giokas wrote:
> On Tue, May 13, 2014 at 03:24:51PM -0500, Felipe Contreras wrote:
> > William Giokas wrote:
> > > On Tue, May 13, 2014 at 02:09:55PM -0500, Felipe Contreras wrote:
> > > > As you say, it's perfectly OK.
> > > 
> > > But wrong. Yes, it works, but it's not how it should be done when we
> > > have a code review such as this. It should simply not be done and makes
> > > no sense to do with an 'if <check ver>; else' kind of thing later in the
> > > application.
> > 
> > That's exactly how it should be done. Maybe this visualization helps
> > 
> >   from mercurial import hg, ui, bookmarks, ...        # for hg >= 3.0
> >   from mercurial import node, error, extensions, ...  # for hg >= 3.0
> >   from mercurial import changegroup                   # for hg >= 3.0
> > 
> >   if check_version(3, 0):
> >       cg = changegroup.getbundle(repo, 'push', ...    # for hg >= 3.0
> >   else:
> >       cg = repo.getbundle('push', heads=list(p_revs)  # for hg < 3.0
> > 
> > Eventually the code would become:
> > 
> >   from mercurial import hg, ui, bookmarks, ...        # for hg >= 3.0
> >   from mercurial import node, error, extensions, ...  # for hg >= 3.0
> >   from mercurial import changegroup                   # for hg >= 3.0
> > 
> >   cg = changegroup.getbundle(repo, 'push', ...        # for hg >= 3.0
> 
> No, the way that it's going to change is that the import statements will
> change, not the 'if:else' things. It would work exactly the same with
> this, however the things that are used only in a specific version for
> this are stated up front. Maybe this visualization helps for what I have
> set up::
> 
>   from mercurial import ...                        # for all hg
>   
>   try:
>       from mercurial.changegroup import getbundle  # for hg with
>                                                    # changegroup.getbundle,
>                                                    # regardless of version

This would make sense if in our eyse all versions of Mercurial were
the same, and we would want the code to work optimally for all of them
forever.

But that's not the case. The current version of Mercurial is more
important, the fact that we have one unnecessary import in older
versions is not of consequence because eventually the won't be
supported.

> When we eventually remove support for mercurial that uses
> repo.getbundle:
> 
>   from mercurial import changegroup, ...           # for all hg
>   ...
>   cg = changegroup.getbundle(...)

And the diff from my version to the final version is smaller.

> > The fact that at some point 'import changegroup' was not needed is
> > irrelevant.
> > 
> > Primarily we want to support the current version of Mercurial.
> > Secondarily we want to support older versions. That's why we add the
> > repo.getbundle() code (as an addendum to the core part).
> 
> So I use arch myself, and I am very used to the 'rolling release' model
> that it employs. I do agree that we should concentrate support for the
> latest release, but for a project like git the other versions of hg
> cannot be ignored, as this project is used on so many different systems.

Older versions are not ignored, they are supported. It's just not worth
tainting the code to avoid an 'import'.

> > > > We could try that, but that would assume we want to maintain getbundle()
> > > > for the long run, and I personally don't want to do that. I would rather
> > > > contact the Mercurial developers about ways in which the push() method
> > > > can be improved so we don't need to have our own version. Hopefully
> > > > after it's improved we wouldn't have to call getbundle().
> > > 
> > > Assuming that mercurial <3.0 will not change, then this should never
> > > need to change.
> > 
> > But it should. Otherwise the code will keep having more and more hacks
> > and it will become less and less maintainable.
> > 
> > That's why we don't have code for hg 1.0; because it would require too
> > many hacks, and nobody cared anyway.
> > 
> > Just like nobody cares about hg 1.0, eventually nobody will care about
> > hg 2.0.
> 
> Yes, it can change. Eventually hg 2.0 will be defunct and no one will
> use it, but what happens if they go back to the old 2.0 style for
> getbundle in hg 4.0?

Then you can tell me I was wrong and we go back to your version. But
that's not going to happen.

And even if it does, we still would need to fix the code.

> We're already good. What if they switch it back in
> 4.1? This works for all of those conditions, and doesn't do anything if
> we're able to get mercurial.changegroup.getbundle.

Every method can change, we can't have wrappers for all of them.

In reality few of them do. And we deal with them on a case by case
basis.

There's no need to worry about the unlikely, especially since there
isn't much difference between the likely and unlikely; we are still
going to need to fix the code.
 
> > > Changes in 'getbundle' upstream would require changes either way.
> > 
> > I doubt we will see any more changes in getbundle, at least not until
> > 4.0, and hopefully by then we wouldn't be using it anyway. I am willing
> >  to bet we won't see those changes.
> > 
> > > > Moreover, eventually there will be a Mercurial 4.0, even 5.0, and at
> > > > some point we would want to remove the hacks for older versions. When we
> > > > do so we would want the import to remain unconditionally, and remove the
> > > > 'check_version(3, 0)' which is already helping to explain what the code
> > > > is for without the need of comments.
> > > 
> > > The same exact thing can be done with this. In fact, it would probably
> > > allow us to have better future-proofing with regards to new versions of
> > > mercurial, there would just be different try:except statements at the
> > > beginning.
> > 
> > No, your code doesn't show that this is for versiosn <= 3.0,
> > 'check_version(3, 0)' does.
> 
> That's the whole point. This did not change the instant 3.0 was
> released.

So you want to add support for 2.9..3.0? Sorry, I don't think it's worth
making the code less readable for that.

> > Plus, when we remove this code my version makes it straight forward:
> > 
> > -    if check_version(3, 0):
> > -        cg = changegroup.getbundle(repo, 'push', ...
> > -    else:
> > -        cg = repo.getbundle('push', heads=list(p_revs), ...
> > +    cg = changegroup.getbundle(repo, 'push', ...
> 
> Because it is not there for things that are <3.0, it is there for
> systems that are unable to import mercurial.changegroup.getbundle.

No, it's there for <3.0. When we are in 5.0 and read this code:

  try:
      from mercurial.changegroup import getbundle

  except ImportError:
      def getbundle(__empty__, **kwargs):
	  return repo.getbundle(**kwargs)

We wouls be wondering: what is that for? Well, for versions of Mercurial
that don't have changegroup.getbundle. But that doesn't answer anything
useful, we we ould have hunt the getbundle() was introduced in to
Mercurial. To avoid at we would have to do:

  # hack for versions of Mercurial <3.0
  try:
      from mercurial.changegroup import getbundle

  except ImportError:
      def getbundle(__empty__, **kwargs):
	  return repo.getbundle(**kwargs)

At that point it would be better to document this in the code:

  if check_version(3, 0):
      from mercurial.changegroup import getbundle
  else:
      def getbundle(__empty__, **kwargs):
	  return repo.getbundle(**kwargs)

Which is much easier to understand. But still, we would be giving too
much importance to 2.x.

> There is no reason to apply a version number to this, except for the
> fact that hg happened to change in version 3.0.

Yes there is: self-documenting code.

Either way, if you want to keep discussing about this, use the git-fc
mailing list, this is not the place.

-- 
Felipe Contreras
