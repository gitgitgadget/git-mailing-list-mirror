From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 26 Sep 2011 18:12:31 -0600
Organization: CAF
Message-ID: <201109261812.31738.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <201109261552.04946.mfick@codeaurora.org> <ece30e6a1b74bcddde5634003408f61f@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 27 02:12:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8LHp-0000kv-LC
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 02:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172Ab1I0AMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 20:12:33 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:4977 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab1I0AMd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 20:12:33 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6481"; a="121760874"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 26 Sep 2011 17:12:32 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 8AD8B10004BE;
	Mon, 26 Sep 2011 17:12:32 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <ece30e6a1b74bcddde5634003408f61f@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182198>

On Monday, September 26, 2011 05:26:55 pm Julian Phillips 
wrote:
> On Mon, 26 Sep 2011 15:52:04 -0600, Martin Fick wrote:
> > On Monday, September 26, 2011 03:39:33 pm Martin Fick 
wrote:
> >> On Monday, September 26, 2011 02:28:53 pm Julian
> >> Phillips
> >> In my case it was called 18785 times!  Any other tests
> >> I should run?
> > 
> > Gerrit stores the changes in directories under
> > refs/changes named after the last 2 digits of the
> > change.  Then under each change it stores each
> > patchset.  So it looks like this:
> > refs/changes/dd/change_num/ps_num
> > 
> > I noticed that:
> >  ls refs/changes/* | wc -l
> >  -> 18876
> > 
> > somewhat close, but not super close to 18785,  I am not
> > sure if that is a clue.  It's almost like each change
> > is causing a re-sort,
> 
> basically, it is ...
> 
> Back when I made that change, I failed to notice that
> get_ref_dir was recursive for subdirectories ... sorry
> ...
> 
> Hopefully this should speed things up.  My test repo went
> from ~17m user time, to ~2.5s.
> Packing still make things much faster of course.

Excellent!  This works (almost, in my refs.c it is called 
sort_ref_list, not sort_refs_list).  So, on the non garbage 
collected repo, git branch now takes ~.5s, and in the 
garbage collected one it takes only ~.05s!

Thanks way much!!!

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
