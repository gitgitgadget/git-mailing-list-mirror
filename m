From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: Re: How to create tags outside of refs/tags?
Date: Tue, 22 Feb 2011 23:08:47 +0100
Message-ID: <AANLkTiki9W_mJKLON+punKJLDWx5rmQdZ3bS16zadYFj@mail.gmail.com>
References: <AANLkTimxAhMfPsqEJVyteuTzXLr+QnhcxpJLgaE=y12_@mail.gmail.com>
 <AANLkTi=7yUh9J9S5LdpNY0SwCv008ih2LEd3KNvy46sL@mail.gmail.com>
 <20110222080305.GA11177@sigill.intra.peff.net> <7vvd0cebi6.fsf@alter.siamese.dyndns.org>
 <20110222081458.GA11825@sigill.intra.peff.net> <m3wrks756a.fsf@localhost.localdomain>
 <20110222152723.GA23353@sigill.intra.peff.net> <AANLkTinTj7BehKYc15jbQzMq+q=2CfLvzTkGSJ-Ps-FH@mail.gmail.com>
 <7v7hcrewyz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 23:09:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps0Q9-0002FT-85
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 23:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab1BVWJK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 17:09:10 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:37965 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017Ab1BVWJI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Feb 2011 17:09:08 -0500
Received: by qyk7 with SMTP id 7so3336706qyk.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 14:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=SPKL7QjMja+eZboLhHGZQaH8dRZtQyfGGo/YF87Ezp4=;
        b=GWYZmvzXS2eX3wrhr5Wf6wskKKP6tcPWpMFQYrn9HSSP7wLZN7QHjBxyAT0oWX52Fn
         jwA/kmmSQyIohsgAWtNo/RqNqyDVi+Bt/2Dh2WrvmH4kexqra6AJfvTpLSonRBEBeDCK
         YGFjZ6NZycmBVgb+02wdx6xdeXOpUZHTRSxFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=rxDYbShDZUxiI7L9QS6yqNpqapGCtvyWTRYU3V7N4Rufkd8O5yd9VroWsLLwVN2FpG
         TlPkHFVcLiC9fIY7iXQKoW7YaZUEsfwbV8rCQPmy3YCfk9At+c9BTKxYDp837yZVZg/B
         awdxlOZxLTWHolCc26HlA2Co9gMUJp4hUzLI4=
Received: by 10.224.67.12 with SMTP id p12mr2747997qai.57.1298412547089; Tue,
 22 Feb 2011 14:09:07 -0800 (PST)
Received: by 10.229.50.6 with HTTP; Tue, 22 Feb 2011 14:08:47 -0800 (PST)
In-Reply-To: <7v7hcrewyz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167583>

Hi,

> How about taking advantage of the fact that you do not have to treat =
tag
> namespace as a global thing? =A0For the "release tool" to "get a comm=
it ID"
> and do something useful, the "release tool" must be working on a git
> repository, and hopefully that repository is something other than the=
 ones
> developers directly play with (by checking out random branches in its
> working tree and compiling, etc.).

These assumptions are all correct. The "release tool" works on his clon=
e
of a central repo. The release tool may even modify the content (e.g. i=
ncreasing
release numbers in project metadata files) and create new git commits.
In the end it wants to create tags/refs locally und push these tags bac=
k
so that in the central repo the commits are not gc'ed.

Something like:

cd <releaseRepo>
git fetch origin
git checkout <commitIdToRelease>
edit pom.xml; git add pom.xml
git commit -m "release ..."
git tag <releaseName>
git push origin 'refs/tags/<releaseName>:refs/releases/<releaseName>'

should do the job, or?
