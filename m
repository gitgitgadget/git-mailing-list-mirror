From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH] Add bare repository indicator for __git_ps1
Date: Fri, 20 Feb 2009 15:56:11 +0100
Message-ID: <499EC48B.9070004@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 20 15:58:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaWp4-0004eU-V7
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 15:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbZBTO4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 09:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753434AbZBTO4S
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 09:56:18 -0500
Received: from hoat.troll.no ([62.70.27.150]:41656 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753321AbZBTO4R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 09:56:17 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id B54FD2106E;
	Fri, 20 Feb 2009 15:56:11 +0100 (CET)
Received: from [172.24.90.95] (unknown [172.24.90.95])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id A5DFB2105F;
	Fri, 20 Feb 2009 15:56:11 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.19) Gecko/20081209 Lightning/0.9 Thunderbird/2.0.0.19 ThunderGit/0.1a Mnenhy/0.7.6.666
X-Enigmail-Version: 0.95.7
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110851>

Prefixes the branch name with "BARE:" if you're in a
bare repository.

Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 Patch tried sent via ThunderGit extension. Sorry if it's mangled :-)

 contrib/completion/git-completion.bash |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0a3092f..c741203 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -138,10 +138,16 @@ __git_ps1 ()
 			fi
 		fi
 
+		local c
+		
+		if test "$(git config --bool core.bare)" == "true"; then
+			c="BARE:"
+		fi
+
 		if [ -n "${1-}" ]; then
-			printf "$1" "${b##refs/heads/}$w$i$r"
+			printf "$1" "$c${b##refs/heads/}$w$i$r"
 		else
-			printf " (%s)" "${b##refs/heads/}$w$i$r"
+			printf " (%s)" "$c${b##refs/heads/}$w$i$r"
 		fi
 	fi
 }
-- 
1.6.2.rc1.20.g8c5b
