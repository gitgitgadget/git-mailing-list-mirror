From: Andre Bossert <anb0s@anbos.de>
Subject: git mergetool: create temporary files in different sub-folders but
 with same filenames
Date: Tue, 02 Jun 2015 20:48:25 +0200
Message-ID: <556DFA79.9020904@anbos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 20:48:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzrEt-0001cb-HX
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 20:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525AbbFBSsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 14:48:36 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38527 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbbFBSse (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 14:48:34 -0400
Received: by wizo1 with SMTP id o1so156044326wiz.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 11:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:message-id:date:from:user-agent
         :mime-version:to:subject:content-type:content-transfer-encoding;
        bh=LuB9ZunHS1+v5P7ErZAfJMrROE3Ccl8JySMy0kW8Ndc=;
        b=Folkw2m5OlaxjGN+TyzQa6S/i6tV6ZLr7spkf5nKqOiju95ZNU1YEjGURh9USY+m7W
         qZOChha30mHVGyhCpD84fkKIPQVKX+zCOXtkifl+LUrTDeLqvu86BkwTcLb9Y4DxZo7a
         tLTATZk+JorbHpa1ttI1YF0FpQC8nHnDK9gelG5q8EuWLOOxkBlgrdZ59DPHgNKbkcrU
         H/FZIfGez5nzgVHNygxc3TtF54/XAzM3p50cfKvinKi2hVHO518JxNFGc/1hknXnyVjR
         9F+GcGOTpADmkKjItwq4Qku3oORkk9J7JrCu6nLe5zfZWtMOiPw0jIOqJihok4b8OWaa
         dFOg==
X-Gm-Message-State: ALoCoQm4i3j6ic4tya9rgr3s0ElvRl36QnGySlGqQregpdMeExywk2x+WuZzy9723CytErt0vWDB
X-Received: by 10.194.161.138 with SMTP id xs10mr54484750wjb.37.1433270913253;
        Tue, 02 Jun 2015 11:48:33 -0700 (PDT)
Received: from [192.168.22.22] (p57A3B28E.dip0.t-ipconnect.de. [87.163.178.142])
        by mx.google.com with ESMTPSA id v3sm22906562wix.8.2015.06.02.11.48.32
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2015 11:48:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270583>

Hello,

we are moving from ClearCase to Git (MSYS 1.9.5 at Win7x64) and trying 
to configure one special merge tool "DiffMerge" for IBM Rhapsody files. 
So we've added our merge tool (script) to gitconfig. The merge script 
calls the DiffMerge for some file-extensions (sbs, rpy etc.). It works 
in general, but the different file names passed to DiffMerge (e.g. 
<base-name>.LOCAL.xyz.<ext>, <base-name>.REMOTE.xyz.<ext>) are shown as 
conflict  --> user have to solve it manually.

I've found the new feature (mergetool.writeToTemp = true) in 
"https://github.com/git/git/blob/master/git-mergetool.sh 
<https://github.com/git/git/blob/master/git-mergetool.sh>" that creates 
one temporary folder for all four files with different names. I've added 
some handling for sub-folders.

Instead of:
     BACKUP="./$MERGED.BACKUP.$ext"
     LOCAL="./$MERGED.LOCAL.$ext"
     REMOTE="./$MERGED.REMOTE.$ext"
     BASE="./$MERGED.BASE.$ext"

i've added this definitions (and some other handling for creation etc.)
...
     TEMP_BACKUP="$MERGETOOL_TMPDIR/BACKUP"
     TEMP_LOCAL="$MERGETOOL_TMPDIR/LOCAL"
     TEMP_REMOTE="$MERGETOOL_TMPDIR/REMOTE"
     TEMP_BASE="$MERGETOOL_TMPDIR/BASE"

     BACKUP="$TEMP_BACKUP/${BASE}$ext"
     LOCAL="$TEMP_LOCAL/${BASE}$ext"
     REMOTE="$TEMP_REMOTE/${BASE}$ext"
     BASE="$TEMP_BASE/${BASE}$ext"
...

I've tested the script with normal merge-workflows and it worked. May i 
request a review and integration in Git?

-- 
Regards
Andre (anb0s)
eMail: anb0s@anbos.de <mailto:anb0s@anbos.de>
