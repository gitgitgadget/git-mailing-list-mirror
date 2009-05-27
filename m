From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH RESEND] Git.pm: Always set Repository to absolute path
	if autodetecting
Date: Wed, 27 May 2009 12:54:55 +0200
Message-ID: <20090527105454.GW17706@mail-vs.djpig.de>
References: <1241703688-6892-1-git-send-email-frank@lichtenheld.de> <1241703688-6892-2-git-send-email-frank@lichtenheld.de> <4A1A49C0.7040102@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 27 13:20:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9HB5-0008R4-88
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 13:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758810AbZE0LTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 07:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757263AbZE0LTq
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 07:19:46 -0400
Received: from pauli.djpig.de ([78.46.38.139]:40905 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757459AbZE0LTp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 07:19:45 -0400
X-Greylist: delayed 1481 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 May 2009 07:19:44 EDT
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id 6B3D19007F;
	Wed, 27 May 2009 12:55:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mMlE+esa8nEp; Wed, 27 May 2009 12:54:55 +0200 (CEST)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id 969259007D;
	Wed, 27 May 2009 12:54:55 +0200 (CEST)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.69)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1M9Gmd-0003bI-5C; Wed, 27 May 2009 12:54:55 +0200
Content-Disposition: inline
In-Reply-To: <4A1A49C0.7040102@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120058>

On Mon, May 25, 2009 at 09:33:20AM +0200, Johannes Sixt wrote:
> Frank Lichtenheld schrieb:
> > From: Frank Lichtenheld <flichtenheld@astaro.com>
> > 
> > So far we only set it to absolute paths in some cases which lead
> > to problems like wc_chdir not working.
> > 
> > Signed-off-by: Frank Lichtenheld <flichtenheld@astaro.com>
> > ---
> >  perl/Git.pm     |    2 +-
> >  t/t9700/test.pl |   10 ++--------
> >  2 files changed, 3 insertions(+), 9 deletions(-)
> > 
> > Resent unchanged. There was one comment which I've reponded too and
> > argued that it didn't apply and there was no further objections.
> > 
> > diff --git a/perl/Git.pm b/perl/Git.pm
> > index 4313db7..e8df55d 100644
> > --- a/perl/Git.pm
> > +++ b/perl/Git.pm
> > @@ -185,7 +185,7 @@ sub repository {
> >  
> >  		if ($dir) {
> >  			$dir =~ m#^/# or $dir = $opts{Directory} . '/' . $dir;
> > -			$opts{Repository} = $dir;
> > +			$opts{Repository} = abs_path($dir);
> 
> Unfortunately, this change breaks MinGW git because the absolute path that
> this produces is MSYS-style /c/path/to/repo, but git does not understand
> this; it should be c:/path/to/repo. This value is ultimately assigned to
> GIT_DIR, but the path name mangling that usually happens when an MSYS
> program (like perl) spawns a non-MSYS program (like git) does not happen.
> 
> Your commit message is quite vague about the problems that you have seen.
> I vote to revert this change.

Note that abs_path is already used twice in the same function. Why are those
usages not problematic? I would be happy to work with you on finding a patch
that doesn't break, but I have to admit that I have no idea of the
Windows<->Perl<->git interactions.

As for the problems, a part of the public API of the module simply doesn't work
(i.e. wc_chdir) which I fixed. If we can't fix it we should at least not pretend
that it works.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
