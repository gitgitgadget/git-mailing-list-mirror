From: Martin Fick <mfick@codeaurora.org>
Subject: Re: RefTree: Alternate ref backend
Date: Tue, 22 Dec 2015 13:56:50 -0700
Message-ID: <6263203.WlZuyGWxlh@mfick1-lnx>
References: <CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com> <567985A8.2020301@alum.mit.edu> <4689734.cEcQ2vR0aQ@mfick1-lnx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 22 21:56:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBTzN-0007vo-5f
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 21:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933767AbbLVU4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 15:56:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49812 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933063AbbLVU4w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 15:56:52 -0500
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1EEEF60325;
	Tue, 22 Dec 2015 20:56:52 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1336E60317; Tue, 22 Dec 2015 20:56:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mfick1-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: mfick@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 6C23A60232;
	Tue, 22 Dec 2015 20:56:51 +0000 (UTC)
User-Agent: KMail/4.8.5 (Linux/3.2.0-75-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <4689734.cEcQ2vR0aQ@mfick1-lnx>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282907>

On Tuesday, December 22, 2015 06:17:28 PM you wrote:
> On Tue, Dec 22, 2015 at 7:41 AM, Michael Haggerty
<mhagger@alum.mit.edu> wrote:
>
> At a deeper level, the "refs/" part of reference names is
> actually pretty useless in general. I suppose it
> originated in the practice of storing loose references
> under "refs/" to keep them separate from other metadata
> in $GIT_DIR. But really, aside from slightly helping
> disambiguate references from paths in the command line,
> what is it good for? Would we really be worse off if
> references' full names were
>
>     HEAD
>     heads/master
>     tags/v1.0.0
>     remotes/origin/master (or remotes/origin/heads/master)

I think this is a bit off, because

  HEAD != refs/HEAD

so not quite useless.

But, I agree that the whole refs notation has always bugged
me, it is quirky.  It makes it hard to disambiguate when
something is meant to be absolute or not.  What if we added
a leading slash for absolute references? Then I could do
something like:

/HEAD
/refs/heads/master
/refs/tags/v1.0.0
/refs/remotes/origin/master

I don't like that plumbing has to do a dance to guess at
expansions, how many tools get it wrong (do it in different
orders, miss some expansions...).  With an absolute
notation, plumbing could be built to require absolute
notations, giving more predictable interpretations when
called from tools.

This is a long term idea, but it might make sense to
consider it now just for the sake of storing refs, it would
eliminate the need for the ".." notation for "refs/..HEAD".

Now if we could only figure out a way to tell plumbing that
something is a SHA, not a ref? :)

-Martin

--
The Qualcomm Innovation Center, Inc. is a member of Code
Aurora Forum, hosted by The Linux Foundation
