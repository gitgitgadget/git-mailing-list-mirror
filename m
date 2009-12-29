From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Possible bug in 1.6.6 with reset --hard and $GIT_WORK_TREE
Date: Tue, 29 Dec 2009 18:36:09 +0700
Message-ID: <fcaeb9bf0912290336m69303c3es8138c4e6497b801a@mail.gmail.com>
References: <1a04eebf0912282247p6975a96el8076cb39378bd104@mail.gmail.com>
	 <fcaeb9bf0912290038u77a5e83cqe2f3cbfab05af263@mail.gmail.com>
	 <20091229200426.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Fyn Fynn <fynfynn@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 12:36:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPaNH-00029Z-Sq
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 12:36:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbZL2LgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 06:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbZL2LgL
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 06:36:11 -0500
Received: from mail-px0-f189.google.com ([209.85.216.189]:40702 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706AbZL2LgK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 06:36:10 -0500
Received: by pxi27 with SMTP id 27so6154302pxi.4
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 03:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=5XLGqs0VIPmBPdpG/riXeMkoljsX8AYyWYplkGK9WjI=;
        b=Jo89hNrpsh9o+tFZgrM4UNUeUd2RguuJ/6At5NgJ01Oqr4n3rkZO5HZBnzvROWA/Q9
         SeJCDKjlKhhGtvouBAw69TGGpZHpnXDYzp5pzONUQ1t/1JbqNssVGo7NRfsY+PJKSqzq
         XJhzO17my6mxXvPnDsx0wbTJhWR+uKDMPwRq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=vaB/Cy5eUfeo2nTpLk9WRDTZ5PUKT6PrD8PIFnjLutAm+ifvEij1+mvvV0fNl/jzbf
         WQvdbSV1N6yDgVHjSgBA/tK/70PozA2pOGAmzMGHOY7HNyuiPPm8POuzN5WYKg2/nqfg
         OEWr1KGx7ZFBMv30bc4k33PbdaAdYH0lW8AOk=
Received: by 10.114.188.1 with SMTP id l1mr11226079waf.193.1262086569531; Tue, 
	29 Dec 2009 03:36:09 -0800 (PST)
In-Reply-To: <20091229200426.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135791>

On 12/29/09, Nanako Shiraishi <nanako3@lavabit.com> wrote:
> Quoting Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
>
>  > On 12/29/09, Fyn Fynn <fynfynn@gmail.com> wrote:
>  >> The exact same git reset command that works in 1.6.4, fails to work
>  >>  under 1.6.6:
>  >>
>  >>  $ GIT_WORK_TREE=$HOME/rawdata/ GIT_DIR=$HOME/rawdata/.git
>  >>  /usr/local/git-1.6.6/bin/git reset --hard
>  >>  fatal: hard reset requires a work tree
>  >>  $ GIT_WORK_TREE=$HOME/rawdata/ GIT_DIR=$HOME/rawdata/.git
>  >>  /usr/local/git-1.6.4/bin/git reset --hard
>  >>  HEAD is now at 77ec73f...
>  >>
>  >>  What gives?
>  >
>  > A recent patch by Jeff (952dfc6 (reset: improve worktree safety valves
>  > - 2009-12-04)) makes sure that "git reset --hard" will not work
>  > outside worktree (which is right).
>
>
> Sorry, but I don't understand why it is *right*. Isn't 'git reset --hard' supposed to make all the files in the working tree match the HEAD, no matter where you start from?

It is generally "right" to work from inside worktree, the way Git
worked before GIT_WORK_TREE came. In case of "git reset --hard", yes
it'd be best if Git could just go to worktree and reset it. I forgot
that "git reset --hard" does not take pathspec. The situation may be a
bit more complicated with "git status" (which also handles worktree as
a whole) because you may need to represent the filename output to be
relative to current working directory, not the GIT_WORK_TREE. Using
GIT_WORK_TREE from outside worktree is imo stretching git to its
limits.
-- 
Duy
