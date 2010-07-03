From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: Issues with line-endings and autocrlf setting after SVN to Git  transition
Date: Sat, 3 Jul 2010 22:09:38 +0200
Message-ID: <17D745C4-191B-4A23-9070-91C5AA981DA4@gmail.com>
References: <AANLkTilsvEbwHhIkvpaZQ4542tH2i6qF4EZR1IjErp46@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Sat Jul 03 22:09:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OV929-0006QZ-EX
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 22:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977Ab0GCUJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jul 2010 16:09:46 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55740 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851Ab0GCUJp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jul 2010 16:09:45 -0400
Received: by ewy23 with SMTP id 23so1322660ewy.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 13:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=R/jc7AQ/bonHnAD4ReyhC44KWde1lZub8pu/uLpBQNY=;
        b=CyuMuQrG9boM9p3kFV+OzT2ZTmD9zit4zfOUJ4dliai71U3gI4f+DKmC+yMfi3CpeO
         xjxMpUeEk5FebWLuwjdTvuq3nWx/A+JcsPy6VhZKL7hdkSA18k4T9IFHz2JAw3Hjevx3
         Mk2V49PjUuKMAjw5BDBO4PfpJNhbpyVyi1w7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=cjszBbHuBApbbiheo5dBtIAksu0iW3xrBRLH1yEvuOlBqWB5lB/zKFSTJBWmFt0DZo
         OxZBkAWhnOWxLy/s1/tsWnIJ9Ry51bCDCVcZm5V2GoITGM7kjKexNe1SCTVzt0wWXAE9
         XCRaO3Arom1gOy/vFgRU1XhYEYtfpJdIyNt5c=
Received: by 10.213.98.71 with SMTP id p7mr766831ebn.18.1278187780536;
        Sat, 03 Jul 2010 13:09:40 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id a48sm18252425eei.19.2010.07.03.13.09.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 03 Jul 2010 13:09:40 -0700 (PDT)
In-Reply-To: <AANLkTilsvEbwHhIkvpaZQ4542tH2i6qF4EZR1IjErp46@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150200>

On 2. juli 2010, at 21.59, Bradley Wagner wrote:

> So I'm running into the infamous issue with line-endings after
> migrating an SVN repo to Git.
> 
> I'm on OS X and I currently have auto.crlf set to "input" as
> recommended on this GitHub page:
> http://help.github.com/dealing-with-lineendings/. I'm doing a fresh
> clone of our repo and it's showing many files as having changed.

That GitHub page is noble, but wrong: setting core.autocrlf gets you into trouble when you clone a repository that already has CRLFs, as you have found.

The upcoming 1.7.2 version of git adds a safety feature to autocrlf that makes it ignore files that already have CRLF in the repository.  You will be able to use autocrlf without getting the spurious changes, but it will no longer convert files with "wrong" line endings already in the repository.

> I've gotten conflicting answers to my question on Stack Overflow:
> http://stackoverflow.com/questions/3161797/will-the-fix-to-correct-line-endings-in-git-repositories-make-future-diffs-usel.
> Should I fix this with a commit or turn off autocrlf? I intend to use
> this repo in both OS X and Windows environments.

It depends what you want, but right now I suggest turning autocrlf off and living with the mixed line endings.  Once git 1.7.2 is released you can start using autocrlf to get CRLF on Windows, as long as you don't mind the mix of LF and CRLF files on OS X.

> The problem with
> fixing it with a commit is that the commit will change every single
> line of these affected files. As I understand it from SVN, this means
> that any diffs that span that commit will basically show the entire
> files as being changed which is definitely frustrating.

"Diff" and "blame" can be told to ignore changes in whitespace, but the real problem with doing a conversion like this using (old) autocrlf is that checking out versions from before the conversion will still show lots of changes.

This is where the other normalization feature introduced in 1.7.2 comes in.  Marking a file with the "text" attribute tells git to normalize its line endings, and the attribute can be set to "auto" for all files if you want automatic conversion.  A configuration variable lets you set which line endings you want in your working directory.  Older versions are not affected since it is an attribute, so you won't get spurious changes when you check them out.

So if you want to normalize line endings in your repository, wait for git 1.7.2 and then read up on the "text" attribute.
-- 
Eyvind
