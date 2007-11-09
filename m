From: "Yossi Leybovich" <sleybo@gmail.com>
Subject: Re: corrupt object on git-gc
Date: Fri, 9 Nov 2007 10:01:29 -0500
Message-ID: <4fe79b4b0711090701g7a43cdfdi5e20e5ffb437d7bb@mail.gmail.com>
References: <4fe79b4b0711090538wf483ce7j89c518962e89780e@mail.gmail.com>
	 <473464A2.7080003@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Yossi Leybovich" <sleybo@mellanox.co.il>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 09 16:02:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqVMh-00041A-Nn
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 16:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbXKIPBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 10:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759500AbXKIPBb
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 10:01:31 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:45526 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbXKIPBa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 10:01:30 -0500
Received: by nz-out-0506.google.com with SMTP id s18so532874nze
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 07:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wTDF+rZLdBrlCVgCPWoT4scDyo/brS4gW34xKUPq1B4=;
        b=R6CZ0cAEvGHjqXXFIJdJDW+ZmdcM0LUX9u8z6bl6BJbWQBeMYZNbXOUSzPMU7LHEZZxJcmE6K4tayFq2UmW5AO6NjJFxmNFn3WLwI54eJM9lvTjRcJubImmdiFSpwPFz5wNmN2GbU8I1KMZoYeXUGi+ElIKdRKZbTV6eqSbQswg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=deDw/QdzGtQLx5LPRtU+SBYPhXQ8Ft4zyu6UdVpwCHygnfOBDMgJ7pr5tPctJJXbWHXXINxX4DvzN/jWkkUODTqgZ2QoNBBr7NHKogekTzIDDhkF1dwOZFvicUu5Nqq9gUGD5NE5dskqotERbB8jxLxIqKOzJw970JpF043QkGk=
Received: by 10.142.216.9 with SMTP id o9mr518603wfg.1194620489164;
        Fri, 09 Nov 2007 07:01:29 -0800 (PST)
Received: by 10.142.217.12 with HTTP; Fri, 9 Nov 2007 07:01:29 -0800 (PST)
In-Reply-To: <473464A2.7080003@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64197>

On Nov 9, 2007 8:46 AM, Andreas Ericsson <ae@op5.se> wrote:
>
> Is this a super-secret project or you can make a tarball of the .git
> directory and send it to me? Trying to track down the cause through
> email is decidedly slow.
>

Actually yes , I am not sure I can send the repository , I will
farther check that.
>
> One tree uses the object. I'm not sure if any commit-objects
> use the tree. Try
>
> for b in $(git branch --no-color -a | cut -b3-); do
> for rev in $(git rev-list HEAD); do
>        git ls-tree -r $rev | grep -q 2d9263c6d23595e7cb2a21e5ebbb53655278dff8
>        test $? -eq 0 && echo $rev && break
> done
> done

tried this and it return empty

[mellanox@mellanox-compile ib]$
[mellanox@mellanox-compile ib]$  for b in $(git branch --no-color -a |
cut -b3-); do
> for rev in $(git rev-list HEAD); do
> git ls-tree -r $rev | grep -q 2d9263c6d23595e7cb2a21e5ebbb53655278dff8;
> test $? -eq 0 && echo $rev && break;
>  done; done
[mellanox@mellanox-compile ib]$
[mellanox@mellanox-compile ib]$

[BTW I didn't notice u use the b varieble so I also tried gi rev-list
$b but still empty ]
I also tried to remove object and tree and apperently other trees and
commits reference to these objects

 mv ../9458b3786228369c63936db65827de3cc06200  ../4b/
mv: cannot stat `../9458b3786228369c63936db65827de3cc06200': No such
file or directory
[mellanox@mellanox-compile ib]$ mv
.git/objects/4b/9458b3786228369c63936db65827de3cc06200  ../4b/
[mellanox@mellanox-compile ib]$ mv
.git/objects/2d/9263c6d23595e7cb2a21e5ebbb53655278dff8  ../2d/
[mellanox@mellanox-compile ib]$ git-fsck --full
broken link from    tree e5a0044c4ccae7635f07414c1f155bac72d25fd9
              to    tree 2d9263c6d23595e7cb2a21e5ebbb53655278dff8
dangling commit 0d43a63623237385e432572bf61171713dcd8e98
dangling commit 4fc6b1127e4a7f4ff5b65a2dd8a90779b5aff3e0
dangling commit 7da607374fe2b1ae09228d2035dd608c73dad7c8
dangling commit 004ef09ae022c60a30f9cd61f90d18df5db3628e
broken link from    tree 8bd00402b2a20024f4556107b8a729b0205657db
              to    tree 2d9263c6d23595e7cb2a21e5ebbb53655278dff8
dangling commit 85112c6fabb6b8913ab244a8645d67380616eba6
missing tree 2d9263c6d23595e7cb2a21e5ebbb53655278dff8
dangling commit bd98481afa93356fa6daa4b6f88c4e631ae2fd72
dangling commit e81e3d2c9c25e5bf5b31327b10b23f9bd0a6d056
dangling commit 92ff9b8cbc771345c9cde0c7fef2c23bb79242b9



>
> If it turns up empty, you *should* be able to safely delete
> 2d9263c6d23595e7cb2a21e5ebbb53655278dff8 and
> 4b9458b3786228369c63936db65827de3cc06200
>
> Make sure to take a backup first though.

a lot of commits and trees point to this

>
> --
> Andreas Ericsson                   andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231
>
