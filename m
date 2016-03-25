From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: How to use @{-1} with push?
Date: Fri, 25 Mar 2016 09:40:40 -0500
Message-ID: <CAHd499AM-OzqiB1hOF=0BTesFxrxNj=+jr1wH6vpQXfgoXd8Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 25 15:40:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajSus-0007TP-TO
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 15:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbcCYOkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 10:40:42 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:32842 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbcCYOkl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 10:40:41 -0400
Received: by mail-vk0-f49.google.com with SMTP id k1so93292545vkb.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 07:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to;
        bh=cP2ZCO5sBkXUZY+kKBY7Ew9BGy/bMUq6bkL+jCMvua8=;
        b=ivXsUEQ1fec5a3jc0gsGrzSOlPNRxMfTagr1mh12QfhGG75xTM1e6xVdTzAghRXiti
         BozYwV5ot+AX2zfqIx2XWuS+08bgDN7/S8/3VhN08PbgyGs9JE18TNOIJnWO/0Q8oH1A
         NfCy2AkAR9nt1mUmmGQto1gtJ97M0kKly04QZHtw3xFwKMWFa7Bonyh/nhdSANVpZkxy
         l6skfNUioaDwzz5UysFwwMpf+7EYXu30EIOza6L08/HksvtoX5DskWx29TMuq90X3IG8
         fH5aHKYCmbL5wW1DQUj6yLfyZAyP9wOJ5hnIU2z+xvVUpxySb7FolrDN+e3cXOe2CZur
         muqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:date:message-id:subject:from
         :to;
        bh=cP2ZCO5sBkXUZY+kKBY7Ew9BGy/bMUq6bkL+jCMvua8=;
        b=e1407jt1nk2Io8odtDkBso/ie+rFyGiovMhcNizSUhXaNTluQooydA5yAEhGBsSmpO
         DIlLJ1+7LdyU2lGyxKWtbLVDZz+wKaGI8QqA2hGfbXpP9VtzI0gb+E2XU2LZvoMdVEIG
         IA7lprMdSsFNOwW6HEmEaIe7pE8dRo4Rj4oU0xgkl9n/KbYKmWeRRBhKARd3hhGQE+Up
         NLkFr2KPmqBC8B0cIwIAMo5llBEIyLFh7tPTXEB2vwcq3304ZnKopLxUKWy8mBYwnDa1
         CrkeAPhBUqhsqs/UITGa55jVaS50mMGmIngbF+0usUpQqrT5C7FihJW8nd7QWBfFmasz
         IDSQ==
X-Gm-Message-State: AD7BkJJJyIrMIgtxvsSGrNZappdA+pgDCCYVUK9Ymo4Sd27cTjewYsNsxgTrhJ3VBVrXM18GQ4Hl0pq3vbBvKg==
X-Received: by 10.31.47.135 with SMTP id v129mr7350202vkv.115.1458916840843;
 Fri, 25 Mar 2016 07:40:40 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.66.68 with HTTP; Fri, 25 Mar 2016 07:40:40 -0700 (PDT)
X-Google-Sender-Auth: MYrYGn06QMlW76fBEc0HDtYNxjA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289891>

I have an alias that I'm working on to do a push and delete of a topic branch:


    # Push HEAD, delete branch local & remote
    #
    # $1 = remote name
    # $2 = branch name
    pushdel = "!f() { : git push ; git push \"$1\" HEAD \":$2\" && git
branch -d \"$2\" ; }; f"


I use it after I merge a topic branch, like so:

$ git pushdel origin my-topic-branch

What would be nice is if I could do one of the two:

$ git pushdel origin -
$ git pushdel origin @{-1}

Both should refer to the last branch, but I know that these can't be
used verbatim in a push command because it doesn't read it as a branch
name normally like `git checkout` would. I'm not sure why, as I do not
have knowledge of the underlying mechanics of these commands.

Is there a way I can use these "relative" branch shorthands in my push
command? If not directly, perhaps there is a way I can update my alias
to do an intermediate translation?

Thanks in advance.
