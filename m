From: Max Nanasy <max.nanasy@gmail.com>
Subject: Re: [BUG] (git commit --patch --message $MESSAGE) disallows hunk editing
Date: Mon, 29 Sep 2014 23:01:44 +0000 (UTC)
Message-ID: <loom.20140930T005553-169@post.gmane.org>
References: <CAM998vGieYU+8s1ermDJSfT8Zu8jDRS4WLjypraoB3iOf+qH7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 01:02:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYjxg-0004VT-KB
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 01:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbaI2XCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 19:02:24 -0400
Received: from plane.gmane.org ([80.91.229.3]:58912 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbaI2XCX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2014 19:02:23 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1XYjx7-00048L-HW
	for git@vger.kernel.org; Tue, 30 Sep 2014 01:01:57 +0200
Received: from inet-aumc08-o.oracle.com ([137.254.4.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Sep 2014 01:01:57 +0200
Received: from max.nanasy by inet-aumc08-o.oracle.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Sep 2014 01:01:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.254.4.11 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.120 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257642>

Max Nanasy <max.nanasy <at> gmail.com> writes:

> 
> Tested against v1.7.12.4
> 
> Steps to reproduce:
> 	A. cd $DIRTY_WORKING_COPY
> 	B. git commit --patch --message $MESSAGE
> 	C. Stage this hunk? e
> Expected behavior:
> 	After step C, the hunk opens in the user's editor
> Actual behavior:
> 	After step C, the hunk is selected unedited (as if the user had entered "y")
> 
> AFAICT, this occurs because of the following code in
> builtin/commit.c:parse_and_validate_options:
> 	if (... || message.len || ...)
> 		use_editor = 0;
> 	...
> 	if (!use_editor)
> 		setenv("GIT_EDITOR", ":", 1);
> Because --message is specified, GIT_EDITOR is set to ":", which
> prevents the user from editing hunks, although the intent is most
> likely to just prevent the user from editing the commit message.
> 

It appears that this was fixed in version 2.0.  The changelog entry says:

 * When it is not necessary to edit a commit log message (e.g. "git
   commit -m" is given a message without specifying "-e"), we used to
   disable the spawning of the editor by overriding GIT_EDITOR, but
   this means all the uses of the editor, other than to edit the
   commit log message, are also affected.
   (merge b549be0 bp/commit-p-editor later to maint).
