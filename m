From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Git.pm: release hash and blob handles
Date: Sat, 11 Oct 2008 23:23:22 +0200
Message-ID: <20081011212322.GU10544@machine.or.cz>
References: <be6fef0d0810111229u60c28671w1afd952200c6fa23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 11 23:24:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kolx0-0004aX-KP
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 23:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbYJKVX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 17:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbYJKVX1
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 17:23:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38872 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbYJKVX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 17:23:26 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 93A2F393A6DC; Sat, 11 Oct 2008 23:23:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <be6fef0d0810111229u60c28671w1afd952200c6fa23@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97990>

On Sun, Oct 12, 2008 at 03:29:28AM +0800, Ray Chuan wrote:
> the methods
> 
>  * hash_and_insert_object
>  * cat_blob
> 
> use bidirectional pipes to pull/push data from the various git
> utilities, but they don't close them after this is complete. this
> denies Git's subsequent attempts to use these resources, leading to
> failure.
> 
> a simple, reproducible test case can be seen at
> http://rctay.spaces.live.com/blog/cns!59D3BFCD027B09E5!792.entry.

Hmm, I don't understand why git-svn does not work for you, but this
patch is not correct. The whole point of the infrastructure is to leave
the pipes open so that subsequent calls _reuse_ these pipes. This leads
to substantial speedup as you do not need to re-fork git all the time.

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
