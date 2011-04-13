From: Axel <axel.ml@laposte.net>
Subject: REMOTE_USER value propagation through http push
Date: Wed, 13 Apr 2011 11:48:51 +0200
Message-ID: <4DA57183.6040308@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 11:56:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9woE-0007DD-QO
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 11:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340Ab1DMJ4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 05:56:21 -0400
Received: from sd-17584.dedibox.fr ([88.191.95.182]:36699 "EHLO mx2.acipia.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748Ab1DMJ4V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 05:56:21 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Apr 2011 05:56:20 EDT
Received: by mx2.acipia.fr (Postfix, from userid 65534)
	id 451538B4001; Wed, 13 Apr 2011 11:48:49 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on martine.acipia.fr
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=10.0 tests=ALL_TRUSTED autolearn=ham
	version=3.2.5
Received: from localhost (localhost [127.0.0.1])
	by mx2.acipia.fr (Postfix) with ESMTP id E45A28B4002
	for <git@vger.kernel.org>; Wed, 13 Apr 2011 11:48:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at acipia.fr
Received: from mx2.acipia.fr ([127.0.0.1])
	by localhost (martine.acipia.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p0KbIN6w4Nnb for <git@vger.kernel.org>;
	Wed, 13 Apr 2011 11:48:45 +0200 (CEST)
Received: from magina.acipia (rsa59-4-82-247-209-197.fbx.proxad.net [82.247.209.197])
	by mx2.acipia.fr (Postfix) with ESMTP id C87DC8B4001
	for <git@vger.kernel.org>; Wed, 13 Apr 2011 11:48:45 +0200 (CEST)
Received: from axel-asus.acipia (unknown [IPv6:2a01:e35:2f7d:1c50:21e:8cff:febf:fce7])
	by magina.acipia (Postfix) with ESMTP id 9A76E6806C
	for <git@vger.kernel.org>; Wed, 13 Apr 2011 11:48:45 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110403 Fedora/3.1.9-6.fc15 Lightning/1.0b2 Thunderbird/3.1.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171439>

Hello

I set up a git server with HTTP authentication with Apache through LDAP 
(Debian Squeeze + Apache 2.2 + mod_authnz_ldap).

I m using gitweb for browsing the repositories. At this moment, the 
commiter name appears to be the local user who called "git push". The 
username used for HTTP authentication is not used as commiter name, 
though the REMOTE_USER environment variable is defined.

After a quick look at http-backend.c it looks like the GIT_COMMITER_NAME 
variable should have been defined with the REMOTE_USER variable. Is this 
right ?

In Apache access logs, the REMOTE_USER appears to be defined in the last 
request of the push :

127.0.1.1 - - [13/Apr/2011:11:45:08 +0200] "GET 
/git/sandbox/info/refs?service=git-receive-pack HTTP/1.1" 200 467 "-" 
"git/1.7.2.5"
127.0.1.1 - - [13/Apr/2011:11:45:08 +0200] "POST 
/git/sandbox/git-receive-pack HTTP/1.1" 401 618 "-" "git/1.7.2.5"
127.0.1.1 - ldapuser [13/Apr/2011:11:45:08 +0200] "POST 
/git/sandbox/git-receive-pack HTTP/1.1" 200 353 "-" "git/1.7.2.5"

Is this behaviour expected ?

Thanks
