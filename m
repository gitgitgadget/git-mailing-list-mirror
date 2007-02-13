From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 3/3] diffstat generation in hooks--update was passing  "^baserev" to git-diff-tree
Date: Tue, 13 Feb 2007 16:32:35 +0000
Message-ID: <200702131632.37401.andyparkins@gmail.com>
References: <200702131424.21665.andyparkins@gmail.com> <45D1DB57.65433549@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <J.Sixt@eudaptics.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 17:33:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH0aL-00007t-9c
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 17:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbXBMQcu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 11:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbXBMQcu
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 11:32:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:1563 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbXBMQct (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 11:32:49 -0500
Received: by ug-out-1314.google.com with SMTP id 44so269506uga
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 08:32:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RnA96h7z4fCq/2P0CQ6L9rIDtPmPjLkO9Fso2HpBirCZtdS4yhU1ICAsKJqyJy+Y6PWJ7aa8BwVxFxAgwRso228zHY2to3dWuaciiDLozV1w76i3yNesxW6aNMXz8s61Da/GKN7GGXQ9SOsn7rMykjDH5XujxkZaR96MDJzx3nI=
Received: by 10.67.117.2 with SMTP id u2mr10618644ugm.1171384367227;
        Tue, 13 Feb 2007 08:32:47 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id 59sm12281863ugf.2007.02.13.08.32.39;
        Tue, 13 Feb 2007 08:32:39 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <45D1DB57.65433549@eudaptics.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39539>

On Tuesday 2007 February 13 15:37, Johannes Sixt wrote:

> Shouldn't that be "... $baserev $newrev"? But read on.

I think it should, yes.  Thanks.

> #   * --- * --- * --- * (oldrev)
> #          \
> #           * --- * --- * (newrev)
>
> git rev-list $oldrev..$newrev
>
> is exactly what you want in this case. The stunt with $baserev is not
> necessary, and it may even be wrong if there is more than one
> merge-base. $oldrev..$newrev will be correct even in this case.

I just pinched the idea from the old update hook by Junio in 4f11b84c84.  I 
just assumed that was the better way to do it.  A quick test shows it to give 
the same output - I'm easy.

> You still need to derive a merge-base, but only to detect the forced
> update and to format the message. Then you should use --not $baserev
> instead of ^$baserev just in case there is more than one merge-base.

Are you suggesting something like this?

git-rev-parse --not --all $baserev | git-rev-list --stdin --pretty $newrev

Which would start showing from $newrev but would exclude all baserevs and all 
existing branches.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
