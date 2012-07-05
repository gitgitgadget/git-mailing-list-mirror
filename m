From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 1/3] git p4: remove unused P4Submit interactive setting
Date: Thu, 05 Jul 2012 08:20:33 +0100
Message-ID: <4FF54041.2000507@diamand.org>
References: <1341408860-26965-1-git-send-email-pw@padd.com> <1341408860-26965-2-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Horowitz <mike@horowitz.name>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 09:20:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmgMw-00052R-T1
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 09:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720Ab2GEHUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 03:20:50 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:62572 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004Ab2GEHUs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 03:20:48 -0400
Received: by eeit10 with SMTP id t10so3093267eei.19
        for <git@vger.kernel.org>; Thu, 05 Jul 2012 00:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=rLDLJdAn476v07G61PBM5XWwOAmrHiWG5jdr0jRTenM=;
        b=YaIwvq/6mxL5RjHU3I9ywXy+75iJ8EDhcnvdpq84xMtJvXjW/8ujj2DcySQ5FZuQcL
         jSDtoIIDHgy2E2qKouKUcI26jrEcQ4DZ//2qVCovQMSL0LT/m6xws+u4pG/Y0T/3Xr9T
         sCWP6wYemzw/4cJ50c4MF5lEEC5n4KjEDPMydRf1w3WWhcOouJygLogX4Nb0mGxJY/w0
         o6ZWKKFPSy78edBv0wFBMqMM35OfoR9AmvDMi/y9fgoWwqI6Elyzhu0AQfwNWrX/hvt8
         qLtqhkpLZTt4r5o79J9zdIQuk+3Ff4AOVMuaAlXwf6Vfg36yKN/5L0GLkK6gnW7BZa40
         cA1Q==
Received: by 10.14.188.129 with SMTP id a1mr5913478een.183.1341472846800;
        Thu, 05 Jul 2012 00:20:46 -0700 (PDT)
