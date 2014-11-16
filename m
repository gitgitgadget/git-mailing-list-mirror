From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] difftool: honor --trust-exit-code for builtin tools
Date: Sat, 15 Nov 2014 18:36:10 -0800
Message-ID: <20141116023609.GA74487@gmail.com>
References: <1416000835-79274-1-git-send-email-davvid@gmail.com>
 <xmqqy4rd1mdw.fsf@gitster.dls.corp.google.com>
 <CAHYJk3Q9tcS+o0hDnDz24ysSKkL6m16OmhyHuj=W88VQjTximw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Adri Farr <14farresa@gmail.com>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 03:36:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpphI-0003Ag-IJ
	for gcvg-git-2@plane.gmane.org; Sun, 16 Nov 2014 03:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186AbaKPCgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2014 21:36:12 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:39423 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755095AbaKPCgM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2014 21:36:12 -0500
Received: by mail-pd0-f173.google.com with SMTP id v10so19066706pde.32
        for <git@vger.kernel.org>; Sat, 15 Nov 2014 18:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=YxsicfhN+79oGUMJQho+AzCC/6pdb5lcKWBE1pX/ChA=;
        b=D4meiNe1Bsy8kyC5XtBcmvWuFiD+Ohfr8P8vrnyuSWww4yUrBeeoth+V2bseirFbd+
         DSZUCJnemdetUplgPYKFPrO5hRUpNbFM9plIwt44YbVHaAahOomCXYJX5MyrOisnZNM9
         7N/fw6GLhuaSNWe4sIOCCDMAlEEWjWXWKON0crIDq87LU6uOxp+XVFRauGDMA0vE7CoP
         mBo15vDcAuVpSnZyqSNTPt1MS2d1PTpFn87wXCXPOK58PSQTkXhay+kJR66pHFlZhY+F
         3HFRs77VntxiErparRSxD3Mv6Vi+tB9K8c5EnIKVeckdlh9YsB8JayYQJgLky3VoFWyT
         DKOw==
X-Received: by 10.68.231.33 with SMTP id td1mr20675387pbc.26.1416105371801;
        Sat, 15 Nov 2014 18:36:11 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id ev8sm31410446pdb.28.2014.11.15.18.36.09
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 15 Nov 2014 18:36:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAHYJk3Q9tcS+o0hDnDz24ysSKkL6m16OmhyHuj=W88VQjTximw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 16, 2014 at 02:51:11AM +0100, Mikael Magnusson wrote:
> On Fri, Nov 14, 2014 at 10:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > David Aguilar <davvid@gmail.com> writes:
> >
> >> run_merge_tool() was not setting $status, which prevented the
> >> exit code for builtin tools from being forwarded to the caller.
> >>
> >> Capture the exit status and add a test to guarantee the behavior.
> >>
> >> Reported-by: Adria Farres <14farresa@gmail.com>
> >> Signed-off-by: David Aguilar <davvid@gmail.com>
> >> ---
> >>  git-mergetool--lib.sh | 1 +
> >>  t/t7800-difftool.sh   | 5 +++++
> >>  2 files changed, 6 insertions(+)
> >>
> >> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> >> index a40d3df..2b66351 100644
> >> --- a/git-mergetool--lib.sh
> >> +++ b/git-mergetool--lib.sh
> >> @@ -221,6 +221,7 @@ run_merge_tool () {
> >>       else
> >>               run_diff_cmd "$1"
> >>       fi
> >> +     status=$?
> >>       return $status
> >>  }
> >
> > Thanks for a quick turn-around.  As a hot-fix for what is already in
> > -rc I am fine with this fix but the patch makes me wonder if $status
> > as a global shell variable has any significance.
> 
> $status is an alias for $? in zsh, and so cannot be assigned to. But
> other than that I don't think it holds any meaning and should be fine
> in a .sh script.


Thanks for the heads-up ~ this is even more reason to cleanup
the script a bit.

If we still need a local variable for it in a few places then I'll
call it $rc instead, but it'll only be used for local things
rather than its current global usage.
-- 
David
