From: "Kai Hendry" <hendry@aplixcorp.com>
Subject: Integration branching
Date: Mon, 7 Apr 2008 14:02:03 +0100
Message-ID: <b24851260804070602o11b93923m7ce7d79d5f59547b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 07 15:02:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jiqzv-0007OP-JE
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 15:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757362AbYDGNCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 09:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757340AbYDGNCM
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 09:02:12 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:29098 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbYDGNCL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 09:02:11 -0400
Received: by yw-out-2324.google.com with SMTP id 5so222058ywb.1
        for <git@vger.kernel.org>; Mon, 07 Apr 2008 06:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=4ONZjVa3vpPCWEhjZqEDETe3G2gBv4slIM7ZuUQTcJk=;
        b=Ka8e5oXKRxh+ydMcWV7ajxs/VR1ZpkYF2oD/Krllr8RvfUp9aHXhAuLSyI1PFcNMHc9iW2aPlUJz/bd7g08Xrv85mx3+4VHFxYbwmBFSjjdlpQtjtAaULgpWcFgWR8GtYVVuPYSVHD785wyhBeL21d596fHZNPf8rzbFcz7jPaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=lQ35wXbmu6mDLx3p/GGn3f2YP/qlxD7J9pJ+GQOlxuNXFr7nnFe1+Edfvm5D0hNcmbMSxsUYnfxK8FGUTMngclKp1+FY1aW+XqB+bzYSKCt+GMiUEPrfxW4hVcXBbOCToA8rgm6qiFD2m1+xA4jJ1NuXaHsbdxy8TRDtSSBPbks=
Received: by 10.114.195.19 with SMTP id s19mr5948767waf.57.1207573323830;
        Mon, 07 Apr 2008 06:02:03 -0700 (PDT)
Received: by 10.114.136.13 with HTTP; Mon, 7 Apr 2008 06:02:03 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: b0a8fcf735a25153
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78972>

I've been asked to setup & host a git repo of an "integration branch"
of WebKit for our developers.

So I expected it to work like so:

git clone git://git.webkit.org/WebKit.git
git checkout -b test

<Make a few small changes and commit>

git-config remote.upload.url ssh://git.webvm.net/srv/git/webkit-test
x61:~/aplix/test/WebKit% git push --thin -v upload test
Pushing to ssh://git.webvm.net/srv/git/webkit-test
Counting objects: 371612, done.
Compressing objects: 100% (67851/67851), done.
Writing objects:  11% (43886/371612), 25.32 MiB | 88 KiB/

However when uploading the branch it seems to upload _everything_
which is far too big and impractical. Couldn't it just somehow
reference the remote branch and just publish the patch of the "small
changes"?

When doing a git-http-push instead of ssh, git resulted in a "Out of
memory" error:

   1. git clone git://git.webkit.org/WebKit.git # Check it out
   2. git checkout -b test # create a "test" branch and switch to it
   3. echo blah >> ChangeLog # change something
   4. git commit -a # commit that test change
   5. git-config remote.upload.url http://moto@moto.webvm.net/moto.git
# configure the upload url
   6. git push upload test # fatal: Out of memory, malloc failed

Was this the fault of the server(nox) or client(x61)?

x61:~% git --version
git version 1.5.4.5
nox:~% git --version
git version 1.5.4.4

So is there some better way of publishing a branch? Without uploading
the whole WebKit?



I did try something else, that was to create a webkit repo on the
server nox like so:

nox:/srv/git/webkit% git --bare init --shared
nox:/srv/git/webkit% git --bare fetch git://git.webkit.org/WebKit.git
master:master
git fetch -f git://git.webkit.org/WebKit.git master:master # again
forcing updates

And let developers branch from that. This proved a little cumbersome
as I need to manually force updates to webkit trunk when developers
asked me to do that.
However once a developer cloned ssh://git.webvm.net/srv/git/webkit.
Creating a test branch 'deleteme' and then `git push origin deleteme`
was extremely fast. So I guess this is the right way to achieve my
goals?


Any suggestions and tips would be greatly appreciated!
