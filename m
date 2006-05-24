From: Jeff King <peff@peff.net>
Subject: Re: Incremental cvsimports
Date: Wed, 24 May 2006 09:58:28 -0400
Message-ID: <20060524135828.GA23934@coredump.intra.peff.net>
References: <93c3eada0605240046t10e00119n4cfc39ec33fe1d92@mail.gmail.com> <46a038f90605240121o117fadb6vf3ce910a3ad3e90@mail.gmail.com> <93c3eada0605240419o48891cdle6c100fc0ac870ff@mail.gmail.com> <20060524122246.GA3997@coredump.intra.peff.net> <93c3eada0605240533q4d1b5b81p128dc2b905aa9976@mail.gmail.com> <20060524132317.GA4594@coredump.intra.peff.net> <93c3eada0605240647i48db0588ja343e348f5feb08e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org,
	geoff@austrics.com.au
X-From: git-owner@vger.kernel.org Wed May 24 15:58:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fitsg-0004WT-CG
	for gcvg-git@gmane.org; Wed, 24 May 2006 15:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932752AbWEXN6b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 09:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932751AbWEXN6b
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 09:58:31 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:50651 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S932753AbWEXN6a (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 09:58:30 -0400
Received: (qmail 85242 invoked from network); 24 May 2006 13:58:28 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 24 May 2006 13:58:28 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 24 May 2006 09:58:28 -0400
To: junkio@cox.net
Mail-Followup-To: junkio@cox.net,
	Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org,
	geoff@austrics.com.au
Content-Disposition: inline
In-Reply-To: <93c3eada0605240647i48db0588ja343e348f5feb08e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20686>

On Wed, May 24, 2006 at 11:17:32PM +0930, Geoff Russell wrote:

> All 3 work.  But if I add a second tag before the ':errno_h", then I
> get an error.
> 
> The "use" line that makes git-cvsimport compile for me is:
> 
>        use POSIX qw(strftime dup2 ENOENT);

Odd. It's either a bug with importing tags in older versions, or there's
some deep perl voodoo that I don't understand (either way, it is "fixed"
in more recent versions).  Importing ENOENT directly is reasonable.

Junio, can you apply the following fix?

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index af331d9..76f6246 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -23,7 +23,7 @@ use File::Basename qw(basename dirname);
 use Time::Local;
 use IO::Socket;
 use IO::Pipe;
-use POSIX qw(strftime dup2 :errno_h);
+use POSIX qw(strftime dup2 ENOENT);
 use IPC::Open2;
 
 $SIG{'PIPE'}="IGNORE";
