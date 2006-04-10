From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git log [diff-tree options]...
Date: Mon, 10 Apr 2006 16:54:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604101652220.2998@g5.osdl.org>
References: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604090950590.9504@g5.osdl.org> <7vodz980az.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 11 01:54:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FT6DG-0002T8-5m
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 01:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWDJXy0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 19:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWDJXy0
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 19:54:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9604 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932192AbWDJXy0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Apr 2006 19:54:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3ANsLtH017827
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 10 Apr 2006 16:54:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3ANsJPl001440;
	Mon, 10 Apr 2006 16:54:20 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodz980az.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18598>



On Mon, 10 Apr 2006, Junio C Hamano wrote:
> >
> > and I think we'd likely want to have some way to select the output. 
> > Probably with the path-limited diff being the default (that's what 
> > "git-whatchanged" does), but perhaps with "--full-diff" showing the whole 
> > commit diff (which is what "gitk" does).
> 
> Yes, but it turns out it is a bit tricky, given that the way
> tree-diff.c is written it pretty much assumes the same pathspec
> is used for diff operation during the lifetime of the process.

Hmm.. The hacky approach would seem to be to just call 
"diff_tree_setup_paths()" just before doing the diff (and re-set it 
afterwards). That should work, I don't think we keep any real state 
around.

> I think we should move (nr_paths, pathlens and paths) to struct
> diff_options.  Two patches to follow shortly.

That certainly seems to be the cleanest option. Not just because it should 
solve this problem, but because it's also what looks most natural anyway 
(and matches the "struct revs" approach).

		Linus
