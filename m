From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 09/13] Clear up the semantics of Series.new_patch
Date: Tue, 9 Oct 2007 22:01:44 +0100
Message-ID: <b0943d9e0710091401s280b3a12md9e700fb3ae007bf@mail.gmail.com>
References: <20070914222819.7001.55921.stgit@morpheus.local>
	 <20070914223154.7001.12254.stgit@morpheus.local>
	 <b0943d9e0710080616r36142946m3e24d2f6893287c9@mail.gmail.com>
	 <20071008132524.GA11253@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 23:01:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfMDC-0002m7-BT
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 23:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176AbXJIVBp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2007 17:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753808AbXJIVBp
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 17:01:45 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:43694 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbXJIVBo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Oct 2007 17:01:44 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1173605rvb
        for <git@vger.kernel.org>; Tue, 09 Oct 2007 14:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=npbYGqfR/kCvRI8tJDoH0R7iSEslUdUowMjLfUaekME=;
        b=RaMVGksF6K0mcnJo70XlQauatcOu4pgpbhTmeNSRN/mUC46nDffA493EOo6cS0cwIlI3gmFcx99NeHyEux60rUU0CQ4iMsdpr8oM6f9IMDiCtI/GbCmHS6Z14jvChx0mUvv5Z41ZpnhJCG36SMA+wNBJ9OEkJ+PgYgwdfRkM2WM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gAEyJS+FzgaCbcYydWvhr8AbGg+c5yysZZ5U7o8Hn/BESWADd9pQ/hJo7YGRh/4kQYYOkig8jLM7PpDh+W0IfXKwPzut8FuUTDClmEHXsuaF7xDFAeQArsXxIRF860zuyEapZV/hbvn8/wuoc4vO6Nksy2Bztf4QGRnJyUsTPKQ=
Received: by 10.141.129.14 with SMTP id g14mr1783377rvn.1191963704164;
        Tue, 09 Oct 2007 14:01:44 -0700 (PDT)
Received: by 10.140.187.15 with HTTP; Tue, 9 Oct 2007 14:01:44 -0700 (PDT)
In-Reply-To: <20071008132524.GA11253@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60437>

On 08/10/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-10-08 14:16:10 +0100, Catalin Marinas wrote:
>
> > On 14/09/2007, David K=E5gedal <davidk@lysator.liu.se> wrote:
> >
> > > +        assert commit or (top and bottom)
> > > +        assert not before_existing or (top and bottom)
> > > +        assert not (commit and before_existing)
> > > +        assert (top and bottom) or (not top and not bottom)
> > > +        assert not top or (bottom =3D=3D git.get_commit(top).get=
_parent())
> >
> > The last assertion here prevents the use of 'stg pick --reverse'.
> > This command creates an unapplied patch with top and bottom reverse=
d
> > and pushes it to force a three-way merge.
> >
> > It seems to work OK if I comment it out but I wonder whether it wil=
l
> > break in the future with the planned removal of the top and bottom
> > files.
>
> I think the assert represents a real constraint, namely that there ha=
s
> to be a 1:1 correspondance between patches and commits.
>
> Couldn't "stg pick --reverse" create a new commit and use that? That
> is, given that we want to revert commit C, create a new commit C* wit=
h

Series.new_patch already creates a commit, why should we move the
functionality to 'pick'? The only call to new_patch with commit=3DFalse
seems to be from 'uncommit' (and it makes sense indeed).

> And shouldn't there be a test for this? :-)

Yes :-). I think there are many other tests needed. It would be useful
to do a code coverage with the existing tests to see what we are
missing. Unit testing might be useful as well but we all have limited
spare time.

--=20
Catalin
