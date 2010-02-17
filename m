From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: Possible bug with git status in 1.7.0
Date: Wed, 17 Feb 2010 20:52:43 +0100
Message-ID: <4B7C490B.8030902@gmail.com>
References: <loom.20100217T184109-183@post.gmane.org> <7vvddvoegv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 20:53:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhpxz-0000rB-Kq
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 20:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740Ab0BQTxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 14:53:22 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:18415 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561Ab0BQTxT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 14:53:19 -0500
Received: by fg-out-1718.google.com with SMTP id 19so372957fgg.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 11:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=g927jmWV+6Dr98KOZszQTxBoO57kYTQ9Nr1YhXdpzcc=;
        b=h9Aj8aeXPHrokrhtwhy16vpPiPpUEF+ysRTwD3yAoS4YwUYPvyRrayY4GZnQSiiNLC
         vG5gutbRMOCmntiyFgJ8txpcum+rf0CPxaSNr6z0EIOMUTZkGhIAxHc1FrmKMIzLRdBt
         KiYHNFa+NIS+VQJIJH5lrjSnQrR3eGx3K20ps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ZdG0lb8vYRHIqtYy1pq2Ivc1zhegvMraDWA3eH4swmCKQyakHelK+ArTt7x05Ntsv/
         zMnEWxNvL9JTSKJGESy0YZLXe7mB8EEXlLVBhqdeK503PgHH9fhPZxi7qpSI8NsZOSIq
         EleAjcIAlxtS6Ze167qjKKiiiMERgW+f+ebGQ=
Received: by 10.87.20.13 with SMTP id x13mr15092354fgi.67.1266436395422;
        Wed, 17 Feb 2010 11:53:15 -0800 (PST)
Received: from ?137.204.107.60? (i2-ve060.ingce.unibo.it [137.204.107.60])
        by mx.google.com with ESMTPS id 12sm15671858fgg.27.2010.02.17.11.53.13
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Feb 2010 11:53:14 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <7vvddvoegv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140256>

Junio C Hamano wrote:
> Sergio <sergio.callegari@gmail.com> writes:
>
>   
>> if you have a submodule and the submodule contains
>> untracked files, "git status" in 1.7.0 keeps showing
>> the module as modified.
>>
>> But of of course it is useless to "git add" the module
>> or to try to "git  commit -a", since the index entry is ok
>>     
>
> Of course it is useless to "git add" in the superproject, and this is
> an intended bugfix.
>
> You are getting reminded that you either forgot to "git add" that file in
> the submodule, or you forgot to add that file to .gitignore in the
> submodule.
>   

Thanks for the explanation!

The wording of the reminder is a bit unclear, though.  Suppose that the 
problem is with submodule "mod".

What you get from git status is a notice that something is modified but 
not updated, with the following suggestion

# Changed but not 
updated:                                                                                      

#   (use "git add <file>..." to update what will be committed)

and then the notice about what is in fact modified

#       modified:   mod


So the first problem is that now git status provides a hint that may be 
confusing.  One gets the idea that he needs to add mod (to store a new 
commit id in the index) and not to add a file in mod.


As a second issue, note that mod is in fact not really modified being that

1) no tracked file in it has been modified.
2) no new commit has been made

and the fact is that from git status I cannot recognize anymore if the 
module is really changed (the module commit id has changed) or has 
uncommited changes (some tracked file is changed) or is merely polluted 
by untracked files, so now I always need to explore the submodule.

It is true that this can be solved putting more stuff in .gitignore.
However, it might be a matter of taste, but I do not like putting all 
byproducts in .gitignore  because not doing so allows me to 
differentiate between

- files that are just garbage
- files that are not tracked but may be still precious

and selectively clean either category using the -x or -X options of git 
clean.


So, it would be nice to improve the feedback of git status for this 
particular case and possibly have an option to avoid status being so 
wordy about untracked files.


Sergio
