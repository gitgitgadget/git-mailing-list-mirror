From: Eli Barzilay <eli@barzilay.org>
Subject: gitweb problem?
Date: Mon, 01 Mar 2010 01:54:29 -0500
Message-ID: <m34ol0wmze.fsf@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 01 07:55:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlzXP-0003Qw-RB
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 07:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199Ab0CAGzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 01:55:25 -0500
Received: from lo.gmane.org ([80.91.229.12]:53549 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110Ab0CAGzY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 01:55:24 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NlzX3-00037l-3u
	for git@vger.kernel.org; Mon, 01 Mar 2010 07:55:09 +0100
Received: from winooski.ccs.neu.edu ([129.10.115.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 07:55:09 +0100
Received: from eli by winooski.ccs.neu.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 07:55:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: winooski.ccs.neu.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:TXUx+XHGnh63NCK6IMxh/BHoR04=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141299>

Whenever I view the toplevel gitweb page (running as a cgi script
under apache), but not when in a specific repo, I get this in my error
log:

gitweb.cgi: Use of uninitialized value $git_dir in concatenation (.) or string at /home/git/gitweb/gitweb.cgi line 2065.
fatal: error processing config file(s)
gitweb.cgi: Use of uninitialized value $git_dir in concatenation (.) or string at /home/git/gitweb/gitweb.cgi line 2221.
gitweb.cgi: Use of uninitialized value $git_dir in concatenation (.) or string at /home/git/gitweb/gitweb.cgi line 2218.

(taken verbatim from the apache error log, removed uninteresting line
prefixes.)

I'm using the pathinfo option, so perhaps there is a problem with that
setup?

Looking at the source, the last two line numbers are in
`git_get_project_config' -- so my guess is that the code is trying to
get the options from the repository config file even when showing the
toplevel page.  Based on this, and also guessing that $git_dir is
unset when viewing the toplevel page, I added

	return unless (defined $git_dir);

to the top (of the `git_get_project_config' function), and I get no
warnings and everything works as it should.

(Disclaimer: I can barely read perl, and I'm a git newbie, so all of
this can be due to some other stupid mistake.)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
