From: James Pickens <jepicken@gmail.com>
Subject: Re: 'git clone' doesn't use alternates automatically?
Date: Sat, 31 Jan 2009 13:08:16 -0700
Message-ID: <885649360901311208s4bc17ae3me2062b07b302291e@mail.gmail.com>
References: <885649360901301412jd5c6b0dne1eff1ff00dd043e@mail.gmail.com>
	 <20090131071238.GC3033@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 31 21:10:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTMAK-0004KL-IP
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 21:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbZAaUIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 15:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbZAaUIT
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 15:08:19 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:23937 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbZAaUIS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 15:08:18 -0500
Received: by wa-out-1112.google.com with SMTP id v33so451976wah.21
        for <git@vger.kernel.org>; Sat, 31 Jan 2009 12:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=x9elhikBsg9j2nV2b6JHKAJf/ZuFP9DgBpdidISMTD0=;
        b=EfwEeJGuMZX88HWD/3FiKXebc5blJoCiq0TGHuB+lENmpSqwbDdZVUaCahwt+wquy5
         9pc53uJDh6tQ+d5H9RZ1E7wN5qJxGaJNiZSVFCl3q3mRAPJkTkt9Jcea/m0lylmkaZJk
         CTvXejrkdl/KVfvjITWUF+ZDRAjeSeCX8JOZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ibdPpWCEmIUlRWW5OX+E3M2J3FBaH6kMf4PNxI83fJtpLaO8fv82qb5asWOpf5ZATe
         x/vxMjnfCw95MhcVXZ7hJA7EEDU76/R1mXPHcVIyenyyLN9tXfYyUPU4Lv6LqZisWffK
         B+JaU8UxuMC2fPJ12wtOzERJBIT4ovJ3d6iUk=
Received: by 10.114.159.5 with SMTP id h5mr83953wae.190.1233432496538; Sat, 31 
	Jan 2009 12:08:16 -0800 (PST)
In-Reply-To: <20090131071238.GC3033@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107935>

On Sat, Jan 31, 2009 at 12:12 AM, Jeff King <peff@peff.net> wrote:
> but presumably in your example the second clone is _not_ on the NFS
> mount, and therefore can't hardlink.

That's correct.

> So you can try "git clone -s" to specify that you definitely want
> alternates.

Well, the clone gets the alternates either way.  It just doesn't
use them to avoid copying the data unless I give -s.  More
importantly, if 'git clone' worked the way I thought, then when I
clone a remote repository for which I have a local mirror, I
could avoid typing '--reference <path to local mirror>' by adding
<path to local mirror>/objects to the alternates file in the
remote repository.

> I don't recall clone ever being that clever, but I could be wrong (it is
> not an area of the code that I am too familiar with).
>
> Can you try a test with a few different versions to see if it ever
> behaved as you expected (and if it does, bisect to find the breakage)?

Damn.  I was hoping the response would be "it's a regression, and
here's a patch to fix it".  I went ahead and tested a few old
versions and they all behave the same way.

So, is there any reason 'git clone' shouldn't automatically use
the alternates that it copied into the new repository?  I might
look into writing a patch if nobody objects.

James
