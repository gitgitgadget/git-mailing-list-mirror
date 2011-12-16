From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Any tips for improving the performance of cloning large repositories?
Date: Fri, 16 Dec 2011 13:02:12 +0000
Message-ID: <CAJ-05NPP7aCcr_SYxLYk8U1entDMv0aF2Me3cTGmOLjYqFKUOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 14:02:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbXQZ-0003Gz-O4
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 14:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759177Ab1LPNCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 08:02:16 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48978 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758921Ab1LPNCO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 08:02:14 -0500
Received: by iaeh11 with SMTP id h11so4343192iae.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 05:02:13 -0800 (PST)
Received: by 10.50.36.230 with SMTP id t6mr8255438igj.83.1324040532843; Fri,
 16 Dec 2011 05:02:12 -0800 (PST)
Received: by 10.42.174.136 with HTTP; Fri, 16 Dec 2011 05:02:12 -0800 (PST)
X-Google-Sender-Auth: k1R1Qc0OrMcFg7ZNIO2cnK3jNM4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187275>

Hi,

We've migrated our old CVS repository into GIT without too many
issues. However now we are rolling out the usage of the new repository
we are hitting some performance bottlenecks, especially on the initial
clone (something our buildbot instance does a lot).

Our repo is large, my .git is around 2.5G although the central repo
has a 1.7Gb single pack file. However some machines handle the cloning
better than others. For one thing the clone process seems to involve
the receiving side needing a large glob of memory which causes
problems when there is memory pressure.

I've tried tweaking the pack size from unlimited to 256m but this
seems to have increased the clone time as the receiving end attempts
to re-pack everything back into an uber-pack.

Another thing that I've noticed is very high systime on the receiving
machines as ethernet and disk I/O is heavily hit.

So what I'm looking for are some tips on how I can tweak
configurations to make the clone process a little less I/O and memory
heavy. Any suggestions?

One thing I did try was a rsync'ed local repo in /var/cache/repos
which the clone command used for reference with something like:

git clone --local --reference /var/cache/repo.git git://repo/repo.git

But that didn't help as it seems to copy the whole thing anyway.

-- 
Alex, homepage: http://www.bennee.com/~alex/
http://www.half-llama.co.uk
