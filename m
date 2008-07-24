From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] editor.c: Libify launch_editor()
Date: Thu, 24 Jul 2008 03:48:14 +0200
Message-ID: <20080724014814.GA8730@leksak.fem-net>
References: <alpine.DEB.1.00.0807180313200.2906@eeepc-johanness> <1216380408-21671-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807181405510.3932@eeepc-johanness> <20080723230923.GA12754@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 03:49:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLpxO-00035e-5B
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 03:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbYGXBsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 21:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbYGXBsZ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 21:48:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:44704 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751069AbYGXBsY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 21:48:24 -0400
Received: (qmail invoked by alias); 24 Jul 2008 01:48:23 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp036) with SMTP; 24 Jul 2008 03:48:23 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19voFQJsr9vTKAjOwUOmnPS7Bnc7I3igWR5g5Y4oC
	gEsopSkFbK2UsH
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KLpwE-000412-3k; Thu, 24 Jul 2008 03:48:14 +0200
Content-Disposition: inline
In-Reply-To: <20080723230923.GA12754@leksak.fem-net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89826>

Stephan Beyer wrote:
> Well, I've seen that *a lot* of lib code (15 functions, see below) is in 
> the builtins.
> 
> Cleaning that up seems to be good to have a real separation between
> libgit and builtins, but I guess such a change would not find its way
> into 1.6.0, would it?
> 
> Regards,
>   Stephan
> 
> PS: I've spontaneously decided to make a list:
> 
> defined-in	func-name	 - used in builtin-\1.c

Of course my list was not complete.
(My regex was too simple.)

I add some:
> builtin-add.c:
> 	add_files_to_cache()	 - add, checkout, commit
> 	interactive_add()	 - add, commit
> 
> builtin-archive.c:
> 	parse_pathspec_arg()	 - archive, upload-archive

	parse_treeish_arg()	 - archive, upload-archive
	parse_archive_args()	 - archive, upload-archive

builtin-commit-tree.c:
	commit_tree()		 - commit-tree, merge

builtin-fetch-pack.c:
	fetch_pack()		 - also used in transport.c

> builtin-init-db.c:
> 	init_db()		 - init-db, clone
> 
> builtin-ls-files.c:
> 	overlay_tree_on_cache()	 - ls-files, commit
> 	report_path_error()	 - ls-files, checkout, commit

	pathspec_match()	 - ls-files, checkout, commit

> builtin-mailsplit.c:
> 	read_line_with_nul()	 - mailsplit, mailinfo
> 
> builtin-merge-recursive.c:
> 	write_tree_from_memory() - merge-recursive, checkout

	merge_trees()		 - merge-recursive, checkout
	merge_recursive()	 - merge-recursive (used nowhere else)

> builtin-prune-packed.c:
> 	prune_packed_objects()	 - prune-packed, prune

builtin-send-pack.c:
	send_pack()		 - also used in transport.c

> builtin-shortlog.c:
> 	shortlog_add_commit()	 - shortlog, log
> 	shortlog_init()		 - shortlog, log
> 	shortlog_output()	 - shortlog, log
> 	shortlog_init()		 - shortlog, log
> 
> builtin-stripspace.c:
> 	stripspace()		 - stripspace, commit, tag
> 
> And launch_editor() that is handled by the patch in this thread.


So keep everything or is it worth splitting that somehow up?

Regards.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
