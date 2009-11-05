From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Preserving branches after merging on ancestor
Date: Thu, 5 Nov 2009 16:30:04 -0600
Message-ID: <20091105223004.GA3224@progeny.tock>
References: <26217077.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Richard Lee <richard@webdezign.co.uk>
X-From: git-owner@vger.kernel.org Thu Nov 05 23:20:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6AhF-0004ks-Vn
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 23:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758992AbZKEWUj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Nov 2009 17:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758989AbZKEWUj
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 17:20:39 -0500
Received: from mail-gx0-f212.google.com ([209.85.217.212]:58348 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758987AbZKEWUi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 17:20:38 -0500
Received: by gxk4 with SMTP id 4so265937gxk.8
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 14:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dlxDvAyRoY6L75KNaOy2a9GqZKv0Njg7mQ6zRe0YOLg=;
        b=sziEpm7DN0IGBaKOuN6HnWEicp0hSVBzIPMJzBbCDWQFcIj43VJQutXE9Ti4jYwclM
         3m4G5wHprEvKGi94yvCcIlwCJkwjGsOeuVgldgJMLF0WZ0SdyQhzFGnfc0XMcHp3FJ8Y
         UlcWZGPpmkE6iY7NGTZh+tIjG0BODglr1YP2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=mFnjs8/c6XYEvUZ4z9BrK7Lp8qdO15ztT2UF8W2aU4I/EZRXlq9DYG/XBmZamjxRPH
         Pkm/kTQt1pXYnqHaDmLtSKZwbXbLKBbGAW9Iitix16HgbSucrxra6V0HC7W42blwhwKo
         IQe8L2vCKbpUgeWoEFyiJRYS6UM6uDB2F6Fes=
Received: by 10.101.155.38 with SMTP id h38mr2484261ano.146.1257459643236;
        Thu, 05 Nov 2009 14:20:43 -0800 (PST)
Received: from progeny.tock (wireless-239-184.uchicago.edu [128.135.239.184])
        by mx.google.com with ESMTPS id 8sm1126141yxb.43.2009.11.05.14.20.41
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Nov 2009 14:20:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <26217077.post@talk.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132250>

Hi Richard,

Richard Lee wrote:
=20
> One way of getting round this problem is to use empty commits on the =
master
> branch, as shown below.
>=20
> *   6fc04b5 Merge branch 'feature2'
> |\
> | * 07a117b stuff on feature2
> * | 52f5ba1 Empty commit
> |/
> *   5deaa93 Merge branch 'feature1'
> |\
> | * b163b17 stuff on feature1
> | * 53bb820 stuff on feature1
> | * c9ef14c stuff on feature1
> * | 34227a3 Empty commit
> |/
> * e88d332 Init
>=20
> But is this correct? It seems rather hackish to create empty commits =
on the
> master branch just to historically preserve commits on a seperate bra=
nch.
> Should I be using feature branches in git like this or another way? F=
or
> example more informative commit messages.=20

As Eric said, you can avoid the empty commits by passing 'git merge'
the --no-ff option, which would give the history I think you intend:

*   26749ab Merge branch 'feature2'
|\
| * b9cd8ff stuff on feature2
|/
*   829ba2c Merge branch 'feature1'
|\
| * b163b17 stuff on feature1
| * 53bb820 stuff on feature1
| * c9ef14c stuff on feature1
|/
* e88d332 Init

But doing this misses some of the main benefits of feature branches
imho.

If you base each feature branch on the stable release or features it
depends on instead, this gives you the freedom to merge one feature wit=
hout
the others to another branch.  For example:

# wouldn=E2=80=99t feature1 be neat? let me try it.
git checkout -b feature1 v1.0
hack hack hack
# looks good.
git commit -a

# how about an unrelated feature2?
git checkout -b feature2 v1.0
hack hack hack
# looks good.
git commit -a

# but do they work?
git checkout v1.0; # detach head for testing [1]
git merge feature1 feature2
make check
# hmm, these don=E2=80=99t seem to work well together
=2E.. (investigating some more)

# looks like feature1 is not ready for prime time
# so let=E2=80=99s just use feature2 for now.
git checkout master
git merge feature2
git branch -d feature2
make check
# looks good; better publish it.
git push origin master

v1.0 --- feature1
    \
     \-- feature2 [master]

As a nice side-effect, if you work this way then you can develop
feature2 without being distracted by new bugs introduced by feature1.

With many features built this way, the revision graph starts to give
some hints about relationships between features developed around the
same time.  For example, with the history

v1.0 --- feature1 --- feature2 -- feature4 -- feature6 - v1.1
                               \                        /
                                -- feature5 ------------

feature4 and feature5 are not likely to be closely related, but
feature4 and feature6 might be.  The exact history of merges is less
important than the general "shape" of the graph.

Thanks for the food for thought.

Hope that helps,
Jonathan

[1] See <http://www.kernel.org/pub/software/scm/git/docs/git-checkout.h=
tml#_detached_head>.
