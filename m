From: Alexander Usov <a.s.usov@gmail.com>
Subject: Re: How do I get a squashed diff for review
Date: Sat, 5 Nov 2011 17:56:58 +0000
Message-ID: <CAH_EFyYUja4cKY5YM4Uqn-bnQZCnhnJCNsxGsUitL+SSqj9qxQ@mail.gmail.com>
References: <CAH_EFyZ_0JB0-5cw-6VEJkfJhSjbmA=3upByQ3YpmnVSvR+9Pg@mail.gmail.com>
 <20111105091514.GA97860@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Roland Kaufmann <rlndkfmn+git@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 05 18:57:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMkV2-0002IR-5u
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 18:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948Ab1KER5k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Nov 2011 13:57:40 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55838 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880Ab1KER5j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Nov 2011 13:57:39 -0400
Received: by ywf7 with SMTP id 7so3679031ywf.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 10:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=HqdP+XkeEKpuJ6hRJLJxS0OwsHMcci0/xiDsYw+oJBw=;
        b=nnw1ntG8/ACzsFJurGO/RSVp8qVW9a8FuD0J2nntuAcvUCSeLop+Tj5/XIPQF4D+dw
         ptxFgEaiy0wltpxfHcoi3PUGo9BI1IbcNAlcUsIlTzd/QTClwW7UIoD2VauIPcBPZmVA
         anVWTU6Rg2mRPZ8LlLmWLFgRDPgfZwphwGiQo=
Received: by 10.236.174.105 with SMTP id w69mr26676698yhl.32.1320515859127;
 Sat, 05 Nov 2011 10:57:39 -0700 (PDT)
Received: by 10.236.105.231 with HTTP; Sat, 5 Nov 2011 10:56:58 -0700 (PDT)
In-Reply-To: <20111105091514.GA97860@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184871>

On 5 November 2011 09:15, David Aguilar <davvid@gmail.com> wrote:
> On Fri, Nov 04, 2011 at 07:15:01PM +0000, Alexander Usov wrote:
>> Hi,
>>
>> However if the feature branch happened to be long-lived and had
>> mainline merged into it it's not going to work -- the
>> resulting diff would contain changes from the merge. The way we are
>> doing things now is to merge master into it
>> once more and then diff, however this is somewhat cumbersome. Is the=
re
>> easier way to do it?
>
> "git diff A...B" is equivalent to "git diff <merge-base A B> B".
> The merge-base can be found with "git merge-base A B"
> and is simply the common ancestor of A and B.
>
> Diffing against the merge base (which doesn't contain the merged
> work done in master) is why you're seeing the merges in the diff.
>
> It sounds like you want the simpler form of "diff" which doesn't
> do any merge-base calculation.
>
> e.g. "git diff A B" and its synonymn "git diff A..B".

Just diffing 2 revisions (or trees) won't do the trick. Let me try to e=
xplain
what I'm trying to achieve.

Consider the following history:

master: A---B---D---F
            \    \
branch:      .-C--E--G

Now I want to review the changes made in the branch prior to merging it=
=2E
What I essentially want to be included in the diff are changes committe=
d in
C & G and conflic resolution done in E (if any).

There are few ways that I know of to achieve it:
- use "git log -p branch ^master " to get a sequence of patches and try=
 to
feed them into combinediff tool (part of the diffutils package). This
will require
some scripting and I'm not really sure if combinediff would work with
git patches.

- "git diff D..branch" would do a trick, but I'm not sure how to
correctly determine
D (if I'm to write a script). This would be the last (in topological
order) commit which is
reachable from both master & branch. Any suggestions on it?


>> And while we are on the topic -- is there a tool for git similar to =
"bzr qdiff"?
>> It's a simple graphical diff viewer with 2 nice features -- it shows
>> complete diff (of multiple files) in a single window and
>> has a checkbox to switch between diff-only & full-text modes.
>> I have seen difftool, but it seems to work on per-file basis, and
>> something like "vi <(git diff ...)" lacks the easy way to
>> switch into full-text mode.
>
> difftool is a wrapper around specialized diff tools, so the
> ability to switch from diff to full view is tool-dependent.
>
> A contrib "git-dirdiff" script was posted to the list recently.
> It builds upon diff tools that can diff directory trees.
>
> http://thread.gmane.org/gmane.comp.version-control.git/184528
>
> There may be a newer version of this script, too. =A0Roland would
> know for sure...

Thanks. Will have a more carefull look at various tools & see if I can
figure something out.


--=20
Best regards,
=A0 Alexander.
