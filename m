From: Christian Couder <christian.couder@gmail.com>
Subject: Re: cherry-pick fail when a symbolic link has been changed into a
 file or directory
Date: Thu, 4 Nov 2010 14:58:03 +0100
Message-ID: <AANLkTinSxO+UOmY-34wd6ubkc4FffJaxcMWJOKitmGj0@mail.gmail.com>
References: <20101104125641.2ef90853@cortex>
	<AANLkTimq8SP-gxZQiXW3Pxg3-1Z98zyPAoNA8JDn0=6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Camille Moncelier <moncelier@devlife.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 14:58:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE0KS-0001o5-48
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 14:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436Ab0KDN6H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 09:58:07 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52325 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106Ab0KDN6G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 09:58:06 -0400
Received: by ewy7 with SMTP id 7so957048ewy.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 06:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7F2K1/mzxKEEWrXo3W0g6e+EeodLBiNJA4ZK96S7yf8=;
        b=F/OOxWlnP//BqyoYoA499uiZVLtF73SL0xNbinkOb6Lgntd320l3kd65WZ7ACwwnvj
         NcyggFFeJ8ORBbxMgPYeQqmS6Zor4bRj7o4ImMJWLMp/UTnGKfiT5+yborBv+s3casP9
         Tl5Uo7DlYE7NETnXmHUlp+TdG+0r4w0aUVAww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=epweai3K0jl+01IcHIVqMiJjzYc6nzTPO/ZsnoCpfKJdwPLiiwzV0pLMH2h0Lre8V+
         8jbyZOuYE/OfOu39cf+CFHaYdcFA6yVV6WldqB7y6blC+B4/H/AsAo3Gkk4VrEFWs0lq
         TaAY0tu8fgWK3G8LD3HcLogaMwmrpRIMghSH8=
Received: by 10.216.30.10 with SMTP id j10mr1964752wea.8.1288879083733; Thu,
 04 Nov 2010 06:58:03 -0700 (PDT)
Received: by 10.216.26.208 with HTTP; Thu, 4 Nov 2010 06:58:03 -0700 (PDT)
In-Reply-To: <AANLkTimq8SP-gxZQiXW3Pxg3-1Z98zyPAoNA8JDn0=6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160721>

On Thu, Nov 4, 2010 at 2:55 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Could you try to cherry-pick with other strategies?
> For example with:
>
> git cherry-pick --strategy resolve test1
>
> I remember there were some problems with the default "recursive"
> strategy and I am not sure they were fixed.
> By the way could you tell which version of git you are using?

PS: Sorry for top-posting. Please don't answer like I just did.

> On Thu, Nov 4, 2010 at 12:56 PM, Camille Moncelier
> <moncelier@devlife.org> wrote:
>> I'm reposting this since I didn't get any responses and I think my
>> message didn't contained enought context.
>>
>> I think I may have spotted a bug, or a unhandled case when doing a
>> cherry-pick
>>
>> Consider a repository like this:
>>
>> # Initialize a dummy repository
>> =A0 =A0mkdir -p repo1 ; cd repo1
>> =A0 =A0git init .
>>
>> # Create a new directory `dir1' and a link to it `dir2'
>> =A0 =A0mkdir dir1
>> =A0 =A0echo file1 > dir1/file1
>> =A0 =A0ln -s dir1 dir2
>> =A0 =A0git add dir1 dir2
>> =A0 =A0git commit -m "Initial status: dir2 -> dir1"
>>
>> # Create a branch named `test1' remove the `dir2' link and
>> # replace it by a new directory
>> =A0 =A0git checkout -b test1
>> =A0 =A0git rm dir2
>> =A0 =A0mkdir dir2
>> =A0 =A0touch file2 > dir2/file1
>> =A0 =A0git add dir2/file1
>> =A0 =A0git commit -m "Removing link: dir1/ and dir2/"
>>
>> # Now create a new file in `test1' branch
>> =A0 =A0message=3D"New file in test1"
>> =A0 =A0echo $message > new_file_test1
>> =A0 =A0git add new_file_test1
>> =A0 =A0git commit -m "$message"
>>
>> # Now try to cherry-pick last commit from `test1' into master
>> =A0 =A0git co master
>> =A0 =A0git cherry-pick test1
>>
>> The cherry-pick fails saying if failed to merge `dir2' despite the f=
act
>> that the commit doesn't affect `dir2' and
>>
>> git diff test1~..test1 | git apply
>>
>> is working. Am I doing something wrong ?
>>
>> --
>> Camille Moncelier
>> http://devlife.org
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
