From: Jeffrey Middleton <jefromi@gmail.com>
Subject: Re: [RFC/PATCH] merge: honor prepare-commit-msg hook
Date: Tue, 8 Mar 2011 18:16:34 -0600
Message-ID: <AANLkTimqxNNJ7ezBYC8V_pW5=HB1md1xVrnKFV8sVBue@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 01:17:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px75J-0003R0-Pu
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 01:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884Ab1CIAQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 19:16:56 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49598 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756719Ab1CIAQz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 19:16:55 -0500
Received: by wwa36 with SMTP id 36so10588wwa.1
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 16:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=2Hl60CykLxHkio7LEmnWVn6zbpiSXZu2q3i41Jx0qi8=;
        b=vtJ7bMBypnE22bxIfLKiPTKi6Jw2fDC/svFNM3qEYADJLxr8/FAHysQvgLyvd1/Ucy
         vSqKbCLrJDOgnoi3VBvQaex/0OOmUv7ffGviQpt7XscRHG/PHL0vHREmIBYjGVi74okt
         6O2wxHRMqpPkD4gSYyCq5VBwuMvi5DXKsJECM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=WPsn/ymWYPxcsnllo8SahUcE217Bo0Ye9H19qJZY0VwAZBBj7fLsqWvbNsuOQH9bGG
         O3YQuzamS/YygYhulagDsFqgKzKBFfpPFyY1tWguGacI+Egib34O81jw5jQr5yGmmlyt
         kRjS62p2MS/g/N4rgwGeCvSInpzInuvCqMWOo=
Received: by 10.216.69.84 with SMTP id m62mr3868793wed.84.1299629814201; Tue,
 08 Mar 2011 16:16:54 -0800 (PST)
Received: by 10.216.167.145 with HTTP; Tue, 8 Mar 2011 16:16:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168716>

I'd like to add a voice to the support for calling the
prepare-commit-msg and post-commit hooks during a merge.

Reading the documentation, it seems like surely prepare-commit-msg
would be called: the description of the hook mentions that the second
argument might be "merge". The sample hook (also mentioned there)
targets only merge commits, but happens to work because it's designed
to only have an effect if there is a "Conflicts:" section, which
therefore means the user is committing manually. Another possible
merge-related use case for the hook would be intelligently rewriting
the subject, e.g. to canonicalize remote names in integration-style
merges.  If y'all don't agree, I'd suggest modifying the documentation
to clarify that the hook is only called for manually-committed merges.

My instinct is that post-commit makes sense too - if you want to print
some extra information after a commit is recorded, why should it just
be non-merges?

(and just in case, this is a reply to an old thread, including a
proposed patch:
http://thread.gmane.org/gmane.comp.version-control.git/151297/ )

Jeffrey

Junio C Hamano <gitster <at> pobox.com> writes:
> Jay Soffian <jaysoffian <at> gmail.com> writes:
> > ---
> > I couldn't figure out why my prepare-commit-msg wasn't being honored
> > by git merge.
>
> It has been that way from day one, it appears.
>
> The bypassing of pre-commit hook was and remains to be a conscious design
> decision.  When you are pulling from your contributors who may have
> objectionable contents that you have to merge, the damage is already
> done; you _could_ yell at them to fix their branch and re-pull in theory,
> but that wouldn't work very well in practice.
>
> On the other hand, I think letting people use prepare-commit-msg for
> merges might  make sense.  Indeed, "git commit" is prepared to call
> prepare-commit-msg telling the hook that it is concluding a merge, when
> your "git merge" stopped due to a conflict (or you stopped it from making
> a new commit with --no-commit).
>
> I don't know about the other hooks "git commit" normally calls.  Both
> "commit-msg" and "post-commit" may make sense, but I don't care too deeply
> either way---I don't care too deeply for pre-commit either ;-).
