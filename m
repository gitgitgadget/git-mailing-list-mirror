From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Making Git untrack few folders
Date: Sun, 12 Sep 2010 16:07:20 +0530
Message-ID: <20100912103717.GA24576@kytes>
References: <AANLkTi=vjueuP66BAMsRDww=J3Nq3Q4BooKF+85khcBn@mail.gmail.com>
 <AANLkTiktMe190OVPrTXMtmfaLRLXeJBZ4vSZewJecQWe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Parag Kalra <paragkalra@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 12 12:39:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oujxn-0004I6-3P
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 12:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244Ab0ILKjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 06:39:05 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59740 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729Ab0ILKjD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 06:39:03 -0400
Received: by pzk34 with SMTP id 34so1717402pzk.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 03:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=80XBkKu0XVEreGrU7bScFAYh5RW3iSir6ff6tBLa/Hk=;
        b=ZNq1Lnfu6xoLTn9lC6j2Y0VpjCzoTVs2qr7TdxHx8cMQ9YXg9XrCgndMIRHR4uVUg7
         z1becip+sR4q/PlFMuKHbmSnDX1s5quMCLPBF5K/oD2vVg/eorprxJa4z2zC9Gh4cdY4
         +3S34I62dbbEGsoSsqlUdh3ZUEG2FlcJPaiAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Lz1QmgBPsxf0HdDYOSNVZOdzQdciHrzwhSSfGx84UAXByb6dnYvWAOyX2WJl8NJB7r
         JkeaREsSlXVdhuLLQERNneYRCMhKNVIHdI8StWBf2EAEdW4sC+aXozywXNXyW2MysRPs
         lUI3xe4XcmQlaGs9ioULeA4+VtMHiACtdSpes=
Received: by 10.143.166.11 with SMTP id t11mr1899392wfo.57.1284287942812;
        Sun, 12 Sep 2010 03:39:02 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id s42sm6661933wfc.9.2010.09.12.03.38.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Sep 2010 03:39:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTiktMe190OVPrTXMtmfaLRLXeJBZ4vSZewJecQWe@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156030>

Hi Parag,

Parag Kalra writes:
> 1. Is there a way I can make Git not track a particular folder in my
> working code base directory. For example, I have a tmp folder in my
> local code base and I don't want Git to track whats going on inside
> that directory.

Yes. See gitignore (5).

> 2. Accidently I have added this folder, committed and pushed it to
> origin master. Is there a way I can remove this tmp folder from git
> revision history and at the same time keeping it intact in my local
> code base directory.

Yes. Simply `rm --cached` the folder, and amemd your previous commit
using `commit --amend`, and perform a non-ff push using the `+`
syntax. For example, to perform a non-ff push to remote branch `foo`
whose local name is `foo`, invoke `push +foo:foo`. Note that other
users who have already pulled the bad commit will have to forget about
it explicitly too.

If the folder tracking information is a few revision deep, consider
using `rebase -i` to manually overwrite those commits to exclude that
folder. If the folder was too many revisions earlier, use a
`filter-branch` index filter to make Git completely forget that
folder.

-- Ram
