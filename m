From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Wed, 8 Jan 2014 01:17:49 +0100
Message-ID: <CALas-ihk6cVfosQ+Ov4QKUcfzvbXrYSonQvsN8Ay1+GTq_Ae-w@mail.gmail.com>
References: <20140105225733.GB4660@book.hvoigt.net> <20140105233943.GJ3156@odin.tremily.us>
 <20140106003314.GL3156@odin.tremily.us> <20140106011255.GM3156@odin.tremily.us>
 <20140106160202.GE27265@t2784.greatnet.de> <CALas-ijXQFcUHWk-jJrLifqsMHAKo6NNKya+jR6RJGGDXY76hg@mail.gmail.com>
 <CALas-ijNgaTQr77DZw3acypgaJHpDFVnGdq97ECM4zu+CPma0w@mail.gmail.com>
 <xmqqd2k3ejfr.fsf@gitster.dls.corp.google.com> <CALas-ihPmJSf9eH0P7Vf28pB4zN_dsa_2=fe+_moZgiP0C3UTA@mail.gmail.com>
 <20140107194503.GA26583@odin.tremily.us> <20140107223858.GB10782@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "W. Trevor King" <wking@tremily.us>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Jan 08 01:18:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0gqf-0005cl-Se
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 01:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787AbaAHASO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 19:18:14 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:49181 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377AbaAHASK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 19:18:10 -0500
Received: by mail-ob0-f175.google.com with SMTP id uz6so979782obc.20
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 16:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gRbEXjZQpC88oHOXJtF0/ez2CS9Lgt5PNg3ucFIVAFI=;
        b=GMIEPUZ0/FxYdfIcMexmU5UO9RJtljMTseN6ns9A/cdFDylw2GJVGaMRnmcIJ7FhU0
         zYaP0MkfEYpxOuYB87iN9In5JJoUegHEUk9ofjxTnb3a4H5QVIttez1ULvu23SJ9PuCQ
         tnBvhyXZv1JWCQ0v/BE/xXbD2fWPMY80lGe4DzfnyNG4K4J2UR/vFvFFtVPwotTdIne9
         +WGLJyKs6Zm9DrXnLC4toloxqwADz8C1p8e+SlqxQaIin+1Xr9jLvxOaPhCHQtvQaaIt
         hXob37Vn9mIT22RbEAXwYfUQjKi5sJQP+he6f3i8trDYrC8NSSb9RfiXhyOWpIK5veZu
         CO4g==
X-Received: by 10.60.124.138 with SMTP id mi10mr3394900oeb.57.1389140289214;
 Tue, 07 Jan 2014 16:18:09 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Tue, 7 Jan 2014 16:17:49 -0800 (PST)
In-Reply-To: <20140107223858.GB10782@sandbox-ub>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240189>

2014/1/7 Heiko Voigt <hvoigt@hvoigt.net>:
> One thing is missing though (and I think thats where Francesco came
> from): What if the developer already has a detached HEAD in the
> submodule?
>
> How does he attach to a branch? For this we need something similar to
> Francescos attach/detach or Trevors submodule checkout with Junio's checkout
> HEAD~0 from here[1].
>
> I am still undecided how we should call it. Because of my
>
> Idea for feature branch support
> - -------------------------------
>
> For the branch attaching feature I would also like something that can actually
> modify .git/config and for me more importantly .gitmodules.
>
> So e.g. if I want to work on a longer lived feature branch in a submodule which
> I need in a feature branch in the superproject I would do something like this:
>
> $ git submodule checkout --gitmodules --merge -b hv/my-cool-feature
>

I said in another thread I said to Junio am not pursuing
--attach|--detach anymore, but seeing that now everybody seem to be
excited about attached HEAD here we are...

Heiko, it's all day I think this syntax: it supports your above "git
submodule checkout" and more. Take attention at the feature branch
part!

NOTE: the following seems to me compatible with Trevor's
"submodule.<module>.branch means attached" patch.

git submodule head
================

The full syntax is the sum of the following ones:
git submodule head [-b <branch>] [--attach] [--] [<path>...]
git submodule head [-b <branch>] [--attach] --index [--] [<path>...]
git submodule head --reset [--] [<path>...]
git submodule head --reset --index [--] [<path>...]

(NOTE: --index should be the same as Heiko's above --gitmodules, it
means -> touch .gitmodules)

All the switches combinations follow, explained:

# Attach the submodule HEAD to <branch>.
# Also set ".git/config" 'submodule.<module>.branch' to <branch>
$ git submodule head -b <branch> --attach <module>

# Attach the submodule HEAD to 'submodule.<module>.branch'.
# If it does not exists defaults to <remote>/master
$ git submodule head --attach <module>

# Unset  ".git/config" 'submodule.<module>.branch'
# Also attach or detach the HEAD according to what is in ".gitmodules":
# with Trevor's patch 'submodule.<module>.branch' set means attached,
# unset means detached
$ git submodule head --reset <module>

NOTE: feature branch part!

# Set ".gitmodules" 'submodule.<module>.branch' to <branch>
$ git submodule head -b <branch> --attach --index <module>

# Unset ".gitmodules" 'submodule.<module>.branch'
$ git submodule head --reset --index <module>
---------------------------------------------------------------------

Also note that a --detach switch is not needed with Trevor's patch. To
resync to a dettached HEAD workflow, when 'submodule.<module>.branch'
is unset in ".gitmodule", --reset (without --index) should be enough.

What do you think? Better?

Thank you,
Francesco
