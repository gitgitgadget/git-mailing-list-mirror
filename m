From: Antony Male <antony.male@gmail.com>
Subject: Re: Rebasing published branches?
Date: Tue, 06 Nov 2012 23:14:51 +0000
Message-ID: <509999EB.5050407@gmail.com>
References: <20121106201822.GE28437@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 07 00:15:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVsMN-0006bl-42
	for gcvg-git-2@plane.gmane.org; Wed, 07 Nov 2012 00:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834Ab2KFXOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 18:14:54 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35723 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab2KFXOx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2012 18:14:53 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so649008wgb.1
        for <git@vger.kernel.org>; Tue, 06 Nov 2012 15:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=DAwS6OkCDsulmyUK5M8ulVMPKjKGmBI02/yaUG6i2vA=;
        b=mJbS5dpAgsABwzVb9crryTsEgC6Vn0puSbW5FiRpEVKd3Oorp0etP+RSh1fClhLsRk
         HZka1TkfGvLYn/twBhnubFoNA/eEqeW2Nre/Qft+OKVdQIloAdjShRBf6BuLW/bTCf/U
         Rv3rMRZ0hlV9UdbHDyPLTtvrM+u/tQrH3wK2bR6B1JutbtNgEfPRBhyA7j7+a40O3bvC
         rAlBMCw/FgjHp7vFz6DW6bcmQZoNzT4b/suqsvBoQFE8oVYULq/AV8CPAjbAAso8JDb8
         E7xbREgim5TyCrqHbgG8p7hYIeCmOI+h6DqhtuHMukvE8v7je5gu6JyCousp/b4O0tv1
         soSw==
Received: by 10.180.87.74 with SMTP id v10mr4638034wiz.21.1352243692453;
        Tue, 06 Nov 2012 15:14:52 -0800 (PST)
Received: from [192.168.1.77] ([80.229.240.47])
        by mx.google.com with ESMTPS id en20sm959729wid.4.2012.11.06.15.14.51
        (version=SSLv3 cipher=OTHER);
        Tue, 06 Nov 2012 15:14:51 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <20121106201822.GE28437@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209127>

On 06/11/2012 8:18 pm, Josef Wolf wrote:
> Hello,
>
> I know, I should never rebase published branches. But...


The major trouble with making rewritten branches public is one of merges.

Assume I have two local repos, A and B, sharing a single remote. I 
create a branch in A, push it to the remote, then fetch it into B. I 
then re-write the branch in A and force-push it, and fetch from B.

As far as B is now concerned, its local history diverges from the 
remote's -- a scenario which must be resolved, usually through a merge, 
before any work can be pushed. Unfortunately, this merge merges together 
the two versions of history -- the old one from B's local history, and 
the new one from the remote -- leading to a mess. If B then pushes, this 
mess is published.

So "published", in the "don't rewrite published branches" sense, means 
"a branch which someone else might regularly pull from, and in doing so 
merge together two versions of history".

In general, remembering that you've pushed rewritten history, and to 
makes sure that you haven't merged two versions of history after a 
merge/pull, is sufficient. After rewriting history on a remote, rebase / 
pull --rebase on a local, un-rewritten branch is sufficient to avoid the 
merging-two-versions-of-history nightmare.

See "RECOVERING FROM UPSTREAM REBASE" in man git-rebase for a more 
in-depth explanation and more discussion of solutions.

> I frequently work on different computers and would like to share my private
> branches across them. When done and the feature is in a good shape, I'd like
> to rebase to clean up history before I make it available to other people.

Rebasing a branch which is about to be deleted (after merging, 
presumably) is generally regarded as fine, provided you're not expecting 
people to base work on the branch before it's rewritten.

Antony
