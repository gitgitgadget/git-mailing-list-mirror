From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/5] remote.c: teach branch_get() to treat symrefs other
 than HEAD
Date: Thu, 2 May 2013 00:14:44 +0530
Message-ID: <CALkWK0n2odCn=GnYSXv7g113PFEX42WF1d2GBGV=ye2TuY3CHA@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
 <1367425235-14998-5-git-send-email-artagnon@gmail.com> <CAMP44s20F-QALd18VPHLF4Fj=eFFvXmkhC4XK__kxNhMoeN=ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 20:45:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXc2B-00025v-Ar
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 20:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756600Ab3EASpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 14:45:30 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:56221 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab3EASpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 14:45:25 -0400
Received: by mail-ie0-f176.google.com with SMTP id x14so2252338ief.35
        for <git@vger.kernel.org>; Wed, 01 May 2013 11:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=c3cdMZEBT6cOOS4cZ/WoT9ew2yLu7aQ+DLVClCYEohg=;
        b=Ea7Sw3/RWZOwxK9VF0m/wgw1aefmQX73ABqV68AjlLdDyZlxiwZaDy83xVAdEoCLHy
         d0nC2nMOSFNEHULjd5BIIyPto7RsaLuhU6YgYOyvhbQvGbWWHmIHO4Ixa3DP66dWLpqu
         ktM1shmPMoW7W1JBU1uk7+GLCG9Z1SxO+C3i1u9yGd74wOMPsjZS8mgwldgj1K7BNPbn
         OXbT9IfFRtQzljsFOLzForRdxPvsbrpQggsS1oH3RJrpw2CJxAqJXbyvU42cT9/s8Psm
         ixfu7OyDGB/pHOt1Rpjfb/P/oEFLc5mudO6GNeiCLhcRE1se7KzmHl7vR8RK8J3WgjbK
         P28A==
X-Received: by 10.50.57.200 with SMTP id k8mr13718771igq.44.1367433925077;
 Wed, 01 May 2013 11:45:25 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 1 May 2013 11:44:44 -0700 (PDT)
In-Reply-To: <CAMP44s20F-QALd18VPHLF4Fj=eFFvXmkhC4XK__kxNhMoeN=ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223121>

Felipe Contreras wrote:
> But why? I'm not familiar with branch_get, but my intuition tells me
> you are changing the behavior, and now branch_get() is doing something
> it wasn't intended to do. And for what?

Why is there a commit message?  I've explained what the behavior change is.

> Your rationale is that it fixes the test cases below, but that's not
> reason enough, since there are other ways to fix them, as my patch
> series shows.

For what exactly.  To fix a real bug: H@{u} and @@{u} don't work where
either H or @ are symbolic refs.  I want custom symbolic refs, because
they are useful.  In other words, "HEAD" is not a sacred symbolic ref.

>>         if (ret && ret->remote_name) {
>>                 ret->remote = remote_get(ret->remote_name);
>>                 if (ret->merge_nr) {
>> diff --git a/sha1_name.c b/sha1_name.c
>> index f30e344..c4a3a54 100644
>> --- a/sha1_name.c
>> +++ b/sha1_name.c
>> @@ -1060,7 +1060,7 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
>>                 return ret - used + len;
>>         }
>>
>> -       cp = strchr(name, '@');
>> +       cp = strstr(name, "@{");
>
> This might make sense, but it feels totally sneaked in.

Sneaked in?  I have three paragraphs in my commit message.  The first
two explain two related changes, and the third one shows how they are
related.

>>         if (!cp)
>>                 return -1;
>>         tmp_len = upstream_mark(cp, namelen - (cp - name));
>
> I think these are two patches should be introduced separately, and
> with a reason for them to exist independent of each other.

I cannot justify the remote.c patch without the "@{" change.
