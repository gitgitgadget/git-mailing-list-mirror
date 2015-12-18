From: Yaroslav Halchenko <yoh@onerussian.com>
Subject: git leaves behind .git/COMMIT_EDITMSG non-shared in --shared
 non-bare repo
Date: Fri, 18 Dec 2015 14:55:03 -0500
Message-ID: <20151218195503.GA4554@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 18 21:18:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aA1U7-0005rZ-Ij
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 21:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbbLRUSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 15:18:35 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:45400 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932736AbbLRUSf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Dec 2015 15:18:35 -0500
X-Greylist: delayed 1409 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Dec 2015 15:18:34 EST
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <yoh@onerussian.com>)
	id 1aA17I-0001E8-L9
	for git@vger.kernel.org; Fri, 18 Dec 2015 14:55:04 -0500
Received: from yoh by washoe.onerussian.com with local (Exim 4.80)
	(envelope-from <yoh@onerussian.com>)
	id 1aA17I-0001E3-2f
	for git@vger.kernel.org; Fri, 18 Dec 2015 14:55:04 -0500
Content-Disposition: inline
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282714>

Not sure for what batch operations that file is actually useful, but the
story is that if we have a shared git repo (I know -- might not be as
common of a situation but possible and allowed to happen), then if one
from the shared group commits within that repository, it becomes
impossible for another person to commit.  

git does take care about chmod'ing all the files under .git/objects etc
for --shared operation, but leaves .git/COMMIT_EDITMSG at the
mercy of user's umask.  IMHO correct resolution, if leaving that file
behind is necessary, is to chmod it in the same fashion as any other
internal .git file in --shared mode -- with group write permission.

I have reproduced that behavior with today's version of git as of
2.7.0.rc1.5.gf3adf45.

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
