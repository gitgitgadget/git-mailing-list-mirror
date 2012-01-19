From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Rebase and incrementing version numbers
Date: Fri, 20 Jan 2012 08:33:57 +1100
Message-ID: <CAH3Anro8T4SJqBvw1E_7u__4kYyB6hMCYPbtHSVxkgSUYSb2+A@mail.gmail.com>
References: <CADo4Y9jGYJasDL9m7_50aOTrOyoezdyg=vcsZhQ87Qk-1XfTUQ@mail.gmail.com>
	<CADo4Y9iKvoXhKg5pEAB+cbA7Rkfa=nF4TLu0xgcS3dnkNi_n4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Thu Jan 19 22:34:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnzcS-0002BC-30
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 22:34:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681Ab2ASVd7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jan 2012 16:33:59 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:54526 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab2ASVd6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2012 16:33:58 -0500
Received: by wics10 with SMTP id s10so332001wic.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 13:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=EId5unTfNAPOUx5zUYhx5NFoFEy4GQD4VyeLBJtwpsE=;
        b=TtST4lOfibc/0OIVp/Isyxun+G4zQBi8Hdzm6VbqeXsz6MWGHSMQQ4uSXYojySxyK/
         e3mpsePwi5SU48nAh8LccX9I3CG/8f9rsngnRGdXynVFih8kfBGt7jO7o4vba1jUVpT/
         osOlr3ixEtBxXsS3j7UC51ArO2jl4tekqrG10=
Received: by 10.181.11.163 with SMTP id ej3mr47457765wid.4.1327008837571; Thu,
 19 Jan 2012 13:33:57 -0800 (PST)
Received: by 10.180.79.195 with HTTP; Thu, 19 Jan 2012 13:33:57 -0800 (PST)
In-Reply-To: <CADo4Y9iKvoXhKg5pEAB+cbA7Rkfa=nF4TLu0xgcS3dnkNi_n4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188839>

On Fri, Jan 20, 2012 at 4:20 AM, Michael Nahas <mike.nahas@gmail.com> w=
rote:
> I'm at a new job and using Git-SVN at a place that is accustomed to S=
VN.
>
> The problem I'm running into is that whenever I change a file in a
> directory, I have to bump up the version number in the configuration
> file. =C2=A0The larger version value in the config file causes my cha=
nges
> to be loaded over the old ones.
>
> Most of my commits are edits to a file like "foo.js" and an increment
> to the version number in "config". =C2=A0Ideally, each of my features
> should live in a single commit and I should be able to make a sequenc=
e
> of them, each time incrementing the version number in config.
>
> The problem I'm running into starts with me editing version=3D100. =C2=
=A0I
> create new commits where I set the version to 101, 102, 103, 104.
> When I go to push ("git svn dcommit"), my coworkers have incremented
> the version to 103. =C2=A0So, I rebase my changes, and get conflicts =
every
> time because of the version number!
>
> Is there a good way to avoid these conflicts? =C2=A0Is there a hook I=
 can
> write? =C2=A0Is there a change to this process that would work smooth=
er
> with Git and its distributed development? =C2=A0It's okay if the vers=
ion
> number skips numbers (e.g., jumps from 100 to 104), as long as it
> increases.
>
> Thanks,
>
> Mike

I wonder if you can defer your changes to the config files until after
you have synced with the current SVN head, so that you typically only
modify the latest configuration file. Then use git to work out what
numbers you have to update (by working out which files you changed
that the SVN upstream has not seen yet). Not perfect, because of race
conditions, and may not work with your integration testing processes,
but perhaps worth considering.

Something like:

1. pull latest SVN
2. work on file
3. test. skip back to 2 until done.
4. ready to push to upstream
5. pull latest SVN
6. calculate configuration changes required
7. apply configuration changes
8. push work + configuration changes upstream

So, there is a window between steps 5 and 8 where you might still have
to deal with a conflict, but at least it  should be much reduced.

I agree with other comments, though, a saner approach might be to
generate the configuration as part of a build process rather than
trying to maintain it in source control.

jon.
