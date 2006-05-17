From: Santi <sbejar@gmail.com>
Subject: Re: "git add $ignored_file" fail
Date: Wed, 17 May 2006 15:41:05 +0200
Message-ID: <8aa486160605170641p2ab8704o@mail.gmail.com>
References: <8aa486160605161507w3a27152dq@mail.gmail.com>
	 <Pine.LNX.4.64.0605161526210.16475@g5.osdl.org>
	 <8aa486160605161542u704ccf03w@mail.gmail.com>
	 <Pine.LNX.4.63.0605171306400.19012@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0605170604i689a8f7axa5aeb7752dc72072@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 15:42:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgMH7-0004sd-IN
	for gcvg-git@gmane.org; Wed, 17 May 2006 15:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbWEQNlJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 09:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWEQNlJ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 09:41:09 -0400
Received: from wx-out-0102.google.com ([66.249.82.206]:8391 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932551AbWEQNlG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 09:41:06 -0400
Received: by wx-out-0102.google.com with SMTP id s6so163773wxc
        for <git@vger.kernel.org>; Wed, 17 May 2006 06:41:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CCwxgzK4L10i97Q0aKxEOwINERlU0fBjttvsAeRHyZRQc37Prn9MqVTlnvnfFeDSQ+DEz58v2vawaPy71PngFVyVhBeVlJ6NRzsVTLenFZBeJX73aaB/hGihzNcDhuxODBB3eR02cv3jUH1A+0T+cn35515ekXoRtCq4pqt9x84=
Received: by 10.70.47.10 with SMTP id u10mr1205627wxu;
        Wed, 17 May 2006 06:41:05 -0700 (PDT)
Received: by 10.70.20.2 with HTTP; Wed, 17 May 2006 06:41:05 -0700 (PDT)
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0605170604i689a8f7axa5aeb7752dc72072@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20196>

2006/5/17, Alex Riesen <raa.lkml@gmail.com>:
> On 5/17/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > It's consistent from an implementation point of view, but not from the
> > > (my?) user point of view.
> >
> > So, you told git to ignore the file. And then you say "please add it". I
> > find it highly consistent that git does not do anything, because *you*
> > decided it should ignore it in the first place.
> >
>
> Well, he didn't say to ignore exactly this file. And Santi didn't know
> git-add uses git-ls-files here. So it actually is unexpected for a novice.
> It was unexpected for me too, until I looked into git-add.sh
>

Actually I'm not a novice, but that is the point.

In the other way, now I find the value of being able to say:

$ git add t*

and be sure that it does not add an ignored file. Unfortunately
git-add cannot distinguish between both. So what I propose is to
document it explicitly, something like:

diff --git a/Documentation/git-add.txt /Documentation/git-add.txt
index 5e31129..42f1e33 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -7,18 +7,20 @@ git-add - Add files to the index file

 SYNOPSIS
 --------
-'git-add' [-n] [-v] [--] <file>...
+'git-add' [-n] [-v] [--] <filespec>...

 DESCRIPTION
 -----------
 A simple wrapper for git-update-index to add files to the index,
 for people used to do "cvs add".

+It only adds non-ignored files, to add ignored files use
+"git-update-index --add".

 OPTIONS
 -------
-<file>...::
-       Files to add to the index.
+<filespec>...::
+       Files to add to the index (see git-ls-files).

 -n::
         Don't actually add the file(s), just show if they exist.
diff --git a/git-add.sh b/git-add.sh
index d6a4bc7..394793f 100755
--- a/git-add.sh
+++ b/git-add.sh
@@ -1,6 +1,6 @@
 #!/bin/sh

-USAGE='[-n] [-v] <file>...'
+USAGE='[-n] [-v] <filespec>...'
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
