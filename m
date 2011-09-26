From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: config-file includes
Date: Mon, 26 Sep 2011 20:45:58 +1000
Message-ID: <CACsJy8BAVRAct=sxTpZ+b-ft1OjbY9oZG6uEXrcsTXw3CXnwSg@mail.gmail.com>
References: <20110923195829.GA27677@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 26 12:46:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R88ho-0003q3-S4
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 12:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747Ab1IZKqb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 06:46:31 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55011 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325Ab1IZKqa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 06:46:30 -0400
Received: by bkbzt4 with SMTP id zt4so5648887bkb.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 03:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=8FYqDS0nbdhQC01xAc0rzZuPKskplRXtls3KeiUrq10=;
        b=wyUqwAqRigIeVWSP9755bui68HQIqxhUuhaETyiS2PsHdQ5UMZ1+dK3d0RPPgTu1PA
         N8NCYnEWMFSZk4ousMm2RMb/kxXe6bvR1Nt0p4KPxhE4vqplU46H8gMseTAL7iuHTZCL
         NosCpdcwcrbxVZlg9tmU15OEf2ZjYQ5VxKq/s=
Received: by 10.204.136.198 with SMTP id s6mr929800bkt.131.1317033989167; Mon,
 26 Sep 2011 03:46:29 -0700 (PDT)
Received: by 10.205.114.134 with HTTP; Mon, 26 Sep 2011 03:45:58 -0700 (PDT)
In-Reply-To: <20110923195829.GA27677@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182101>

On Sat, Sep 24, 2011 at 5:58 AM, Jeff King <peff@peff.net> wrote:
> Here's one solution I've given a little thought to. Comments welcome.
>
> I've sometimes wanted an "include" mechanism in git config files.
> Partially to just keep things tidier, partially to avoid
> cutting-and-pasting between some repo-specific config, and partially
> because I'd like a conditional inclusion mechanism[1]. I was thinking=
 of
> something that would be syntactically compatible but semantically
> meaningless in current versions of git, like:
>
> =C2=A0[include]
> =C2=A0path =3D /some/file
> =C2=A0path =3D /some/other/file
> =C2=A0path =3D ~/some/file/in/your/homedir
>
> You could extend this to look in refs, with something like:
>
> =C2=A0[include]
> =C2=A0ref =3D meta:config
>
> which would resolve meta:config to a blob and examine it (i.e., it wo=
uld
> look at refs/heads/meta).

I had something similar [1], although I disregarded worktree content
completely. One thing about this meta thing is fsck/prune must dig in
config file in order not to accidentally remove something config file
refers to.

Another thing is, what if I want to exclude certain part of the include=
d config?

[1] http://thread.gmane.org/gmane.comp.version-control.git/163285/focus=
=3D163288

> [1] I want conditional inclusion because sometimes the rules for conf=
ig
> =C2=A0 =C2=A0entries changes from version to version. For example, I =
have
> =C2=A0 =C2=A0pager.diff set to a script in my ~/.gitconfig. But older=
 versions of
> =C2=A0 =C2=A0git don't understand non-boolean values and barf. I'd re=
ally like to
> =C2=A0 =C2=A0do something like:
>
> =C2=A0 =C2=A0[include-ifdef "has-pager-scripts"]
> =C2=A0 =C2=A0path =3D ~/.gitconfig-pager
>
> =C2=A0 =C2=A0where "has-pager-scripts" would be a magic flag compiled=
 into git
> =C2=A0 =C2=A0versions that understand that config.

But how far would you go with conditional expressions?
--=20
Duy
