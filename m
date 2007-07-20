From: "Chris Larson" <clarson@kergoth.com>
Subject: [PATCH] git-submodule fixes for call to git config --get-regexp
Date: Fri, 20 Jul 2007 10:23:05 -0700
Message-ID: <b6ebd0a50707201023h12ed3c61v31ccb2b356c1ee42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 20 19:23:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBwCB-0001qB-Fy
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 19:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbXGTRXK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 13:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757323AbXGTRXJ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 13:23:09 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:24707 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759873AbXGTRXH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 13:23:07 -0400
Received: by nz-out-0506.google.com with SMTP id s18so834817nze
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 10:23:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=VCbtCUSejlScgqTRBdwjL9pyuBM23j/1HsAkJezs82a2lW+qMS6nsYNjUInpXJbJkS+pt9QR5tIfhRvFUAz7XvoKv5wdHkHUPIyrh/uVpc0wyfQY+ddL4Ie0a5NLLVhGzrqzLEUw2+ZpHjP+cqwmQxoAnGSwWgftHUshLdrPW0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=qUtDJ5kByC8w+FZkL1C6cxAfc8yC6aIbgM5c6ZtYw/YU25aNmpfyJwOw7dGWrSmcp6PYLrauu7vEsxtr1+xCCG6FYjKtMpYSM32aHyWlLmG6ubioNURqS1glJUFI7JRvltTS3EOsyiFJDQVUDcKXbsDQsA8Urs/e+GvXabzPkz0=
Received: by 10.142.234.12 with SMTP id g12mr50283wfh.1184952185729;
        Fri, 20 Jul 2007 10:23:05 -0700 (PDT)
Received: by 10.142.81.6 with HTTP; Fri, 20 Jul 2007 10:23:05 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 26976880811ae94a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53102>

Two minor git-submodule fixes:
* Escape !'s in the git config --get-regexp, so submodule paths can
contain them.
* Be more explicit about the value regex, otherwise things get confused if one
  submodule name is a prefix of another (since --get-regexp can return
  multiple values).

Signed-off-by: Chris Larson <clarson@kergoth.com>

--- git-submodule.sh.old	2007-07-20 10:13:22.578125000 -0700
+++ git-submodule.sh	2007-07-20 10:14:56.281250000 -0700
@@ -46,7 +46,8 @@ get_repo_base() {
 #
 module_name()
 {
-       name=$(GIT_CONFIG=.gitmodules git config --get-regexp
'^submodule\..*\.path$' "$1" |
+       path=$(echo "$1" | sed -e 's/\!/\\!/g')
+       name=$(GIT_CONFIG=.gitmodules git config --get-regexp
'^submodule\..*\.path$' "^$path$" |
        sed -nre 's/^submodule\.(.+)\.path .+$/\1/p')
        test -z "$name" &&
        die "No submodule mapping found in .gitmodules for path '$path'"

-- 
Chris Larson - clarson at kergoth dot com
Dedicated Engineer - MontaVista - clarson at mvista dot com
Core Developer/Architect - TSLib, BitBake, OpenEmbedded, OpenZaurus
