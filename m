From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] Improve Git performance on big trees
Date: Fri, 15 Jan 2010 20:36:42 +0700
Message-ID: <fcaeb9bf1001150536r445a9ee4jbf4fea4afa038c99@mail.gmail.com>
References: <1263481341-28401-1-git-send-email-pclouds@gmail.com>
	 <46a038f91001140721j5acb766cxfd777570d6edfca4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 14:36:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVmM8-0005Jt-1H
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 14:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382Ab0AONgq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jan 2010 08:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752177Ab0AONgq
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 08:36:46 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:42648 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113Ab0AONgp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jan 2010 08:36:45 -0500
Received: by pzk1 with SMTP id 1so848324pzk.33
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 05:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LRXuGKSG+9uHE1vxBKTmLV0VjeaEkevasgn1yxAmXbo=;
        b=LSVqqmUFMeaEpSlvi9KV2MThZbuBWyGsfOJQmfXpJPbvnGZ4laQNt8CeBOInc+0wQR
         CEkdnzBB7YtcB/mREP9va+enSj43nBg9jpBgivJcrwY/QjxdiFkJ9RA2o4nilUsGrY/h
         8dZWyvt3Pup2ADjhjT+GvaCw6ik00ZqQonXec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Y8Pltj5tEqpIw6rgVFNzs6sdSmq2/8ntfTNQMXCC+W3hNMcTJbpo5vgHOr4NVScKjt
         6dl+bbH/WBjKd+3NbDKYOz5Xpa+M1iMfmhD6h+XYhlarsRst74ZlHz+J3WMIKO/nzf0e
         NiOmthdkcMokRwj0AdOQp870EW1jwyL0g980U=
Received: by 10.114.215.5 with SMTP id n5mr1619200wag.222.1263562602485; Fri, 
	15 Jan 2010 05:36:42 -0800 (PST)
In-Reply-To: <46a038f91001140721j5acb766cxfd777570d6edfca4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137069>

On 1/14/10, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> 2010/1/14 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>:
>
> > Almost 1 sec for "git rm foo" still seems too long though,
>  > probably due to writing a 9MB index.
>
>
> One of the main issues there is that the Gentoo dir tree seems to be
>  very flat. The kernel tree is huge, but much deeper, and does not ha=
ve
>  a huge top-level directory -- and git handles it fairly well.

Kernel tree is about one third the size of gentoo-x86 in terms of
worktree. It takes ~1 sec to do "git status" on kernel tree and 3 secs
on gentoo-x86, quite proportional. Except that 3 secs feel much longer
than 1 :-)

Directory structure may also affect performance though. Kernel tree
only has ~2k directories while gentoo-x86 has ~20k shallow dirs.

>  Perhaps the Gentoo tree can be rearranged to be more nested? If your
>  devs strongly prefer a flat view of it, that could be arranged with
>  symlinks.
>
>  Alternatively, each port can be in its own repo, and you can make a
>  "top level repo" using git submodules -- this is what Fedora/RH is
>  exploring at the moment.

There were discussions of these in the past. And to my experience,
these ideas won't go anywhere. The number of worktree files may drop
significantly after Git migration because I believe all ChangeLog
(~13k files on total ~80k) will be gone.
--=20
Duy
