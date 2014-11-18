From: Mike Hommey <mh@glandium.org>
Subject: Re: Getting a commit sha1 from fast-import in a remote-helper
Date: Tue, 18 Nov 2014 11:31:12 +0900
Message-ID: <20141118023112.GA14034@glandium.org>
References: <20141118003426.GA6528@glandium.org>
 <20141118014028.GF4336@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 03:31:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqYZm-0002LI-0K
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 03:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbaKRCb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 21:31:26 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:46133 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbaKRCb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 21:31:26 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1XqYZU-0003fK-Gs; Tue, 18 Nov 2014 11:31:12 +0900
Content-Disposition: inline
In-Reply-To: <20141118014028.GF4336@google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 17, 2014 at 05:40:28PM -0800, Jonathan Nieder wrote:
> Mike Hommey wrote:
> 
> > - fast-import's `ls` command documentation about its output format
> >   mentions that the output may contain commits, so I tried the trick of
> >   creating a tree with commits, but fast-import then fails with:
> >     fatal: Not a blob (actually a commit)
> >   which I totally understand, but then I wonder why the documentation
> >   mentions it and how one would get a tree containing references to
> >   commits. I guess the documentation should be fixed.
> 
> Odd.  Here's what happens when I try:
> 
>  $ echo "ls $(git rev-parse HEAD)" | git fast-import --quiet
>  fatal: Missing space after tree-ish: ls a4a226a366ab0a173ed9e5f70f2a95d0d21e54c5
>  fast-import: dumping crash report to .git/fast_import_crash_14080
>  $ echo "ls $(git rev-parse HEAD) " | git fast-import --quiet
>  040000 tree d3d38e7d71cb40ebbaf2798b01837b3de43fd4a1
> 
> How did you get that "Not a blob" message?

When trying to *create* a tree with a commit in it, so instead of giving
the mark for a blob to a filemodify command, giving a mark for a commit.
That is what fails with "Not a blob".
So it's not possible to create a tree with a reference to a commit, at
least with fast-import.
But, the documentation for the ls command says this:

   Output uses the same format as git ls-tree <tree> -- <path>:

        <mode> SP ('blob' | 'tree' | 'commit') SP <dataref> HT <path> LF

The 'commit' string certainly seems it cannot be there.

> I think a good fix would be to teach parse_ls a mode with no <path>
> parameter.  Something like this (untested; needs cleanup and tests):

This would make both your commands output the same thing, right? It
wouldn't help my case :)

Mike
