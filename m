From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Wrong file diff for merge conflict
Date: Sun, 05 Jul 2009 12:23:59 -0700
Message-ID: <7vws6nhr1s.fsf@alter.siamese.dyndns.org>
References: <loom.20090704T072854-229@post.gmane.org>
	<alpine.LFD.2.01.0907051113240.3210@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Bucur <stefan.bucur@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 05 21:24:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNXJo-0000Nj-02
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 21:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbZGETX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2009 15:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752725AbZGETX5
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 15:23:57 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:50529 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbZGETX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2009 15:23:56 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090705192400.SZQF17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 5 Jul 2009 15:24:00 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id CKPz1c00T4aMwMQ03KPz1a; Sun, 05 Jul 2009 15:23:59 -0400
X-VR-Score: -70.00
X-Authority-Analysis: v=1.0 c=1 a=Z4Rwk6OoAAAA:8 a=eVUyA3bpAAAA:8
 a=GoSBff9x3haba4yWZR8A:9 a=Z_N8iEYw2RKzJ5MePHwA:7
 a=gemgjicJrIlpC-4kjssazKaxIyEA:4 a=jbrJJM5MRmoA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.LFD.2.01.0907051113240.3210@localhost.localdomain> (Linus Torvalds's message of "Sun\, 5 Jul 2009 11\:43\:14 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122752>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So is it a bug? Nope. I can pretty much guarantee that it's not a bug....

Without the precise common ancestor version it is hard to tell, but using
the "one old version http://pastebin.ca/1483691" as a base and running
diff3 (or merge from RCS suite) yields identical results as ours, so in
that sense it is not a bug.

>  - Tune the zealous merge a bit, and in particular try to avoid the cases 
>    where this happens (as mentioned, in C code, it's often re-indentation 
>    together with trivial lines that match after it).
>
>    This is kind of what the "patience" diff algorithm tries to do: use 
>    primarily non-trivial sequences as the anchors for similarity, and 
>    ignore the trivial ones. We have a "--patience" switch to "git diff", 
>    maybe we could tune the three-way merge somehow similarly.

Hmm. I have to think about this a bit.

>  - Don't rely so heavily on just the traditional three-way merge result.
>
>    This is what I personally do. The trivial 3-way merge result is 
>    wondeful for the truly trivial merges, when it gives trivial results 
>    that are easy to fix up. But let's face it, the traditional 3-way merge 
>    result just sucks for anything more complicated. When you have an empty 
>    side on one of the conflicts, is that because the other side added 
>    everything, or is it because oen side removed it? Or is it, like in 
>    this case, simply because trivially similar lines got the whole diff 
>    confused about which parts didn't change at all?
>
>    The good news is that git does have a few nice merge tools. One is 
>    "git diff", which actually shows way more than the trivial three-way 
>    end result, in that you can diff against either side, and by default it 
>    does that fairly complex "diff against both sides" thing that is also 
>    quite useful once you get used to it.
>
>    Another is "gitk --merge [filename]" which is wonderful as a tool to 
>    see what both sides actually did, to figure out what the intent of both 
>    branches were when the three-way merge result is just noise.

Two other are "git log --merge -p" and "git checkout --conflicts=diff3".

> The right answer is probably some combination of "all of the above". In 
> the meantime, right now, only the last one is somethign git itself will 
> help you with.
