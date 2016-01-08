From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: [BUG] git add . after removing .git/ in a subdirectory triggers assertion failure
Date: Fri, 08 Jan 2016 12:33:06 +0100
Message-ID: <vpqvb74fgr1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 08 12:36:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHVLD-0001Q4-Hu
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 12:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585AbcAHLgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 06:36:19 -0500
Received: from mx2.imag.fr ([129.88.30.17]:52046 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754310AbcAHLgS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 06:36:18 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u08BX5Zi007317
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 8 Jan 2016 12:33:05 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u08BX6RQ008415;
	Fri, 8 Jan 2016 12:33:06 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 08 Jan 2016 12:33:05 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u08BX5Zi007317
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1452857585.8803@MDgglVkXcZaCG2nmt+/dmA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283547>

Hi,

No time to debug this for now, but I have a reproduction script:

mkdir test && cd test
git init sub   
cd sub/
touch foo && git add . && git commit -m"foo"
cd ..
git init
git add sub 
rm -fr sub/.git/
cd sub/
git add .

In short, sub used to be a submodule, but we removed the .git/ and tried
to "git add ." the result.

The last line triggers this:

git: pathspec.c:317: prefix_pathspec: Assertion `item->nowildcard_len <= item->len && item->prefix <= item->len' failed.

Cheers,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
