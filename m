From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: filtering out mode-change-only changes
Date: Wed, 29 Feb 2012 13:11:03 -0600
Message-ID: <4F4E7847.9030402@gmail.com>
References: <jik2le$2lb$1@dough.gmane.org> <7vmx82wbmr.fsf@alter.siamese.dyndns.org> <7vipiqwb2g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 20:11:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2ovc-0000wZ-LP
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 20:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030762Ab2B2TLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 14:11:03 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48051 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758031Ab2B2TLB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 14:11:01 -0500
Received: by ghrr11 with SMTP id r11so1046374ghr.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 11:11:00 -0800 (PST)
Received-SPF: pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.138.110 as permitted sender) client-ip=10.236.138.110;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of nkreitzinger@gmail.com designates 10.236.138.110 as permitted sender) smtp.mail=nkreitzinger@gmail.com; dkim=pass header.i=nkreitzinger@gmail.com
Received: from mr.google.com ([10.236.138.110])
        by 10.236.138.110 with SMTP id z74mr2301722yhi.114.1330542660764 (num_hops = 1);
        Wed, 29 Feb 2012 11:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ZeNnP/vIO3LcNEBb1X4Ji4QIm6Fhu9GFBObYIH2KFnc=;
        b=h8ZSEsESJhuElP0yhpQLmglwl3QYumUu6Jl3U9koGzAPeV2spAo4oXi+UZ35n2rYfj
         a1WcIS5glVQgeG3MkmbSOFJRNbPxCKCyl4K4cIIt/7d4hV39vLm4KuUihk52aGhtUAY7
         rjo3ppW1MgpDcAtn4WecvHSwoBFxKYiXYA+7A=
Received: by 10.236.138.110 with SMTP id z74mr1824689yhi.114.1330542660653;
        Wed, 29 Feb 2012 11:11:00 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id h21sm35960840ann.1.2012.02.29.11.10.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 11:11:00 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <7vipiqwb2g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191844>

On 2/28/2012 9:52 PM, Junio C Hamano wrote:
> Junio C Hamano<gitster@pobox.com>  writes:
>
>> "Neal Kreitzinger"<neal@rsss.com>  writes:
>>
>>> What is the best way to filter out the "mode change only" entries from a
>>> "name-status diff result" listing of changed files?
>>> ...
>> I do not know about random scripts people write, but there is nothing
>> built-in.
>
> Having said that, if we _were_ to do this built-in, an obvious logical
> place to do so is to define a new DIFF_OPT_IGNORE_EXECUTABLE_BIT, teach
> "--ignore-executable-bit" command line option to diff_opt_parse(), and
> then teach diff_resolve_rename_copy() to consider this bit when the code
> originally set DIFF_STATUS_MODIFIED.  Instead, the updated code that is
> working under --ignore-executable-bit option would drop such a filepair
> from diff_queued_diff.
>
> I do not know if such a change is worth doing, though.  It depends on the
> real reason why do you have so many "mode change only" changes that would
> make rebasing or cherry-picking too troublesome.
>
I see three parts to this issue that are related but also independent:
Questions:
(Q1) Is the user handling filemodes correctly in git?
(Q2) Why does the user need to interrogate filemodes in git?
(Q3) How are file modes interrogated by the user in git?

Some Answers:
Q1: Is the user handling filemodes correctly in git?

A1-1: (My Context)
Perhaps I'm not, but I'm not prepared to ignore filemodes.  I think I 
need to be aware of what's changing.  Blasting everything with the linux 
chmod 777 shotgun, or the git core.filemode=false shotgun does not seem 
like the right answer to me.  I need to do more homework on linux 
permissions and git executable bit tracking.

A1-2: (General Context)
Some users do legitimately choose to have core.filemode=true and are 
correct in doing so.

Q2: Why does the user need to interrogate filemodes in git?

A2-1: (My Context)
After a rebase we need to review what changed with a 4-way diff to have 
the full context of merge-base, topic, upstream, and merged. Because we 
are mere-mortals, we want to use gui side-by-side diff (ie, diffuse) 
instead of 4-way combined diff. git-difftool only takes two file parms 
so I have to write my own script. git-mergetool's can display 4-way diff 
but insist on mangling the $MERGED file with their own attempts at 
redoing the merge, ie. creating their own merge conflicts even though 
$MERGED has no conflict markers on input.

A2-2: (General Context)
"Vendor code drops" (see git-rm manpage) can have substantial 
file-mode-only changes along with real content changes due to incorrect 
tar procedures and/or the vendor's filesystem being a "mode breaking 
filesystem". Also, there are these human stdin's going about 
capriciously with a free-will doing chmod's.

Q3: How are file modes interrogated by the user in git?

A3-1: (Some Current Options)
--name-status lumps file-mode-only changes and content changes together 
under status "M".
--raw can be parsed to discern filemode changes concurrent with 
identical content sha1's.
--summary "mode change" entries might also be usable to apply a filter 
to --name-status results.

A3-2: (Some Desired Options)
--name-status learns a new status for file-mode-only changes (ie, "P" 
for "P"ermissions).
--raw learns "P+x" and "P-x" in the status column to tell you if the 
executable bit was added or removed.

I wonder if filemode tracking was somewhat of an afterthought of the 
content-is-king design of git and that is why it is semi-opaque.

v/r,
neal
