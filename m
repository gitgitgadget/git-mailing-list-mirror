From: Joshua N Pritikin <jpritikin@pobox.com>
Subject: Re: etoys - binary blob in GIT
Date: Sat, 10 Feb 2007 15:19:34 +0530
Message-ID: <20070210094934.GH13381@always.joy.eth.net>
References: <20070208095523.GE3708@always.joy.eth.net>
	<u7ius5te9.wl%yoshiki@squeakland.org>
	<20070209182003.GE13381@always.joy.eth.net>
	<usldf3z10.wl%yoshiki@squeakland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sugar@laptop.org
To: Yoshiki Ohshima <yoshiki@squeakland.org>
X-From: sugar-bounces@laptop.org Sat Feb 10 10:49:59 2007
Return-path: <sugar-bounces@laptop.org>
Envelope-to: glls-sugar@m.gmane.org
Received: from pedal.laptop.org ([18.85.2.148])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HForm-0000UK-El
	for glls-sugar@m.gmane.org; Sat, 10 Feb 2007 10:49:58 +0100
Received: from pedal.laptop.org (localhost.localdomain [127.0.0.1])
	by pedal.laptop.org (Postfix) with ESMTP id 3DB10EF81AB;
	Sat, 10 Feb 2007 04:49:56 -0500 (EST)
X-Original-To: sugar@laptop.org
Delivered-To: sugar@laptop.org
Received: from spam.laptop.org (spam.laptop.org [18.85.46.23])
	by pedal.laptop.org (Postfix) with ESMTP id 5E309EF81AB
	for <sugar@laptop.org>; Sat, 10 Feb 2007 04:49:54 -0500 (EST)
X-ASG-Debug-ID: 1171100993-728f00000000-3Xmyjt
X-Barracuda-URL: http://18.85.46.23:8000/cgi-bin/mark.cgi
X-Barracuda-Connect: sceptre.pobox.com[207.106.133.20]
X-Barracuda-Start-Time: 1171100993
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by spam.laptop.org (Spam Firewall) with ESMTP id B30CCDA5D
	for <sugar@laptop.org>; Sat, 10 Feb 2007 04:49:53 -0500 (EST)
Received: from sceptre.pobox.com (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D6154B3F;
	Sat, 10 Feb 2007 04:50:14 -0500 (EST)
Received: from emit.nirmalvihar.info (unknown [59.95.5.38])
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9ACDD2646C;
	Sat, 10 Feb 2007 04:50:10 -0500 (EST)
Received: by emit.nirmalvihar.info (sSMTP sendmail emulation);
	Sat, 10 Feb 2007 15:19:34 +0530
X-ASG-Orig-Subj: Re: [sugar] etoys - binary blob in GIT
Content-Disposition: inline
In-Reply-To: <usldf3z10.wl%yoshiki@squeakland.org>
X-PGP-Key: 06E3 3D22 D307 AAE6 ACB4  6B44 A9CA A794 A4A6 0BBD
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Virus-Scanned: by Barracuda Spam Firewall at laptop.org
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=3.5
	QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.5 tests=
X-Barracuda-Spam-Report: Code version 3.1, rules version 3.1.8271
	Rule breakdown below
	pts rule name              description
	---- ----------------------
	--------------------------------------------------
X-BeenThere: sugar@laptop.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "Discussion of OLPC design,
	desktop platform and user experience" <sugar.laptop.org>
List-Unsubscribe: <http://mailman.laptop.org/mailman/listinfo/sugar>,
	<mailto:sugar-request@laptop.org?subject=unsubscribe>
List-Archive: <http://mailman.laptop.org/pipermail/sugar>
List-Post: <mailto:sugar@laptop.org>
List-Help: <mailto:sugar-request@laptop.org?subject=help>
List-Subscribe: <http://mailman.laptop.org/mailman/listinfo/sugar>,
	<mailto:sugar-request@laptop.org?subject=subscribe>
Sender: sugar-bounces@laptop.org
Errors-To: sugar-bounces@laptop.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39213>

On Sat, Feb 10, 2007 at 04:35:07AM +0900, Yoshiki Ohshima wrote:
> > >   What the Etoys team actually uses for our own change management is
> > > called "update stream" mechanism.  That is a sequence of small patches
> > > in text.  These patches are kept on an FTP/HTTP or WebDAV/HTTP server,
> > > and the developers submit the patches via FTP or WebDAV, and other
> > > users and developers fetches them via WebDAV or HTTP into their EToys
> > > image.  The image in the git repository is made in this way.  95% of
> > > the case, it is enough to recreate a "practically" identical image by
> > > merely fetching the patches.
> > 
> > I think the proper way to do that is to clean the upgrade directory 
> > after each commit so that the upgrade directory only keeps patches for 
> > the current changeset.
> 
>   I'm not sure what is the upgrade directory, so not sure the upside
> of this is.  Can you elaborate?

Sure, something like this:

$ export IMAGE=$HOME/etoys.image
$ cd etoys
$ git init-db
$ echo 1 > image-version
$ git add image-version
$ mkdir upgrade
$ cd upgrade
$ ls
patch1	patch2

# These patches are the "update stream" from the previous commit to the 
# current commit.

$ cat patch1
touch $IMAGE
$ cat patch2
echo abc >> $IMAGE
$ cd ..
$ git add patch1 patch2
$ git commit -a

# After every commit, you can remove the previous update stream.

$ git rm upgrade/*

# Here is the update stream for the next commit:

$ echo 2 > image-version
$ cat upgrade/patch1
echo def >> $IMAGE
$ git add upgrade/patch1
$ git commit -a
$ git rm upgrade/*

# Etc

Now you have a history of the update stream and you know which image 
belongs with which commit.
