From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Incremental CVS update
Date: Thu, 22 Jun 2006 16:08:09 -0400
Message-ID: <9e4733910606221308v2f995adev8c5b721be0a009e2@mail.gmail.com>
References: <9e4733910606220526o14ebe76ala4d327f012a0e8f5@mail.gmail.com>
	 <46a038f90606221236j2c5c9692yecef924aa769c1c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Keith Packard" <keithp@keithp.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 22 22:09:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtVTM-0000VK-2c
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 22:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbWFVUIM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 16:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWFVUIL
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 16:08:11 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:18161 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030355AbWFVUIK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 16:08:10 -0400
Received: by nz-out-0102.google.com with SMTP id z31so526758nzd
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 13:08:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lhDDYZpwFl8a2kg3efe9HdsmoeOCsCTDt4MTspFjhG8ZHB9c+2K/Nc5NWk8xEkwldi/cF1IYMCTA+63fyzq5TNs/CF8H7HSMLp/C0vSHnnrJo8RF50ty8n2vqVPY0/ZpDbGDLNXUcdUq7fa9RMWiQa59IFyCVns7BRqq01rz00U=
Received: by 10.36.221.38 with SMTP id t38mr1427210nzg;
        Thu, 22 Jun 2006 13:08:09 -0700 (PDT)
Received: by 10.36.37.5 with HTTP; Thu, 22 Jun 2006 13:08:09 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606221236j2c5c9692yecef924aa769c1c9@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22365>

On 6/22/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 6/23/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > cvsps keeps it's incremental status in ~/.cvps/*. parsecvs might want
> > to keep it's status in the .git repository and use tags to locate it.
> > You could even have a utility to show when and what was imported. By
> > keeping everything in git it doesn't matter who runs the incremental
> > update commands.
>
> Jon,
>
> what cvsps keeps is a cache of what it knows about the repo history,
> to ask only for new commits. Now, cvsps will always write to STDOUT
> the full history, and git-cvsimport discards the commits it has
> already seen, based on reading the state of each git head.

The cache is 723MB for the Mozilla repo. Since the info gets cached in
my home directory anyone else who needs to sync the repo doesn't get
to use the cache.

[jonsmirl@jonsmirl .cvsps]$ pwd
/home/jonsmirl/.cvsps
[jonsmirl@jonsmirl .cvsps]$ ls -l
total 707492
-rw-rw-r-- 1 jonsmirl jonsmirl 723758657 Jun 15 16:10 #home#mozcvs##mozilla
[jonsmirl@jonsmirl .cvsps]$


Keith is rewriting parsecvs. If you analyze all of the data
structures, the info needed for the conversion should be able to fit
into well under 100MB instead of the ~2GB the current programs are
using.

There are lots of ways to reduce memory consumption. You can turm CVS
revisions into git IDs as soon as the revision is seen. That lets you
get away from tracking file names and long CVS revision numbers. It
also works to turn the author/log fields immediately into a hash. When
possible switching to arrays instead of linked list is smaller too.

Some stats:
1M revisions
200K unique changesets (author/log combos)
200KB symbols
1,800 branches

cvsps has the lowest memory consumption, it uses 1200 bytes per
revision. It looks like it is possible to lower this to less than 100
bytes per rev.

>
> So cvsps + git-cvsimport don't keep any extra data around, and I am
> 100% certain that parsecvs don't need that either.
>
> cheers,
>
>
> martin
>


-- 
Jon Smirl
jonsmirl@gmail.com
