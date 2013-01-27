From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v4 1/2] for-each-repo: new command used for multi-repo
 operations
Date: Sun, 27 Jan 2013 19:42:23 +0000
Message-ID: <20130127194223.GR7498@serenity.lan>
References: <1359290777-5483-1-git-send-email-hjemli@gmail.com>
 <1359290777-5483-2-git-send-email-hjemli@gmail.com>
 <7vk3qywiqf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 20:42:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzY7y-0005zS-11
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 20:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357Ab3A0Tmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 14:42:33 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:45647 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295Ab3A0Tmb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 14:42:31 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 23E406064CD;
	Sun, 27 Jan 2013 19:42:31 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vCTjSQw-Zm+b; Sun, 27 Jan 2013 19:42:30 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 5880E6064D5;
	Sun, 27 Jan 2013 19:42:25 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vk3qywiqf.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214718>

On Sun, Jan 27, 2013 at 11:04:08AM -0800, Junio C Hamano wrote:
> One more thing that nobody brought up during the previous reviews is
> if we want to support subset of repositories by allowing the
> standard pathspec match mechanism.  For example,
> 
> 	git for-each-repo -d git diff --name-only -- foo/ bar/b\*z
> 
> might be a way to ask "please find repositories match the given
> pathspecs (i.e. foo/ bar/b\*z) and run the command in the ones that
> are dirty".  We would need to think about how to mark the end of the
> command though---we could borrow \; from find(1), even though find
> is not the best example of the UI design.  I.e.
> 
> 	git for-each-repo -d git diff --name-only \; [--] foo/ bar/b\*z
> 
> with or without "--".

Would it be better to make this a (multi-valued) option?

    git for-each-repo -d --filter=foo/ --filter=bar/b\*z git diff --name-only

It seems a lot simpler than trying to figure out how the command is
going to handle '--' arguments.

> Oh, that reminds me of another thing.  Perhaps we would want to
> export the (relative) path to the found repository in some way to
> allow the commands to do this kind of thing in the first place?
> "submodule foreach" does this with $path, I think.

I think $path is the only variable exported by "submodule foreach" which
is applicable here, but it doesn't work on Windows, where environment
variables are case-insensitive.

Commit 64394e3 (git-submodule.sh: Don't use $path variable in
eval_gettext string) changed "submodule foreach" to use $sm_path
internally although I notice that the documentation still uses $path.

Perhaps $repo_path in this case?


John
