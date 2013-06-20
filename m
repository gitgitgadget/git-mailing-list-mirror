From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Splitting a rev list into 2 sets
Date: Thu, 20 Jun 2013 09:04:19 -0400
Message-ID: <CABURp0r+rzRqHv9vMX3Nsxn_p2R7zf8AsY=_Cg98xWRWn+7bkg@mail.gmail.com>
References: <CAC9WiBi-E+LN4hKGeu0mG7ihJWCaTg-W1Dx_PWmX_vsx-uLOaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 15:04:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpeXc-0007Zg-Su
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 15:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965388Ab3FTNEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 09:04:41 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:37607 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965039Ab3FTNEk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 09:04:40 -0400
Received: by mail-vc0-f177.google.com with SMTP id hv10so4648038vcb.8
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 06:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Mvv3mWtsPXtbpjXk1E4aUPHMLqeXE2xj4yniJUy5i3c=;
        b=KWm2dOk/Hf06qC47pZZakfZ2UQC74amCh8GB0uXkKDHxhlkVZoEtLWpZqihkGIxyx4
         dy0TZ6o97qbPnFS6stvmnPR7mjTRrmN3G2+9LebzmHTx2tC8RewVjIZQjjaZxivVMkVw
         jjJC7QFZq8nByh4aX26kJtW/G2oAn3vxgy8M4ujJ02tKdajTVqF3ru1lJwVJC4KYBzJM
         glC95y9shfLYVosfli91VpEPzuG1h8kzv5xbvCJFedq12jm4DYYUfPF5451h/voRvzPR
         k72tt/6uoRohzbK6HTPHuiSjSe9KQqOHOr1im8HSKohBKP+YSKqeB1TL0qzR/WiS7adh
         EdcA==
X-Received: by 10.220.111.206 with SMTP id t14mr2715894vcp.77.1371733479671;
 Thu, 20 Jun 2013 06:04:39 -0700 (PDT)
Received: by 10.58.220.72 with HTTP; Thu, 20 Jun 2013 06:04:19 -0700 (PDT)
In-Reply-To: <CAC9WiBi-E+LN4hKGeu0mG7ihJWCaTg-W1Dx_PWmX_vsx-uLOaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228493>

On Thu, Jun 20, 2013 at 6:14 AM, Francis Moreau <francis.moro@gmail.com> wrote:
> I'd like to write a script that would parse commits in one of my repo.
> Ideally this script should accept any revision ranges that
> git-rev-list would accept.
>
> This script should consider commits in master differently than the
> ones in others branches.
>
> To get the commit set which can't be reached by master (ie commits
> which are specific to branches other than master) I would do:
>
>   # "$@" is the range spec passed to the script
>   git rev-list "$@" ^master | check_other_commit
>
> But I don't know if it's possible to use a different git-rev-list
> command to get the rest of the commits, ie the ones that are reachable
> by the specified range and master.
>
> One way to do that is to record the first commit set got by the first
> rev-list command and check that the ones returned by "git rev-list $@"
> are not in the record.
>
> But I'm wondering if someone can see another solution more elegant ?

I do not know if I would call this elegant, but I think this
codification of your "One way to do that" is at least small and mostly
readable:

   git rev-list "$@" |grep -v -f <(git rev-list "$@" ^master)

Phil
