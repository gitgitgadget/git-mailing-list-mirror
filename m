From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Saving space/network on common repos
Date: Mon, 22 Dec 2014 19:12:33 -0800
Message-ID: <20141223031233.GX29365@google.com>
References: <CAGXKyzEYhR69w1=4q-xtBagVBwOPqNA9C=AD0bAorB+5eRtVRg@mail.gmail.com>
 <20141217223215.GO29365@google.com>
 <CAGXKyzEqTik3p=A8NZJ6kUscFjw_Dh1mBPT-ciwq9L8kNKDDig@mail.gmail.com>
 <20141218000723.GP29365@google.com>
 <CAGXKyzGnnt6bBEPoy4nvNn=zX0hdRHpgvsAe263apaDsVxv0dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Craig Silverstein <csilvers@khanacademy.org>
X-From: git-owner@vger.kernel.org Tue Dec 23 04:12:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Ftq-00064I-73
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 04:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754233AbaLWDMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 22:12:37 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:60831 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbaLWDMg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 22:12:36 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so5417139iec.15
        for <git@vger.kernel.org>; Mon, 22 Dec 2014 19:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CwNvpXr6Hmqb7ImTE43PYhOw4wLG6yaionG5GwkJAVA=;
        b=IWQiLd3zbZBCREE6BV7t6DDezWRCxTZRNHuIatdMzWKoVE4PVi5RbRv/3RVG1lCDT5
         R0O8OOzj74YCig/0bPU7/GsXxLP0hoNrCcvusRivCFx+MD9Z9ndxIBeAY513K4Tbge+0
         xq4p4JiuBsD/gGlH65HpwSFO/jxXlzXhiNUmXwsHUK3TNLrJ57Dbe4HJ0ZEtBF7IeOAP
         sIMNgk3kbnzNJREUzsY+40vt2tyzVfv1P9K9xwE5+F8kFgsQydzyt5XMoATwWRZmVCvn
         /+l5iJP2PYO9Z2nyYKspCC02mjgUD36AeBN1xzUfDQewyuSJZeHxFu/25n7aIz2Tp0Wh
         cIKA==
X-Received: by 10.50.28.20 with SMTP id x20mr19344612igg.27.1419304355893;
        Mon, 22 Dec 2014 19:12:35 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:d0f3:eebb:4e13:baf])
        by mx.google.com with ESMTPSA id g18sm9377615ioe.35.2014.12.22.19.12.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Dec 2014 19:12:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGXKyzGnnt6bBEPoy4nvNn=zX0hdRHpgvsAe263apaDsVxv0dA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261712>

Craig Silverstein wrote:

> btw, just FYI, the scheme you lay out here doesn't actually work
> as-is.  The problem is the config file, which has an entry like:
>            worktree = ../../../mysubmodule
> This depends on the config file living in
> ./git/modules/mysubmodule/config.  But the proposed scheme moves the
> config file to mysubmodule/.git/config, and the relative path is
> broken.

As was pointed out to me privately, the behavior is exactly as you
described and I had confused myself by looking at directory that
wasn't even made with git-new-workdir.  Sorry for the nonsense.

Workdirs share a single config file because information associated to
branches set by "git branch --set-upstream-to", "git branch
--edit-description", "git remote", and so on are stored in the config
file.

The 'git checkout --to' series in "pu" avoids this problem by ignoring
core.bare and core.worktree in worktrees created with 'git checkout --to'.
To try it:

	git clone https://kernel.googlesource.com/pub/scm/git/git
	cd git
	git merge 'origin/pu^{/nd/multiple-work-trees}^2'
	make
	PATH=$(pwd)/bin-wrappers:$PATH

	git checkout --to=../experiment next

This seems like good motivation to try to get that series in good
shape and release it soon.

Thanks again,
Jonathan
