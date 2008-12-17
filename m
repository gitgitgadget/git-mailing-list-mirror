From: "Tim Visher" <tim.visher@gmail.com>
Subject: Re: Is it possible to roll back unstaged changes while leaving the staged ones for the next commit?
Date: Wed, 17 Dec 2008 17:48:50 -0500
Message-ID: <c115fd3c0812171448o3db6f4c1oc24e39f9a68ed1d3@mail.gmail.com>
References: <c115fd3c0812171157m3d180534gb5630fbcf39b2bbd@mail.gmail.com>
	 <7vy6yelf2m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 23:50:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD5Dm-0002bW-UE
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 23:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbYLQWsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 17:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbYLQWsw
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 17:48:52 -0500
Received: from rn-out-0910.google.com ([64.233.170.189]:26388 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbYLQWsv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 17:48:51 -0500
Received: by rn-out-0910.google.com with SMTP id k40so128965rnd.17
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 14:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=x3ut3fLdXfvhE1BIgBgWpYb1ddmVKDdvAM6e00LaTis=;
        b=S3RGB2eN76ohHTuJ5NNdUNcQfbgfdE1T4UKqyTas9oCEMRVwJnMosVn8Vx10y/aD+W
         jpT3TQm57oXimX2/Sz/1530Q3OOttA/LIfvb+QaF0pl03pPY+wmaBca+6odTRt7W40wT
         QJGi4L8Yoch1UeqrJEhB9Brt1b5bezx6bCyeg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=T0BRliXK26IG/CsDl63ATnuJT+gmWoVU19N6hR3oLz8KevnQkPe61Qql7MaomXQMeU
         nGG7nCa5L+2I4NUJOFQeFZNzXTRfxPEqBgNat6HiJ7hV22IQXH2oUAdQJJcaQyB5F+Eh
         HQ6ahAJkCKxDRZTl/I1HDucCJcNmKH6EcLieg=
Received: by 10.100.48.19 with SMTP id v19mr1018472anv.46.1229554130600;
        Wed, 17 Dec 2008 14:48:50 -0800 (PST)
Received: by 10.100.198.2 with HTTP; Wed, 17 Dec 2008 14:48:50 -0800 (PST)
In-Reply-To: <7vy6yelf2m.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103407>

On Wed, Dec 17, 2008 at 3:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The last part of the sentence after "because" does not parse for me at
> all...

Sorry for the double/triple/quadruple negatives I threw in there.
Makes the statement incredibly unclear.

> , but I think you are after one of the following:
>
>  (1) if you want to get rid of garbage changes in your work tree, you
>     would want "git checkout $that_path";
>
>  (2) if you want to temporarily stash away further changes in your work
>     tree, because you would want to first test what is staged, commit it,
>     and then later continue to refine the changes stashed away thusly,
>     you would want "git stash --keep-index".
>
>

If I could attempt to make my situation a little clearer.

I had two very similar files (I know, I know, DRY, blah blah. :\ It's
not my source tree to begin with... bleh) and I wanted to duplicate a
bunch of simple edits (adding white space, comments, etc.) from one of
them to the other without having to manually compare them.

Then, a light bulb went off in my head and I thought to myself that it
would make a ton of sense to use `git add -i` to add only the changes
that I wanted to the files and leave the stuff I wanted to be
different between the two of them out.  I `cp`ed the edited file over
the other file and then fired up `git add -i` and proceeded to stage
all of the edits that I wanted.  This left me with a staged version of
the file that was exactly what I wanted and a locally modified file
with contents that I didn't want.  However, the changes were still
untested.

What I wanted to do was basically get rid of the unstaged edits on
this file but keep the staged ones.  Without committing.

Unfortunately I couldn't figure out how to do this.  The solution I
came up with was to go ahead and `git commit` the staged changes and
then `git checkout PATH` the just committed file to overwrite the
local edits with the version of the file I wanted.

I want to know if it was possible to accomplish this without the commit stage.

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
