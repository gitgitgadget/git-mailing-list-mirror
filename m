From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv2 03/12] git p4: remove submit failure options [a]pply
 and [w]rite
Date: Sat, 15 Sep 2012 22:52:19 +0100
Message-ID: <5054F893.3040704@diamand.org>
References: <1347221773-12773-1-git-send-email-pw@padd.com> <1347221773-12773-4-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 23:52:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TD0Hv-00039M-Iq
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 23:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437Ab2IOVwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 17:52:23 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:56118 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539Ab2IOVwW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 17:52:22 -0400
Received: by weyx8 with SMTP id x8so3116683wey.19
        for <git@vger.kernel.org>; Sat, 15 Sep 2012 14:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=WtxIRD5oDW0pGa/fbsRlQ75aN8mUQyBCC20NbSxg4Uw=;
        b=cVgot4K63ymZA1Kx/Yndnkrg8iyOHr1Z7WwlGvioBrhlzBoQGZwnCKHbAs4v59bCsV
         3CHo0TlLIdjcXnJ7xpe0r3vbGGuCC91IH0zcNbgufKYsZd/5f2E7HK5JexHXoGilSRxF
         iBUWFoEElsColjgEloGXg5xOPhrjsqI1HfQpfsyOuZvarddxf1qmN4D4VKo61i8YKXOS
         4GwRdLZqpcN7GWc9Gtu3kggit5vdY59S3Xo1Qk7nRbGZdqOVw1Wd/OHXJlZlLVkXQJvX
         DuS1QBJ9FARFji29ayTm5EeHM49B8sjOdetNZqDCYk9h/aa0IJl7/26qaU3MVrrtDCE4
         0NSA==
Received: by 10.180.84.1 with SMTP id u1mr6634626wiy.15.1347745940803;
        Sat, 15 Sep 2012 14:52:20 -0700 (PDT)
Received: from [86.6.26.120] (cpc21-cmbg14-2-0-cust119.5-4.cable.virginmedia.com. [86.6.26.120])
        by mx.google.com with ESMTPS id el6sm7715004wib.8.2012.09.15.14.52.19
        (version=SSLv3 cipher=OTHER);
        Sat, 15 Sep 2012 14:52:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
In-Reply-To: <1347221773-12773-4-git-send-email-pw@padd.com>
X-Gm-Message-State: ALoCoQk5/eQlzqaLU0YPjIRko2DhD2mcNzWzKfZXm/VCJKcSg3e/fsH2qkJ0LLE0T2jfdhpxjOy8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205585>

git-p4 won't be quite the same without these completely misleading and 
confusing messages :-)

Ack.



On 09/09/12 21:16, Pete Wyckoff wrote:
> When a patch failed to apply, these interactive options offered
> to:
>
>      1) apply the patch anyway, leaving reject (.rej) files around, or,
>      2) write the patch to a file (patch.txt)
>
> In both cases it suggested to invoke "git p4 submit --continue",
> an unimplemented option.
>
> While manually fixing the rejects and submitting the result might
> work, there are many steps that must be done to the job properly:
>
>      * apply patch
>      * invoke p4 add and delete
>      * change executable bits
>      * p4 sync -f renamed/copied files
>      * extract commit message into p4 change description and
>        move Jobs lines out of description section
>      * set changelist owner for --preserve-user
>
> Plus the following manual sync/rebase will cause conflicts too,
> which must be resolved once again.
>
> Drop these workflows.  Instead users should do a sync/rebase in
> git, fix the conflicts there, and do a clean "git p4 submit".
>
> Signed-off-by: Pete Wyckoff<pw@padd.com>
> ---
>   git-p4.py | 20 ++------------------
>   1 file changed, 2 insertions(+), 18 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 2405f38..e08fea1 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1200,9 +1200,8 @@ class P4Submit(Command, P4UserMap):
>           if not patch_succeeded:
>               print "What do you want to do?"
>               response = "x"
> -            while response != "s" and response != "a" and response != "w":
> -                response = raw_input("[s]kip this patch / [a]pply the patch forcibly "
> -                                     "and with .rej files / [w]rite the patch to a file (patch.txt) ")
> +            while response != "s":
> +                response = raw_input("[s]kip this patch ")
>               if response == "s":
>                   print "Skipping! Good luck with the next patches..."
>                   for f in editedFiles:
> @@ -1210,21 +1209,6 @@ class P4Submit(Command, P4UserMap):
>                   for f in filesToAdd:
>                       os.remove(f)
>                   return False
> -            elif response == "a":
> -                os.system(applyPatchCmd)
> -                if len(filesToAdd)>  0:
> -                    print "You may also want to call p4 add on the following files:"
> -                    print " ".join(filesToAdd)
> -                if len(filesToDelete):
> -                    print "The following files should be scheduled for deletion with p4 delete:"
> -                    print " ".join(filesToDelete)
> -                die("Please resolve and submit the conflict manually and "
> -                    + "continue afterwards with git p4 submit --continue")
> -            elif response == "w":
> -                system(diffcmd + ">  patch.txt")
> -                print "Patch saved to patch.txt in %s !" % self.clientPath
> -                die("Please resolve and submit the conflict manually and "
> -                    "continue afterwards with git p4 submit --continue")
>
>           system(applyPatchCmd)
>
