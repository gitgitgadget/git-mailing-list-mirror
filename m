From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: how to apply patch?
Date: Sun, 7 Feb 2010 21:00:29 +0800
Message-ID: <be6fef0d1002070500p4850b847p21a0736447100050@mail.gmail.com>
References: <13f0168a1002061720t93ff6aew3420a41a547549d8@mail.gmail.com>
	 <13f0168a1002061805o5d64c05cy9d8f0190a8f37feb@mail.gmail.com>
	 <be6fef0d1002062040x6556b73fvb2a62a85fe21ec9e@mail.gmail.com>
	 <13f0168a1002062206p8da7dd0n5f1b353c33b344f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Matt Di Pasquale <liveloveprosper@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 14:00:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ne6kd-00065P-VH
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 14:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256Ab0BGNAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 08:00:31 -0500
Received: from mail-iw0-f182.google.com ([209.85.223.182]:43406 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab0BGNAa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 08:00:30 -0500
Received: by iwn12 with SMTP id 12so5939840iwn.26
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 05:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=H0EbTZNyOdz6Zvk/euKdIPnrmkelpsblCV1sBadW94Q=;
        b=LQ31FLov+PSB3sRUki/9Ut86RpHXBuEZbRxfrZ8mX5oK1vpt5K1+/h/FFUirhZFQOr
         mvV/DhN3x27zbJxphwKrWqZ9ArE5d4FPdMlHYqn/2f6HRF9udTgxw0HT4ePIB47xmhKB
         MhO3c/CAsoeyzelzYGCOqbom0OdHrMII9jJhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Gb33jHemh75k63XrH6m01+URZ76zrf3BYpB+QGiK051nOAugs+QcXNYh9OhPZcy3yc
         8G8quY8ysOmRCf1SVD77GsJouY3dWKyxtkOlnhHqjXu5UTktyf44jo1/9O94NkXiXKV6
         /xL7BK6u0LCTs5HRPq0dFzjyaRXj84Q+bwfCE=
Received: by 10.231.146.66 with SMTP id g2mr6435218ibv.60.1265547629681; Sun, 
	07 Feb 2010 05:00:29 -0800 (PST)
In-Reply-To: <13f0168a1002062206p8da7dd0n5f1b353c33b344f3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139238>

Hi,

On Sun, Feb 7, 2010 at 2:06 PM, Matt Di Pasquale
<liveloveprosper@gmail.com> wrote:
> [snip]
> Also, is there an easy way to do something like this with a branch
> instead of a remote? Remote doesn't make sense to me conceptually (and
> I already have a remote repo setup that I push to from master).

I'm already doing this with branches. It's true that I used a remote
configuration, but the remote configuration ("[remote local]") says
that we're treating the local repository as the remote repo ("url =
.") and to "fetch" the dev branch (into FETCH_HEAD).

(btw, instead of '[remote local]' it should be '[remote "local"]'.)

I do this so that you can just type "git pull" without specifying the
branch, unlike when using git-rebase.

> Maybe
> I should have 2 different branches? One for dev & one for pro. How
> would I do that?

You should.

Your history for the two branches would look like this:

a---b---c dev
         \
          A---B---C pro

(if you're reading this in a non-fixed width font, pro branches off at "c".)

The commits in uppercase (A, B, C) are those that are applied onto dev
- for example, changing file paths, configuration, etc.

Let's say you've made some changes onto your dev branch. To update
your production site, you would rebase your pro changes onto the dev
branch (using the config and commands in the previous message), so
that you get this history:

a---b---c---d---e dev
                 \
                  A'---B'---C' pro

(pro branches off at dev's tip, "e".)

You have to keep in mind several issues. For example, if you're
updating file paths, when new files are added in the dev branch, you
need to update the pro side to modify the file paths in those files. I
was also assuming your dev branch fast-forwards cleanly, or else the
rebase fumbles.

-- 
Cheers,
Ray Chuan
