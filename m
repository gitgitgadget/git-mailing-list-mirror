From: Jonas Bernoulli <jonas@bernoul.li>
Subject: Empty config sections are neither deleted nor reused
Date: Fri, 13 May 2016 16:55:51 +0200
Message-ID: <87r3d6knwo.fsf@bernoul.li>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 17:06:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1EfR-0005x4-E3
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 17:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283AbcEMPGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 11:06:08 -0400
Received: from mail.hostpark.net ([212.243.197.30]:36915 "EHLO
	mail.hostpark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbcEMPGH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 11:06:07 -0400
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 May 2016 11:06:06 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.hostpark.net (Postfix) with ESMTP id 270FA16B39
	for <git@vger.kernel.org>; Fri, 13 May 2016 16:56:04 +0200 (CEST)
X-Virus-Scanned: by Hostpark/NetZone Mailprotection at hostpark.net
Received: from mail.hostpark.net ([127.0.0.1])
	by localhost (mail1.hostpark.net [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id ikK1acHpto6G for <git@vger.kernel.org>;
	Fri, 13 May 2016 16:56:03 +0200 (CEST)
Received: from hal (80-218-86-217.dclient.hispeed.ch [80.218.86.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.hostpark.net (Postfix) with ESMTPSA id AACDD16B3C
	for <git@vger.kernel.org>; Fri, 13 May 2016 16:56:03 +0200 (CEST)
User-agent: mu4e 0.9.17; emacs 25.0.93.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294538>

After running

  git init .
  git config foo.bar baz
  git config --unset foo.bar    # 1
  git config foo.bar baz        # 2

.git/config contains

  [core]
          repositoryformatversion = 0
          filemode = true
          bare = false
          logallrefupdates = true
  [foo]
  [foo]
          bar = baz

(1) did not remove the "foo" section when the last contained variable
was unset and (2) did not reuse the empty "foo" section when "foo.bar"
was set again.

I would prefer if unsetting the last variable in a section would cause
the heading of the now empty section would be removed.

But it might also make sense to not remove an empty section and to
instead reuse an empty section.  That would prevent a section from being
moved to eof because it became temporarily empty.  Maybe that was the
intention and Git at some point stopped re-using an empty section?

It could even be argued that it would make sense for empty sections to
be removed *and* reused (in order to "cleanup" old empty sections).

The only possible combination which doesn't make sense is to not remove
an empty section and to also not reuse an empty section - unfortunately
that's what Git currently does.

  Best regards,
  Jonas
