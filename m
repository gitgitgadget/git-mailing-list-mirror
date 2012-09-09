From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH/RFC] blame: respect "core.ignorecase"
Date: Sun, 09 Sep 2012 21:03:14 +0200
Message-ID: <504CE7F2.9010306@kdbg.org>
References: <1347210113-27435-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 21:03:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAmn5-0007eQ-TX
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 21:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701Ab2IITDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 15:03:21 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:56062 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754330Ab2IITDT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 15:03:19 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 0D4ABCDF83;
	Sun,  9 Sep 2012 21:03:17 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id C532119F3E3;
	Sun,  9 Sep 2012 21:03:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <1347210113-27435-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205087>

Am 09.09.2012 19:01, schrieb Ralf Thielow:
> If "core.ignorecase" is true, "git blame" fails
> when the given path differs to the real path in case
> sensitivity.
...
> +				dir = opendir(res.buf);
...
> +					struct dirent *ent = readdir(dir);
...
> +					if (!strcasecmp(p.buf, ent->d_name)) {

I don't think this is how core.ignorecase is intended to work. It does
not trigger case-insensitive lookup in the worktree (this is still done
by the OS), but it does a case-insensitive lookup in the index. That is,
given a worktree entry 'readme', it allows to find the index entry 'README'.

IMO, it is only correct that 'git blame file' operates on 'FILE' if
'FILE' exists in the index, and in only that case, it does not matter
how the 'file' is named in the worktree.

-- Hannes
