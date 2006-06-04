From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Using subversion tools on Mozilla CVS
Date: Sun, 4 Jun 2006 11:48:27 -0400
Message-ID: <9e4733910606040848t5ce63f2dv84fc8bad3e33f867@mail.gmail.com>
References: <9e4733910606032009p252ff5fai7401401427ae3ec3@mail.gmail.com>
	 <BAYC1-PASMTP08068F9BD23CF4FA8A1BDBAE970@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 17:49:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmuq8-0001cn-Cn
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 17:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWFDPs3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 11:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWFDPs3
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 11:48:29 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:55562 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751511AbWFDPs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 11:48:28 -0400
Received: by nz-out-0102.google.com with SMTP id s18so996457nze
        for <git@vger.kernel.org>; Sun, 04 Jun 2006 08:48:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sdWOdflO383wn4E3+BDlVywklbu1eTNOkIqnkyuk9eX35tq6au7hy4jaZvIBQDdefv1fVLLxwmmF0t7ae2rUmKm5j3Sh5YMKH8+3wTIaLo9yjtMKK40t6HMt1LfollCCK3Eg5uvx/wnBkxpLNT+Clg5h71DojdVFPhP8LBV7sd8=
Received: by 10.36.250.34 with SMTP id x34mr4925916nzh;
        Sun, 04 Jun 2006 08:48:28 -0700 (PDT)
Received: by 10.36.39.3 with HTTP; Sun, 4 Jun 2006 08:48:27 -0700 (PDT)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP08068F9BD23CF4FA8A1BDBAE970@CEZ.ICE>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21269>

On 6/4/06, Sean <seanlkml@sympatico.ca> wrote:
> On Sat, 3 Jun 2006 23:09:00 -0400
> "Jon Smirl" <jonsmirl@gmail.com> wrote:
>
> > I found this tool written in Python for importing CVS into Subversion.
> > It seems to be handling the Mozilla CVS repository with fewer problems
> > than parsecvs.
> >
> > http://cvs2svn.tigris.org/cvs2svn.html
> >
> > Since I'm not a native Python speaker, anyone else want to give a try
> > at changing it to support git?
>
> Hi Jon,
>
> If you haven't tried to import into git with a recent version of
> git-cvsimport, it would be worth a shot.

I tried it a couple of weeks ago and it barely made it into the
conversion. This repository is massive so if the tool doesn't scale
extremely well it quickly collapses.

I can't get it to run all the way, but I estimate that the git
parsecvs tool will need 11GB of RAM to import Mozilla CVS. Each time I
try to import the repository it runs 8-10 hours before failing. 11GB
process means you need a 64b machine.

> As for the tool you've referenced above, it does look pretty good.
> It makes multiple passes and saves to a temp file after each, letting
> you resume from that point and means it can use less memory overall.

This tool imported the Mozilla repository to SVN on the first try. It
needs about 10GB of temp disk space but it never took over 100MB of
RAM while running. It is much more advanced than anything git has. I'd
recommend reworking it to become git's main CVS import tool.

> It can produce a pretty straight forward looking dump file if you
> pass it the "--dump-only" option, rather than it pushing the results
> into svn; for instance:
>
>  $ cvs2svn --dump-only --dumpfile DUMPFILE <cvs directory>
>
> It shouldn't be too hard to write a script that imports the revisions
> found in the resulting DUMPFILE into git.

I haven't learned enough about GIT yet to figure out how to import the
change sets.
The cvs2svn tool uses eight passes to convert CVS into something SVN can use.
In the last pass it has turned everything into change sets and it
pipes them to a SVN process that commits them. Mozilla has 205,787
change sets. It would be best if there was some way to pipe things
into git, I suspect the dumpfile for Mozilla would be huge.

This command imports Mozilla CVS, I had to add --use-cvs since the RCS
tools can't handle all the strange options used in Mozilla CVS files.

cvs2svn --use-cvs -s svntest \
  --force-tag=THUNDERBIRD_0_7_RELEASE --force-tag=CVS \
 --force-branch=JAVADEV_RTM_20001102 \
 --force-branch=XPCOM_BRANCH_LANDING_981104 \
 --force-branch=MOZILLA_1_3_BRANCH \
 --force-branch=N3 \
 --force-branch=SeaMonkey_M4_BRANCH \
 --force-branch=NORMANDY_BRANCH \
 --force-branch=FASTLOAD_20010529_BRANCH \
 --force-branch=MozillaSourceClassic_19981026_BRANCH \
 --force-branch=RDF_19981124_BRANCH \
 --force-branch=OTIS_TEST_BRANCH \
 --force-branch=Netscape61_PR1_Mini_BRANCH \
 --force-branch=XPCOM20_BRANCH \
 --force-branch=XPC_IDISP_20020417_BRANCH \
 --force-branch=RDF_122898_BRANCH \
 --force-branch=MOZILLA_1_4_BRANCH \
 --force-branch=Netscape_20000922_BRANCH \
 --force-branch=NETSCAPE_7_0_OEM_BRANCH \
 --force-branch=RDF_19990407_BRANCH \
 --force-branch=ALERT_SERVICE_BRANCH \
 --force-branch=SeaMonkey_M12_BRANCH \
 --force-branch=SpiderMonkey140_NES40Rtm_Branch \
mozilla/mozilla

It takes about 16 hours to convert MozCVS with this command on my
machine. Once you have done the full conversion you can rerun the last
pass without rerunning the others. That makes it easier to develop GIT
support since you don't have to do the entire conversion each time.

cvs2svn -p 8 --use-cvs -s svntest \
  --force-tag=THUNDERBIRD_0_7_RELEASE --force-tag=CVS \
 --force-branch=JAVADEV_RTM_20001102 \
 --force-branch=XPCOM_BRANCH_LANDING_981104 \
 --force-branch=MOZILLA_1_3_BRANCH \
 --force-branch=N3 \
 --force-branch=SeaMonkey_M4_BRANCH \
 --force-branch=NORMANDY_BRANCH \
 --force-branch=FASTLOAD_20010529_BRANCH \
 --force-branch=MozillaSourceClassic_19981026_BRANCH \
 --force-branch=RDF_19981124_BRANCH \
 --force-branch=OTIS_TEST_BRANCH \
 --force-branch=Netscape61_PR1_Mini_BRANCH \
 --force-branch=XPCOM20_BRANCH \
 --force-branch=XPC_IDISP_20020417_BRANCH \
 --force-branch=RDF_122898_BRANCH \
 --force-branch=MOZILLA_1_4_BRANCH \
 --force-branch=Netscape_20000922_BRANCH \
 --force-branch=NETSCAPE_7_0_OEM_BRANCH \
 --force-branch=RDF_19990407_BRANCH \
 --force-branch=ALERT_SERVICE_BRANCH \
 --force-branch=SeaMonkey_M12_BRANCH \
 --force-branch=SpiderMonkey140_NES40Rtm_Branch \
mozilla/mozilla


-- 
Jon Smirl
jonsmirl@gmail.com
