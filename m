From: Bill Lear <rael@zopyra.com>
Subject: Re: Git push failure with update hook success
Date: Wed, 7 Mar 2007 10:46:48 -0600
Message-ID: <17902.60536.5890.608883@lisa.zopyra.com>
References: <17902.59497.831409.218529@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 17:47:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOzI6-0004So-4r
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 17:47:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965562AbXCGQqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 11:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965563AbXCGQqx
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 11:46:53 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60775 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965562AbXCGQqx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 11:46:53 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l27Gkqd14589;
	Wed, 7 Mar 2007 10:46:52 -0600
In-Reply-To: <17902.59497.831409.218529@lisa.zopyra.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41675>

On Wednesday, March 7, 2007 at 10:29:29 (-0600) Bill Lear writes:
>...
>whether it might be better to call the update hook after everything
>had actually been written, including the log file.

I dug into the code: in receive-pack.c, the command 'update(struct
command *cmd)', calls write_ref_sha1() after run_update_hook()
and does not check the return code of write_ref_sha1().  write_ref_sha1()
will return an error if log_ref_write() fails, as it seems to in
our case, here:

		if (logfd < 0)
                        return error("Unable to append to %s: %s",
                                     log_file, strerror(errno));

On the client push side, we get:

error: Unable to append to logs/refs/heads/master: Permission denied


Bill
