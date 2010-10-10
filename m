From: Arnout Engelen <arnouten@bzzt.net>
Subject: Re: [PATCH] log which temporary file could not be created
Date: Sun, 10 Oct 2010 20:56:22 +0200
Message-ID: <20101010185622.GX9348@bzzt.net>
References: <20101009201751.GK9348@bzzt.net> <20101010024124.GA20305@burratino> <20101010103327.GO9348@bzzt.net> <20101010180909.GA12320@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 20:56:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P514V-000696-8T
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 20:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081Ab0JJS43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 14:56:29 -0400
Received: from smtp-1.concepts.nl ([213.197.30.124]:54992 "EHLO
	smtp-1.concepts.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670Ab0JJS42 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 14:56:28 -0400
Received: from 5ee5397b.ftth.concepts.nl
	([94.229.57.123] helo=mail.bzzt.net ident=Debian-exim)
	by smtp-1.concepts.nl with esmtp (Exim 4.69)
	(envelope-from <arnouten@bzzt.net>)
	id 1P514I-0003Bm-DL; Sun, 10 Oct 2010 20:56:22 +0200
Received: from arnouten by localhost with local (Exim 4.69)
	(envelope-from <arnouten@bzzt.net>)
	id 1P514I-0005Kx-Pt; Sun, 10 Oct 2010 20:56:22 +0200
Content-Disposition: inline
In-Reply-To: <20101010180909.GA12320@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: arnouten@bzzt.net
X-SA-Exim-Scanned: No (on localhost); SAEximRunCond expanded to false
X-Concepts-MailScanner-Information: Please contact abuse@concepts.nl for more information
X-Concepts-MailScanner-ID: 1P514I-0003Bm-DL
X-Concepts-MailScanner: Found to be clean
X-Concepts-MailScanner-SpamCheck: 
X-Concepts-MailScanner-From: arnouten@bzzt.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158684>

On Sun, Oct 10, 2010 at 01:09:09PM -0500, Jonathan Nieder wrote:
> Arnout Engelen wrote:
> > On Sat, Oct 09, 2010 at 09:41:24PM -0500, Jonathan Nieder wrote:
> >> 	fatal: Unable to create temporary file '.merge_file_Sc7R5c': File exists
> >> 	fatal: Unable to create temporary file 'newrepo/.git/tOWHcxk': No space left on device
> >
> > Perhaps we should also log the current working directory when the temporary 
> > filename is relative?
> 
> Let's step back for a moment.  Was there an example that prompted
> this patch?  

Yes: I was trying to do an initial push to a sf.net git repo, and this gave me:

arnouten@bird:~/asdf/notion$ git push sourceforge master
raboofje@notion.git.sourceforge.net's password: 
Counting objects: 21542, done.
Compressing objects: 100% (4179/4179), done.
fatal: Unable to create temporary file: Permission denied
error: pack-objects died of signal 13
error: pack-objects died with strange error
error: failed to push some refs to 'ssh://raboofje@notion.git.sourceforge.net/gitroot/notion/notion'
arnouten@bird:~/asdf/notion$

This seems to have been an error at the server side. I never did find out what
exactly went wrong - I just re-initialized the repo using the shell access and
all was fine after that.

> Were you aware of where git would be trying to create
> files in that example?  (I'm genuinely curious.)

No clue - but I'm not very into git 'internals' yet.

> Converting the filename to an absolute path with make_absolute_path
> might be useful, but I am not entirely sure it is worth the
> complication.
> 
> >> 	fatal: Unable to create temporary file '': Permission denied
> >>
> >> What should git do in this situation?
> >
> > Perhaps we should strdup() the template before mkstemp(), and log the 
> > strdup()'ed template when the original has been cleared?
> 
> Is it be preferable for the filename to always have XXXXXX in it?  If
> so, then copying it into a temporary buffer (on-stack, preferably)
> could be a sane solution, yes.

I'm not sure about 'always', but it'd be nice to have something to fall back 
to when the mkstemp clears the template.


Kind regards,

Arnout
