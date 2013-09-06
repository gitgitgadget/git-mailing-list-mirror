From: Corey Thompson <cmtptr@gmail.com>
Subject: Re: git-p4 out of memory for very large repository
Date: Fri, 6 Sep 2013 15:03:45 -0400
Message-ID: <20130906190345.GA3239@jerec>
References: <20130823011245.GA7693@jerec>
 <52170C6A.4080708@diamand.org>
 <20130823114856.GA8182@jerec>
 <20130825155001.GA875@padd.com>
 <20130826134756.GA1335@jerec>
 <20130828154135.GA16921@jerec>
 <20130829224609.GB25879@padd.com>
 <5224EA2C.7090001@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Sep 06 21:03:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI1K1-0008Qz-IW
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 21:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046Ab3IFTDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 15:03:53 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:46217 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab3IFTDw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 15:03:52 -0400
Received: by mail-yh0-f42.google.com with SMTP id z12so1377551yhz.29
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 12:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CtELb+oNayirzQ90tT4fe0KaUeS8Srk9gGBagKMVOvc=;
        b=kabrE/pj4eiQGQb6Kack1JSVXWvgOZB+At3up3MEAQGO37IkqLtE2+cS+uLBMAXsQc
         3acfbj6MqUDUHc6BB6Bs/idt2yjGgA3Z/23P81+5cEPARSDDdvdO6j64DCVJkjyMnlap
         RubRpagCX8J0byWwfN23sipQv9kinUvKrAeXeLBfUaIuKlGBVRSI6Yq7CB5CaUZVUHnH
         sZofndnxFQEQse/XMrGB82lQDDklk9Qb697zhgVz7agVi3G04Eeh7YZOXskxX5qSRg6d
         8hnXYOuMZ6krFS7XNxOk3dptZJZxbYceoijLTFAqmv65gzuZDoB/9FF/x7Lub8GnEQ/J
         tV+w==
X-Received: by 10.236.144.169 with SMTP id n29mr3542769yhj.46.1378494232232;
        Fri, 06 Sep 2013 12:03:52 -0700 (PDT)
Received: from jerec (c-71-59-19-88.hsd1.ga.comcast.net. [71.59.19.88])
        by mx.google.com with ESMTPSA id w42sm4681027yhb.8.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Sep 2013 12:03:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5224EA2C.7090001@diamand.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234087>

On Mon, Sep 02, 2013 at 08:42:36PM +0100, Luke Diamand wrote:
> I guess you could try changing the OOM score for git-fast-import.
> 
> change /proc/<pid>/oomadj.
> 
> I think a value of -31 would make it very unlikely to be killed.
> 
> On 29/08/13 23:46, Pete Wyckoff wrote:
> >I usually just do "git p4 sync @505859".  The error message below
> >crops up when things get confused.  Usually after a previous
> >error.  I tend to destroy the repo and try again.  Sorry I don't
> >can't explain better what's happening here.  It's not a memory
> >issue; it reports only 24 MB used.
> >
> >Bizarre.  There is no good explanation why memory usage would go
> >up to 32 GB (?) within one top interval (3 sec ?).  My theory
> >about one gigantic object is debunked:  you have only the 118 MB
> >one.  Perhaps there's some container or process memory limit, as
> >Luke guessed, but it's not obvious here.
> >
> >The other big hammer is "strace".  If you're still interested in
> >playing with this, you could do:
> >
> >     strace -vf -tt -s 200 -o /tmp/strace.out git p4 clone ....
> >
> >and hours later, see if something suggests itself toward the
> >end of that output file.
> >
> >		-- Pete
> 

Finally, I claim success!  Unfortunately I did not try either of the OOM
score or strace suggestions - sorry!  After spending so much time on
this, I've gotten to the point that I'm more interested in getting it to
work than in figuring out why the direct approach isn't working; it
sounds like you're both pretty confident that git is working as it
should, and I don't maintain the system I'm doing this on so I don't
doubt that there might be some artificial limit or other quirk here that
we just aren't seeing.

Anyway, what I found is that Pete's incremental method does work, I just
have to know how to do it properly!  This is what I WAS doing to
generate the error message I pasted several posts ago:

git clone //path/to/branch@<begin>,<stage1>
cd branch
git sync //path/to/branch@<stage2>
# ERROR!
# (I also tried //path/to/branch@<stage1+1>,<stage2>, same error)

Eventually what happened is that I downloaded the free 20-user p4d, set
up a very small repository with only 4 changes, and started some old
fashioned trial-and-error.  Here's what I should have been doing all
along:

git clone //path/to/branch@<begin>,<stage1>
cd branch
git sync //path/to/branch@<begin>,<stage2>
git sync //path/to/branch@<begin>,<stage3>
# and so on...

And syncing a few thousand changes every day over the course of the past
week, my git repo is finally up to the Perforce HEAD.  So I suppose
ultimately this was my own misunderstanding, partly because when you
begin your range at the original first change number the output looks
suspiciously like it's importing changes again that it's already
imported.  Maybe this is all documented somewhere, and if it is I just
failed to find it.

Thanks to both of you for all your help!
Corey
