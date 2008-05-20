From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGit: kha/{safe,experimental} updated
Date: Tue, 20 May 2008 18:19:02 +0100
Message-ID: <b0943d9e0805201019x10bf87ecr1c11c8ee474f6138@mail.gmail.com>
References: <20080514014309.GA17955@diana.vm.bytemark.co.uk>
	 <b0943d9e0805191421n1ca676dai1b3ed7d6eb1df5f4@mail.gmail.com>
	 <20080520070441.GB7324@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue May 20 19:20:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyVVH-0003Hw-16
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 19:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbYETRTH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 May 2008 13:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbYETRTG
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 13:19:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:59827 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbYETRTF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 May 2008 13:19:05 -0400
Received: by ug-out-1314.google.com with SMTP id h2so742337ugf.16
        for <git@vger.kernel.org>; Tue, 20 May 2008 10:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YvFVeVQVhO0hMlHI+cMXRPbAlbA3OEnqqIhB3QfjH+0=;
        b=NlVUjvGMj/5GmSGQX7lK8UoakLfoZItllfGu5GIyRigOlTWpq2ddmcl/VhBrbMBj0pAFlyKZMBC+4dKfAu+PueVM2TJCDAFTEThKYgvud102eE1tpzEoWCVVQZFNqlR85xlxXkdqXvbo/8UhL/N25m4eeJv7DIv7wGWgv+HGiqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ffOLQpcITnM/SR8N/KR09rFR951+rI0eeEhSyMzyfM/gRklKGg/d3ZhnAKDAWbg5n0p/RSO9afnOsWDf6xuHGP8JwndfIq+dabFk1ZpUinpY/o9bS1k3kaI5ZNsVT56zmalyxNE/v7VBmXBiVyvNlQ06M9dMvydPDe7HPdkoRBA=
Received: by 10.67.102.6 with SMTP id e6mr5829047ugm.25.1211303942870;
        Tue, 20 May 2008 10:19:02 -0700 (PDT)
Received: by 10.66.255.4 with HTTP; Tue, 20 May 2008 10:19:02 -0700 (PDT)
In-Reply-To: <20080520070441.GB7324@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82486>

2008/5/20 Karl Hasselstr=F6m <kha@treskal.com>:
> The system I built works like this at install time:
>
>  i1. Create stgit/builtin_version.py, populated with git-describe
>      output.
>
>  i2. Install as usual.

=46ine (with some notes for releases, see below).

> And at runtime:
>
>  r1. If we have a .git directory, ask git what version we are.
>      (Actually, we just try to run git describe and see if it
>      succeeds.)
>
>  r2. Otherwise, go with the built-in version (only works if
>      stgit/builtin_version.py exists).

OK.

> Now, as to released versions, you could simply plop a suitably
> prepared stgit/builtin_version.py in the tarball, and it'll all work.
> i1 should fail silently when run from an unpacked tarball, so i2 will
> pick up the builtin_version.py from the tarball. And at runtime, r1
> will fail and we'll fall back to r2.

I build release tarball from the directory under Git control and I
always get a builtin_version.py generated. In my initial patch I had a
check in setup.py for a .release file. I could add a check in
write_builtin_version to ignore the extra .git stuff if I am making a
release (only keep the tag name).

Another alternative is to check for the number of commits from the
latest tag and, if this is 0, simply ignore the Git id.

BTW, Git seems to use 6 characters for the current commit id and StGIT
5. Should we change this for consistency?

> Oh, and please consider making annotated release tags in the future.
> As is, I had to ask git-describe to look at unannotated tags as well,
> which won't be so good in case a developer uses those as a scratch pa=
d
> while developing.

I always thought annotated tags are created by default. I'll do this
from now on.

--=20
Catalin
