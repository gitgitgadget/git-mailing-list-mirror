From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 16:29:01 -0400
Message-ID: <4539318D.9040004@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610201821.34712.jnareb@gmail.com> <20061020181210.GA29843@artax.karlin.mff.cuni.cz> <200610202047.11291.jnareb@gmail.com> <Pine.LNX.4.64.0610201151130.3962@g5.osdl.org> <45391F1C.80100@utoronto.ca> <Pine.LNX.4.64.0610201231570.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Jan Hudec <bulb@ucw.cz>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 22:29:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb0zt-0008VW-FP
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 22:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422984AbWJTU3i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 16:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423141AbWJTU3i
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 16:29:38 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:10397 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1422984AbWJTU3h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 16:29:37 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[192.168.2.19])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Gb0zH-0005Jt-00; Fri, 20 Oct 2006 16:29:03 -0400
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610201231570.3962@g5.osdl.org>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29534>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:
> 
> On Fri, 20 Oct 2006, Aaron Bentley wrote:
> 
>>Linus Torvalds wrote:
>>
>>>Git goes one step further: it _really_ doesn't matter about how you got to 
>>>a certain state. Absolutely _none_ of what the commits in between the 
>>>final stages and the common ancestor matter in the least. The only thing 
>>>that matters is what the states at the end-point are.
>>
>>That's interesting, because I've always thought one of the strengths of
>>file-ids was that you only had to worry about end-points, not how you
>>got there.
>>
>>How do you handle renames without looking at the history?
> 
> 
> You first handle all the non-renames that just merge on their own.
> If you were to use one hundredth of a second per file regardless of file, 
> a stupid per-file merge would take 210 seconds, which is just 
> unacceptable. So you really don't want to do that.

Agreed.  We start by comparing BASE and OTHER, so all those comparisons
are in-memory operations that don't hit disk.  Only for files where BASE
and OTHER differ do we even examine the THIS version.

We can do a do-nothing kernel merge in < 20 seconds, and that's
comparing every single file in the tree.  In Python.  I was aiming for
less than 10 seconds, but didn't quite hit it.

> So recursive basically generates the matrix of similarity for the 
> new/deleted files, and tries to match them up, and there you have your 
> renames - without ever looking at the history of how you ended up where 
> you are.

So in the simple case, you compare unmatched THIS, OTHER and BASE files
to find the renames?

>   I don't know if people appreciate how good it is to do a merge of two 
>   21000-file branches in less than a second. It didn't have any renames, 
>   and it only had a single well-defined common parent, but not only is 
>   that the common case, being that fast for the simple case is what 
>   _allows_ you to do well on the complex cases too, because it's what gets 
>   rid of all the files you should _not_ worry about ]

Well, I certainly appreciate that.  I've never worried about the speed
of text merge algorithms, because you rarely merge very many files.  The
key is making the tree merge fast.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFOTGN0F+nu1YWqI0RAii+AJ0eduC3bYya5Ao8vm1EpBb38tJP4ACeJRYe
9/D+ahDRJa87NTryc7j3C+U=
=plWA
-----END PGP SIGNATURE-----
