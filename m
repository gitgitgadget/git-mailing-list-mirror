From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cherry picking and merge
Date: Fri, 1 Aug 2014 13:02:01 -0700
Message-ID: <20140801200201.GS12427@google.com>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mike Stump <mikestump@comcast.net>
X-From: git-owner@vger.kernel.org Fri Aug 01 22:02:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDJ1n-0001Bc-Ln
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 22:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755889AbaHAUCH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 16:02:07 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:46365 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755872AbaHAUCF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 16:02:05 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so6385650pab.0
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=S+pGkWDn6jex3zx7sLE5zuPMVUOAnfRls5+18WfLQlE=;
        b=G4ju6L8YOwZMfRexD538i6PDggMNpLaaF8zi3u+mN8JbKDIcYF5KjJdOqK6cqtWcKZ
         cav1wgqI6xDi4Y5M2jR6jR5HCkPcABGyLcNC3iBcApuN0/DtL/wY8COm/Prd0k+5Xpmd
         suH/15Y2fumEHGDABqzADQfSmjeiAdbHEN8kzgp0PQabB9yvgpy8ZZr8Zq7ZeTtd2gil
         92dYSJO3EO3oiVgqplShimUtswj0RLhcFqQmM3mg4M3lHzqTis/nn0ptBX6iW0F5NSXA
         a65JnVg8DlX4JPg4kLmdpLE2J47D8gME0VLWkWwwy3d7tXDD+ABzIT2+m7XD0NHl2lJM
         TPFg==
X-Received: by 10.68.167.133 with SMTP id zo5mr8662878pbb.21.1406923324695;
        Fri, 01 Aug 2014 13:02:04 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:303c:6b98:896:51f2])
        by mx.google.com with ESMTPSA id gi8sm9552784pbc.16.2014.08.01.13.02.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 01 Aug 2014 13:02:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254657>

Hi Mike,

Mike Stump wrote:

> Cherry picking doesn=E2=80=99t work as well as it should.  I was test=
ing on
> git version 1.7.9.5.
>
> Put in a line in a file, call it:
>
> first version
>
> then cherry pick this into your branch. Then update on master and
> transform that into:
>
> second version
>
> then, merge that branch back to master.  Death in the form of conflic=
ts.

Do you mean that "git merge" should be aware of what changes you have
already cherry-picked?

It isn't, and that's deliberate ("git merge" is designed to be simple
as possible, though no more simple than that).  This way, if on a side
branch someone makes a change that would conflict with "master" and
then backs it out, then the branch can still merge cleanly.

Generally people do one of the following:

 * Use a merge-centric workflow.  Don't cherry-pick "forward" but
   merge instead.  (Do use cherry-pick for backports when you forgot
   to commit a fix on top of the oldest supported branch that would
   need it.)  The gitworkflows(7) manpage has more details on how
   this works.

 * Use a cherry-pick-centric workflow.  Never merge.  Notice when
   you're trying to apply a patch you already applied and skip it.
   (Others in the thread have covered this workflow a little.)

Even in those workflows, it's possible to have conflicts due to
genuinely conflicting changes, even with no cherry-pick involved.  I
find the '[merge] conflictstyle =3D diff3' setting (see git-config(1))
and git-rerere(1) to be helpful in making that less painful.

Hope that helps,
Jonathan
