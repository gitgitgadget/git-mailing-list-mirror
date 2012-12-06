From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Perform minimal stat comparison when some stat fields
 are not set
Date: Thu, 06 Dec 2012 08:21:03 +0100
Message-ID: <50C0475F.1030206@viscovery.net>
References: <7vhao0jc98.fsf@alter.siamese.dyndns.org> <805916413.19333293.1354756160521.JavaMail.root@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 08:21:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgVlu-0003Bu-5b
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 08:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788Ab2LFHVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2012 02:21:09 -0500
Received: from so.liwest.at ([212.33.55.24]:21423 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754726Ab2LFHVI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2012 02:21:08 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TgVlX-0006ru-KS; Thu, 06 Dec 2012 08:21:03 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 56FCE1660F;
	Thu,  6 Dec 2012 08:21:03 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <805916413.19333293.1354756160521.JavaMail.root@dewire.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211156>

Am 12/6/2012 2:09, schrieb Robin Rosenberg:
>> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
>>> At least JGit does sets uid, gid, ctime, ino and dev fields to zero
>>> on update. To Git this looks like the stat data does not match and
>>> a full file compare will be forced even it size and mtime match.
>>> This
>>> is in practice unnecessary. Sense JGit's presence by checking if
>>> ino
>>> and dev is zero.

Is this meant to better support C git and JGit working on the same repository?

MinGW git sets these two stat fields to zero as well. But we have less of
an interoparability problem between different git implementations in
practice on Windows, I think.

>> Besides, is it sane to do this unconditionally to affect people who
>> do not use JGit?
> 
> Would a config option like core.minstat be better? The name would imply no dynamic detection.

A configuration option is the way to go. We already have core.trustctime,
core.symlinks, core.filemode, core.ignoreCygwinFSTricks.

But your new mode is not "minimal". In some implementations or on some
filesystems, even more bits of stat information could be meaningless
(think of atime, rdev, nlink, uid, gid). Perhaps core.trustdevandino? Or
an enumeration core.ignoreCacheStat=ctime,dev,ino?

-- Hannes
