From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: git push tags
Date: Fri, 26 Oct 2012 20:20:20 +0200
Message-ID: <20121026182020.GF10560@camk.edu.pl>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
 <CAM9Z-nkxCOyrtJ8vCF=00vrA_1eFr2-Fk7PXjYEx0HbVt0GPkQ@mail.gmail.com>
 <CAB9Jk9A95YrrtH8ue-CJ6Mqe9Z+3nfo=tjurLZjmecfiMFijvg@mail.gmail.com>
 <CAM9Z-nkosbe1NXYnu7x6v4seLqCnMBWg-jrdH2eJ9RetaZBTyQ@mail.gmail.com>
 <20121026174255.GE10560@camk.edu.pl>
 <CAM9Z-nkBO1dbF-sBFLuxM_S_MT79Cx=gLEL+83XKB7ys8VTqNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 20:20:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRoWQ-0006fy-45
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 20:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965861Ab2JZSUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 14:20:30 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:43797 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965556Ab2JZSU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 14:20:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 21B265F0048;
	Fri, 26 Oct 2012 20:20:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id c6mZD9GTWFiX; Fri, 26 Oct 2012 20:20:21 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id B9BD05F0047;
	Fri, 26 Oct 2012 20:20:21 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 7CB3443CFD; Fri, 26 Oct 2012 20:20:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAM9Z-nkBO1dbF-sBFLuxM_S_MT79Cx=gLEL+83XKB7ys8VTqNQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208474>

On Fri, Oct 26, 2012 at 02:07:09PM -0400, Drew Northup wrote:
> On Fri, Oct 26, 2012 at 1:42 PM, Kacper Kornet <draenog@pld-linux.org> wrote:
> > On Thu, Oct 25, 2012 at 05:16:00PM -0400, Drew Northup wrote:
> >> On Thu, Oct 25, 2012 at 3:05 PM, Angelo Borsotti
> >> <angelo.borsotti@gmail.com> wrote:
> >> > Are remote repositories less protected than the local ones? I
> >> > think that to be consistent, the same strategy should be used on all
> >> > repositories, i.e. rejecting changes on tags by default, unless they
> >> > are forced.

> >> So here we come to the core argument. Is sounds to me like you want
> >> changes to remote tags to work differently from push updates to ALL
> >> other references. The required change, if I'm not mistaken, would be
> >> for tags to not permit fast-forward updates while all other references
> >> would be pushed normally. From my brief and un-enlightened look at the
> >> push code I can't see that being as easy as it sounds.

> > I think the patch below obtains the requested behaviour:

> > diff --git a/remote.c b/remote.c
> > index 04fd9ea..7fcb51e 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -1320,7 +1320,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
> >                         !ref->deletion &&
> >                         !is_null_sha1(ref->old_sha1) &&
> >                         (!has_sha1_file(ref->old_sha1)
> > -                         || !ref_newer(ref->new_sha1, ref->old_sha1));
> > +                         || !prefixcmp(ref->name, "refs/tags") || !ref_newer(ref->new_sha1, ref->old_sha1));

> >                 if (ref->nonfastforward && !ref->force && !force_update) {
> >                         ref->status = REF_STATUS_REJECT_NONFASTFORWARD;

> > --
> >   Kacper Kornet

> Kacper,
> I obviously didn't dig deep enough. In any case, I presume that's what
> he's asking for. I can't remember if git is still forcing tags to
> always be located in "refs/tags" however. I didn't think it was.

I have based my assumption about location of tags on gitglossary:

tag
 A ref under refs/tags/ namespace that points to an object of an
 arbitrary type (typically a tag points to either a tag or a commit
 object).

-- 
  Kacper
