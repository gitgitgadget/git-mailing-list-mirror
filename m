From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git diff dira dirb file ...
Date: Fri, 06 Jun 2008 17:03:17 -0700
Message-ID: <7vmylyqfga.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0806061821320.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Jun 07 02:04:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4luy-0002Tg-DQ
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 02:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757376AbYFGADZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 20:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758206AbYFGADZ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 20:03:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39136 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755666AbYFGADY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 20:03:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 633681409;
	Fri,  6 Jun 2008 20:03:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A69E81408; Fri,  6 Jun 2008 20:03:19 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0806061821320.19665@iabervon.org> (Daniel
 Barkalow's message of "Fri, 6 Jun 2008 18:27:23 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 25382A36-3425-11DD-BD9F-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84147>

Daniel Barkalow <barkalow@iabervon.org> writes:

> After a lot of trying, I finally found something that git diff doesn't 
> handle. If you've got two trees of files with the same general structure, 
> even if they aren't at all git-related, you can use:
>
> $ git diff dira dirb
>
> to get a nice diff between them. But then it would be intuitive and useful 
> to be able to restrict by path the files within those directories that you 
> want to compare (much like "git diff origin master file1 file2 ...") with:
>
> $ git diff dira dirb file1 file2
>
> That would, of course, compare dira/file1 with dirb/file1 and dira/file2 
> with dirb/file2. Before I start looking into implementing this, is it 
> incoherent for some reason I'm not seeing?

Incoherent?

I do not see anything fundamentally wrong with it, except that command
line parsing may get tricky, because we rely on the revision command line
parser, and logically you should be able to spell the above commandline as
"diff dira dirb -- file1 file2", revision parser wants anything that comes
before -- to be revisions, not paths.

Just make sure that you got two directories, at least one of which is
outside the work tree, mark your diff option as "no-index", then walk the
two directories in parallel to populate the diff_queue().  Once you are
done walking, let diffcore_std() to do its usual thing.

Having said that, that new "feature" is not git anymore, and I'd rather
wish to see competent git people to be working on hunting for and fixing
outstanding bugs during the -rc period, than spending their time on new
features and non-git hacking, but all of us do this as hobbies, so I
wouldn't stop you ;-)
