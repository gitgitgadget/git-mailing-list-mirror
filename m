From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC PATCH 0/3] grep: submodule support
Date: Wed, 29 Sep 2010 13:28:51 -0700
Message-ID: <1285792134-26339-1-git-send-email-judge.packham@gmail.com>
Cc: git@vger.kernel.org
To: Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Wed Sep 29 22:29:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P13Gs-00020m-Iy
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 22:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755704Ab0I2U2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 16:28:51 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:40949 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755566Ab0I2U2u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 16:28:50 -0400
Received: by pxi10 with SMTP id 10so292469pxi.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 13:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Wa2Ne4O0dyngCIyIbkUPYQAv+nlEEXOSbI4iTVtvvzI=;
        b=FcWCSGQ9RIx0kOeozBjE5qsATqw7Wg77bfeMBmds02PTjQFJXhaOJ0p8xfJr4zCoOn
         2FzpgLlA4HFPSLWAmY48DsrbwzuB4CZHtzR9iGVorpNGkIw1KZWYeBskH2YN+NYzU9Dj
         wxxln/IWiSCssw/QUxyC7Ppv1c3Ka+pS3FKhc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=PbuXR/vWhmUuIewerzHphIHrSoLMG/1RPiS5BkyOvLHcL+RBpZFLiIxws/ceakxMhk
         x1yoT+AzJt6jft47+hmnU/Ba4Gx5FHAaGbz+HO6qV5GPg3YSCi5e3z5npc2sFD66FcZx
         jUp9lhMy0LOGEmrWxS5tPLRae+cZIpi4VVmOU=
Received: by 10.114.136.19 with SMTP id j19mr2551025wad.54.1285792129802;
        Wed, 29 Sep 2010 13:28:49 -0700 (PDT)
Received: from localhost.localdomain (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id o17sm15169981wal.9.2010.09.29.13.28.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Sep 2010 13:28:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157599>

This patch series is my initial attempt to add submodule awareness to git grep.
It's also the first time I've played with the git C code so expect bugs. The
patches are based off apply on Jens Lehmann's 'enhance_git_for_submodules'
branch in git://github.com/jlehmann/git-submod-enhancements.git

The first patch adds some basic tests for grep with submodules. There is
probably some overlap with other grep tests so I'll have a more in-depth look
at what is needed later. I have a problem with the tests that when I invoke
'git grep' using run_command I actually end up using the installed git which
doesn't understand my new --submodule-prefix option.

The 2nd patch just adds a --submodule-prefix option so that I can prepend some
text to the output from the sub processes.

The 3rd patch is the main implementation. Currently I rebuild a command line
for the subprocess based on the opts structure and I make use of the modified
argv[0] from the command. Neither of these are really optimal, it'd be much
easier if I could just start my subprocess from cmd_grep (or even grep_cache).
Any pointers to get me moving in this direction are welcome. Even if I retain
the rebuilding of the command line I'd like to rebuild the pattern(s) instead
of relying on the saved_argv[0].

Chris Packham (3):
      add test for git grep --recursive
      grep: prepare grep for submodules
      grep: add support for grepping in submodules
