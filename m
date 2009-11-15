From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: excerpts from tomorrow's "What's cooking" draft
Date: Sun, 15 Nov 2009 03:07:50 +0100
Message-ID: <fabb9a1e0911141807q4be6015bjda4805496be6dbb3@mail.gmail.com>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org> <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com> 
	<alpine.LNX.2.00.0911111259520.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Nov 15 03:08:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9UXK-0007r3-AX
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 03:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbZKOCIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 21:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbZKOCIH
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 21:08:07 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:57739 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbZKOCIF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 21:08:05 -0500
Received: by ey-out-2122.google.com with SMTP id 9so1445749eyd.19
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 18:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=+6tOsQptOhwjHXwIfDMl93g0HCPkXeC+bibnbOx9YRQ=;
        b=N7tFUOfBZGFhfLu/FbakX7PsUVOYJlXohM/KDXmoZ0oqjTXgm8CudeV/OFXCwIfDq/
         S6ivwUhDZqaKOjm4pys+xlUhOPwR1Mt+NgTPaR2z6I82eyUnpLSPloekTxVRDvu5M8BF
         ZR0qlUOMNeHpg16CztBiuB6pRq9WpEjyIbd1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=lz49tjIDu2CBNyxm8/tPLtM0ShCCOE+rJB7an/1LnvRWG0mRq0BlV0wvtimuaPSewg
         TUdNaHOeO/sa/kkyvV4N+3qKtA6U4AIqnztgEHaUfXbX9Gf5SmaoCZQXEU5ygYXiXqwT
         n8DVdjQ1k+7Pi5Je76ZyWOstAGLnwyEEyl+Zs=
Received: by 10.216.88.136 with SMTP id a8mr630374wef.77.1258250890112; Sat, 
	14 Nov 2009 18:08:10 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.0911111259520.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132905>

Heya,

On Wed, Nov 11, 2009 at 19:45, Daniel Barkalow <barkalow@iabervon.org> wrote:
> Okay, finally got to it just now. This is entirely untested (because I
> don't have anything that uses it), but it compiles and should be correct.
> It would be nice to get a clean bill of health on it from valgrind.

After a lot of manual comparison of valgrind traces (comparing cloning
a local git repo and a local hg repo), I have found the following
before applying your patch (I removed the ==proc== and "by 0xDEADBEEF"
noise):

  20 bytes in 1 blocks are definitely lost in loss record 24 of 95
    at : calloc (vg_replace_malloc.c:418)
    by : xcalloc (wrapper.c:75)
    by : get_importer (transport-helper.c:132)
    by : fetch_with_import (transport-helper.c:150)
    by : fetch (transport-helper.c:198)
    by : transport_fetch_refs (transport.c:977)
    by : cmd_clone (builtin-clone.c:538)
    by : run_builtin (git.c:251)
    by : handle_internal_command (git.c:396)
    by : run_argv (git.c:438)
    by : main (git.c:509)

  60 bytes in 1 blocks are definitely lost in loss record 43 of 95
    at : realloc (vg_replace_malloc.c:476)
    by : xrealloc (wrapper.c:59)
    by : strbuf_grow (strbuf.c:61)
    by : strbuf_getwholeline (strbuf.c:335)
    by : strbuf_getline (strbuf.c:349)
    by : get_helper (transport-helper.c:52)
    by : get_refs_list (transport-helper.c:228)
    by : transport_get_remote_refs (transport.c:943)
    by : cmd_clone (builtin-clone.c:535)
    by : run_builtin (git.c:251)
    by : handle_internal_command (git.c:396)
    by : run_argv (git.c:438)

  65 bytes in 1 blocks are definitely lost in loss record 47 of 95
    at : malloc (vg_replace_malloc.c:195)
    by : realloc (vg_replace_malloc.c:476)
    by : xrealloc (wrapper.c:59)
    by : strbuf_grow (strbuf.c:61)
    by : strbuf_addf (strbuf.c:199)
    by : get_helper (transport-helper.c:69)
    by : get_refs_list (transport-helper.c:228)
    by : transport_get_remote_refs (transport.c:943)
    by : cmd_clone (builtin-clone.c:535)
    by : run_builtin (git.c:251)
    by : handle_internal_command (git.c:396)
    by : run_argv (git.c:438)

  65 bytes in 1 blocks are definitely lost in loss record 50 of 95
    at : malloc (vg_replace_malloc.c:195)
    by : realloc (vg_replace_malloc.c:476)
    by : xrealloc (wrapper.c:59)
    by : strbuf_grow (strbuf.c:61)
    by : strbuf_addf (strbuf.c:199)
    by : fetch_with_import (transport-helper.c:158)
    by : fetch (transport-helper.c:198)
    by : transport_fetch_refs (transport.c:977)
    by : cmd_clone (builtin-clone.c:538)
    by : run_builtin (git.c:251)
    by : handle_internal_command (git.c:396)
    by : run_argv (git.c:438)

  123 (96 direct, 27 indirect) bytes in 1 blocks are definitely lost
in loss record 71 of 95
    at : malloc (vg_replace_malloc.c:195)
    by : realloc (vg_replace_malloc.c:476)
    by : xrealloc (wrapper.c:59)
    by : get_helper (transport-helper.c:62)
    by : get_refs_list (transport-helper.c:228)
    by : transport_get_remote_refs (transport.c:943)
    by : cmd_clone (builtin-clone.c:535)
    by : run_builtin (git.c:251)
    by : handle_internal_command (git.c:396)
    by : run_argv (git.c:438)
    by : main (git.c:509)

Annotated with the relevant source and my comments:
    by : get_importer (transport-helper.c:132)
	fastimport->argv = xcalloc(5, sizeof(*fastimport->argv));

You never free fastimport->argv.

    by : get_helper (transport-helper.c:52)
		if (strbuf_getline(&buf, file, '\n') == EOF)

You never strbuf_release(&buf).

    by : get_helper (transport-helper.c:69)
			strbuf_addf(&gitdir, "gitdir %s\n", get_git_dir());

I do strbuf_reset(&gitdir), which should of course be
strbuf_release(&gitdir), oops.

    by : fetch_with_import (transport-helper.c:158)
		strbuf_addf(&buf, "import %s\n", posn->name);

Same here, you never strbuf_release(&buf).

    by : get_helper (transport-helper.c:62)
			ALLOC_GROW(refspecs,
				   refspec_nr + 1,
				   refspec_alloc);

This would of course be fixed by your patch.

However, applying your patch causes:
error: Trying to write ref refs/heads/tip with nonexistant object
0000000000000000000000000000000000000000
fatal: Cannot update the ref 'HEAD'.

If I comment out both new lines in disonnect_helper like so fixes that:
	//free_refspec(data->refspec_nr, data->refspecs);
	//data->refspecs = NULL;

Commenting out only one of the two makes the error return, any idea's?

-- 
Cheers,

Sverre Rabbelier
