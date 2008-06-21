From: Junio C Hamano <gitster@pobox.com>
Subject: Re: MinGW port pull request
Date: Sat, 21 Jun 2008 02:46:36 -0700
Message-ID: <7vskv79l37.fsf@gitster.siamese.dyndns.org>
References: <485B6510.3080201@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Jun 21 11:47:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9zhH-0006Un-0c
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 11:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbYFUJqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 05:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752802AbYFUJqt
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 05:46:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781AbYFUJqs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 05:46:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B43B9A712;
	Sat, 21 Jun 2008 05:46:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E1C6AA711; Sat, 21 Jun 2008 05:46:38 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F605F98E-3F76-11DD-95E3-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85702>

Johannes Sixt <j.sixt@viscovery.net> writes:

> please pull the MinGW (Windows) port patch series from
>
> git://repo.or.cz/git/mingw/j6t.git for-junio

Took a look.  A quick impression.

 * Too many whitespace breakages in borrowed compat/regex.[ch] are very
   distracting.

 * It is a very nice touch to rename sample templates to make sure they
   are not executable (after all they are just samples).

 * Shouldn't my_mktime() if exported out of date.c be named a bit better?

 * The ifdef block in git.c::main() introduces decl-after-stmt which we
   tend to avoid, but it is much worse to solve it by adding another ifdef
   block just to enclose decl of char *bslash at the beginning of the
   function.  Perhaps enclose it in an extra block?

 * In sanitary_path_copy(), you left "break;" after /* (1) */ but now that
   "break" is not inside a switch() anymore, so you are breaking out of
   something else, aren't you?  -- Ah, the clean-up phase will be no-op in
   that case because src points at '\0'.  Tricky but looks correct ;-)

 * There seem to be an unrelated general fix in upload-pack.c

 * There are still too many ifdefs.  I am wondering if the changes to
   pager and process stuff is easier to manage in the longer term if they
   are made into completely separate files (i.e. instead of linking
   pager.o you would link mingw-pager.o).  I dunno.

 * There is an interaction with dr/ceiling topic that is already in 'next'
   that needs to be resolved before we merge this in 'next'.

Parked in 'pu' for now but with a broken merge resolution.
