From: Fengguang Wu <lkp@intel.com>
Subject: Re: 0 bot for Git
Date: Wed, 13 Apr 2016 21:44:27 +0800
Message-ID: <20160413134427.GA21158@wfg-t540p.sh.intel.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
 <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
 <vpq60vnl28b.fsf@anie.imag.fr>
 <CAGZ79kaLQWVdehMu4nas6UBpCxnAB_-p=xPGH=aueMZXkGK_2Q@mail.gmail.com>
 <vpqoa9ea7vx.fsf@anie.imag.fr>
 <xmqqmvoypn7g.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Philip Li <philip.li@intel.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 15:44:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqL5x-0003gd-2z
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030688AbcDMNod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 09:44:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:34686 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934296AbcDMNod (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:44:33 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP; 13 Apr 2016 06:44:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,479,1455004800"; 
   d="scan'208";a="685594701"
Received: from zhuling1-mobl.ccr.corp.intel.com (HELO wfg-t540p.sh.intel.com) ([10.254.208.62])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Apr 2016 06:44:28 -0700
Received: from wfg by wfg-t540p.sh.intel.com with local (Exim 4.86)
	(envelope-from <lkp@intel.com>)
	id 1aqL5n-0005jW-3P; Wed, 13 Apr 2016 21:44:27 +0800
Content-Disposition: inline
In-Reply-To: <xmqqmvoypn7g.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291452>

> > I don't know how 0 bot solves this, but the obvious issue with this
> > approach is to allow dealing with someone sending a patch like
> >
> > +++ Makefile
> > --- Makefile
> > +all:
> > +	rm -fr $(HOME); sudo rm -fr /
> >
> > to the list. One thing that Travis gives us for free is isolation:
> > malicious code in the build cannot break the bot, only the build
> > itself.

Sure, isolation is a must have for public test services like Travis or
0day. We optimize the 0day infrastructure for good behaviors and also
have ways to isolate malicious ones.

> True, presumably the Travis integration already solves that part, so
> I suspect it is just the matter of setting up:
> 
>  - a fork of git.git and have Travis monitor any and all new
>    branches;
> 
>  - a bot that scans the list traffic, applies each series it sees to
>    a branch dedicated for that series and pushes to the above fork.
> 
> isn't it?

Right. 0day bot could auto maintain a patch-representing git tree for
Travis to monitor and test. As how we already did for the linux kernel
project, creating one git branch per patchset posted to the lists:

        https://github.com/0day-ci/linux/branches

In principle the git project should have more simple rules to decide
"which base should the robot apply a patch to". But we do need some
hints about the git community's rules in order to start the work. If
without such hints from the community, we may start with dumb rules
like "apply to latest origin/master" or "apply to latest release tag".

Thanks,
Fengguang
