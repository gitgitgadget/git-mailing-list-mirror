From: Jean-Yves LENHOF <jean-yves@lenhof.eu.org>
Subject: Bug when doing make test using root user
Date: Fri, 12 Jun 2015 11:43:01 +0200
Message-ID: <28c940a4a806c8da130403068cf4c0ef@lenhof.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 11:52:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3Ldo-0004yP-46
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 11:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869AbbFLJwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 05:52:37 -0400
Received: from jedimaster.lenhof.eu.org ([91.121.74.224]:37801 "EHLO
	mail.lenhof.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754640AbbFLJwf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 05:52:35 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jun 2015 05:52:35 EDT
X-PHP-Originating-Script: 0:rcmail.php
User-Agent: Roundcube Webmail/0.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271476>

Hi,

I tried to compile git 2.4.3 using root on a server. It failed on test 
41 of t0302-credential-store.sh
In fact even if we remove read access on a directory, root still can 
acces this directory.
Using a not privilegied user make the test work.
Perhaps the test should be adapted to this corner case.
Trace below.

Have fun,

JYL

*** t0302-credential-store.sh ***
ok 1 - helper (store) has no existing data
ok 2 - helper (store) stores password
ok 3 - helper (store) can retrieve password
ok 4 - helper (store) requires matching protocol
ok 5 - helper (store) requires matching host
ok 6 - helper (store) requires matching username
ok 7 - helper (store) requires matching path
ok 8 - helper (store) can forget host
ok 9 - helper (store) can store multiple users
ok 10 - helper (store) can forget user
ok 11 - helper (store) remembers other user
ok 12 - when xdg file does not exist, xdg file not created
ok 13 - setup xdg file
ok 14 - helper (store) has no existing data
ok 15 - helper (store) stores password
ok 16 - helper (store) can retrieve password
ok 17 - helper (store) requires matching protocol
ok 18 - helper (store) requires matching host
ok 19 - helper (store) requires matching username
ok 20 - helper (store) requires matching path
ok 21 - helper (store) can forget host
ok 22 - helper (store) can store multiple users
ok 23 - helper (store) can forget user
ok 24 - helper (store) remembers other user
ok 25 - when xdg file exists, home file not created
ok 26 - setup custom xdg file
ok 27 - helper (store) has no existing data
ok 28 - helper (store) stores password
ok 29 - helper (store) can retrieve password
ok 30 - helper (store) requires matching protocol
ok 31 - helper (store) requires matching host
ok 32 - helper (store) requires matching username
ok 33 - helper (store) requires matching path
ok 34 - helper (store) can forget host
ok 35 - helper (store) can store multiple users
ok 36 - helper (store) can forget user
ok 37 - helper (store) remembers other user
ok 38 - if custom xdg file exists, home and xdg files not created
ok 39 - get: use home file if both home and xdg files have matches
ok 40 - get: use xdg file if home file has no matches
not ok 41 - get: use xdg file if home file is unreadable
#
#               echo "https://home-user:home-pass@example.com" 
 >"$HOME/.git-credentials" &&
#               chmod -r "$HOME/.git-credentials" &&
#               mkdir -p "$HOME/.config/git" &&
#               echo "https://xdg-user:xdg-pass@example.com" 
 >"$HOME/.config/git/credentials" &&
#               check fill store <<-\EOF
#               protocol=https
#               host=example.com
#               --
#               protocol=https
#               host=example.com
#               username=xdg-user
#               password=xdg-pass
#               --
#               EOF
#
ok 42 - store: if both xdg and home files exist, only store in home file
ok 43 - erase: erase matching credentials from both xdg and home files
# failed 1 among 43 test(s)
1..43
make[2]: *** [t0302-credential-store.sh] Error 1
make[2]: Leaving directory `/root/git-2.4.3/t'
make[1]: *** [test] Error 2
make[1]: Leaving directory `/root/git-2.4.3/t'
make: *** [test] Error 2
