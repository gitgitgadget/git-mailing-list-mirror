From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: error: Can't cherry-pick into empty head
Date: Mon, 6 Jun 2016 15:21:44 +0200
Message-ID: <afafa51c-f950-594e-7142-5b28b1182add@drmicha.warpmail.net>
References: <CAOxYW4yTCMYcY=9YvwHNK5rKDK0_f-Uc7L92-QuQkv_hwCV+HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Fabrizio Cucci <fabrizio.cucci@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 15:21:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9uTX-0000cI-B7
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 15:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbcFFNVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 09:21:47 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44614 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751038AbcFFNVr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 09:21:47 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id EC60821E93;
	Mon,  6 Jun 2016 09:21:45 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute7.internal (MEProxy); Mon, 06 Jun 2016 09:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=LnjEAbCQwdXPxDgheYulktqJEqQ=; b=ZVrTGN
	nm9u63p3gmZAfFsRHwj9CEulGcmkbmnzc2d9LzN+nxC1BqPjplS/sRx5l35nRQTP
	vxR4g+PKI3QmGJrY5JxhPOL9CpW1CfipcuzVMNzaWtJXdraKGWFmNyCjdaR+CsRd
	s2C4++ydjPVpIc8O2Z7CXzw+ZXHGb51iU6Jzw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=LnjEAbCQwdXPxDg
	heYulktqJEqQ=; b=KQCsHaAkCF6ZSR53m+Sx44T0B9AadGQ5AqZaGkSVvDotdXs
	729P8zJby7PEsJ9B0/mqkHax/JAUFMLizacNkIyLOAxsNoz0h8BMMMTB7FR436Xf
	vmmwEp0SA69sXK2TV7EaW/LvavmXq5Ya3FuuIR5v1DHzgzhcsKK2bXaTjKiA=
X-Sasl-enc: 4Vqg8g7fpTtV97CClkLvtyRhxHlMVTm+0sxAD4FJLDNd 1465219305
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 35023CCDA1;
	Mon,  6 Jun 2016 09:21:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <CAOxYW4yTCMYcY=9YvwHNK5rKDK0_f-Uc7L92-QuQkv_hwCV+HA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296505>

Fabrizio Cucci venit, vidit, dixit 28.05.2016 19:54:
> Hello everyone,
> 
> I'm trying to understand why I'm getting the error as per subject.
> 
> The scenario is the following: I'm on the master branch (which
> contains several commits) and I would like to create a new empty
> branch (let's call it new-orphan) and cherry-pick only the commits
> related to a specific folder (let's call it my-folder) from the master
> branch.
> 
> So, I tried the following command sequence:
> 
>   master $ git checkout --orphan new-orphan
>   new-orphan $ git rm --cached -r .
>   new-orphan $ git clean -df
> 
> After confirming that I'm in a clean state (with "$ git status") I tried:
> 
>   new-orphan $ git rev-list --reverse master -- my-folder/ | git
> cherry-pick --stdin
> 
> as suggested https://git-scm.com/docs/git-cherry-pick, but what I get
> is "error: Can't cherry-pick into empty head".
> 
> What I don't really understand is:
> 
> 1) if I cherry-pick a single commit instead of multiple commits,
> everything works fine:
> 
>   new-orphan $ git cherry-pick <some-commit-id>
> 
> 2) if I commit something before trying the above command, everything works fine:
> 
>   new-orphan $ touch README
>   new-orphan $ git add README
>   new-orphan $ git commit -m "added README"
>   new-orphan $ git rev-list --reverse master -- my-folder/ | git
> cherry-pick --stdin
> 
> Can someone please help me understand this?

The implementation for the single commit and multiple commit cases is
different (so that you can do a single cherry-pick from with a running
cherry-pick sequence). As a side effect, the single commit pick does not
care about an empty head.

I'll follow up with a patch which changes that.

Michael
