From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: excerpts from tomorrow's "What's cooking" draft
Date: Sat, 14 Nov 2009 21:49:51 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911142145571.14365@iabervon.org>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org> <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com>  <alpine.LNX.2.00.0911111259520.14365@iabervon.org> <fabb9a1e0911141807q4be6015bjda4805496be6dbb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 03:53:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9VEq-0002Vq-K8
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 03:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbZKOCtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 21:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbZKOCtr
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 21:49:47 -0500
Received: from iabervon.org ([66.92.72.58]:36923 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbZKOCtq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 21:49:46 -0500
Received: (qmail 32550 invoked by uid 1000); 15 Nov 2009 02:49:51 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Nov 2009 02:49:51 -0000
In-Reply-To: <fabb9a1e0911141807q4be6015bjda4805496be6dbb3@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132906>

On Sun, 15 Nov 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Wed, Nov 11, 2009 at 19:45, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > Okay, finally got to it just now. This is entirely untested (because I
> > don't have anything that uses it), but it compiles and should be correct.
> > It would be nice to get a clean bill of health on it from valgrind.
> 
> After a lot of manual comparison of valgrind traces (comparing cloning
> a local git repo and a local hg repo), I have found the following
> before applying your patch (I removed the ==proc== and "by 0xDEADBEEF"
> noise):
> 
>   20 bytes in 1 blocks are definitely lost in loss record 24 of 95
>     at : calloc (vg_replace_malloc.c:418)
>     by : xcalloc (wrapper.c:75)
>     by : get_importer (transport-helper.c:132)
>     by : fetch_with_import (transport-helper.c:150)
>     by : fetch (transport-helper.c:198)
>     by : transport_fetch_refs (transport.c:977)
>     by : cmd_clone (builtin-clone.c:538)
>     by : run_builtin (git.c:251)
>     by : handle_internal_command (git.c:396)
>     by : run_argv (git.c:438)
>     by : main (git.c:509)
> 
>   60 bytes in 1 blocks are definitely lost in loss record 43 of 95
>     at : realloc (vg_replace_malloc.c:476)
>     by : xrealloc (wrapper.c:59)
>     by : strbuf_grow (strbuf.c:61)
>     by : strbuf_getwholeline (strbuf.c:335)
>     by : strbuf_getline (strbuf.c:349)
>     by : get_helper (transport-helper.c:52)
>     by : get_refs_list (transport-helper.c:228)
>     by : transport_get_remote_refs (transport.c:943)
>     by : cmd_clone (builtin-clone.c:535)
>     by : run_builtin (git.c:251)
>     by : handle_internal_command (git.c:396)
>     by : run_argv (git.c:438)
> 
>   65 bytes in 1 blocks are definitely lost in loss record 47 of 95
>     at : malloc (vg_replace_malloc.c:195)
>     by : realloc (vg_replace_malloc.c:476)
>     by : xrealloc (wrapper.c:59)
>     by : strbuf_grow (strbuf.c:61)
>     by : strbuf_addf (strbuf.c:199)
>     by : get_helper (transport-helper.c:69)
>     by : get_refs_list (transport-helper.c:228)
>     by : transport_get_remote_refs (transport.c:943)
>     by : cmd_clone (builtin-clone.c:535)
>     by : run_builtin (git.c:251)
>     by : handle_internal_command (git.c:396)
>     by : run_argv (git.c:438)
> 
>   65 bytes in 1 blocks are definitely lost in loss record 50 of 95
>     at : malloc (vg_replace_malloc.c:195)
>     by : realloc (vg_replace_malloc.c:476)
>     by : xrealloc (wrapper.c:59)
>     by : strbuf_grow (strbuf.c:61)
>     by : strbuf_addf (strbuf.c:199)
>     by : fetch_with_import (transport-helper.c:158)
>     by : fetch (transport-helper.c:198)
>     by : transport_fetch_refs (transport.c:977)
>     by : cmd_clone (builtin-clone.c:538)
>     by : run_builtin (git.c:251)
>     by : handle_internal_command (git.c:396)
>     by : run_argv (git.c:438)
> 
>   123 (96 direct, 27 indirect) bytes in 1 blocks are definitely lost
> in loss record 71 of 95
>     at : malloc (vg_replace_malloc.c:195)
>     by : realloc (vg_replace_malloc.c:476)
>     by : xrealloc (wrapper.c:59)
>     by : get_helper (transport-helper.c:62)
>     by : get_refs_list (transport-helper.c:228)
>     by : transport_get_remote_refs (transport.c:943)
>     by : cmd_clone (builtin-clone.c:535)
>     by : run_builtin (git.c:251)
>     by : handle_internal_command (git.c:396)
>     by : run_argv (git.c:438)
>     by : main (git.c:509)
> 
> Annotated with the relevant source and my comments:
>     by : get_importer (transport-helper.c:132)
> 	fastimport->argv = xcalloc(5, sizeof(*fastimport->argv));
> 
> You never free fastimport->argv.
> 
>     by : get_helper (transport-helper.c:52)
> 		if (strbuf_getline(&buf, file, '\n') == EOF)
> 
> You never strbuf_release(&buf).
> 
>     by : get_helper (transport-helper.c:69)
> 			strbuf_addf(&gitdir, "gitdir %s\n", get_git_dir());
> 
> I do strbuf_reset(&gitdir), which should of course be
> strbuf_release(&gitdir), oops.
> 
>     by : fetch_with_import (transport-helper.c:158)
> 		strbuf_addf(&buf, "import %s\n", posn->name);
> 
> Same here, you never strbuf_release(&buf).
> 
>     by : get_helper (transport-helper.c:62)
> 			ALLOC_GROW(refspecs,
> 				   refspec_nr + 1,
> 				   refspec_alloc);
> 
> This would of course be fixed by your patch.
> 
> However, applying your patch causes:
> error: Trying to write ref refs/heads/tip with nonexistant object
> 0000000000000000000000000000000000000000
> fatal: Cannot update the ref 'HEAD'.
> 
> If I comment out both new lines in disonnect_helper like so fixes that:
> 	//free_refspec(data->refspec_nr, data->refspecs);
> 	//data->refspecs = NULL;
> 
> Commenting out only one of the two makes the error return, any idea's?

Looks like I'm discarding the information before I use it, instead of 
after. Try moving those lines to release_helper(), and a "!data->refspecs 
&&" to the !prefixcmp(... "refspec ") if condition. (That is, keep the 
refspecs from the first call to the helper until the whole thing is 
released, and ignore those capabilities in later calls.)

	-Daniel
*This .sig left intentionally blank*
