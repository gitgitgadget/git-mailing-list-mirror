From: Sergio <sergio.callegari@gmail.com>
Subject: pack.packSizeLimit, safety checks
Date: Mon, 1 Feb 2010 09:20:42 +0000 (UTC)
Message-ID: <loom.20100201T101056-232@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 01 10:21:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbsT4-0008T7-P9
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 10:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117Ab0BAJVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 04:21:10 -0500
Received: from lo.gmane.org ([80.91.229.12]:47771 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724Ab0BAJVI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 04:21:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NbsSv-0008Q6-Mj
	for git@vger.kernel.org; Mon, 01 Feb 2010 10:21:06 +0100
Received: from mars-fw.arces.unibo.it ([137.204.143.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 10:21:05 +0100
Received: from sergio.callegari by mars-fw.arces.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 10:21:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.143.2 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100106 Ubuntu/9.10 (karmic) Firefox/3.5.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138597>

Hi,

documentation about pack.packSizeLimit

says:

The default maximum size of a pack. This setting only affects packing to a file,
i.e. the git:// protocol is unaffected. It can be overridden by the
--max-pack-size option of git-repack(1).

I would suggest clarifying it into

The default maximum size of a pack in bytes. This setting only affects packing
to a file, i.e. the git:// protocol is unaffected. It can be overridden by the
--max-pack-size option of git-repack(1).

Since --max-pack-size takes MB and one might be tempted to assume that the same
is valid for pack.packSizeLimit.

Also note that some safety check on pack.packSizeLimit could probably be
desirable to avoid an unreasonably small limit. For instance:

Assume that pack.packSizeLimit is set to 1 (believing it would be 1MB, but it is
in fact 1B). With this at the first git gc every object goes in its own pack.
You realize the mistake, you fix pack.packSizeLimit to 1000000, but at this
point you cannot go back since git gc cannot run anymore (too many open files).

Maybe, considering all the possible use cases of pack.packSizeLimit could help
finding a reasonable lower bound.
