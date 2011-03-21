From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: "git rm" is not a valid merge resolution?
Date: Mon, 21 Mar 2011 20:56:41 +0100
Message-ID: <4D87AD79.5000806@gmail.com>
References: <4D879882.4070608@gmail.com> <vpqpqpk724l.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:56:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1lDk-00042g-Nz
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 20:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286Ab1CUT4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 15:56:51 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40933 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277Ab1CUT4u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 15:56:50 -0400
Received: by bwz15 with SMTP id 15so5317822bwz.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 12:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=F2u9+7yU0QYZTG0P8FdeoxYTwv0Km0IohpCPlFASrbU=;
        b=a1qjdUyb00n+4DsjklLNJgcs/60xfBmIFx5sGgpscUGmOdJk47XZ/6PqZkawBu4b1F
         ieoK7oUROpm9zicRISowbj6ZOci5gHEgtIRHnyMMg18sGurvKNzy47gv1f8hhfpLeeZU
         Ak0qIptI6gt097KLHsZqvqOHqYFGvEeIN6X3s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=uc9HHVEvoSD1e061CDTU3+PKUQXTnVw/RQZbvBMiOt0mLUw2R0YWBJD1IlvIvVIYYa
         sb9tdTkOEwPU/kvUoWJQqCnTcQIG9hmGO45gwObPyCNkPrZWAAuv3JABCjcE57wJaVyq
         Ku5fnW+EWfmXixmCsBQYSB02YXAvvvhg7X+bk=
Received: by 10.204.10.81 with SMTP id o17mr4220248bko.94.1300737408840;
        Mon, 21 Mar 2011 12:56:48 -0700 (PDT)
Received: from [192.168.1.101] (aadh98.neoplus.adsl.tpnet.pl [83.4.85.98])
        by mx.google.com with ESMTPS id c11sm4600694bkc.14.2011.03.21.12.56.47
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 12:56:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <vpqpqpk724l.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169655>

W dniu 21.03.2011 19:35, Matthieu Moy pisze:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
> 
>> Hi,
>>
>> git-status shows a hint that says
>>     use "git add/rm <file>..." as appropriate to mark resolution
>>  
>> But if I "git rm file" the file gets deleted. Is this really the 
>> appropriate merge resolution?
> 
> In most cases, no, but when you have a modify/delete conflict for
> example, "git rm" is one of the candidates to resolve the conflict. The
> hint gives the general case.

I think this is not completely true. You can stage removal of a file with
git add, but it's harder than use of git rm.

This is something I don't understand. Why is there a difference between
removing files and (adding files or removing content)?

You must use special flags to "git add" to remove files, while you don't
need such flags to add file or remove content.

All changes are tracked. You won't loose your data if you remove the
file by mistake. It is the same as remove some content by mistake.


Is it caused by the name of the command ("add")? Some people would be
surprised if "git add" marked removed file for removal. But I think
some would be already surprised that you have to "add" your changes.

Or maybe it is caused by the fact that "git tracks content" (if I
remember correctly)? I don't see a problem here. The command just
tells git what content it should track. "git add" does not say
"track this change (file path addition/file deletion)" but
"track this file path content", so if the file got deleted there
is nothing to track.


Maybe the command should be named "stage". You should stage your
changes. Add the file deletion is the same change as file addition.

You would do
   
    git stage addedfile
    git stage deletedfile
    git stage changedfile

This would be consistent.

(For me it doesn't need to be "stage" name. It could be handled by
"add").


Currently it works like this:

   git add untracked # Adds untracked file 
   git add . # Adds all untracked files

   rm tracked
   git add tracked # Does not stage the delete
   git add . # Does not stage the delete
   git add -A tracked # This works - stages deletion of tracked file

   git add -u # Stages all tracked changes, also new/deleted tracked files
   git add -A # Stages all changes, also new/deleted untracked files

   # No way to do following (without listing files explicitly):

   # 1. Added several new files, but has also several tracked files changed
   #    and want to only add new files

   # 2. Removed several tracked files, but has also several other tracked
   #    files changed and want to only remove deleted files. 

-- 
Piotr Krukowiecki
