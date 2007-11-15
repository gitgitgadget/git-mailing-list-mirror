From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Odd .gitignore behaviour
Date: Thu, 15 Nov 2007 12:49:21 +0000
Message-ID: <80ir431xny.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 13:49:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IseAA-0008OC-3u
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 13:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759945AbXKOMt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 07:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759126AbXKOMtZ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 07:49:25 -0500
Received: from rufus.isode.com ([62.3.217.251]:53072 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758230AbXKOMtY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 07:49:24 -0500
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <RzxAUQBBVLAP@rufus.isode.com> for <git@vger.kernel.org>;
          Thu, 15 Nov 2007 12:49:22 +0000
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Thu, 15 Nov 2007 12:49:21 +0000
X-Hashcash: 1:20:071115:git@vger.kernel.org::5owxTVllbSfa/Sj2:0000000000000000000000000000000000000000003ZzR
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65115>

Perhaps I'm misreading the manpage, but I think this is wrong:

    % mkdir base; cd base
    % git init
    % mkdir -p sub1/sub2
    % cd sub1
    % echo foo > .gitignore; echo '!sub2/foo' >> .gitignore
    % touch sub2/foo
    % git add sub2/foo
    The following paths are ignored by one of your .gitignore files:
    sub1/sub2/foo
    Use -f if you really want to add them.
    fatal: no files added

So sub1/sub2/foo matches the first pattern in sub1/.gitignore, but it
also matches the negated pattern '!sub2/foo' (in the same file, so
precedence isn't an issue).  And the manpage says

       o An optional prefix ! which negates the pattern; any matching
           file excluded by a previous pattern will become included
           again. If a negated pattern matches, this will override
           lower precedence patterns sources.

So surely sub1/sub2/foo ought to be included again?  Or is the first
line in sub1/.gitignore not "a previous pattern" in this sense?

If I move the "foo" pattern up a level, creating a .gitignore in base
just containing "foo", then sub1/sub2/foo is still regarded as
ignored, even though it surely matches the negating pattern
sub1/.gitignore, and that should be of higher precedence than the
pattern in base/.gitignore?
