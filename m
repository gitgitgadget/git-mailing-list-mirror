From: Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: git-format-patch with -o ../ in subdir of working copy writes output
 in wrong place
Date: Mon, 12 Jan 2009 20:04:32 -0200
Message-ID: <496BBE70.9060405@cesarb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 23:13:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMV1Z-0000m1-31
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 23:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbZALWLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 17:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbZALWLQ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 17:11:16 -0500
Received: from smtp-03.mandic.com.br ([200.225.81.143]:41300 "EHLO
	smtp-03.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbZALWLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 17:11:16 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Jan 2009 17:11:15 EST
Received: (qmail 30432 invoked from network); 12 Jan 2009 22:04:33 -0000
Received: from grumari.nitnet.com.br (HELO [192.168.96.4]) (zcncxNmDysja2tXBpdiToZWJlF6Wp6IuYnI=@[200.157.204.13])
          (envelope-sender <cesarb@cesarb.net>)
          by smtp-03.mandic.com.br (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 12 Jan 2009 22:04:33 -0000
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105400>

If you are in a subdirectory of your working copy (for instance, 
linux-2.6/drivers/net) and use git-format-patch with -o to a sequence of 
../ (for instance, -o ../../../) to write to the working copy's parent 
directory, it instead interprets the directory passed to -o as relative 
to the root of the working copy, instead of the expected current directory.

Testcase:
mkdir a
cd a
git init
mkdir b
touch b/c
git add b/c
git commit -m 'test'
cd b
echo 'test' > c
git commit -a -m 'test'
git format-patch -o ../ HEAD^..HEAD

Expected result: put the patch within the "a" directory
Result with v1.6.1: put the patch within the parent of the "a" directory

(This testcase uses ../ instead of ../../ to avoid putting the patch 
file in an unexpected place, like in your home directory, which is what 
would happen in practice.)

-- 
Cesar Eduardo Barros
cesarb@cesarb.net
cesar.barros@gmail.com
