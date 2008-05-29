From: "Frank Ch. Eigler" <fche@redhat.com>
Subject: reducing prune sync()s
Date: Thu, 29 May 2008 16:57:43 -0400
Message-ID: <20080529205743.GC17123@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 22:59:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1pDl-0001A0-UM
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 22:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbYE2U6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 16:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756583AbYE2U6e
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 16:58:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46012 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755037AbYE2U6e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 16:58:34 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m4TKwXk5014764
	for <git@vger.kernel.org>; Thu, 29 May 2008 16:58:33 -0400
Received: from pobox-3.corp.redhat.com (pobox-3.corp.redhat.com [10.11.255.67])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4TKwXnM004323
	for <git@vger.kernel.org>; Thu, 29 May 2008 16:58:33 -0400
Received: from touchme.toronto.redhat.com (IDENT:postfix@touchme.yyz.redhat.com [10.15.16.9])
	by pobox-3.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4TKwGsO006937
	for <git@vger.kernel.org>; Thu, 29 May 2008 16:58:33 -0400
Received: from ton.toronto.redhat.com (ton.yyz.redhat.com [10.15.16.15])
	by touchme.toronto.redhat.com (Postfix) with ESMTP id 3CB8A8001FF
	for <git@vger.kernel.org>; Thu, 29 May 2008 16:58:00 -0400 (EDT)
Received: from ton.toronto.redhat.com (localhost.localdomain [127.0.0.1])
	by ton.toronto.redhat.com (8.13.1/8.13.1) with ESMTP id m4TKvhAq002914
	for <git@vger.kernel.org>; Thu, 29 May 2008 16:57:43 -0400
Received: (from fche@localhost)
	by ton.toronto.redhat.com (8.13.1/8.13.1/Submit) id m4TKvhOF002913
	for git@vger.kernel.org; Thu, 29 May 2008 16:57:43 -0400
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83243>

Hi -

In at least builtin-prune-packed.c, builtin-prune.c, and
guilt-repack.sh, there is an unconditional sync call.  On a machine
with lots of dirty disk data, writing it to some slow device, this
sync can take a long time.

Would there be interest in making this sync disableable with
git-config?  Or perhaps having the blanket sync be replaced a
list of fsync()s for only the relevant git repository files?

- FChE
