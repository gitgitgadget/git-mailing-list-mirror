From: David Glesser <glesserd@ensimag.fr>
Subject: tag format and tests
Date: Mon, 30 May 2011 16:12:30 +0200
Message-ID: <db6ec478a7cb9b963d90651f5315ffec@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: <Matthieu.Moy@grenoble-inp.fr>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 16:45:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR3iY-0002Eg-1c
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 16:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757328Ab1E3Ooq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 10:44:46 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60851 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757246Ab1E3Oop (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 10:44:45 -0400
X-Greylist: delayed 1933 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 May 2011 10:44:45 EDT
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p4UECTJe006707
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 May 2011 16:12:29 +0200
Received: from web-ensimag.imag.fr (web-ensimag [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id p4UECUPL013919;
	Mon, 30 May 2011 16:12:30 +0200
Received: from webmail.ensimag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id p4UECUBC026538;
	Mon, 30 May 2011 16:12:30 +0200
X-Sender: glesserd@ensimag.fr
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 30 May 2011 16:12:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p4UECTJe006707
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: glesserd@ensimag.fr
MailScanner-NULL-Check: 1307369550.01328@YVs/NJi6UPXqFQxqy3htNw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174751>

Hello,

We are currently coding a minimal git client using libgit2. We use git
tests to test our git client. We have an error caused by the tag format
used by libgit2.
The test t1006-cat-file.sh report many errors, the first one is:
not ok - 23 Size of tag is correct
This error comes from libgit2 and how it writes the timestamp, see below:

$ cat tag && echo
object 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689
type blob
tag hellotag
tagger SpongeBob <spongebob.square@crusty-crabs.com> 0000000000 +0000

cheeseburger
$ git mktag < tag
7eade44ddd1b9ee24a44e0b2dde2561efea7f7d6
$ echo 7eade44ddd1b9ee24a44e0b2dde2561efea7f7d6 | git cat-file --batch
7eade44ddd1b9ee24a44e0b2dde2561efea7f7d6 tag 154
object 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689
type blob
tag hellotag
tagger SpongeBob <spongebob.square@crusty-crabs.com> 0000000000 +0000

cheeseburger


And now using libgit2 :

$ git2 mktag < tag
49bc784cd2071c97a14841b3eab1181dd1c8fbcd
$ echo 49bc784cd2071c97a14841b3eab1181dd1c8fbcd | git cat-file --batch
49bc784cd2071c97a14841b3eab1181dd1c8fbcd tag 145
object 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689
type blob
tag hellotag
tagger SpongeBob <spongebob.square@crusty-crabs.com> 0 +0000

cheeseburger

Both formats are accepted by git.
It's reasonable to say that the test is wrong because it doesn't fit
exactly with the format ?


David G.
