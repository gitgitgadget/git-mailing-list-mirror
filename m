From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Potentially dangerous behavior of git gc
Date: Mon, 19 Oct 2009 08:04:58 +0000 (UTC)
Message-ID: <loom.20091019T095725-840@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 10:05:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MznFL-0006C5-AY
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 10:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755607AbZJSIFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 04:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754251AbZJSIFX
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 04:05:23 -0400
Received: from lo.gmane.org ([80.91.229.12]:38113 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753521AbZJSIFU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 04:05:20 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MznF6-00068a-Ec
	for git@vger.kernel.org; Mon, 19 Oct 2009 10:05:24 +0200
Received: from i2-ve060.ingce.unibo.it ([137.204.107.60])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Oct 2009 10:05:24 +0200
Received: from sergio.callegari by i2-ve060.ingce.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Oct 2009 10:05:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.107.60 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.0.14) Gecko/2009090217 Ubuntu/9.04 (jaunty) Firefox/3.0.14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130672>

Hi,

I encountered an issue with git gc.

Consider the following scenario. Repo A is using repo B as an alternate object
database through the .git/objects/info/alternates mechanism. B is at
/some_path/B.  A has some references, including HEAD that are pointing at
objects that are in fact in the object database of B.

For some reasons, paths are modified on the machine, so that B gets moved at
/some_new_path/B.

Obviously A cannot find its objects anymore and its alternate info should be
updated.

Suppose that now one runs git gc on A.

Correctly git gc complains about the broken alternate link.
And then complains again as it cannot find some objects.

However, rather than trying to preserve the repo integrity, it then _removes_
all the references pointing to non existing objects.

With this when the alternate info of A is finally updated, A is broken, missing
many references and not having a head anymore.

Would it be better to have git gc not to take dangerous actions on potentially
problematic repos?

Thanks

Sergio
