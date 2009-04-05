From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Sun, 5 Apr 2009 05:54:53 +0200
Message-ID: <20090405035453.GB12927@vidovic>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic> <20090405T001239Z@curie.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 05:56:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqJTQ-0006j3-Oi
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 05:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756940AbZDEDzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 23:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753655AbZDEDzD
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 23:55:03 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:43545 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbZDEDzB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 23:55:01 -0400
Received: by ewy9 with SMTP id 9so1468962ewy.37
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 20:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=y74niqgW1ghw+kYsTGwCYItd0TDiCYyNuF3gzJnxQ4Q=;
        b=hsfxSXjnvE9YCrnz38FgX4g+gQirw1xPGM7ofvg/jLuonjOz7BYGYM2lXj21ENnSze
         pR83CKEIB0KR8bAgYkm2M/poYmh7n7rc8+sklsYynQT6LcNE6zjzi6yXKrSD9RnuvsYc
         UCq9iLB5eCSZ5ynkzj2wPPeeLZX+Auzn6Q3TE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=F69dQOPwXMa7HZgJ8VEMcnxxXkVgLjM1RS207WcC9ZvpC5s+TboF7yD7PUBLFNAl5W
         dHVJH30Wor0VZ9VYuHx3jd3Vb5syKLx2U410ecPZxGhzp6B4VKH2x2/7BRCQLP8eSojA
         9mpeehkX+BLCuBoQ3NutRe9Vv9NWoZI0Jh6bA=
Received: by 10.210.71.12 with SMTP id t12mr155801eba.41.1238903698791;
        Sat, 04 Apr 2009 20:54:58 -0700 (PDT)
Received: from @ (ABordeaux-258-1-82-86.w86-201.abo.wanadoo.fr [86.201.73.86])
        by mx.google.com with ESMTPS id 28sm5005026eye.14.2009.04.04.20.54.56
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Apr 2009 20:54:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090405T001239Z@curie.orbis-terrarum.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115630>

On Sat, Apr 04, 2009 at 05:37:53PM -0700, Robin H. Johnson wrote:

> That causes incredibly bloat unfortunately.
> 
> I'll summarize why here for the git mailing list. Most our developers
> have the entire tree checked out, and in informal surveys, would like to
> continue to do so. There are ~13500 packages right now 

Each developer doesn't work on so many packages, right ? From my point
of view, checkin'out the entire tree is the wrong way on how to do
things.

Also, you could keep an entire tree repo assuming it's _not_
"fetch-able".

> For each package, the .git directory, assuming in a single pack,
> consumes at least 36 inodes.  Tail-packing is limited to Reiserfs3 and
> JFS, and isn't widely used other than that, so assuming 4KiB inodes,
> that's an overhead of at least 144KiB per package. Multiple by the
> number of packages, and we get an overhead of 2GiB, before we've added
> ANY content.

> Without tail packing, the Gentoo tree is presently around 520MiB (you
> can fit it into ~190MiB with tail packing). This means that
> repo-per-package would have an overhead in the range of 400%.

Don't know about the business for Gentoo, but HDD is cheap. Also, I'd
like to know how much space you will gain with the CVS to Git migration.
How bigger is a CVS repo against a Git one ?

One repo per category could be a good compromise assuming one seperate
branch per ebuild, then.

> Additionally, there's a lot of commonality between ebuilds and packages,
> and having repo-per-package means that the compression algorithms can't
> make use of it - dictionary algorithms are effective at compression for
> a reason.

Please, no. We are in the long term issues. Compression will be
efficient. It's all about the content of the files and dictionary
algorithms certainly will do a good job over the ebuilds revisions.

-- 
Nicolas Sebrecht
