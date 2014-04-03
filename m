From: Jonathan Nieder <jrn@google.com>
Subject: Re: [PATCH V2 0/7] fix hunk editing with 'commit -p -m'
Date: Thu, 3 Apr 2014 15:11:15 -0700
Message-ID: <20140403221115.GA23467@google.com>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 04 00:11:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVpr1-0008Tr-BG
	for gcvg-git-2@plane.gmane.org; Fri, 04 Apr 2014 00:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbaDCWLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2014 18:11:18 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:48489 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbaDCWLR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2014 18:11:17 -0400
Received: by mail-pa0-f73.google.com with SMTP id kq14so425764pab.2
        for <git@vger.kernel.org>; Thu, 03 Apr 2014 15:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zq7RuTHR0GWd3KQNm49+1Za4vafuiH/iZNRIRn6fR7k=;
        b=lRoXmoqDRwxMRVbA9PQVESOcc0+QnnZa/ggfC49ECbL46VcOeK4a+dKgAiqZaFXrnM
         jsbaQSU0sTBlENmgMSmUZ3XfeAyP2yVGN7+rondjrV/5pmbM7jmb+zK4bZGB2g8bav27
         kZlU88zk/+qFqeqZ5RU8Vj4oXAOYw4AHMPOhdz/oTVnCyMRSc246dH/6aKGi879V2f4A
         QHqY/Qlo4LDvrDk9eD1gWUO3YZE7FVphi9IvFkKwWnsF8/+qS0AqIXdiS27ZF6wRYwzz
         lw/7Xh9Kf5NA1rGpU7s/uisPDPX45O3GO1R1Oi0Izo/BIdr7iSiVNl5YT8xMG/HTV83T
         ltaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=zq7RuTHR0GWd3KQNm49+1Za4vafuiH/iZNRIRn6fR7k=;
        b=MgAbQBwhWSOpF3/sYCPJwshonCAZYnsFHnyO3X41qzY8fbXK1jxoTJAd+TpOmEIXII
         HOhOwiwbOOnzScvSNDTeW0mY5lFyYfQ4uc7S7ABnqCEXyBGWh4DB2mJUZKH7lHWhne/m
         VYwfdz6MHwYlyZa43ub7jhnrmU0zMFglNZPUFVHsOyTUAI/ihXyriVMqhL+Cx1vzJizY
         LLv1xIYal16MvEd3J4NpE88dpYAf0oZNjtCX8lDPQiXrCf1c179NQwnKFSPVyynnbfTw
         dIOJ4DR8CGZzRRQFa+PivvPRhagu/0JMsH1OKNikTkRaCDMfnp/feavJVNAIxuXEqEsY
         L0uw==
X-Gm-Message-State: ALoCoQmSLLisnbYHn+wAzgM5+LXTUO195pJ824j4hJzHv1u3tf7nfTyPI/E8hh3SJDPVASPksdxYjyA0dS17KWolCYQA4t/ZYc1j04309ohEdVm7BNDr1QmwzsP74wKyc3ixksQniBh1HwgjIjihS4fE+s+yxayC/MsNgbPhsaiEPGEeDV7QGJ2T4GPWnqUa83UeySrxyYlo
X-Received: by 10.66.190.202 with SMTP id gs10mr5517155pac.0.1396563076317;
        Thu, 03 Apr 2014 15:11:16 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id s65si1239230yhc.2.2014.04.03.15.11.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Apr 2014 15:11:16 -0700 (PDT)
Received: from aiede.mtv.corp.google.com (aiede.mtv.corp.google.com [172.27.69.120])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 11FB231C121;
	Thu,  3 Apr 2014 15:11:16 -0700 (PDT)
Received: by aiede.mtv.corp.google.com (Postfix, from userid 183862)
	id 9CB931A15EE; Thu,  3 Apr 2014 15:11:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245755>

Hi,

A quick note for the future:

Benoit Pierre wrote:

> This patch fixes the fact that hunk editing with 'commit -p -m' does not work:
> GIT_EDITOR is set to ':' to indicate to hooks that no editor will be launched,
> which result in the 'hunk edit' option not launching the editor (and selecting
> the whole hunk).

This information should have gone in the relevant patch's commit
message itself.  That way, people don't have to hunt down the relevant
mailing list thread to understand the patch.

Generally a cover letter should say as little as possible (mostly
"here is what patch you might want to look at first, and here is an
overview of why the patches are in this particular order").

Thanks for a nice fix.  Perhaps we'll see more in the future, hence
this note. :)  And if you have ideas for where an explanation of this
could go in the documentation (somewhere in
Documentation/SubmittingPatches?), that would be welcome too.

Thanks,
Jonathan
