From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: detached HEAD before root commit - possible?
Date: Sun, 23 Jun 2013 21:20:54 -0700
Message-ID: <CANiSa6jNjCDjj_ZD7COXyDUx9DxFpuVqT-Lm24KQVMDK=serpw@mail.gmail.com>
References: <20130623225505.GO20052@goldbirke>
	<20130623235432.GA3024@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 06:21:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqyHF-0002gG-C7
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 06:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864Ab3FXEU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 00:20:56 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:62820 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab3FXEUz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 00:20:55 -0400
Received: by mail-wg0-f48.google.com with SMTP id f11so7791994wgh.3
        for <git@vger.kernel.org>; Sun, 23 Jun 2013 21:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TzKMmULxW7FnLDJVvgUpVuvFSQr662BeUgadZQLbJkA=;
        b=i8dH7Z9mqI1Oe+jDedj688eR66RLqXGdruMpjHXtVi1Dop8Ze3GJijjSSdcAvQR0Ht
         ttRrsoE1HSbAtLFPfOsP+AZVPTZlOYtb/v78Q4R3CTj8ZusmA9cXrAMOc3clKH2Hvhwx
         BrU0hD2l0/TbEsLbDyhC38ZTCeHSUR1OteRIfvn31OAQyOQebDKnpK353cqczmnuARy3
         AylxX7flcYhCWFRyisJw6mg0vm3AqoKwJke2WF1cA5Sp75+lzGuZXgSMzM/8jbdo14Pm
         fOs60MPtl5NWYGk+l99m5nPcDJcS5gg6N/N9/acCII47LLpq9dWLRq7+7k8rwXO63B4z
         jZCA==
X-Received: by 10.194.237.38 with SMTP id uz6mr15429252wjc.73.1372047654151;
 Sun, 23 Jun 2013 21:20:54 -0700 (PDT)
Received: by 10.180.99.98 with HTTP; Sun, 23 Jun 2013 21:20:54 -0700 (PDT)
In-Reply-To: <20130623235432.GA3024@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228768>

On Sun, Jun 23, 2013 at 4:54 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> In other words, HEAD always either points to an unborn or existing
> branch or an existing commit.  It's not clear to me what it would
> mean to detach from an unborn branch.

I think it should mean that the next commit would be a root commit (of
course) and that HEAD would be detached and point to that commit. I
find that it helps to think of unborn branches (and "unborn" detached
HEAD) as pointing to some fixed root commit.

I wanted an "unborn detached HEAD" once when working on rebase.
Imagine what "git rebase --root" would do when run on a detached HEAD.
It is currently slightly broken because it forces the rebase (i.e.
creates a new root commit). This is inconsistent with e.g. "git rebase
HEAD~10", which won't do anything (assuming linear history). It would
have been nice if "git rebase --root" could be implemented as:

 1. create unborn detached HEAD
 2. cherry-pick commits
 3. set branch (or not, if started from detached HEAD)

Instead, what I ended up doing at some point was to create a temporary
unborn branch that I deleted after picking the first commit.

Anyway, that was just to show another point of view; I'm not
suggesting we should implement support for unborn detached HEAD.

Martin
