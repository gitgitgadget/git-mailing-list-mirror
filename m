From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-checkout changes the index but not the checked out files?
Date: Mon, 23 Apr 2007 12:17:19 +1200
Message-ID: <46a038f90704221717i8e5c1bkff066dcbdb0a0523@mail.gmail.com>
References: <46a038f90704221625k216864cdwb2b35bc035fac7e9@mail.gmail.com>
	 <7virbokmx1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 23 02:17:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfmFd-0002Ac-IX
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 02:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965656AbXDWARV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 20:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965657AbXDWARV
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 20:17:21 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:2603 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965656AbXDWARU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 20:17:20 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1600542wxd
        for <git@vger.kernel.org>; Sun, 22 Apr 2007 17:17:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GIvhPFOMstnW/BPy6r0KnG+tvbImGBXFVHjr7p3TncKiCGelYpbTPqsEgD8M64raOHtUqQRPYHUPQpLpuW5c3m8PGYU6KGMa95SswJYbaFZjIbCeF1WKy0Gg88R7ATAtiZpE0Pqw0AUywj0bTXAcyRB9g/giRJsLLRAYKvyKCHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jUGY01hENF0QwN9UkhEFiqveTubqFMhtAnmE+AR+fuQDYI9x4pYIWqnGkCdfXuIDm+VMdoyEue3r8NPMFgNpnpamRzuDM9AYu5C05r9Qwp5UyMONkvZTz0IJS4L1ALlLyu5tewuGDb23MORbfdAqjxVqRaypycL9YY9wblRDkkA=
Received: by 10.90.63.16 with SMTP id l16mr589313aga.1177287439465;
        Sun, 22 Apr 2007 17:17:19 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Sun, 22 Apr 2007 17:17:19 -0700 (PDT)
In-Reply-To: <7virbokmx1.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45291>

On 4/23/07, Junio C Hamano <junkio@cox.net> wrote:
> Shouldn't happen.  Details?

Hmnmm. Not sure really what to look for ;-)

If I try it on my git checkout (checkout origin/pu and then checkout
master) nothing strange happens. But if I do it on my project,
(fetchable from http://git.catalyst.net.nz/moodle-r2.git ) between a
"local" mdl18-local and origin/MOODLE_18_STABLE, it all goes weird.

Just re-ran the process with bash -x, and it switches to a detached
head when going to origin/MOODLE_18_STABLE (as expected). And when
switching back, it all looks _almost_ reasonable except that there's a
call to git-read-tree with -m and 2 sha1s. It is trying to merge
mdl18-local and mdl18-topnz apparently.

In fact:

 - I am on mdl18-local
 - git-status is clean
 - git checkout mdl18-local reports "Already on branch "mdl18-local"
but it does a merge anyway

The problem seems to be that the SHA1 returned here is bogus:

   $ git-rev-parse --verify 'mdl18-local^0'
   warning: refname 'mdl18-local' is ambiguous.
   a26c09be05a08e5f911ef84b5f8010ba155ea77d

If I disambiguate it one way or the other, I get correct results

   $ git-rev-parse --verify 'refs/heads/mdl18-local^0'
   634dcf72a31d0c75a98c1d69dd4763def7bcf2d5
   $ git-rev-parse --verify 'remotes/origin/mdl18-local^0'
   6e6ae22a2960d3ac321acd1cdfa09f23068f33b4

but the ambiguous "git-rev-parse --verify 'mdl18-local^0'" returns the
SHA1 for a head called 'mdl18-topnz' that I am not asking for. Why?

cheers,


m
