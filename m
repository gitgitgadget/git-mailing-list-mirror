From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: filter-branch IO optimization
Date: Thu, 11 Oct 2012 22:34:24 +0200
Message-ID: <878vbc21f3.fsf@pctrast.inf.ethz.ch>
References: <fa1e05a5-54b3-47ff-bd28-dc463ebbc4bd@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: git list <git@vger.kernel.org>
To: Enrico Weigelt <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Thu Oct 11 22:35:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMPTD-0004bn-56
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 22:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759351Ab2JKUed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 16:34:33 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:22030 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759333Ab2JKUe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 16:34:28 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 11 Oct
 2012 22:34:23 +0200
Received: from pctrast.inf.ethz.ch.ethz.ch (46.126.8.85) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 11 Oct
 2012 22:34:24 +0200
In-Reply-To: <fa1e05a5-54b3-47ff-bd28-dc463ebbc4bd@zcs> (Enrico Weigelt's
	message of "Thu, 11 Oct 2012 17:39:47 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207511>

Enrico Weigelt <enrico.weigelt@vnc.biz> writes:

> for certain projects, I need to regularily run filter-branch on quite
> large repos (>10k commits), and that needs to be run multiple times,
> which takes several hours, so I'm looking for optimizations.
[...]
> #2: run a tree-filter which:
>     * removes all files not belonging to the wanted module
>     * move the module directory under another subdir (./addons/)
>     * fix author/comitter name/email if empty (because otherwise fails)

The usual advice is "use an index-filter instead".  It's *much* faster
than a tree filter.  However:

>     * fix charater sets and indentions of source files

That last step is rather crazy.  At the very least you will want to only
operate on files that were changed since the parent commit, so as to
avoid scanning the whole tree.  If you do this right, it should also fit
into an index-filter.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
