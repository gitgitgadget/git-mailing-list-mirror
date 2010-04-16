From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] patch-id: Add support for mbox format
Date: Fri, 16 Apr 2010 23:52:15 +0200
Message-ID: <4BC8DC0F.5010007@gnu.org>
References: <1271434948-14134-1-git-send-email-bonzini@gnu.org> <7vk4s7cks4.fsf@alter.siamese.dyndns.org> <4BC8CEC7.40003@gnu.org> <7vochjay8a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 23:52:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2tSd-0001ZJ-MS
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 23:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572Ab0DPVwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 17:52:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:9093 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932490Ab0DPVwT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 17:52:19 -0400
Received: by fg-out-1718.google.com with SMTP id 19so527566fgg.1
        for <git@vger.kernel.org>; Fri, 16 Apr 2010 14:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=C4UMJU50DUJdrxmvCIjFjKofOxuMJsPEtDrgyaj2yEM=;
        b=X6W2HW5w4SBQzhzR6JCYt3jFvBbkoZp30TdtFjeIhPIj8aJELS6sI7Vpp90WwhMXsD
         wSVuZpONYa9T1OdLP0239zJX1r0ucbnsS+pnq6NUStjwjfhIEcOVVvulKaf67gF306it
         H/5nBbqOLHY/l0JIZ0xqtozI83jGKUI1QnX5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=dkV5QiuQWwA+u4D3KMsfVLythWvIvOJXq8MHsmFyT+zMsn36vL35sVc3rRFaKZPzU4
         +N8BF8FZbVY0LYkQhupvevlknoCUKPVb5OOtAX550hlFh/TulecOs4SEdsvtTNp/UBlg
         +ZG5vTsKKRziKWWhBOiYGW9p1HfuqMdd1G8j4=
Received: by 10.223.76.132 with SMTP id c4mr963162fak.106.1271454738009;
        Fri, 16 Apr 2010 14:52:18 -0700 (PDT)
Received: from yakj.usersys.redhat.com (s209p8.home.99maxprogres.cz [85.93.118.17])
        by mx.google.com with ESMTPS id p17sm4882592fka.46.2010.04.16.14.52.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Apr 2010 14:52:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.3
In-Reply-To: <7vochjay8a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145097>

On 04/16/2010 11:23 PM, Junio C Hamano wrote:
>>>>   I have an alias that takes two arguments and compares their patch IDs.
>>>>   I would like to use to make sure I've tested exactly what I submit
>>>>   (patch by patch), like
>>>>
>>>>       git patch-cmp origin/master.. file-being-sent
>>>> ...
>>>
>>> I somehow have a feeling that this is solving a wrong problem.
>>
>> In what sense?
>
> Why does file-being-sent have anything from origin/master to begin with?
> Perhaps the --ignore-if-in-upstream mechanism needs to be updated so that
> you won't have duplicates that patch-id could easily find in the first
> place?

I think we're speaking about different things, --ignore-if-in-upstream 
doesn't have anything to do with this.  The git patch-cmp alias is just 
checking that

   git show origin/master.. | git patch-id | tac | awk '{print $1}'

and

   git patch-id < file-being-sent | awk '{print $1}'

produce the exact same output.

I use this when I had to edit the file-being-sent, e.g. to add cover 
letters or an introduction to a patch series.  Since some time passes 
between format-patch and send-email, I want to test that the file I'm 
sending is exactly what I have in the repository, and that I'm not 
submitting the wrong series.

Alternatively, I could apply file-being-sent to a detached HEAD and 
compare the trees, like

   topic=`git rev-parse HEAD`
   git checkout origin/master
   git am file-being-sent || echo bad
   mine=HEAD
   for i in `git rev-list origin/master..$topic`; do
     git diff-tree $i $mine || echo bad
     mine=${mine}^
   done

However, comparing the patch-id is faster and perfect for this job. 
What were your intended uses for the git-patch-id utility?

Paolo
