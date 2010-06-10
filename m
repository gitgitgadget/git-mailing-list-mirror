From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC/PATCHv2] bash completion: Support "divergence from upstream" warnings in __git_ps1
Date: Thu, 10 Jun 2010 14:03:41 +0200
Message-ID: <201006101403.41754.trast@student.ethz.ch>
References: <4C0AE640.3040503@pileofstuff.org> <201006070942.34753.trast@student.ethz.ch> <4C0EB7F1.1030707@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Thu Jun 10 14:04:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMgUW-0004YT-Bf
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 14:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111Ab0FJMEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 08:04:06 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:41761 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753799Ab0FJMEF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 08:04:05 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 14:04:04 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 10 Jun
 2010 14:03:42 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <4C0EB7F1.1030707@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148860>

Andrew Sayers wrote:
> +				if [ "${GIT_PS1_SHOWUPSTREAM-}" = "svn" ]; then
> +
> +					# git-svn upstream checking
> +					p="$( git config --get svn-remote.svn.url )"
> +					upstream=( $( git log --first-parent -1 \
> +						--grep="^git-svn-id: $p" ) )
> +					upstream=${upstream[ ${#upstream[@]} - 2 ]}
> +					upstream=${upstream%@*}
> +					upstream=${upstream#*$p/}

This appears to be tailored to --stdlayout, and sadly doesn't work in
the (probably fairly common) case of single-branch checkouts where
git-svn only puts a "remotes/git-svn" branch.

I can't come up with any easy-but-robust method of checking that
though.  Perhaps it suffices to check that

  git config 'svn-remote.svn.(branches|tags)'

comes up empty, and in this case simply use git-svn as the remote.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
