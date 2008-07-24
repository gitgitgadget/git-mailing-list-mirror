From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Thu, 24 Jul 2008 16:00:16 +0700
Message-ID: <fcaeb9bf0807240200x10a6a267h4c37e4566da967ba@mail.gmail.com>
References: <20080723145518.GA29035@laptop>
	 <loom.20080724T065737-580@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "James Pickens" <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 11:01:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLwhM-0005sB-HS
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 11:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbYGXJAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 05:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbYGXJAT
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 05:00:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:56022 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbYGXJAS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 05:00:18 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1343664fgg.17
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 02:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OewAsd8jQT+nruqvdFTQMROQkMcj97XIVhK6/CsXyA0=;
        b=Qdcr1BCe1bNzJv/sFikNt4uYEW1LVT3Mod7MamX822LPPUQkeUlxcULSy4x+dQ9e1P
         EnsisDgsPotBERQyBALvFurRD/6nnyFshklw0C0bi8vR13vuzzewKy0xfcBSiGDvrYoe
         FlI2Gy1OovSln0RbEOIQtZUiOIXSoCJC+snOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fmkS1xDXPz+G1NcFXc+fuwtk5op0dZaJpwWoBmNA7vorLHCTgtsCIP94JD2bbhowff
         uZ2QHXoh3xvdGaxKkmNyZdO1f2EcBCaqzYBYGdRJSbRCQnz/NjaNrCzRBlBf92xF9yiC
         jGGJo9O9y2wJW6AhNRUuTbfawQ3JmDViUxfks=
Received: by 10.86.70.11 with SMTP id s11mr641126fga.45.1216890016454;
        Thu, 24 Jul 2008 02:00:16 -0700 (PDT)
Received: by 10.86.91.2 with HTTP; Thu, 24 Jul 2008 02:00:16 -0700 (PDT)
In-Reply-To: <loom.20080724T065737-580@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89856>

On 7/24/08, James Pickens <jepicken@gmail.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:
>
>  > I have not looked at non-builtin commands yet, but I think it's not
>  > a big deal. We have several rounds before this series is good enough ;)
>  > So in short, sparse prefix will be stored in config, core.sparsecheckout.
>  > you have three new commands to enter/update/leave sparse checkout:
>  >
>  > git clone --path=prefix       # clone with sparse checkout
>  > git checkout --path=prefix    # limit/update checkout paths
>  > git checkout --full           # stop sparse checkout
>  >
>
>
> First things first, thanks a lot for working on this feature.  I have an
>  enormous project in CVS (144GB repo, containing 65000 directories and
>  463000 files) that I've been wanting to convert to git for a while now,
>  and the lack of sparse checkouts was the only thing about git that was
>  standing in the way.  The project is so big that checking out the whole
>  tree all the time is unworkable, and I think my coworkers would hang me
>  if I tried to make them use submodules.  We already use sparse checkouts
>  in CVS to make it manageable, so sparse checkout support in git would
>  vastly simplify the transition.
>
>  I played around with the patch briefly, and I have a couple of comments
>  on the interface.
>
>  First, I would want a capability to checkout a directory non-recursively.
>  I.e., checkout directory A/B, without also checking out directory A/B/C.
>  Perhaps a modifier could be added to a path element to make it
>  non-recursive.

This one is difficult (and may probably produce more intrusive patch).
Let's see what I can do.

>  Second, I would want a capability to checkout and release directories
>  incrementally, similar to how we do it in cvs.  For example, I might do
>  the following in cvs:
>
>  $ cvs co -l A         # Checkout dir A non-recursively
>  $ cd A
>  $ cvs up -l -d B1 B2  # Checkout dirs A/B1 and A/B2 non-recursively
>  $ cd B1
>  $ cvs up -d C1 C2     # Checkout dirs A/B1/C1 and A/B1/C2 recursively
>  (Oops, didn't need C2)
>  $ cvs release -d C2
>  At this point I would have the following directory tree, assuming the C1
>  directory in the repo contained a D1 directory:
>
>  A/
>  A/B1/
>  A/B1/C1/
>  A/B1/C1/D1/
>  A/B2/
>
>  A similar capability in git would be much appreciated.

You can do that with "git checkout --path" (non-recursive checkout aside):

$ git checkout --path=A                     # checkout full A
$ git checkout --path=A/B1/C1               # no, limit to A/B1/C1 only
$ git checkout --path=A/B1/C1:A/B2          # extend to A/B2 too

>
>  Finally, I noticed what I think is a bug: if you do a partial checkout of
>  a non-existing directory, you just get an empty tree.  I would expect to
>  get an error message in that case.

Thanks.

>  I hope this is helpful, and thanks again for working on this.
>
>  James
>
>
>
>  --
>  To unsubscribe from this list: send the line "unsubscribe git" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Duy
