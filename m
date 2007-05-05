From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Makefile: use --unsafe option under Cygwin with asciidoc
Date: Sat, 05 May 2007 01:10:47 -0700
Message-ID: <7v7irnlmgo.fsf@assigned-by-dhcp.cox.net>
References: <ejlze97d.fsf@cante.net> <46388CBE.1080605@byu.net>
	<7vslaf4121.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
X-From: git-owner@vger.kernel.org Sat May 05 10:11:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkFM4-0000IX-8m
	for gcvg-git@gmane.org; Sat, 05 May 2007 10:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666AbXEEIKu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 04:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755293AbXEEIKu
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 04:10:50 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:38494 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754666AbXEEIKs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 04:10:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070505081047.RCTN1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 5 May 2007 04:10:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vLAn1W00D1kojtg0000000; Sat, 05 May 2007 04:10:48 -0400
In-Reply-To: <7vslaf4121.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 02 May 2007 09:56:06 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46251>

Junio C Hamano <junkio@cox.net> writes:

> Eric Blake <ebb9@byu.net> writes:
>
>> According to Jari Aalto on 5/2/2007 5:49 AM:
>>> New: variable ASCIIDOC_FLAGS was introduced. It was also added to two
>>> new targets. The old ASCIIDOC_EXTRA is set to --unsafe under Cygwin to
>>> ignore asciidoc error about unsafe include.
>>
>> This isn't just for cygwin, since it benefits any platform where the
>> installed asciidoc is 8.1 or better (asciidoc is currently at 8.2.1 if you
>> build the from tarballs).

I got curious and tried this myself.

> What unsafe things do we include?  Maybe _that_ is what should
> be fixed?

I couldn't trigger "unsafe" error.

> Also the last time we checked (I cannot take credits for this
> work -- see "git show origin/todo:TODO" and look for
> "AsciiDoc"), AsciiDoc 8 had backward compatibility problems, and
> you needed to add some pragma in asciidoc.conf to make it
> compatible with sources written for AsciiDoc 7 (i.e. our
> documentation).

Here are randomly selected differences between the documentation
pages formatted with AsciiDoc 7 and 8.

        --- 7	2007-05-05 01:06:39.000000000 -0700
        +++ 8	2007-05-05 01:06:36.000000000 -0700
        @@ -1,33 +1,33 @@
         git\-bundle will only package references that are shown by git\-show\-ref:
        -this includes heads, tags, and remote heads. References such as master~1 
        +this includes heads, tags, and remote heads. References such as master1
         cannot be packaged, but are perfectly suitable for defining the basis.
         More than one reference may be packaged, and more than one basis can be
         specified. The objects packaged are those not contained in the union of
        -the given bases. Each basis can be specified explicitly (e.g., ^master~10),
        +the given bases. Each basis can be specified explicitly (e.g., ^master10),
         or implicitly (e.g., master~10..master, master \-\-since=10.days.ago).

Notice broken tilde.

        -After this three\-way merge, the local modifications are _not_
        +After this three\-way merge, the local modifications are \fInot\fR
         registered in your index file, so git diff would show you what changes
         you made since the tip of the new branch.

        -<p>which will simply _create_ the branch, but will not do anything further.
        +<p>which will simply <em>create</em> the branch, but will not do anything further.

AsciiDoc 8 knows _emphasis_ which is nice.

        -Allow ~user notation to be used in requests. When specified with no
        -parameter, requests to git://host/~alice/foo is taken as a request to
        +Allow user notation to be used in requests. When specified with no
        +parameter, requests to git://host/alice/foo is taken as a request to
         access \fIfoo\fR repository in the home directory of user alice. If
         \-\-user\-path=path is specified, the same request is taken as a
         request to access path/foo repository in the home directory of user
         alice.

Again, broken tilde.

         In the above example output, the function signature was changed from
        -both files (hence two \- removals from both file1 and file2, plus ++
        -to mean one line that was added does not appear in either file1 nor
        +both files (hence two \- removals from both file1 and file2, plus + to
        +mean one line that was added does not appear in either file1 nor
         file2). Also two other lines are the same from file1 but do not appear
        -in file2 (hence prefixed with +).
        +in file2 (hence prefixed with ).

Missing plus (in manpage output).

         <p>In the above example output, the function signature was changed
         from both files (hence two <tt>-</tt> removals from both file1 and
        -file2, plus <tt>++</tt> to mean one line that was added does not appear
        +file2, plus <tt><tt>+</tt> to mean one line that was added does not appear
         in either file1 nor file2).  Also two other lines are the same
        -from file1 but do not appear in file2 (hence prefixed with <tt> +</tt>).</p>
        +from file1 but do not appear in file2 (hence prefixed with <tt> </tt></tt>).</p>
         <p>When shown by <tt>git diff-tree -c</tt>, it compares the parents of a

Same (in HTML output).

I haven't dug into the list archive article I quoted yet (the
pointer is also found in TODO file in 'todo' branch) and haven't
tried the backward compatibility pragma, but you can clearly see
that the above differences are simply unacceptable.  They are
not insignificant cosmetic differences -- the most important
techinical details are being mangled, rendering the
documentation useless.  We _do_ need the backward compatiblity
enabled in asciidoc.conf or somewhere.
