From: Andreas Gruenbacher <agruen@suse.de>
Subject: [BUG] Git add <device file> silently fails
Date: Sat, 17 Apr 2010 16:24:17 +0200
Organization: SUSE Labs
Message-ID: <201004171624.17797.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 17 16:24:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O38wc-0001gs-19
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 16:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab0DQOYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 10:24:20 -0400
Received: from cantor2.suse.de ([195.135.220.15]:48218 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751530Ab0DQOYT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 10:24:19 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id A9DF1867E2
	for <git@vger.kernel.org>; Sat, 17 Apr 2010 16:24:18 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31.12-0.1-desktop; KDE/4.3.1; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145148>

Hello,

there is code in read-cache.c:add_to_index() which checks if a file to be 
added is a regular file, directory, or symlink; this function otherwise 
error()s out.  It looks as if add_to_index() is supposed to be called via:

  builtin/add.c:update_callback() ->
    read-cache.c:add_file_to_index() ->
      read-cache.c:add_to_index()

However, when trying to add a device special file, update_callback() ends up 
never getting called, no error message is produced, and git add silently 
fails:

	$ sudo mknod foobar c 1 3
	$ git add foobar
   $ echo $?
	0

Maybe someone familiar with run_diff_files() can have a look?

Thanks,
Andreas
