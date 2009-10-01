From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Do not show 'patch' link in 'commit' view for merges
Date: Thu, 1 Oct 2009 09:36:23 +0200
Message-ID: <200910010936.24789.jnareb@gmail.com>
References: <20090930201953.22301.73887.stgit@localhost.localdomain> <20091001031140.GA30094@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 01 09:36:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtGDM-000586-PJ
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 09:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669AbZJAHg1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Oct 2009 03:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755653AbZJAHg0
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 03:36:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:30808 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755651AbZJAHg0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Oct 2009 03:36:26 -0400
Received: by fg-out-1718.google.com with SMTP id 22so2367210fge.1
        for <git@vger.kernel.org>; Thu, 01 Oct 2009 00:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=iVyCJSCHhc1lAiGJPYMyfVes+VFkB8bPjLMNgRA9wmk=;
        b=uRltb7PsAYjvgIYhzYPDfmkIEzWG0uv8hnkzlEEZCTROCa00WfRAMPzskBWBjdvl2B
         hGL8g60pRrMp4EzVSLzmyoKryq1bhupJXJVPOBfzOvXcVvhXaMs/gm6EbxtJPXpeeg54
         nxAPy0JMItoBxX8fGgWTbmzWlIVdbMsg8A47g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=u3yiuAqYtY6PuI1TWGedb9mSxJPvFe9UjK3FkFlXqrF/GvSQOqzcZHnrJu1K839NL0
         zE09SzE1+6WpAuA77cnVtoHtIH2Ypue6CXhJ/Slz9gUr0jQ0PmxjUXJK/GLk8mq/UiKl
         pcm94LCJnWp8oAdaTcyyrhHV57E2EblyiuqeI=
Received: by 10.86.227.26 with SMTP id z26mr823061fgg.76.1254382589009;
        Thu, 01 Oct 2009 00:36:29 -0700 (PDT)
Received: from ?192.168.1.13? (abvd215.neoplus.adsl.tpnet.pl [83.8.201.215])
        by mx.google.com with ESMTPS id l12sm905242fgb.20.2009.10.01.00.36.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Oct 2009 00:36:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20091001031140.GA30094@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129378>

Dnia czwartek 1. pa=C5=BAdziernika 2009 05:11, Jeff King napisa=C5=82:
> On Wed, Sep 30, 2009 at 10:21:53PM +0200, Jakub Narebski wrote:
>=20
> > Show 'patch' link in the 'commit' view only for commits which have
> > exactly one parent, otherwise call to git-format-patch would fail f=
or
> > the hyperlinked 'patch' action.
>=20
> Fail in what way? From my cursory reading of the code, it looks like =
the
> 'patch' action calls into git_commitdiff, which handles the multi-par=
ent
> case.
>=20
> I assume I'm reading wrong, since you obviously know gitweb much bett=
er
> than I do. :) But can you expand a little on the nature of the proble=
m
> in the commit message?

Well, from the point of view of behavior, 'patch' link in 'commit' view
for a merge commit, e.g.
  gitweb.cgi/git.git/commit/833423ae071ffedb7fbca39789f14f9a45a3d1c4
leads to the 'patch' view
  git.git/patch/833423ae071ffedb7fbca39789f14f9a45a3d1c4
which leads to 'text/plain' output with the following contents:

  Reading git-format-patch failed


=46rom the point of view of code, 'patch' view is handled by git_patch(=
)
subroutine, which in turn calls git_commitdiff(-format =3D> 'patch', -s=
ingle=3D> 1);
git_commitdiff checks if 'patch' view is enabled feature, and then=20
composes and calls the following command (I have skipped --git-dir=3D..=
=2E):

  git format-patch --encoding=3Dutf8 --stdout -1 --root <commit-id>

And git-format-patch produces no output for merge commit.  Then=20
git_commitdiff dumps output of git-format-patch

	local $/ =3D undef;
	print <$fd>;

and somehow fails on closing filehandle

	close $fd
		or print "Reading git-format-patch failed\n";

Even if 'patch' view didn't fail, it is not a good idea to have link
to an empty page (or page with only error message).  Though probably
git_commitdiff could check if it is used for a merge commit...

--=20
Jakub Narebski
Poland
