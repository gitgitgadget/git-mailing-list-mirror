From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: git push tags
Date: Fri, 26 Oct 2012 19:42:55 +0200
Message-ID: <20121026174255.GE10560@camk.edu.pl>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
 <CAM9Z-nkxCOyrtJ8vCF=00vrA_1eFr2-Fk7PXjYEx0HbVt0GPkQ@mail.gmail.com>
 <CAB9Jk9A95YrrtH8ue-CJ6Mqe9Z+3nfo=tjurLZjmecfiMFijvg@mail.gmail.com>
 <CAM9Z-nkosbe1NXYnu7x6v4seLqCnMBWg-jrdH2eJ9RetaZBTyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 20:07:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRoJl-0005GI-7y
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 20:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965686Ab2JZSHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 14:07:23 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:41407 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965639Ab2JZSHW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 14:07:22 -0400
X-Greylist: delayed 1457 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Oct 2012 14:07:22 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id BCEB65F004C;
	Fri, 26 Oct 2012 19:43:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id QlR7cZvhLAgk; Fri, 26 Oct 2012 19:42:57 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 40B435F0048;
	Fri, 26 Oct 2012 19:42:57 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 04BCE43CFD; Fri, 26 Oct 2012 19:42:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAM9Z-nkosbe1NXYnu7x6v4seLqCnMBWg-jrdH2eJ9RetaZBTyQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208473>

On Thu, Oct 25, 2012 at 05:16:00PM -0400, Drew Northup wrote:
> On Thu, Oct 25, 2012 at 3:05 PM, Angelo Borsotti
> <angelo.borsotti@gmail.com> wrote:
> > Are remote repositories less protected than the local ones? I
> > think that to be consistent, the same strategy should be used on all
> > repositories, i.e. rejecting changes on tags by default, unless they
> > are forced.

> So here we come to the core argument. Is sounds to me like you want
> changes to remote tags to work differently from push updates to ALL
> other references. The required change, if I'm not mistaken, would be
> for tags to not permit fast-forward updates while all other references
> would be pushed normally. From my brief and un-enlightened look at the
> push code I can't see that being as easy as it sounds.

I think the patch below obtains the requested behaviour:

diff --git a/remote.c b/remote.c
index 04fd9ea..7fcb51e 100644
--- a/remote.c
+++ b/remote.c
@@ -1320,7 +1320,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 			!ref->deletion &&
 			!is_null_sha1(ref->old_sha1) &&
 			(!has_sha1_file(ref->old_sha1)
-			  || !ref_newer(ref->new_sha1, ref->old_sha1));
+			  || !prefixcmp(ref->name, "refs/tags") || !ref_newer(ref->new_sha1, ref->old_sha1));
 
 		if (ref->nonfastforward && !ref->force && !force_update) {
 			ref->status = REF_STATUS_REJECT_NONFASTFORWARD;

-- 
  Kacper Kornet
