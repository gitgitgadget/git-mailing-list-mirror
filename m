From: David Aguilar <davvid@gmail.com>
Subject: Re: [Cygwin 1.7] git difftool does not work with Windows kdiff3
Date: Tue, 1 Dec 2009 21:11:52 -0800
Message-ID: <20091202051151.GA45348@gmail.com>
References: <db95995b0911301445v3b757f75y7f4eaf4abaaa9f80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: cygwin@cygwin.com, git@vger.kernel.org
To: David Antliff <david.antliff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 06:12:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFhVW-0004Wf-TV
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 06:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbZLBFLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 00:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbZLBFLz
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 00:11:55 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:36643 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbZLBFLy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 00:11:54 -0500
Received: by yxe17 with SMTP id 17so5268865yxe.33
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 21:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=HYAzYHSyvfoNIAuWX6XUvb4LNYefwoknkCQXUsdk6RQ=;
        b=mcily9XbIefraNpiy4FJoxobtthFxLTIT5igHVRXa8Y1QXmVU6eq+Qr+u8UAQEp/Oy
         aQrZ6o5riJP7YU5nasl5Ev4Cg3Sb99wqutYZ6R0rAWvKIrGddENe3BeZq5eckF2lMF6k
         RWwE7o0w+f7cyhyrpOXMni43NyUbabXKKZIWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VI9CQ3/E2ilZ4sXfuJTs3MFZ19NBwcvG2dypp6eMIQ7k3xGFschWqxS/tthas1FsDZ
         TQvcxqyP/IvnVKYyFf4opZoYZQqufDRmtd8aq57Cz6G0aeicCM2b5bJw1cz/lmUs/Qil
         fTa+Q9qhvtj7WSbPrnh2Bfd4FWzkEWsDUwYw0=
Received: by 10.90.62.4 with SMTP id k4mr2266786aga.56.1259730720545;
        Tue, 01 Dec 2009 21:12:00 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 35sm409720yxh.33.2009.12.01.21.11.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 21:11:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <db95995b0911301445v3b757f75y7f4eaf4abaaa9f80@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134298>

I added the git list to the CC: list.

On Tue, Dec 01, 2009 at 11:45:35AM +1300, David Antliff wrote:
> 
> git-mergetool works very well with a native Windows (i.e. not Cygwin)
> installation of kdiff3 because it creates its working files in the
> current working directory, usually called
> ./<original-file>.LOCAL.xxxx.<ext> and
> ./<original-file>.REMOTE.xxxx.<ext>. Because these paths are relative
> to the CWD, the non-Cygwin version of kdiff3 handles this fine. E.g:
> 
> kdiff3 --auto --L1 build.xml (Base) --L2 build.xml (Local) --L3
> build.xml (Remote) -o build.xml ./build.xml.BASE.5512.xml
> ./build.xml.LOCAL.5512.xml ./build.xml.REMOTE.5512.xml
> 
> But git-difftool does something slightly different - it creates the
> temporary versions of the file in /tmp with a random prefix, e.g.
> /tmp/Vc0BZy_<original-file>. This causes the Windows version of kdiff3
> to fail to open the file, because the path "/tmp/...." is invalid. In
> my case, the path that would work is "c:/cygwin-1.7/tmp/..." instead:
> 
> kdiff3 --auto --L1 "build.xml (A)" --L2 "build.xml (B)"
> /tmp/Vc0BZy_build.xml build.xml
> 
> It's the  /tmp/... bit that kdiff3 can't understand. On the other
> hand, this command does work:
> 
> kdiff3 --auto --L1 "build.xml (A)" --L2 "build.xml (B)"
> c:/cygwin-1.7/tmp/Vc0BZy_build.xml build.xml
> 
> 
> Perhaps git-difftool should create the temporary file in CWD just like
> git-mergetool, rather than the Cygwin-specific path /tmp?
> 
> I'm using the Windows version of kdiff3 to avoid dependency on the
> graphical X libraries that Cygwin's kdiff3 would require. I think it's
> a fairly common thing to do when working with git on Windows. I can
> see that the Cygwin version of kdiff3 would probably not exhibit this
> problem.
> 
> I imagine the same problem will occur with other Windows versions of
> merge/diff tools.
> 
> I also understand if there's no intention by the Cygwin git
> maintainer to support non-Cygwin gui merge tools, but I don't think
> I'm the only person using them extensively.
> 
> -- David.


git-difftool is built on top of git's GIT_EXTERNAL_DIFF
mechanism.  So this problem is not specific to difftool.

I don't have a general solution for you but I do have
a workaround until a better solution manifests itself.

Here's one workaround:

	$ TMPDIR=.
	$ export TMPDIR

git honors $TMPDIR and that'll make git write files in
the current directory.

Likewise, running `git difftool` should work since the
paths handed off to the difftool should be e.g.
./XXXXXX_build.xml.

That said, I don't know if git dereferences the "." thus
making the workaround invalid.  I haven't tested it.


If that doesn't work then there's another alternative.
You could write a simple kdiff3 wrapper script to
translate the cygwin paths into Windows-native paths.

Drop it in the front of $PATH and it'll magically
work.  Otherwise, set the difftool.kdiff3.path
configuration variable to the path of the wrapper
script and difftool will use your wrapper without
it being in $PATH.

I hope that helps for now.



An aside:

I've always tested git-difftool on Windows using msysgit.
Windows-native kdiff3 is one of the tools that I've tested
and didn't have any problems using msysgit and native kdiff3
together.

cygwin git and msysgit are very different, of course.
It's likely that msysgit does a lot more magic to
make this possible, but I just wanted to throw that
out there.

If anyone knows of a general solution to this problem
then I'm all ears.


Good luck and let us know how it goes,

-- 
		David
