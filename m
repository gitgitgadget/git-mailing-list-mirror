From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: Any chance for a Git v2.1.5 release?
Date: Thu, 26 Feb 2015 15:38:51 -0800
Message-ID: <35E11B78-6FF8-41DE-BBF5-8978DA2F87A6@gmail.com>
References: <C5211E53-8905-41C9-9D28-26D7BB51E76A@gmail.com> <xmqqk2z7qe8s.fsf@gitster.dls.corp.google.com> <2D3EB6D1-3029-4F60-AF29-E044E92DB036@gmail.com> <xmqq4mqapo9r.fsf@gitster.dls.corp.google.com> <DCB8EEAA-F6C3-4321-833E-39B80673C7E9@gmail.com> <xmqqvbiol7fg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 00:39:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR81E-0004aI-9W
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 00:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbbBZXi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 18:38:56 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36268 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932213AbbBZXiz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 18:38:55 -0500
Received: by pdjp10 with SMTP id p10so16622644pdj.3
        for <git@vger.kernel.org>; Thu, 26 Feb 2015 15:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=MZsyez+nXK9gnclNoND8it+pSXehxhLXMSHVDdkzaAE=;
        b=UhMbjtuphq+H1kVMCd74rz9baP4zfqh0FAB7hhTTToG9vMm863hCQgOB32jbGKwiFW
         CgwPbRwc1JH2DJd/WggIQ1VV8IticygFT+EfV61sroDwJgEXLO2iPNLb9V9/zU7LZfZm
         HRF8MrMTAW12pHNQCCIsDYunlawYlaswwyQ+Bz4b/n7WFGef1ubaJpvJK415uN4rsEYq
         4dQu82K4fyh0DOLV2wGqtFhy69wPiLsgPom5OcVGK+7ViK+U11JIR53cmtlRsbFGdM0w
         ul6br7cLwXyWC0e0h0tD6cpiH5/CvxEbrYVI1/IIMFT4gC1ByAkpJBtobdyFFo+DYh4P
         qgTQ==
X-Received: by 10.68.237.131 with SMTP id vc3mr18714088pbc.129.1424993934812;
        Thu, 26 Feb 2015 15:38:54 -0800 (PST)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id ps6sm1960399pbb.94.2015.02.26.15.38.53
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 26 Feb 2015 15:38:54 -0800 (PST)
In-Reply-To: <xmqqvbiol7fg.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264480>

On Feb 26, 2015, at 12:54, Junio C Hamano wrote:

> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> I would like to better understand how the various heads are
>> maintained.  I've read MaintNotes and I've got the concepts, but I'm
>> still a little fuzzy on some details.  It looks to me like all topics
>> still only in pu after master has been updated are then rebased onto
>> the new master and then pu is rebuilt.
>
> Topics in 'pu' not yet in 'next' _can_ be rebased, but unless there
> is a good reason to do so, I wouldn't spend extra cycles necessary
> to do such thing.  I even try to keep the same base when replacing
> the contents of a branch with a rerolled series.  For example, today
> I have this:
>
>    $ git config alias.lgf
>    log --oneline --boundary --first-parent
>    $ git lgf master..nd/slim-index-pack-memory-usage
>    3538291 index-pack: kill union delta_base to save memory
>    7b4ff41 FIXUP
>    45b6b71 index-pack: reduce memory footprint a bit
>    - 9874fca Git 2.3
>
> and Duy has a newer iteration of it starting at $gmane/264429.  What
> I would do, after saving these patches in a mbox +nd-index-pack,
> would be to
>
>    $ git checkout 9874fca
>    $ git am -s3c ./+nd-index-pack
>    $ git show-branch HEAD nd/slim-index-pack-memory-usage
>    ... compare corresponding changes between the old and the new
>    ... until I am satisified; otherwise I may tweak the new one
>    $ git rebase -i 9874fca
>    ... and then finally
>    $ git branch -f nd/slim-index-pack-memory-usage HEAD
>
> to update the topic.  Of course, it would be necessary to rebuild
> 'pu' by merging all the topics that are in it on top of 'master'.

Thanks.  That's helpful.

> After finishing 2.3.0 release, at some point while 'master' is still
> at 2.3.0, something like this would happen:
>
>    $ git branch -m maint maint-2.2
>    $ git branch maint master

So the reason I don't notice force-updates to maint when this happens  
is because of the "Sync with maint" commits that make sure the new  
maint contains the old one.

>> Also, how do you handle a down merge to maint when you have this:
>>
>> * (master)
>> * merge topic foo
>> |\
>> | * topic foo
>> |/
>> * c
>> * b
>> * a
>> * (tag: vX.X.X, maint)
>> *
>
> I don't, and this is done by making sure I do not get into such a
> situation in the first place.
>
> A general rule of thumb when applying a set of patches that are
> fixes eventually worth having in older maintenance tracks is to find
> the oldest maintenance branch and apply them there.

If I were to keep a maint-lts branch somewhere I would need to cherry- 
pick topics with desired fixes that fall into that situation.  That's  
what I expected but when you mentioned down merging the fixes I wanted  
to make sure I wasn't overlooking something.

I'll see about setting up a maint-lts in a local git repository clone  
and tracking LTS fixes.  If I'm able to keep that going without it  
becoming a black-hole of temporal need that sucks the life right out  
of me  ;)  then perhaps we can have a discussion at a future date  
about what would be needed for you to consider pulling from it and  
issuing LTS releases off it.  :)

-Kyle
