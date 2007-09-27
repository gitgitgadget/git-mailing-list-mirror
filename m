From: Theodore Tso <tytso@mit.edu>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Thu, 27 Sep 2007 18:52:18 -0400
Message-ID: <20070927225218.GD8688@thunk.org>
References: <94ccbe710709271312k7eac8e35y353180596a0abc9a@mail.gmail.com> <7vd4w3ua2j.fsf@gitster.siamese.dyndns.org> <94ccbe710709271338u79ba89beh5a637bf84f8edf44@mail.gmail.com> <7v8x6ru97z.fsf@gitster.siamese.dyndns.org> <7vwsubsuh1.fsf@gitster.siamese.dyndns.org> <94ccbe710709271417h6349c807j6424c25175c26ea2@mail.gmail.com> <94ccbe710709271422x5d1739c2g5da961c88a4336fe@mail.gmail.com> <7vmyv7sshv.fsf@gitster.siamese.dyndns.org> <7vir5vss58.fsf@gitster.siamese.dyndns.org> <94ccbe710709271523s7e4c7a1dh53e34bd460c31d1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kelvie Wong <kelvie@ieee.org>
X-From: git-owner@vger.kernel.org Fri Sep 28 00:52:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib2Dm-0003Wj-A3
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 00:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757722AbXI0Wwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 18:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758048AbXI0Wwa
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 18:52:30 -0400
Received: from thunk.org ([69.25.196.29]:38796 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753162AbXI0Ww3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 18:52:29 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Ib2My-0001A2-9b; Thu, 27 Sep 2007 19:02:08 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1Ib2DS-0006Rt-JF; Thu, 27 Sep 2007 18:52:18 -0400
Content-Disposition: inline
In-Reply-To: <94ccbe710709271523s7e4c7a1dh53e34bd460c31d1f@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59347>

On Thu, Sep 27, 2007 at 03:23:44PM -0700, Kelvie Wong wrote:
> Finally got it to work.  emacs (at least the version I'm using,
> 22.1.1) seems to set the $PWD via its first argument, that is,
> $LOCAL's directory, and when it goes to save, it tries to save $path
> on top of that.

It's not that emacs sets $PWD via its first argument, but the output
file is passed from emerge-files*-command to stashed in the per-buffer
variable emerge-file-out, which in turn gets passed to the emacs lisp
file write-file, which is what gets run when you run C-x C-w --- and
write-file interprets a relative pathname based on the containing
directory of the existing buffer.

> The updated patch above would be just to use the basename, that is, if
> it is certain that $LOCAL and $path will always reside in the same
> directory -- and I believe, but am not certain, that this is the case.

> Also, I am not sure if this is specific to my version of Emacs, so
> perhaps some further testing is required.

Yep, I've checked both emacs21 and emacs23-snapshot, and they both use
write-file, so this seems to be a long-standing bug (and I would call
it that) in emerge.el.  So a patch like what you suggested is probably
going to be needed.

						- Ted
