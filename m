From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Interest in locking mechanism?
Date: Tue, 12 Jan 2010 20:26:59 +0100
Message-ID: <46a038f91001121126t6b2bdd36vfe5ed44291644ab9@mail.gmail.com>
References: <1263319565-sup-1767@ezyang>
	 <32541b131001121101i76ad8062p3a7f3571ad86b0ce@mail.gmail.com>
	 <1263323292-sup-4182@ezyang>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>, git <git@vger.kernel.org>
To: "Edward Z. Yang" <ezyang@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 12 20:27:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUmOV-0005Cx-9D
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 20:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708Ab0ALT1G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jan 2010 14:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754580Ab0ALT1G
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 14:27:06 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:45766 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754059Ab0ALT1D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jan 2010 14:27:03 -0500
Received: by ewy1 with SMTP id 1so5067125ewy.28
        for <git@vger.kernel.org>; Tue, 12 Jan 2010 11:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZffyOFHtyOP/QjBbS4LwMlDp5MskxQ/093su2a4ctjk=;
        b=ixGMf4hdvChOWvRv7FvuxvnvU1EUr+gAgn7GLpDAz02ppZJ2IM8b2eckmdGQY+7w3+
         mK3//xLKoJ5TrRiKLcyOnRg/TA2HJO4uIyHzshZNhhBRDfT8ogvaQ2ySTzjXVfybvC6z
         8rwPs+fZuE4yUIF8vVUAlnwHWGOYIAgdGi714=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PJA4ermbGTlvKCN0ERWDYh5g2i8fzAOgRYg5LjPbuQoob4lZBCtM0LPuiWFIibw6x1
         aqBHUb305rHvGX0vj40ypyC2T5R37CgXvjeq0psDOYlucHHFBVWM+F5IVKTIEXWe/85L
         eAORJ/4CFTW3Dfeq3l7YwPUpdtmww8PeNZkSU=
Received: by 10.213.96.232 with SMTP id i40mr6274495ebn.77.1263324421026; Tue, 
	12 Jan 2010 11:27:01 -0800 (PST)
In-Reply-To: <1263323292-sup-4182@ezyang>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136753>

On Tue, Jan 12, 2010 at 8:11 PM, Edward Z. Yang <ezyang@mit.edu> wrote:
> I would like to respectfully disagree. =A0I want to use git because:

I have to say, Avery's got a very good point, and my position (as a
cross SCM user) is that he's right. But I have two suggestions that
might work to at least try out what you say you want...:

 - Write a wrapper around your editor invokation to call `flock $EDITOR=
 $@`

 - Use rcs on top of git, just for the locking -- write a commit hook
that auto-commits to rcs when you commit to git; add suitable excludes
so git doesn't worry about ,v files.

And a comment on your points -

> =A0 =A0* I use Git on a regular basis, and do not use RCS. =A0I const=
antly
> =A0 =A0 =A0have to go digging through the manpages when I occasionall=
y do
> =A0 =A0 =A0stumble upon an RCS system. =A0Interface familiarity is ni=
ce.

that's very weak. Write your our wrappers that mimic git commands you
want to use...

> =A0 =A0* Putting it in Git means that you can easily grow; you can de=
cide
> =A0 =A0 =A0"Hey, maybe we want to do branchy development" and just do=
 it,
> =A0 =A0 =A0rather than have to drum up the activation energy to do an
> =A0 =A0 =A0rcsimport

"Drum up the energy" is somewhat exaggerated ;-)

> =A0 =A0* If code is deployed in a production context as a Git checkou=
t,

If that's what you are doing (or will be doing), just drop rcs, and
explore workflows that help bring attention to any case where there
were edits on the same file.

Actually -- you can focus on workflows that prevent or highlight cases
where the same file is "being edited" in a pre-commit hook that checks
and warns...

 - if new commits (on the matching branch) touch the file (evil: will
have to do git-fetch)

 - if the file was committed recently by a different committer

 - if we're committing a merge involving files changing on more than
one of the heads involved (this case can sometimes be auto-merged with
a diff3-like algorythm)

maybe something on that track helps



m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