Received: from [86.6.30.7] (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id y54sm60122832eef.10.2012.07.05.00.20.45
        (version=SSLv3 cipher=OTHER);
        Thu, 05 Jul 2012 00:20:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
In-Reply-To: <1341408860-26965-2-git-send-email-pw@padd.com>
X-Gm-Message-State: ALoCoQldWQtzPkFc+uEZjeWixgph9FXfR7ZuUSEMUB4AWnfbxO6MEUmtzVTOWt3W/WSaSLWPhk1G
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201022>

On 04/07/12 14:34, Pete Wyckoff wrote:
> The code is unused.  Delete.

I've used that non-interactive code path in the past, in the very early 
days of using it (setting interactive to false manually).

The nice thing about it is that if you're using git-p4 for the very 
first time it lets you do the final submission to p4 by hand, without 
having to trust the script to do the right thing. Once I convinced 
myself that git-p4 was doing the right thing, I then stopped using it.

Is it worth retaining, perhaps fixed so that it can be set on the 
command line and documented? Or just discard?

Thanks
Luke

>
> Signed-off-by: Pete Wyckoff<pw@padd.com>
> ---
>   git-p4.py | 144 ++++++++++++++++++++++++++++----------------------------------
>   1 file changed, 66 insertions(+), 78 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index f895a24..542c20a 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -844,7 +844,6 @@ class P4Submit(Command, P4UserMap):
>           ]
>           self.description = "Submit changes from git to the perforce depot."
>           self.usage += " [name of git branch to submit into perforce depot]"
> -        self.interactive = True
>           self.origin = ""
>           self.detectRenames = False
>           self.preserveUser = gitConfig("git-p4.preserveUser").lower() == "true"
> @@ -1209,86 +1208,77 @@ class P4Submit(Command, P4UserMap):
>
>           template = self.prepareSubmitTemplate()
>
> -        if self.interactive:
> -            submitTemplate = self.prepareLogMessage(template, logMessage)
> +        submitTemplate = self.prepareLogMessage(template, logMessage)
>
> -            if self.preserveUser:
> -               submitTemplate = submitTemplate + ("\n######## Actual user %s, modified after commit\n" % p4User)
> -
> -            if os.environ.has_key("P4DIFF"):
> -                del(os.environ["P4DIFF"])
> -            diff = ""
> -            for editedFile in editedFiles:
> -                diff += p4_read_pipe(['diff', '-du',
> -                                      wildcard_encode(editedFile)])
> -
> -            newdiff = ""
> -            for newFile in filesToAdd:
> -                newdiff += "==== new file ====\n"
> -                newdiff += "--- /dev/null\n"
> -                newdiff += "+++ %s\n" % newFile
> -                f = open(newFile, "r")
> -                for line in f.readlines():
> -                    newdiff += "+" + line
> -                f.close()
> -
> -            if self.checkAuthorship and not self.p4UserIsMe(p4User):
> -                submitTemplate += "######## git author %s does not match your p4 account.\n" % gitEmail
> -                submitTemplate += "######## Use option --preserve-user to modify authorship.\n"
> -                submitTemplate += "######## Variable git-p4.skipUserNameCheck hides this message.\n"
> -
> -            separatorLine = "######## everything below this line is just the diff #######\n"
> -
> -            (handle, fileName) = tempfile.mkstemp()
> -            tmpFile = os.fdopen(handle, "w+")
> -            if self.isWindows:
> -                submitTemplate = submitTemplate.replace("\n", "\r\n")
> -                separatorLine = separatorLine.replace("\n", "\r\n")
> -                newdiff = newdiff.replace("\n", "\r\n")
> -            tmpFile.write(submitTemplate + separatorLine + diff + newdiff)
> +        if self.preserveUser:
> +           submitTemplate = submitTemplate + ("\n######## Actual user %s, modified after commit\n" % p4User)
> +
> +        if os.environ.has_key("P4DIFF"):
> +            del(os.environ["P4DIFF"])
> +        diff = ""
> +        for editedFile in editedFiles:
> +            diff += p4_read_pipe(['diff', '-du',
> +                                  wildcard_encode(editedFile)])
> +
> +        newdiff = ""
> +        for newFile in filesToAdd:
> +            newdiff += "==== new file ====\n"
> +            newdiff += "--- /dev/null\n"
> +            newdiff += "+++ %s\n" % newFile
> +            f = open(newFile, "r")
> +            for line in f.readlines():
> +                newdiff += "+" + line
> +            f.close()
> +
> +        if self.checkAuthorship and not self.p4UserIsMe(p4User):
> +            submitTemplate += "######## git author %s does not match your p4 account.\n" % gitEmail
> +            submitTemplate += "######## Use option --preserve-user to modify authorship.\n"
> +            submitTemplate += "######## Variable git-p4.skipUserNameCheck hides this message.\n"
> +
> +        separatorLine = "######## everything below this line is just the diff #######\n"
> +
> +        (handle, fileName) = tempfile.mkstemp()
> +        tmpFile = os.fdopen(handle, "w+")
> +        if self.isWindows:
> +            submitTemplate = submitTemplate.replace("\n", "\r\n")
> +            separatorLine = separatorLine.replace("\n", "\r\n")
> +            newdiff = newdiff.replace("\n", "\r\n")
> +        tmpFile.write(submitTemplate + separatorLine + diff + newdiff)
> +        tmpFile.close()
> +
> +        if self.edit_template(fileName):
> +            # read the edited message and submit
> +            tmpFile = open(fileName, "rb")
> +            message = tmpFile.read()
>               tmpFile.close()
> +            submitTemplate = message[:message.index(separatorLine)]
> +            if self.isWindows:
> +                submitTemplate = submitTemplate.replace("\r\n", "\n")
> +            p4_write_pipe(['submit', '-i'], submitTemplate)
>
> -            if self.edit_template(fileName):
> -                # read the edited message and submit
> -                tmpFile = open(fileName, "rb")
> -                message = tmpFile.read()
> -                tmpFile.close()
> -                submitTemplate = message[:message.index(separatorLine)]
> -                if self.isWindows:
> -                    submitTemplate = submitTemplate.replace("\r\n", "\n")
> -                p4_write_pipe(['submit', '-i'], submitTemplate)
> -
> -                if self.preserveUser:
> -                    if p4User:
> -                        # Get last changelist number. Cannot easily get it from
> -                        # the submit command output as the output is
> -                        # unmarshalled.
> -                        changelist = self.lastP4Changelist()
> -                        self.modifyChangelistUser(changelist, p4User)
> -
> -                # The rename/copy happened by applying a patch that created a
> -                # new file.  This leaves it writable, which confuses p4.
> -                for f in pureRenameCopy:
> -                    p4_sync(f, "-f")
> -
> -            else:
> -                # skip this patch
> -                print "Submission cancelled, undoing p4 changes."
> -                for f in editedFiles:
> -                    p4_revert(f)
> -                for f in filesToAdd:
> -                    p4_revert(f)
> -                    os.remove(f)
> +            if self.preserveUser:
> +                if p4User:
> +                    # Get last changelist number. Cannot easily get it from
> +                    # the submit command output as the output is
> +                    # unmarshalled.
> +                    changelist = self.lastP4Changelist()
> +                    self.modifyChangelistUser(changelist, p4User)
> +
> +            # The rename/copy happened by applying a patch that created a
> +            # new file.  This leaves it writable, which confuses p4.
> +            for f in pureRenameCopy:
> +                p4_sync(f, "-f")
>
> -            os.remove(fileName)
>           else:
> -            fileName = "submit.txt"
> -            file = open(fileName, "w+")
> -            file.write(self.prepareLogMessage(template, logMessage))
> -            file.close()
> -            print ("Perforce submit template written as %s. "
> -                   + "Please review/edit and then use p4 submit -i<  %s to submit directly!"
> -                   % (fileName, fileName))
> +            # skip this patch
> +            print "Submission cancelled, undoing p4 changes."
> +            for f in editedFiles:
> +                p4_revert(f)
> +            for f in filesToAdd:
> +                p4_revert(f)
> +                os.remove(f)
> +
> +        os.remove(fileName)
>
>       # Export git tags as p4 labels. Create a p4 label and then tag
>       # with that.
> @@ -1437,8 +1427,6 @@ class P4Submit(Command, P4UserMap):
>               commit = commits[0]
>               commits = commits[1:]
>               self.applyCommit(commit)
> -            if not self.interactive:
> -                break
>
>           if len(commits) == 0:
>               print "All changes applied!"
