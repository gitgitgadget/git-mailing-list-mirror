From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git clone --depth: shallow clone problems
Date: Tue, 26 May 2015 19:47:02 +0700
Message-ID: <20150526124702.GA12101@lanh>
References: <CALxdAKiyRMR-jF2KcBQGYgXUb+D8=YaESU3E9KN+zBLx=0UCNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michal Pomorski <misieck@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 26 15:13:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxEfR-0006Su-Qe
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 15:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695AbbEZMrm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 May 2015 08:47:42 -0400
Received: from [209.85.220.48] ([209.85.220.48]:35125 "EHLO
	mail-pa0-f48.google.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752641AbbEZMrk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 May 2015 08:47:40 -0400
Received: by pacwv17 with SMTP id wv17so92099356pac.2
        for <git@vger.kernel.org>; Tue, 26 May 2015 05:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=R7bKGDO1VZ4HtsQ4qx3yftoszX5JGhAWo2RuU4gVR50=;
        b=RR/rpKyxWdipucvW5TrsAgFHN30DrmLJcYdKilCnQHD5t+UehuxWtGEmU+nrITXXF0
         xDGZDC4Asbbp/cDy+1iv+IZQH85rOCilFgi1bDAAeY4RKqop1sHbee5+eAW9LvaMa56y
         4WlQ+7vngybAVO5Jj/+wokcL6awNjnFXALh5vtsNoZRgppkxx+UPEKYsEFUEmOnIL6ME
         /3uU/kSeoagkbhkQG2w8V/pQoOLeqeNXdULYKYHYnBC83a5dhQA0u0bE5KG61FX3XssU
         nNfFC5mzGzkn0GfCsl8z/YrvaAvpU+fcFlppQi7PO6pWy8bZoFv2hAJMk7Nq/JTQ8mA3
         jevQ==
X-Received: by 10.68.169.34 with SMTP id ab2mr47889845pbc.120.1432644420306;
        Tue, 26 May 2015 05:47:00 -0700 (PDT)
Received: from lanh ([115.73.44.199])
        by mx.google.com with ESMTPSA id rt8sm13009215pbb.37.2015.05.26.05.46.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2015 05:46:59 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 26 May 2015 19:47:02 +0700
Content-Disposition: inline
In-Reply-To: <CALxdAKiyRMR-jF2KcBQGYgXUb+D8=YaESU3E9KN+zBLx=0UCNw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269935>

On Thu, Apr 23, 2015 at 04:53:04PM +0200, Michal Pomorski wrote:
> tl: skip to the second paragraph
>=20
> So here is what I just experienced:
> We had an emergency error in an application at work and as the
> responsible developer was unavailable, I was asked to check it out an=
d
> look into it.
> We are a small branch of a bigger company and our connection to the
> company's source servers is really slow, so just to quickly start it
> up, I decided to take a shallow clone (that's what it is for, right?)=
=2E
> After a while we realized, the clone I have made was not sufficient
> and was missing some newest work done on the project.
> I did "git fetch --unshallow" which finished surprisingly quickly, an=
d
> it did not bring any newer commits.
> Unaware of the fine print hiding in the documentation of git clone, I
> blamed the repo (and in extension the person who provided me the
> address to it). After coming to a realization, a process which cost m=
e
> time and embarrassment, I understood what is supposed to be the
> "correct" behaviour:
> "--single-branch
> Clone only the history leading to the tip of a single branch, either
> specified by the --branch option or the primary branch remote's HEAD
> points at. When creating a shallow clone with the --depth option, thi=
s
> is the default, unless --no-single-branch is given to fetch the
> histories near the tips of all branches."
> Of course, the new commits were put on a custom branch, and I knew
> that all the time, but I expected the branch to show up eventually, a=
t
> least after git fetch --unshallow.
>=20
>
> I hope you can see the faults in the usability of the commands I was
> exposed to:
> 1) git clone --depth  should:
>    -warn about only fetching the current HEAD (name it by a real name
> if applicable)
> and/or
>    -require the --branch option so that it is not left to chance
> (current HEAD could be anything; is it really meaningful to talk abou=
t
> the current HEAD on a server?)
> and/or
>    -make the --no-single-branch the default...
> and maybe
>    -have the option to clone the most recent commits.

--single-branch being the default was because we (at least I, stilll)
believed it was the common case, so I don't think we should revert
it. But I can see --unshallow documentation is misleading. How about
this? I think it's better than what we have.

-- 8< --
Subject: [PATCH] fetch-options.txt: clarify what --unshallow does

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/fetch-options.txt | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index 45583d8..63d3452 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -14,12 +14,17 @@
 	branch history. Tags for the deepened commits are not fetched.
=20
 --unshallow::
-	If the source repository is complete, convert a shallow
-	repository to a complete one, removing all the limitations
+	If the source repository is complete, convert all shallow
+	refs to complete ones, removing all the limitations
 	imposed by shallow repositories.
 +
 If the source repository is shallow, fetch as much as possible so that
-the current repository has the same history as the source repository.
+the all existing refs of current repository have the same history as i=
n
+the source repository.
++
+Note that if the repository is created with --single-branch, which is
+default for a shallow clone, only one ref is completed. `--unshallow`
+does not fetch all remaining refs from source repository.
=20
 --update-shallow::
 	By default when fetching from a shallow repository,
--=20
2.3.0.rc1.137.g477eb31
-- 8< --

> 2) git fetch --unshallow should convert the clone into an actual
> equivalent of a normal, not shallow clone.

I was thinking of some way to undo --single-branch too. I don't think
it should be the job of --unshallow, maybe a new option, but I can't
think of a name better than --really-unshallow :P

It's been a while and no one responds to this, perhaps people are not
interested in such an option?

> 3) The documentation should be improved. The behaviour of --shallow i=
s
> described partly in the description of --no-single-branch. This is th=
e
> documentation equivalent of the infamous "come from" control flow
> structure.

Yes. Like this?

-- 8< --
Subject: [PATCH] clone.txt: mention --single-branch in --depth

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-clone.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index f1f2a3f..9c320da 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -185,7 +185,9 @@ objects from the source repository into a pack in t=
he cloned repository.
=20
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
-	specified number of revisions.
+	specified number of revisions. --single-branch is
+	automatically specified unless the user overrides it with
+	--no-single-branch
=20
 --[no-]single-branch::
 	Clone only the history leading to the tip of a single branch,
--=20
2.3.0.rc1.137.g477eb31

-- 8< --
