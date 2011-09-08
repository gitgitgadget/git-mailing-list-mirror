From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Git Bug - diff in commit message.
Date: Thu, 8 Sep 2011 16:26:01 +0000
Message-ID: <CAMOZ1BtbpbG+19G6Hfau_2_F5L3Ad+x-Payd9aKajJxU_V_tyA@mail.gmail.com>
References: <1315493353942-6772145.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: anikey <arty.anikey@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 01:19:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nsa-0006Ph-1l
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 01:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073Ab1IHXTX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Sep 2011 19:19:23 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55381 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162Ab1IHXSy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2011 19:18:54 -0400
Received: by gxk21 with SMTP id 21so546878gxk.5
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 16:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2V/ub7X5pcuCS7JfZ3qnz/7SLAzWBjTbREQKIxyAvfE=;
        b=IV3SGUjcatgXTEmtdDnKSJnVE9QNJGuen9HtWvSFT6ImZgwUi/wW5NoBTV+ERJSTBF
         Qa0K9FD1ORT7b22qFU30iqOdyZPwVqU05ysBoR4uhTKKPFJJTW0Cqbb18HGg/Lai9HW6
         7wdRX0oIvlHUEgI9y8yYN0oG88sYKr3zwgaaE=
Received: by 10.42.162.70 with SMTP id w6mr346349icx.280.1315499191109; Thu,
 08 Sep 2011 09:26:31 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Thu, 8 Sep 2011 09:26:01 -0700 (PDT)
In-Reply-To: <1315493353942-6772145.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181002>

On Thu, Sep 8, 2011 at 14:49, anikey <arty.anikey@gmail.com> wrote:
> Hi, peops. I'm pretty much sure that's a bug.
>
> What I did was putting git diff (i needed to tell people that for my =
changes
> to start working they needed to aplly message-inline patch to some co=
de
> which was not under git) in commit message. Like adding:
>
> diff --git a/app/controllers/settings_controller.rb
> b/app/controllers/settings_controller.rb
> index 937da74..0e8440d 100644
> --- a/app/controllers/settings_controller.rb
> +++ b/app/controllers/settings_controller.rb
> @@ -42,7 +42,7 @@ class SettingsController < ApplicationController
> =C2=A0 end
>
> =C2=A0 def snmp_mibs
> - =C2=A0 =C2=A0render layout: 'ext3'
> + =C2=A0 =C2=A0render layout: 'ext3_2'
> =C2=A0 end
>
> =C2=A0 def cfg_auth_keys(auth_type=3D:all)
>
> though the commit itself didn't contain that change. So while `git re=
base
> some_branch_name` I started getting:
>
> First, rewinding head to replay your work on top of it...
> Applying: My cool patch.
> fatal: sha1 information is lacking or useless
> (app/controllers/settings_controller.rb).
> Repository lacks necessary blobs to fall back on 3-way merge.
> Cannot fall back to three-way merge.
> Patch failed at 0001 My cool patch.
>
> When you have resolved this problem run "git rebase --continue".
> If you would prefer to skip this patch, instead run "git rebase --ski=
p".
> To restore the original branch and stop rebasing run "git rebase --ab=
ort".

Ha!

It would appear that `git rebase' is in fact producing patches with
`git format-patch' and then applying the resulting patches with `git
am', which gets confused by your inline diff; this can be clearly seen
in the `git-rebase--am[.sh]' file.

Perhaps `git rebase' should be reimplemented to use `git cherry-pick',
or does that suffer from the same problem?
