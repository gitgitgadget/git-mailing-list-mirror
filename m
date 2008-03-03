From: "Maxim Gordienko" <mgordienko@gmail.com>
Subject: Re: [GIT-P4] usage under Windows
Date: Mon, 3 Mar 2008 22:24:28 +0300
Message-ID: <96c268400803031124s28e7f5f2s3d0a41ab670477c1@mail.gmail.com>
References: <96c268400802212244g7fd2de2bj6c1b7022885c8e89@mail.gmail.com>
	 <47C5E4EC.1060003@trolltech.com>
	 <96c268400802291048u31a2d8b6ub1726ade941afb8c@mail.gmail.com>
	 <B929D1FF-BAF7-4595-9DAF-07E62B90D767@gmail.com>
	 <47C97C03.8040303@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Marius Storm-Olsen" <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 20:25:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWGHs-0001v1-47
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 20:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755711AbYCCTYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 14:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755627AbYCCTYb
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 14:24:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:65266 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673AbYCCTY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 14:24:29 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2200418ugc.16
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 11:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=NR8OKDPqq5Z4jehqE6rcRtJhXUotqYCskdu1Sh4ATTU=;
        b=fH628RrouY+EPFDUxoH/mZT+2KG2tahZiYcMwqlcM0qLFYOJ40/3Qi5h5n/eQZn6pknPOT7ICmOBQidnw5Rju2oVJmNf6jHuiulY3Aicg7rgeHVn4ItHfqBIjiaa7M1fOjEDzjEHiXXnXw6kzv1ecnZlZ5p7ZPZYbDQ8LWHQnU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FxoS4NjenDnYQkFixTQuk3OfvajRTcQpaJ0hD63yHRhbri3KTzxyI7HfaVKnxctZ6oA9m0SPUzo2jV5/HFVl8O1EtGXBGnzs1Xk/K0IGw/pROiwimTQD+5B8fmi0is175I3nsQanRth51P8pDnw3fPlOr51o56WkQXYNDV2Bbg8=
Received: by 10.67.89.15 with SMTP id r15mr4998489ugl.12.1204572268169;
        Mon, 03 Mar 2008 11:24:28 -0800 (PST)
Received: by 10.66.252.19 with HTTP; Mon, 3 Mar 2008 11:24:28 -0800 (PST)
In-Reply-To: <47C97C03.8040303@trolltech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75975>

Marius, thank you for the tip! but unsynced files not the case. Entire
p4 client dir is in sync with depot.
but i found this:
$ p4 edit 1.txt
1.txt - file(s) not on client.

$ p4 revert //depot/main/1.txt
//depot/main/1.txt#21 - was edit, reverted

git-p4 issues command not pointing on existing file (from p4 point of
view). So we just need to issue full path in sync command.

On Sat, Mar 1, 2008 at 6:53 PM, Marius Storm-Olsen <marius@trolltech.com> wrote:
> Tor Arvid Lund wrote:
> > On 29. feb.. 2008, at 19.48, Maxim Gordienko wrote:
> >> Synchronizing p4 checkout... executing p4 sync ... Path
> >> 'c:/tmp/p42/main\...' is not under client's root 'c:\p4'.
> >
> > I have seen it too. I'm not sure, but it seems to me like even though
> > the git-p4 script does a chdir(<perforce_dir>) before calling "p4
> > <command> <args>" the chdir is "not seen by" p4 on windows.
> >
> > I have a patch on my machine where i simply change all the p4 calls,
> > like so:
> >
> > system("p4 sync ...") --> system("p4 sync %s..." % self.clientPath)
> >
> > This seems to work in all cases, and also in Mac OS X... I can
> > probably clean the patch up a bit, and submit it later today or
> > tomorrow if you're interested.
>
> It must mean that you initially didn't have the perforce files synced to
> disk according to you client spec, so the command to 'cd' into the
> perforce directory failed? I think this problem is solved by just doing a
>     p4 sync //depot/...
> to make sure that all the files exists on disk, before trying the 'git
> p4 submit' again.
>
> git-p4 does not require checked out files to clone from perforce, but
> requires the files to exist on disk to be able to submit back to the depot.
>
> --
> .marius
>
>
