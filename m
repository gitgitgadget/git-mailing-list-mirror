From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow trees
Date: Sun, 15 Apr 2007 12:57:13 +0700
Message-ID: <fcaeb9bf0704142257x3761ef2cie3996420b3bcd24a@mail.gmail.com>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net>
	 <Pine.LNX.4.64.0704141019290.18655@racer.site>
	 <20070415000330.GG3778@curie-int.orbis-terrarum.net>
	 <Pine.LNX.4.63.0704141655390.31807@qynat.qvtvafvgr.pbz>
	 <20070415020139.GB2689@curie-int.orbis-terrarum.net>
	 <20070415043146.GB2229@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 07:57:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hcxjz-0002Kq-KH
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 07:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbXDOF5P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 01:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbXDOF5P
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 01:57:15 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:43021 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbXDOF5O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 01:57:14 -0400
Received: by an-out-0708.google.com with SMTP id b33so1332693ana
        for <git@vger.kernel.org>; Sat, 14 Apr 2007 22:57:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hOuIgHTBc7Y7IC8UHZVgTEF00cLNcOR3+nJd0UiMNQY/GwzmiSXcExR+KMtnCPIPCGNMU2eHLDBfE4IZ0sQm9pmLgxx0cEXUGgkpUGzLWD6YmUnmUVzn8KLEjyGpItNKfqggpLT1DBOpHvuEycjLgDN86JhT6EcLCTrSzjifM5w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XxPuoPpEl2HouKXBtr6tfpTFKIhI2IXcHkpT0QbVlolZJLF2USh47+TrrWRkdKYjZfOHliRQXoeLiSK9tNmIYmCUkFv7DFUTVUZMZ5rsGm5kTUgltYe96escK3eSzsx0b+9F6MV+LejRfNlflfTiZscD4YVZxM1ABSlRYp1mRCI=
Received: by 10.115.77.1 with SMTP id e1mr1593625wal.1176616633532;
        Sat, 14 Apr 2007 22:57:13 -0700 (PDT)
Received: by 10.114.66.6 with HTTP; Sat, 14 Apr 2007 22:57:13 -0700 (PDT)
In-Reply-To: <20070415043146.GB2229@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44488>

On 4/15/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > The tree that goes out to users is NOT git or CVS. What you point to
> > here is impossible unless we forced all of the users to migrate to git
> > (a truly herculean task if there was ever one).
> > It's a tarball or an rsync of an automatically managed CVS checkout.
> > (Tarballs go onto the release media, and are also widely used by those
> > that sneaker-net their trees to machines for security reasons).
> > Alternatively, the users browse the viewcvs, and pull something from the
> > Attic. Regardless of where they get the file from, the problem is that
> > the file doesn't contain any markers to help the developers merge it
> > back again.
>
> Git won't do this for you.  We specifically don't mangle source[*1*].
>
> What you could do is create a program that mangles the files before
> delivery.  You would probably want to do something like:
>
>   $Id: 7fbf239:path/to/file$
>
> where 7fbf239 is the earliest commit that introduced that particular
> version of path/to/file, even if that is months old.  That would
> be most like what CVS would do.  8 char abbreviated commits should
> be reasonably stable, and not too long to read or copy and paste.
> A format like the above would also be easy to grab and copy into
> a Git command line.
>
> If we had a Git library that could access the repository, this would
> a pretty easy program to write.  You are basically blaming each path
> in the current HEAD commit on the parent, until you cannot blame
> anyone else for that path.  You do this blame on the entire tree,
> and then output the munged structure (or only the files you want
> munged).
>
> Its good we have a GSoC project working on libification!  ;-)
>
> [*1*] Yes, I'm ignoring the nutso crlf support that's now in...  Even
>       though I work on Windows, the only true line ending is LF.  ;-)

Can we add an attribute like Subversion's svn:keywords? If the
attribute is set, we expand keywords when checkout and remove
expansion in memory before doing any git operations. It's some kind of
I/O filter for working directory access.

-- 
Duy
