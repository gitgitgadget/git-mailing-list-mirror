From: Pete Wyckoff <pw@padd.com>
Subject: Re: git-p4 clone @all error
Date: Sat, 3 Nov 2012 10:09:46 -0400
Message-ID: <20121103140946.GB4651@padd.com>
References: <1351593879401-7570219.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arthur <a.foulon@amesys.fr>
X-From: git-owner@vger.kernel.org Sat Nov 03 15:10:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUeQZ-0001Yf-SM
	for gcvg-git-2@plane.gmane.org; Sat, 03 Nov 2012 15:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755668Ab2KCOJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 10:09:50 -0400
Received: from honk.padd.com ([74.3.171.149]:36314 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754093Ab2KCOJt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 10:09:49 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id DF012D02;
	Sat,  3 Nov 2012 07:09:48 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id A2B062424F; Sat,  3 Nov 2012 10:09:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1351593879401-7570219.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208979>

a.foulon@amesys.fr wrote on Tue, 30 Oct 2012 03:44 -0700:
> So, i want import my perforce projet on my server git.
> 
> perforce my project tree :
> 
> depot
>   dev_data
>   mainline
>   release_1.0
>   release_1.0.0
> 
> my command is :
> 
> git-p4 clone -v --detect-branches //depot@all /home/user/projets/deport
> 
> The problem :
> 
> Importing revision 7727 (100%)Traceback (most recent call last):
>   File "/usr/bin/git-p4", line 3183, in <module>
>     main()
>   File "/usr/bin/git-p4", line 3177, in main
>     if not cmd.run(args):
>   File "/usr/bin/git-p4", line 3048, in run
>     if not P4Sync.run(self, depotPaths):
>   File "/usr/bin/git-p4", line 2911, in run
>     self.importChanges(changes)
>   File "/usr/bin/git-p4", line 2618, in importChanges
>     self.initialParent)
>   File "/usr/bin/git-p4", line 2198, in commit
>     epoch = details["time"]
> KeyError: 'time'

This isn't the --detect-branches code path, as far as I can tell.
Line 2618, importChanges, is the not-detect case.  But either
way, I suspect that p4 returns results we weren't expecting, and
this is just the symptom of that problem.

> if i make a p4 sync //depot/...#head on my perforce server i've this error : 
> Librarian checkout
> depot/mainline/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/api429decryption.txt failed.
> open for read: depot/mainline/xxxxxxxxxxxxxxxxxx/api429decryption.txt,v: Le
> fichier spcifi est introuvable.
> 
> My p4 clone can't checking out files after importing revision..

I've seen this before at our site.  If you search for "librarian
checout" you'll see lots of messages suggesting there's some sort
of problem with the p4 server.

I'm going to work on a patch to git-p4 to make it print a more
useful diagnostic in the case of your error above.  Can you
make this problem occur reliably?

		-- Pete
