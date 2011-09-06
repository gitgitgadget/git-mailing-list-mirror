From: mfwitten@gmail.com
Subject: Re: Question about right-only
Date: Tue, 06 Sep 2011 15:24:39 -0000
Message-ID: <ec1404d75fd6461fa731f31625126884-mfwitten@gmail.com>
References: <4E6607B2.2090000@intland.com>
Cc: git@vger.kernel.org
To: =?ISO-8859-2?Q?Tajti_=C1kos?= <akos.tajti@intland.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 17:32:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0xdi-0000p1-Gq
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 17:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057Ab1IFPch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 11:32:37 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43159 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019Ab1IFPcf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 11:32:35 -0400
Received: by wwf5 with SMTP id 5so6357662wwf.1
        for <git@vger.kernel.org>; Tue, 06 Sep 2011 08:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:subject:date:to:cc:message-id:in-reply-to:references;
        bh=b5kXLteFcb98VREkONUtnFP+J33gLYHruxURlFcY/S0=;
        b=HeFlG9X4kfOhPc7l14+cEqmbIB+DFO7rtcGJG4tBaIJcvEwevS61vQGxfCDdpBjZ/u
         dBwDZuB2yTniYwxFC6Y5gaoJ8w1iSMcusitx1Q2RgxL9g+rKx6mCP2dHY+t7OaSFhTTr
         xy60VfGco7a5ylSM/nrDsIwTZEFmGZpkKXjy4=
Received: by 10.227.167.10 with SMTP id o10mr2140435wby.91.1315323154539;
        Tue, 06 Sep 2011 08:32:34 -0700 (PDT)
Received: from gmail.com ([109.236.85.157])
        by mx.google.com with ESMTPS id o7sm456660wbh.8.2011.09.06.08.32.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Sep 2011 08:32:33 -0700 (PDT)
In-Reply-To: <4E6607B2.2090000@intland.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180806>

On Tue, 06 Sep 2011 13:44:50 +0200, Tajti wrote:

> what does the right-only option of git-log actually do? The manual is 
> not too verbose about it.

The documentation is indeed a bit messy, so let me rearrange it for you.

>From `git help rev-parse':

  r1...r2 is called symmetric difference of r1 and r2 and is
  defined as `r1 r2 --not $(git merge-base --all r1 r2)'. It is
  the set of commits that are reachable from either one of r1 or
  r2 but not from both.

Then we have this from `git help log':

  --left-right
      Mark which side of a symmetric diff a commit is reachable
      from. Commits from the left side [(r1 above)] are prefixed with
      < and those from the right [(r2 above)] with >...

which should explain what `<' and `>' mean in the following from
`git help log':

  --left-only, --right-only
      List only commits on the respective side of a symmetric
      range, i.e. only those which would be marked < resp. > by
      --left-right.

This is probably most useful with the following option, described
in `git help log':

  --cherry-pick
      Omit any commit that introduces the same change as another
      commit on the "other side" when the set of commits are
      limited with symmetric difference.

      ...

      For example, --cherry-pick --right-only A...B omits those
      commits from B which are in A or are patch-equivalent to a
      commit in A. In other words, this lists the + commits from
      git cherry A B. More precisely, --cherry-pick --right-only
      --no-merges gives the exact list.

That is, you often run into multiple commit objects that are unique
because of, say, differing commit dates, but that actually introduce
the same change to the source; this combination of options is helpful
in weeding out commits that introduce the same change.

If you're still confused, don't hesitate to poke the list some more;
the documentation is quite lacking over all topics, so don't feel
stupid.
