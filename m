From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Debugging strange "corrupt pack" errors on SuSE 9
Date: Wed, 20 Jun 2007 16:17:11 +1200
Message-ID: <46a038f90706192117x53420c04o27f05e8fa6c338a5@mail.gmail.com>
References: <46a038f90706191936m121a94e4x1e59dff4fe217988@mail.gmail.com>
	 <alpine.LFD.0.99.0706192313290.20596@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	jonathan.newman@catalyst.net.nz
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jun 20 06:17:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0rd8-00018h-VW
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 06:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434AbXFTERP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 00:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753200AbXFTERO
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 00:17:14 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:23220 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281AbXFTERM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 00:17:12 -0400
Received: by wx-out-0506.google.com with SMTP id t15so58843wxc
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 21:17:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZvOqfF4hXD8baxs0qb7se/kEBEiyx7nEYepKqRHeV6SM85vs0Hq2Ww1cqqdvFxomGDMyvvlpoPcpYmodZs70Qzyshf8vDEPZVhOeMqF0JTnamWHxOqgdUHYCvvxMv4c0l76KZ9UmI1cWh6Sz7a40tm8gPfhqTb1NQOXWfeRx3ak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L/s9pNhDlgUn3apqjGf9qw9ZZZmG5xnSPhuafPr11D1IK38xGPKe0mK+qouEyGb6+/8KmLWOB0IrMqpufqE99NErnKyIljVKa+UjlvnjSkQ1owEgi9iL8yH9PpJSO7gt/slU+neWC/nNviiiCVNjD+tDNvjWN0RyxWPAScNmwUg=
Received: by 10.90.54.4 with SMTP id c4mr38220aga.1182313031822;
        Tue, 19 Jun 2007 21:17:11 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Tue, 19 Jun 2007 21:17:11 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.99.0706192313290.20596@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50528>

On 6/20/07, Nicolas Pitre <nico@cam.org> wrote:
> The full exact error message would be highly useful indeed.

Yes. I haven't seen it first hand either, and the machine is closely
guarded :-/ but I think you are on to something: it's a v1.4.0.

# git --version
> git version 1.4.0

# cat /etc/issue
Welcome to SUSE LINUX Enterprise Server 9 (i586) - Kernel \r (\l).
# uname -a
Linux lhostname 2.6.5-7.244-bigsmp-100hz #3 SMP Sun Aug 13 21:50:35 NZST
2006 i686 i686 i386 GNU/Linux

The errors look like

# git-pull /home/jun/moodle-r2.git
ird-mk2:fromusb
fatal: git-unpack-objects exec failed
fatal: git-unpack-objects died with error code 128
Fetch failure: /home/jun/moodle-r2.git

# cg-update fromusb
Using hard links
Fetching head...
Fetching objects...
Getting pack 445d79a6fe09a3d03489449f63faef0d9e9e2668
 which contains 4f4773fb3403f3ec4097ab7c7b1fdec23b9aa924
fatal: corrupted pack file
.git/objects/pack/pack-445d79a6fe09a3d03489449f63faef0d9e9e2668.pack
progress: 2 objects, 0 bytes
cg-fetch: objects fetch failed

> Maybe the client machine runs git version < 1.4.2.2, in which case it is
> possible that your push created a pack containing delta objects with
> offset to base which git versions prior 1.4.2.2 do not understand.

Ouch. We weren't supposed to have non-backwards compatible changes...

> If this is the problem you are facing (the error message should confirm
> this) then the easiest solution is to upgrade git on the client.

Ha ha. Not particularly easy, unfortunately.

> A quick fix for the client is to set repack.usedeltabaseoffset to
> false on the machine where you have git 1.5 installed, then run "git
> repack -a -d", and finally copy the pack over to the client repository.

That'll be a bit easier -- it's a fix we can do on the transfer repo ourselves.

Thanks! I do wonder though -- isn't a backwards-incompatible change
like this worthy of don't we bump core.repositoryformatversion?

> But because you push to a local repository (a mounted USB stick is
> considered a local repo) then you don't get to negociate the pack
> capabilities of the final destination, and therefore more "bad" delta
> objects might sneak in again.

How does that work? So any repo we push _from_ can override (and muck
up) the destination repo, ignoring its config?

That sounds a bit broken - the pack being built for a local
destination should respect the settings of the destination repo.


m
