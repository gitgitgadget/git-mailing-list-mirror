From: Paul Jackson <pj@sgi.com>
Subject: Re: Stacked GIT 0.1 (a.k.a. quilt for git)
Date: Thu, 23 Jun 2005 17:58:48 -0700
Organization: SGI
Message-ID: <20050623175848.1cf41a52.pj@sgi.com>
References: <tnxy899zzu7.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 02:50:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlcOv-0007fl-TJ
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 02:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbVFXA4z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 20:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbVFXA4z
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 20:56:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:54446 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262958AbVFXA4v (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 20:56:51 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j5O2knot002367;
	Thu, 23 Jun 2005 19:46:49 -0700
Received: from v0 (mtv-vpn-hw-masa-1.corp.sgi.com [134.15.25.210])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j5O0uldO40406562;
	Thu, 23 Jun 2005 17:56:47 -0700 (PDT)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <tnxy899zzu7.fsf@arm.com>
X-Mailer: Sylpheed version 1.9.12 (GTK+ 2.6.7; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Interesting idea.  Thanks.

I am just firing it up now - noticing a couple of nits:

 1) "Unknown" is misspelled as "Unkown" in a couple places.

 2) I tried doing an "stg init" in the stgit subtree that I had
    just unpacked and installed (python setup.py install).  This
    did several lines of "Adding ..." and then displayed the
    number "16" and sat there.  I typed some random guesses at
    it, and realized I was inside my $EDITOR=/bin/ed.

    Before invoking an editor, it would be a good idea to tell the
    user you are doing so.  If someone is on a telnet session to
    a system with their $DISPLAY set wrong, they might not even
    get the terse "16" clue that I got, that they are editing
    something.

 3) My editor 'ed' exits with non-zero status if I make even the most
    trivial editing error.  This resulted in this "stg init" failing
    with:
	stg init: Editor (ed .commitmsg) failed
    I'd recommend ignoring the exit status of externally invoked
    editors.

 4) I tried rerunning that "stg init" without further ado, and it
    failed again (due to the incomplete init above, no doubt), with:

	Traceback (most recent call last):
	  File "/usr/bin/stg", line 25, in ?
	    main()
	  File "/usr/lib/python2.4/site-packages/stgit/main.py", line 557, in main
	    command.func(parser, options, args)
	  File "/usr/lib/python2.4/site-packages/stgit/main.py", line 91, in init
	    stack.init()
	  File "/usr/lib/python2.4/site-packages/stgit/stack.py", line 187, in init
	    patch_dir = get_patch_dir()
	  File "/usr/lib/python2.4/site-packages/stgit/stack.py", line 36, in get_patch_dir
	    return os.path.join(git.base_dir, 'patches', git.get_head_file())
	  File "/usr/lib/python2.4/posixpath.py", line 60, in join
	    if b.startswith('/'):
	AttributeError: 'NoneType' object has no attribute 'startswith'

 5) I tried again, doing:

	rm -fr .git
	stg init
	# on the commit message edit - just quit 'q', to avoid any error exit

    This failed again, leaving my new git tree in god only knows what bogus state.
    It failed with:

	stg init: Commit message not modified

    I'm getting a little frustrated by now.  Guess I will just nuke the .git subtree
    and try again, as I have no clue what useful or bogus state this left me in.

    Try generating fewer fatal errors, and try giving a tiny clue what state (ok or
    not or how bad) one is left in after an apparently fatal error, and for extra
    credit, a clue what to do next.

 6) Ok - got through the init that time.

Since I am fond of both quilt and Python, and since I need to be using git and/or cogito,
I will poke around some more with this - it's promising.

I see something about a patch emailer on the todo list -- you're welcome to make use of
my patch emailer (I use with quilt, though it's not tightly bound to quilt) at:

  http://www.speakeasy.org/~pj99/sgi/sendpatchset

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
