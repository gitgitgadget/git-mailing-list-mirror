From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [SoC RFC] libsvn-fs-git: A git backend for the subversion
	filesystem
Date: Wed, 19 Mar 2008 23:18:34 -0700
Message-ID: <1205993915.17607.32.camel@brick>
References: <3e8340490803182108y40a9aec2q8e5bcb78b907bbb5@mail.gmail.com>
	 <20080320045632.GB8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Bryan Donlan <bdonlan@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 07:19:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcE7T-00013c-Ed
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 07:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887AbYCTGSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 02:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754882AbYCTGSi
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 02:18:38 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:58963 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868AbYCTGSh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 02:18:37 -0400
Received: by wa-out-1112.google.com with SMTP id v27so860582wah.23
        for <git@vger.kernel.org>; Wed, 19 Mar 2008 23:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=pv4UjQxeeS5RkcsM2c8NVprbqQr8PcshLVQyN7OKnQk=;
        b=bN2SFW61Q45JVkg6abDkcH5T0Wv590uRXk3saYEl17arn+01L60caigVYJsw0F9a74R7DKObDna1H4wLvI39e9vnT20guFy14X74XYkStfQF7lserWg7yKmFMkka3jBzTSizrlULRd440b/iaAev2FVuKb0Fu6ONKo3Gw17MQvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=jbREo3oiXUhqvQ4stFz7rknyTmeTRgwxWcgX1kOTvgkz5Oo1sTHkRyzBdkTxhjVmOMglId+0LpJn+syj1c4db+Jt/tPKHub6+f904tD8AYbHK71L2jEdW5iuDhyS/veE9qWIkZIpW7+sKPe6Gg8ecK76hXLe1QKIcwsxBaD75Vk=
Received: by 10.114.169.2 with SMTP id r2mr2831712wae.118.1205993917060;
        Wed, 19 Mar 2008 23:18:37 -0700 (PDT)
Received: from ?192.168.1.100? ( [216.19.190.48])
        by mx.google.com with ESMTPS id v35sm2571488wah.19.2008.03.19.23.18.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Mar 2008 23:18:36 -0700 (PDT)
In-Reply-To: <20080320045632.GB8410@spearce.org>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77633>

On Thu, 2008-03-20 at 00:56 -0400, Shawn O. Pearce wrote:
> Bryan Donlan <bdonlan@gmail.com> wrote:
> > /revmap/NNN - a reference to the commit hash in the .git-svn branch
> >   corresponding to the given subversion revision number
> 
> How about using a simple flat file interface?  To initially prime
> the file you can do something like:
> 
> 	git rev-list --topo-order --date-order --reverse --all >.git/svn-map
> 
> and then number the revisions by the line number that they appear on.
> Locating a Git SHA-1 for a specific SVN revision would be a simple
> case of lseek(fd, 41 * rev, SEEK_SET).  Going the other direction
> would be more of a challenge, but is still doable.
> 
> Updating the file should just require appending new commits; if
> the SVN client wants a new commit you append on and return the
> line number.  If Git has caused new commits not in this file you
> need to rebuild the log.  This would have to be done incrementally,
> to prevent changing a prior SVN revision number that clients may
> already know about.

Why not just copy the rev_map format git-svn already uses, it's pretty
efficient.

Harvey
