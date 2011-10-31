From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: git rev-parse --since=1970-01-01 does not work reliably
Date: Mon, 31 Oct 2011 20:17:09 +0400
Message-ID: <20111031161708.GA29924@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 17:25:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKufV-0007Cs-Fl
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 17:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170Ab1JaQY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 12:24:56 -0400
Received: from vint.altlinux.org ([194.107.17.35]:46987 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370Ab1JaQYz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 12:24:55 -0400
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Oct 2011 12:24:55 EDT
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id 2D898226C057
	for <git@vger.kernel.org>; Mon, 31 Oct 2011 16:17:09 +0000 (UTC)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id 211B33F485E2; Mon, 31 Oct 2011 20:17:09 +0400 (MSK)
Content-Disposition: inline
X-fingerprint: FE4C 93AB E19A 2E4C CB5D  3E4E 7CAB E6AC 9E35 361E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184508>

Hi,

git rev-parse --since=1970-01-01 (and other git commands that take
date string arguments like --since) may fail when --since=1970-01-01 is
given.  Whether it fails or not depends on current time and timezone data.
For example, "TZ=Europe/Paris git rev-parse --since=1970-01-01" fails two
hours a day (between 00:00 and 02:00 CET), and those who use more eastern
timezones are even less lucky.  In artificial timezones like UTC-24 it
always fails:

$ TZ=UTC-24 git rev-parse --since=1970-01-01
--max-age=18446744073709523490

The problem is that several internal git functions implicitly convert
time_t to unsigned long, so when time_t gets negative, all date string
processing breaks.


-- 
ldv
