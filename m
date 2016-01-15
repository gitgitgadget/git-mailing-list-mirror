From: Marcus Brinkmann <marcus.brinkmann@ruhr-uni-bochum.de>
Subject: BUG: git subtree split gets confused on removed and readded directory
Date: Fri, 15 Jan 2016 17:23:24 +0100
Message-ID: <56991CFC.7060705@ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 17:29:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK7Fx-0001Rr-QY
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 17:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbcAOQ3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 11:29:41 -0500
Received: from out2.mail.ruhr-uni-bochum.de ([134.147.42.229]:59584 "EHLO
	mx2.mail.ruhr-uni-bochum.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750942AbcAOQ3l (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jan 2016 11:29:41 -0500
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jan 2016 11:29:40 EST
Received: from mx2.mail.ruhr-uni-bochum.de (localhost [127.0.0.1])
	by mx2.mail.ruhr-uni-bochum.de (Postfix mo-ext) with ESMTP id 3phnqx1sJcz4xJf
	for <git@vger.kernel.org>; Fri, 15 Jan 2016 17:23:25 +0100 (CET)
Received: from mx2.mail.ruhr-uni-bochum.de (localhost [127.0.0.1])
	by mx2.mail.ruhr-uni-bochum.de (Postfix idis) with ESMTP id 3phnqx1DHkz4xSq
	for <git@vger.kernel.org>; Fri, 15 Jan 2016 17:23:25 +0100 (CET)
X-Envelope-Sender: <marcus.brinkmann@ruhr-uni-bochum.de>
X-RUB-Notes: Internal origin=134.147.42.227
Received: from mail1.mail.ruhr-uni-bochum.de (mail1.mail.ruhr-uni-bochum.de [134.147.42.227])
	by mx2.mail.ruhr-uni-bochum.de (Postfix mi-int) with ESMTP id 3phnqx0MfYz4xSd
	for <git@vger.kernel.org>; Fri, 15 Jan 2016 17:23:24 +0100 (CET)
Received: from [192.168.142.173] (p5093a15e.dip0.t-ipconnect.de [80.147.161.94])
	by mail1.mail.ruhr-uni-bochum.de (Postfix) with ESMTPSA id 3phnqw5ZkxzyTR
	for <git@vger.kernel.org>; Fri, 15 Jan 2016 17:23:24 +0100 (CET)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
X-Virus-Scanned: clamav-milter 0.98.7 at mx2.mail.ruhr-uni-bochum.de
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284178>

Hi,

I made a simple test repository showing the problem here:
https://github.com/lambdafu/git-subtree-split-test

After creating the master branch, I created the split/bar branch like this:

$ git subtree split -P bar -b split/bar

The resulting history is confused by the directory "bar" which was
added, removed and then re-added again.  The recent history up to adding
the directory the second time is fine.  But then it seems to loose track
and add the parent of that commit up to the initial commit in the history.

I'd expect that the parent of the readding commit is an empty tree
commit (which removed the last files in the directory), and that before
that are commits that reflect the initial creation of that directory
with its files, but rewritten as a subtree, of course.

Thanks!
Marcus
