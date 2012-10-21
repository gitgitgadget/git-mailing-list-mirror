From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix git p4 sync errors
Date: Sun, 21 Oct 2012 12:06:10 -0700
Message-ID: <7vwqyjfxwd.fsf@alter.siamese.dyndns.org>
References: <AC43C2B4-623F-4590-9F92-6CCA26645EFE@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Luke Diamand <luke@diamand.org>
To: Matt Arsenault <arsenm2@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 21:06:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ0qw-0003wT-4w
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 21:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176Ab2JUTGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 15:06:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36932 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480Ab2JUTGN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 15:06:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D070D93DB;
	Sun, 21 Oct 2012 15:06:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NcJ3ELJkMcSuIqYIXKZFuKJmubY=; b=ZTPD42
	mFIOqjdO0h+G2NOJ7NQxSzjguFjdjm9BbwhBbKdorYbyJR80GD2YBSqBCkUGljI7
	sYOdPVHI/Ijphz0OqK9M+FRlp8K2GkOgUTQofSdMs+wYiB7FUeQAqS0QR19wBA12
	goSPXWi/VUBQvByBOFFPYFwXYVricTVvzbKJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mFt/kNsDwF5UyaGaCMNCjpgbrrpEmtPD
	CPoIruYTAFAD1aecA9X7OCrGy7T6lnIYmSzE/j8lM39Z3kBHqgcGb5KNV80gehQ9
	BP4UNeU26y57dF2smc7zyn1Gtqmdxn5K4kXaIUFvQrmikJ/1zlUwBKk7swBFDhWo
	jLKy6A6iXig=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD93993D9;
	Sun, 21 Oct 2012 15:06:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFA7A93D8; Sun, 21 Oct 2012
 15:06:11 -0400 (EDT)
In-Reply-To: <AC43C2B4-623F-4590-9F92-6CCA26645EFE@gmail.com> (Matt
 Arsenault's message of "Sat, 20 Oct 2012 18:59:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 60FD8D80-1BB2-11E2-A2DC-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208136>

[Added area experts of git-p4 to Cc.]

Matt Arsenault <arsenm2@gmail.com> writes:

> From 425e4dc6992d07aa00039c5bb8e8c76def591fd3 Mon Sep 17 00:00:00 2001
> From: Matt Arsenault <arsenm2@gmail.com>
> Date: Sat, 20 Oct 2012 18:48:45 -0700
> Subject: [PATCH] git-p4: Fix not using -s option to describe

Please do not include these four lines in the body of the message.
The "Subject: " line is there so that you can copy & paste to your
MUA (instead of having to type something different from scratch),
and we use the authorship From/Date from your e-mail message.

>
> This solves errors in some cases when syncing renamed files.

Can you be a bit more descriptive?  What are "errors in some case"?

A good rule of thumb is to imagine a user of this command who is
having a problem who reads this commit log message.  Does the
symptom described to have fixed by the commit detailed enough to
allow her to tell if this change may potentially fix the problem she
is having?

> Other places where describe is used use the -s, except this one.

This makes it sound as if the changed line was an odd-man out among
many others, and it is clear we always want "describe -s" throughout
this command.  But my "git grep 'p4.*describe'" shows there are two
places, one with "-s" and one without.

What are returned from this invocation of p4Cmd() seem to be passed
to self.splitFilesIntoBranches() as its commit[] and the fields
'depotFile#', 'rev#', 'action#' and 'type#' are looked at in the
method, and then to self.commit() as its details[], for fields
'time', 'user', 'change', 'desc', and 'options'.

What field, if any, gets wrong value when "-s" is not used?  Or
perhaps some fields are omitted incorrectly?  What field are we
getting out of p4Cmd() that we are not using in the existing
callchain by not passing "-s" [*1*]?

In short, what I am getting at are:

 - What breaks by not passing "-s"?  What are the user visible
   symptoms?

 - Why is it a bug not to pass "-s"?  How does the bug happen?

Thanks.

[footnote]

*1*

http://www.perforce.com/perforce/r12.1/manuals/cmdref/describe.html
says that "describe -s" omits files diffs, but I do not know how it
affects "-G describe -s" output that we are reading (what fields in
the unmarshalled dict we are reading from is affected).

> Signed-off-by: Matt Arsenault <arsenm2@gmail.com>
> ---
>  git-p4.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 882b1bb..e203508 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2543,7 +2543,7 @@ class P4Sync(Command, P4UserMap):
>      def importChanges(self, changes):
>          cnt = 1
>          for change in changes:
> -            description = p4Cmd(["describe", str(change)])
> +            description = p4Cmd(["describe", "-s", str(change)])
>              self.updateOptionDict(description)
>  
>              if not self.silent:
