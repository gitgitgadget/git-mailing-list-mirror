From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] editor.c: Libify launch_editor()
Date: Thu, 24 Jul 2008 01:09:23 +0200
Message-ID: <20080723230923.GA12754@leksak.fem-net>
References: <alpine.DEB.1.00.0807180313200.2906@eeepc-johanness> <1216380408-21671-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807181405510.3932@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 01:10:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLnTe-0000Fo-Mq
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 01:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828AbYGWXJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 19:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865AbYGWXJe
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 19:09:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:60884 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753778AbYGWXJd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 19:09:33 -0400
Received: (qmail invoked by alias); 23 Jul 2008 23:09:32 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp023) with SMTP; 24 Jul 2008 01:09:32 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18vd7Vo+xgvgxEp/0OIlm34g0vQ5JYrrJLztEOpKo
	BuStLtguCgEwIF
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KLnSV-0007Xj-CC; Thu, 24 Jul 2008 01:09:23 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807181405510.3932@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89800>

Hi,

Johannes Schindelin wrote:
> > This patch removes exit()/die() calls and builtin-specific messages from 
> > launch_editor(), so that it can be used as a general libgit.a function 
> > to launch an editor.
> 
> Thanks.  Now we have to convince Junio that it is a good idea :-)

Well, I've seen that *a lot* of lib code (15 functions, see below) is in 
the builtins.

Cleaning that up seems to be good to have a real separation between
libgit and builtins, but I guess such a change would not find its way
into 1.6.0, would it?

Regards,
  Stephan

PS: I've spontaneously decided to make a list:

defined-in	func-name	 - used in builtin-\1.c

builtin-add.c:
	add_files_to_cache()	 - add, checkout, commit
	interactive_add()	 - add, commit

builtin-archive.c:
	parse_pathspec_arg()	 - archive, uploard-archive

builtin-init-db.c:
	init_db()		 - init-db, clone

builtin-ls-files.c:
	overlay_tree_on_cache()	 - ls-files, commit
	report_path_error()	 - ls-files, checkout, commit

builtin-mailsplit.c:
	read_line_with_nul()	 - mailsplit, mailinfo

builtin-merge-recursive.c:
	write_tree_from_memory() - merge-recursive, checkout

builtin-prune-packed.c:
	prune_packed_objects()	 - prune-packed, prune

builtin-shortlog.c:
	shortlog_add_commit()	 - shortlog, log
	shortlog_init()		 - shortlog, log
	shortlog_output()	 - shortlog, log
	shortlog_init()		 - shortlog, log

builtin-stripspace.c:
	stripspace()		 - stripspace, commit, tag

And launch_editor() that is handled by the patch in this thread.

Then there are functions that are non-static, but not declined in
any .h file. A patch that makes them static follows in a separate mail.

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
