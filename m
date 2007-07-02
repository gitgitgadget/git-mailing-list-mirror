From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] git-mergetool: add support for ediff
Date: Mon, 2 Jul 2007 17:58:59 -0400
Message-ID: <20070702215859.GA20597@thunk.org>
References: <11830788163411-git-send-email-sam.vilain@catalyst.net.nz> <31e9dd080706281831vbe24597i9b6a5f6f6db6fec8@mail.gmail.com> <20070629040328.GG29279@thunk.org> <20070702020401.GD28917@thunk.org> <46896EF2.70006@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Sewall <jasonsewall@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Jul 02 23:59:19 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5TvP-0003gA-49
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 23:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755846AbXGBV7N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 17:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755841AbXGBV7N
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 17:59:13 -0400
Received: from THUNK.ORG ([69.25.196.29]:60691 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755819AbXGBV7M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 17:59:12 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I5U32-0006bg-1p; Mon, 02 Jul 2007 18:07:08 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I5Tv9-0007Rs-NV; Mon, 02 Jul 2007 17:58:59 -0400
Content-Disposition: inline
In-Reply-To: <46896EF2.70006@vilain.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51414>

On Tue, Jul 03, 2007 at 09:32:34AM +1200, Sam Vilain wrote:
> > Unfortunately, it's not enough.  Ediff doesn't have an "abort" command
> > which returns a non-zero exit status, and when you use the "quit"
> > command, it asks you a series of obnoxious questions:
> > 
> > Quit this Ediff session? (y or n)
> > File /usr/projects/git/test/testfile.c exists, overwrite? (y or n)
> > Merge buffer saved in /usr/projects/git/test/testfile.c
> > <delay for 3 annoying seconds>
> > Merge buffer saved.  Now kill the buffer? (y or n)
> 
> Yeah, I normally just save the merged buffer and quit.  This skips all that.
> 
> But I will add your little snippet to my .emacs :)

You probably don't want to just add that snippet to your .emacs, since
it changes the ediff 'quit' command to always cause emacs to
immediately exit, and that's probably not the right thing if you are
starting ediff from an emacs session.

The correct fix would involve stealing code from emerge's
emerge-merge-files-command function to parse the arguments from the
command-line --- and in fact, probably the simplest way of fixing
things for folks would be to write replacement emerge-*-command
functions which call ediff after patching the ediff hooks in the
emacs-lisp fragment I sent above.

In fact, maybe that's the right approach.  I don't think we want to
ship emacs lisp files which git-mergetool depends upon, but what if we
instead ship some emacs lisp code in the contrib directory which a
user could slip into their .emacs file which replaces the two
emerge-*-command functions which ones that call ediff instead?

That way we don't have all of this complexity added into git-mergetool.

		 	   	      	   - Ted
