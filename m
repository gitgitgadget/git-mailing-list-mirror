From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: New ref generates 8MB mail message
Date: Wed, 18 Jan 2006 08:12:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601180810330.3240@g5.osdl.org>
References: <20060118140907.GV19769@parisc-linux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 17:13:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzFvc-0001Ik-M0
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 17:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbWARQMU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 11:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbWARQMU
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 11:12:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1966 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030318AbWARQMT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 11:12:19 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0IGCHDZ009898
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Jan 2006 08:12:18 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0IGCGRB007664;
	Wed, 18 Jan 2006 08:12:17 -0800
To: Matthew Wilcox <matthew@wil.cx>
In-Reply-To: <20060118140907.GV19769@parisc-linux.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.66__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14834>



On Wed, 18 Jan 2006, Matthew Wilcox wrote:
> 
> Based on the idea that a new branch is probably a branch off master, and
> if it isn't, then at least sending a log vs master is better than a log
> vs the beginning of time, I propose this patch:

Actually, since the update hook _should_ be called before the ref has 
actually been updated, it's probably much better to instead of this:

> -	git-rev-list --pretty "$3"
> +	git-rev-list --pretty "$3" ^master

do something like this:

	git-rev-list --pretty "$3" $(git-rev-parse --not --all)

which basically says: show any commits that are in the new ref, but are 
not in _any_ other ref.

Untested, of course.

		Linus
