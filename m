From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Do not show 'patch' link in 'commit' view for merges
Date: Thu, 1 Oct 2009 11:18:01 +0200
Message-ID: <200910011118.02875.jnareb@gmail.com>
References: <20090930201953.22301.73887.stgit@localhost.localdomain> <200910010936.24789.jnareb@gmail.com> <20091001075540.GA13436@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 01 11:18:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtHnk-00077p-D7
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 11:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871AbZJAJSF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Oct 2009 05:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbZJAJSF
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 05:18:05 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:50683 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbZJAJSE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 05:18:04 -0400
Received: by fxm18 with SMTP id 18so6017101fxm.17
        for <git@vger.kernel.org>; Thu, 01 Oct 2009 02:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=YBqJN2xu71/aawWm2qmBO4y5FAxajKPH4VTluYX2zcA=;
        b=s3wbGXS/KpQNknHjKrPGk+Z5s7i4Eg/xpV4DY5HlvtOdGqUTgeMspkQI+AJp+retA5
         fdVgXYD/tif5sg3FFJ2l/slg8IkrOMYyEz7S68ot/srEGJn5M7DjfmeyubxxgI/0iPH8
         zGhnueeinnwIGq/ML1xNBISDq5CcH210iXznI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=YZgJV5geerY259mXUC+cfZAuQci6JcyGezRFyyz5PA4MBBONBQ8bLJ36KmBmOdKJcs
         Zn0U9BfZq7MSFXss3XKL4bbv9q8osTwc58Q5vVAcZQs/ccaFA6WYZetyFjM7ljKXYRKB
         NTmNPEspwX2OLfu76ImUNM353JpeUJ/U9atp8=
Received: by 10.204.34.70 with SMTP id k6mr732285bkd.178.1254388687356;
        Thu, 01 Oct 2009 02:18:07 -0700 (PDT)
Received: from ?192.168.1.13? (abvd215.neoplus.adsl.tpnet.pl [83.8.201.215])
        by mx.google.com with ESMTPS id b17sm4383873fka.43.2009.10.01.02.18.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Oct 2009 02:18:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20091001075540.GA13436@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129384>

Dnia czwartek 1. pa=C5=BAdziernika 2009 09:55, Jeff King napisa=C5=82:
> On Thu, Oct 01, 2009 at 09:36:23AM +0200, Jakub Narebski wrote:
>=20
> > From the point of view of code, 'patch' view is handled by git_patc=
h()
> > subroutine, which in turn calls git_commitdiff(-format =3D> 'patch'=
, -single=3D> 1);
> > git_commitdiff checks if 'patch' view is enabled feature, and then=20
> > composes and calls the following command (I have skipped --git-dir=3D=
=2E..):
> >=20
> >   git format-patch --encoding=3Dutf8 --stdout -1 --root <commit-id>
> >=20
> > And git-format-patch produces no output for merge commit.  Then=20
> > git_commitdiff dumps output of git-format-patch
>=20
> Ah, OK, I see the code path you are talking about now. My first thoug=
ht
> was "shouldn't it be handling the merge case?" but that really doesn'=
t
> make any sense. The "patch" view is just about something that can be
> given to "git am", and it doesn't understand merges anyway. And the
> "commitdiff" and "html" formats already handle it appropriately.
>=20
> So I think your patch is the right thing to do. Thanks for the
> explanation.

I'll enhance commit message to talk about issues touched here (that
'patch' is for git-am and doesn't make sense for merges, regardless
of possible bug in 'patch' view when used for merge commits), and
check if this correction isn't needed also elsewhere.

I'll send v2 of this patch in a bit.

--=20
Jakub Narebski
Poland
