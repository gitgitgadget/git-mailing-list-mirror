From: Theodore Tso <tytso@mit.edu>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Sun, 11 Feb 2007 23:24:25 -0500
Message-ID: <20070212042425.GB18010@thunk.org>
References: <45CFA30C.6030202@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@verizon.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 07:39:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGUqQ-0003Wh-QY
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 07:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933034AbXBLGjM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 01:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933037AbXBLGjM
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 01:39:12 -0500
Received: from thunk.org ([69.25.196.29]:35543 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933034AbXBLGjK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 01:39:10 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HGUvN-0000hf-IA; Mon, 12 Feb 2007 01:44:29 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HGSjp-0003P0-TF; Sun, 11 Feb 2007 23:24:25 -0500
Content-Disposition: inline
In-Reply-To: <45CFA30C.6030202@verizon.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39379>

On Sun, Feb 11, 2007 at 06:13:16PM -0500, Mark Levedahl wrote:
> I am NOT intending to start a flamewar O:-) , so please don't turn this 
> into one.
> 
> The recent threads on a mingw git port are explicit in the intent to 
> provide a Windows native git. I believe there is a fundamental conflict 
> here with the position, clearly stated by Linus, that git does not alter 
> content in any way. Windows suffers the curse of DOS line endings (\r\n 
> vs \n), and a true port to Windows *must* allow for \r\n and \n to be 
> semantically the same thing as most large projects end up with a mixture 
> of such files and/or are targeting cross-platform capabilities. The 
> major competing solutions git seeks to supplant (cvs, cvsnt, svn, hg) 
> have capability to recognize "text" files and transparently replace \r\n 
> with \n on input, the reverse on output, and ignore all such differences 
> on diff operations. To be relevant on native Windows, git must do the 
> same. Otherwise, git will be deemed "too wierd" and dismissed in favor 
> of a tool "that works."

So this is something that I've tried proposing to the Mercurial
developers, but it's never been implemented in hg.  It'll be
interesting to see what the git community thinks.  :-)

My proposal does require adding a file type to each file, as tracked
metadata, which may doom it from the start.  If you add a file type,
then you have to support mutating the file type, and some way of
handling merge conflicts (generally, picking one type or another).

Then for each file type, we implement a set of interfaces (perhaps as
simple as a series of executables named git-<type>-<operation>) which
if present, transforms the file from its live format to the canonical
format which is actually checked in and back again.  Besides using
this for the DOS CR/LF problem, it also allows for an efficient
storage of things like OpenOffice files which are a zipped set of .xml
files.  By decompressing them before pushing them into the SCM, it
means that if the user makes a tiny spelling correction in their
OpenOffice file, the delta stored in the git repository can be much
more efficiently stored (since the diff of the .xml tree will be
small, where as the diff of the entire compressed file is likely going
to be close to the entire size of the .odt file).

Another nice thing to provide for each file type would be a
pretty-printer for the diffs, so it becomes easier to see the delta
between two versions of an OpenOffice file in a textual window.

So, is this idea sane or completely insane?  Hopefully it passes
Linus's it-solves-multiple-problems-at-once test, at least.  :-)

							- Ted
