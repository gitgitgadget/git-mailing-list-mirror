From: John Szakmeister <john@szakmeister.net>
Subject: Re: Nesting a submodule inside of another...
Date: Tue, 12 Jul 2011 21:21:04 -0400
Message-ID: <CAEBDL5U0F+QaqhW92i-s82-C9fj2knp6JPNtNvgdJY68kRYwWQ@mail.gmail.com>
References: <CAEBDL5XQDehUyqKoazxy+YVHh_2iAyt9aE-77H1jZg4oujMJgw@mail.gmail.com>
	<4E1C9F21.6070300@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git mailing list <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 13 03:23:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgoAn-0004Fe-5D
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 03:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008Ab1GMBVH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jul 2011 21:21:07 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:59910 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854Ab1GMBVF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2011 21:21:05 -0400
Received: by fxd18 with SMTP id 18so5453614fxd.11
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 18:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=l61iGYVVswfbTgzPjpjP5nQwWCM7QXr29bHlfhpNDhU=;
        b=AOJ8lq4agWQrbggzbbuHryW607cV95j8E16Pk68LXB8x+F9jBhToVuM3Sn0TDwc0no
         3ovJNlwqguqQ25vwKLB1sH+vJACJJwrS2sIMbVGcT059JekS6bdcWYVcCIDpr1Sknn0s
         TCrgWNq5uTIolX8P0ZXsB/yrAzHROIZIPgI/w=
Received: by 10.223.100.3 with SMTP id w3mr580861fan.146.1310520064038; Tue,
 12 Jul 2011 18:21:04 -0700 (PDT)
Received: by 10.223.30.68 with HTTP; Tue, 12 Jul 2011 18:21:04 -0700 (PDT)
In-Reply-To: <4E1C9F21.6070300@web.de>
X-Google-Sender-Auth: fN170EpePUA_JhK1IPcNSuOznW4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176989>

On Tue, Jul 12, 2011 at 3:23 PM, Jens Lehmann <Jens.Lehmann@web.de> wro=
te:
> Am 12.07.2011 14:01, schrieb John Szakmeister:
>> I've got a project where we have several frameworks involved, and
>> external modules we want to pull into the framework tree. =C2=A0We'd=
 like
>> to make use of submodules and have something like this:
>> =C2=A0 =C2=A0 top-level/ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<-=
- .gitmodules lives here
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 src/
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 framework1/ =C2=A0 <-- a submodule
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 module/ =C2=A0 =C2=A0 <-- =
another submodule
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 framework2/ =C2=A0 <-- a submodule
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 module2/ =C2=A0 =C2=A0<-- =
another submodule
>>
>> Currently, git fails trying to do this. =C2=A0It's not happy about
>> .gitmodules living at the top-level and nesting a submodule inside o=
f
>> another[1]. =C2=A0Is there a technical reason that this is not allow=
ed?
>
> Submodules are repositories of their own, so their work tree is outsi=
de
> the superproject's work tree. You're attempting to have a submodule o=
f
> the superproject inside another submodule of the superproject, but th=
is
> won't work because it does not live in the superproject's work tree (=
as
> that doesn't include submodules and their subdirectories).

I guess I still don't see how that's a problem.  It seems to me that
for the superproject the ignore rule needs to be:
  ignore framework1, except framework1/module

And then it could check its status.  Of course, framework1 would
somehow need to know to ignore it... and I'm not sure how that can be
communicated.

> To have nested submodules you must add "module" as a submodule of
> "framework1" and "module2" as a submodule of "framework2". Then git
> will handle them just fine (assuming you use the --recursive option f=
or
> "git submodule update" and friends). Of course that means that if you
> want to record a new commit of a sub-submodule in the superpoject, yo=
u'll
> have to commit that in it's parent submodule first and then can recor=
d
> that commit in the superproject. (But if "framework1" wouldn't depend=
 on
> a specific version of "module", there would be no reason to put it in=
side
> it in the first place, right?)

We can't do that.  The base framework should not include the module in
its repository.  We drop in different modules that get shared across
some projects, but not others.  They get mixed and matched.  This was
pretty straight-forward to do with Subversion.  Admittedly, I don't
like the layout of it... but unfortunately, I'm not really in control
of that either.

>> Limiting the traversal up the tree, etc.? =C2=A0I've worked around t=
he lack
>> of support to do this for now, but it would be really nice if we cou=
ld
>> do such a thing.
>
> I can't think of a sane way to make that work.

:-(

[snip]
> But at least since 1.6.2 git should issue a meaningful error message.
> With current master I get:
>
> $ git add sub/file
> fatal: Path 'sub/file' is in submodule 'sub'

Sorry, I wasn't trying to do a 'git add'.  I was trying to do a 'git
submodule add'.

> What version are you using?

I'm using 1.7.6rc3.  I updated to the latest trunk and still get the sa=
me error:

:: git submodule add $PWD/../c b/c
The following path is ignored by one of your .gitignore files:
b/c
Use -f if you really want to add it.

HTH.

-John
