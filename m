From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Default exclude rules for Git
Date: Fri, 19 Sep 2008 08:46:34 -0700
Message-ID: <7v8wtouoit.fsf@gitster.siamese.dyndns.org>
References: <1221755370-6817-1-git-send-email-kirr@landau.phys.spbu.ru>
 <1221755370-6817-2-git-send-email-kirr@landau.phys.spbu.ru>
 <36ca99e90809181038o74c73121j59849b3f24fe6469@mail.gmail.com>
 <alpine.LNX.1.00.0809181526190.19665@iabervon.org>
 <20080919050612.GA4423@roro3> <20080919142211.GE10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Sep 19 17:48:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgiDA-0000y2-D1
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 17:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbYISPqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 11:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbYISPqu
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 11:46:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35663 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbYISPqu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 11:46:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D71363C97;
	Fri, 19 Sep 2008 11:46:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BC54163C96; Fri, 19 Sep 2008 11:46:41 -0400 (EDT)
In-Reply-To: <20080919142211.GE10360@machine.or.cz> (Petr Baudis's message of
 "Fri, 19 Sep 2008 16:22:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2B3963E8-8662-11DD-B1C8-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96294>

Petr Baudis <pasky@suse.cz> writes:

> I think it would actually make most sense to insert some conservative
> default ignore rules to the Git's stock excludes template. (Or better,
> have a single file with default Git's exclude rules. Tools newly
> installed on the system could even add their entries there during
> installation as Git's quest on world dominations progresses.) I'd
> shamelessly propose Cogito's set of default excludes for starters:
>
> 	*.[ao]
> 	.*
> 	!.git*
> 	tags
> 	*~
> 	#*
>
> (or omit the first line if that feels too C-specific - but I think it
> should be extremely rare to find files you _want_ to track even in non-C
> projects; and I'd argue anytime that by default ignoring hidden files
> is absolutely the sanest thing to do.)

I do not see a need to change any canned template shipped with git.  I
actually think it is a grave regression to add anything arbitrary, even if
one person happens to think the choice is conservative, to the set of
tool-wide ignore patterns.  And here is why.

I haven't personally seen any project that wants its users to _edit_ a
file whose names end with ".a" or ".o" and track it.  That does not
however mean that there can be no project and/or environment that validly
wants to track files with ".o" suffix (isn't it the case that windows shop
use ".obj" for object files and ".o" suffix do not have any particular
meaning to them?)  By placing "*.o" to tool-wide ignore file, your version
of git is making life for participants in such a project harder because
they can now easily forget to add a newly created "*.o" files (status
won't show them).  The tool should be extremely conservative not to
encourage such mistakes.

The best place to express such a project wide policy (e.g. "in this
project, '*.o' files will never, or rarely if ever, be tracked and we
expect our developers to appreciate not seeing them in status output by
default") is a tracked .gitignore file.

I earlier said that "*~" should not be in project-wide .gitignore file
because use of Emacs vs vi is a matter of personal taste, and Emacs
specific "*~" pattern does not belong to a project policy, just like
vim "*.swp" pattern doesn't.

But I think that reasoning is flawed.  The right criteria should not be
about "use of Emacs vs vi", but about "do we in this project ever want to
track files that match *~ or *.swp as legitimate contents".  If a project
expects not to have a tracked file whose name ends with ".swp", even if it
does _not_ mean to encourage use of vim over Emacs or any other editor, I
think it is fine to add such to its tracked .gitignore file for its
developer's benefit.
