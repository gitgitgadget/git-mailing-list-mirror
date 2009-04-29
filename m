From: Marcin Zalewski <marcin.zalewski@gmail.com>
Subject: Re: Diftool problems
Date: Wed, 29 Apr 2009 15:55:42 -0400
Message-ID: <7c0fdf4f0904291255i4076df8cubb26fdb2d51826d4@mail.gmail.com>
References: <7c0fdf4f0904290915i56f58981i70e7093e9bf87d8b@mail.gmail.com> 
	<200904292142.59471.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Wed Apr 29 21:56:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzFtW-0003lc-5U
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 21:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256AbZD2T4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 15:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752668AbZD2T4G
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 15:56:06 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:43869 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbZD2T4E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 15:56:04 -0400
Received: by fxm2 with SMTP id 2so1405425fxm.37
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 12:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dDnwmr1ntD28zZ7fcKKuy0tu2vOAsWJNH+xxSSIc9q4=;
        b=ggCPKIqdo5pgDLZhLeoZl+I1BT8tpglM75rFT5zp/NWI2wG58SDx9y5zC+6vdnBkkY
         Cz9ZRRvyPVy8qVfRFv4QtMzvKF6q7riwYn3FRZcg5bVz8qDZbAXJtQ0a62rGJ5RcMr8O
         zlyTHpa5Crd6UJ3vxanDi8UnNuDA+RanDb8eg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=B+e0Q5PpfoiO4JNuoamnGSjNH3W8gMut6efEG6YXa7HU3YmW8fBCfra1oRuIhULpte
         kHIH/NSpxAFgcaVah9I39s9geV/xqKkVSnKot0AqWSWE3q7ivrGArrQmLYIfjAYNim4C
         9xcQO/KSWabqg+19V7WqS0cyn5Okk8FUa2Ix0=
Received: by 10.103.52.13 with SMTP id e13mr468848muk.74.1241034962116; Wed, 
	29 Apr 2009 12:56:02 -0700 (PDT)
In-Reply-To: <200904292142.59471.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117932>

> The real fix would be to adjust the ediff snippet for difftool support.

The emas snippet was meant to work with mergetool and it does (I
think). Changing the emacs code could indeed help with difftool but it
would break mergetool.

> As you said yourself, git-difftool is not meant for merging files, so
> there is no reason to open more than 2 files at all.

I agree, but the current implementation of difftool uses mergetool
library. That may be the reason why difftool is trying to come up with
the third file. Here is the snippet of code from mergetool library
that executes emerge in case of non-merge-mode:

"$merge_tool_path" -f emerge-files-command \
				"$LOCAL" "$REMOTE" "$(basename "$MERGED")"

> The built-in difftools 'emerge' and 'ecmerge' still seem to open LOCAL,
> REMOTE and MERGED. This should be fixed, so that they don't open MERGED
> any more, but I don't have emacs installed, so I shouldn't try it
> myself.

Again, I agree. This could be one of the possible solutions, but it
would require that mergetool library is changed or rewriting pieces of
mergetool in difftool. Correct me if I am wrong.

> Oh, and LOCAL shouldn't be copied to a temporary file in the first
> place, because people don't use git-difftool in read-only mode only.

I think that merge result could be a temporary file, like in
mergetool. In a situation where I use git to track an SVN repository,
difftool can be actually used to merge my uncommitted changes with a
commit from someone else after doing svn rebase. On the other hand, I
am no git expert so there may be a better way to handle this case.

-m
