From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Git's database structure
Date: Wed, 5 Sep 2007 20:52:06 +0100
Message-ID: <200709052052.07597.andyparkins@gmail.com>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com> <46DE5861.4050201@op5.se> <9e4733910709050641j34d58683ra72caa52c56cdf0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Jon Smirl" <jonsmirl@gmail.com>, "Andreas Ericsson" <ae@op5.se>,
	"Theodore Tso" <tytso@mit.edu>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 21:52:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT0vF-0005Cn-DD
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 21:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112AbXIETwQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 15:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756097AbXIETwQ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 15:52:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:43086 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756103AbXIETwP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 15:52:15 -0400
Received: by ug-out-1314.google.com with SMTP id z38so96420ugc
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 12:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=vzs8J4IsnEVNI+l5dZS0JZiKSwqPlWMVsUkGw6e0cuk=;
        b=bkqcysWOnVeB8FwpTiNliH/Yml7xEvy0lmiaXQGjhDR/JeuIkdqPwKyvQ2ePY9lki+LoJEBKo5K8dAQBL59qsbn3KHsquHdqqmQehpEhHU4NaJJM02W7r7qg3iOvD4uI7jV9I90+2JXrtl3pCjeO4xd5IYQsjXUUv+lLo9MnKT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qmwRfKSmBsgMk/S0D+iZ5Eben5aGZm+8wJ7OoY2ij9gz6xHuzbHy49shxxRt52699v8CSZ02bBSzCEmkc0zmTTXJjrqxITPhETsRZ7p4drH42OP1OuW3aey6ik+ryCscSQECp2KlKyw7ZZ1A02D+gZUR6ndxkGfTGSY93u9sX3k=
Received: by 10.78.165.16 with SMTP id n16mr2600216hue.1189021930289;
        Wed, 05 Sep 2007 12:52:10 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTPS id o30sm231191ugd.2007.09.05.12.52.08
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Sep 2007 12:52:09 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <9e4733910709050641j34d58683ra72caa52c56cdf0f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57756>

On Wednesday 2007, September 05, Jon Smirl wrote:

> The path name field needs to be moved back into the blobs to support
> alternative indexes. For example I want an index on the Signed-off-by
> field. I use this index to give me the SHAs for the blobs
> Signed-off-by a particular person. In the current design I have no way
> of recovering the path name for these blobs other than a brute force
> search following every path looking for the right SHA.

Erm, if that's your only way then you designed your index incorrectly.

 1. Signed-Off-By lines appear in commits, so your index should be an index
    of SOB name against commit hash
 2. Lookup the commit for that commit hash.  As usual this is blindlingly
    git-fastic.
 3. That commit blob contains a tree hash.  Look it up.  As usual this is 
    blindingly git-fastic
 4. Start gathering blobs for that tree.  Fast, fast, fast.
 5. Any subtree objects you come across, goto 4.

This is not a brute force lookup and it's stuff that git is really good at 
anyway.

I'm really not sure I see what problem you're trying to solve.  Whatever 
index you want, you could keep and maintain if you wanted to without 
impacting git's core storage at all.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
