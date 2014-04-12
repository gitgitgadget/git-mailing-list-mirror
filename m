From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 6/9] branch: display publish branch
Date: Sat, 12 Apr 2014 09:34:49 -0500
Message-ID: <53494f09531cc_c9914c7308a@nysa.notmuch>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
 <1397156686-31349-7-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mSfsUrSMPMmZ+PNtZ2WBUqN4Swk_e6S1fMGuUoocJSEg@mail.gmail.com>
 <53471d0b4c8dc_d696b12f08c@nysa.notmuch>
 <20140411111750.GA28858@sigill.intra.peff.net>
 <20140411134801.GB5871@nysa.casa.local>
 <20140412112344.GA14820@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>,
	John Szakmeister <john@szakmeister.net>
To: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 16:45:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYzAy-0004AL-Go
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 16:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbaDLOow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 10:44:52 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:43308 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbaDLOov (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 10:44:51 -0400
Received: by mail-ob0-f177.google.com with SMTP id wo20so7125426obc.36
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 07:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=VMtOQrCWuHydy5ffSozbnFjkwV1SVgt3pdInGiH0lrk=;
        b=VM3FAp/JtclBHPeTqdc857YWrSey0zwG4myMmbQzPUU1aUmqT3168f+WPCbn1+qjWG
         HLlYkRl07xUy8OBo4niM4US9hs/nmyyi9jxOi1dE20JExM6seJ+op9SxiyVAzBErxwqm
         PqWphtXdYf+kEIwyFm81hq8nYexIqXkr0s2mA+T6htJAA0Zz3OAOAfVn1wpbVEHWAWMt
         7NJ8o6y727Rk9ruUrNWe8Nevg/a+yoH977ClK7iZk/5Ai98Fw0dK6X965d5bOWzozclF
         slWuzlg8I9+OiIYC+vz2V4EfB3eJ+c+R9Zdq3M+rxhp8BVeDYHFLD62PT1DnB5KU6Vac
         0wYg==
X-Received: by 10.60.133.17 with SMTP id oy17mr2246416oeb.51.1397313891028;
        Sat, 12 Apr 2014 07:44:51 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id oz15sm45713196oeb.13.2014.04.12.07.44.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Apr 2014 07:44:49 -0700 (PDT)
In-Reply-To: <20140412112344.GA14820@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246173>

Jeff King wrote:
> On Fri, Apr 11, 2014 at 08:48:01AM -0500, Felipe Contreras wrote:
> 
> > I think of @{publish} as "the branch the user has configured to push
> > to"; it overrides all other configurations (push.default and push
> > refspecs). I wouldn't mind having a @{push} *in addition* to @{publish}
> > that would have the behavior you mention, but for @{publish} I'm pretty
> > certain the behavior I want is that it maps *directly* to what the user
> > has configured.
> 
> I guess I don't understand why we need "branch.*.push" when we already
> have push refspecs that do the same thing (and are more powerful, as
> they can glob).

Really? I think it's pretty simple.

I have a configuration similar to the following

  [remote "gh"]
  	url = git@github.com:felipec/git.git
  [branch "master"]
  	pushremote = gh
  	push = refs/heads/master
  [branch "fc/master"]
  	pushremote = gh
  	push = refs/heads/fc/master
  [branch "up/publish"]
  	pushremote = gh
  	push = refs/heads/fc/publish

Now, if I didn't, I could create it easily with something like this:

  % git push -p gh master
  % git push -p gh fc/master
  % git push -p gh up/publish:fc/publish

How would that translate to push refspecs?

  [remote "gh"]
  	url = git@github.com:felipec/git.git
  	push = refs/heads/master:refs/heads/master
  	push = refs/heads/fc/master:refs/heads/fc/master
  	push = refs/heads/up/master:refs/heads/fc/publish
  [branch "master"]
  	pushremote = gh
  [branch "fc/master"]
  	pushremote = gh
  [branch "up/publish"]
  	pushremote = gh

So in theory it could be possible to make it work without branch.x.push.

If I run `git branch -v`, it would show the publish branch correctly.

  master cee0c27 [origin/master, gh/master] Git 1.9.1

However, if I have a configuration like this:

  [remote "gh"]
  	url = git@github.com:felipec/git.git
  	push = refs/heads/*:refs/heads/*

Git would still show the same publish branch, even though the user never
explicitely told it do to so (e.g. with `git push -p`). To me this is not OK;
if I haven't specifically set a publish branch, it shouldn't be shown.

And then, what happens when I do:

  % git branch --unset-upstream up/publish

Or:

  % git branch -d up/publish

Should Git remove the appropriate push refspec? What if that refspec was
manually added by the user before the concept of the publish branch even
existed?

To me using the refspec just adds more complications, and it's not symetric
with @{upstream}. With branch.x.push, the symetry is very much there; the code
is similar to @{upstream}, the configuration as well, and what the user expects
too; it's much simpler. Also, the user can clearly see what are his manually
configured refspecs, as opposed to the ones added by `git push -p`.

It's just neat.

-- 
Felipe Contreras
