From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: Bug? Files are losing history after subtree merge
Date: Wed, 2 Oct 2013 22:10:05 +0200
Message-ID: <CAN0XMOJB4wco+O9EYn3swXHG-o7sHvNY6DPbfqtOi2yFAuFiSA@mail.gmail.com>
References: <1380741617-14593-1-git-send-email-ralf.thielow@gmail.com>
	<vpqsiwjlarx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 02 22:10:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRSkQ-0008RE-2w
	for gcvg-git-2@plane.gmane.org; Wed, 02 Oct 2013 22:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599Ab3JBUKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Oct 2013 16:10:07 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:46529 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050Ab3JBUKG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Oct 2013 16:10:06 -0400
Received: by mail-wi0-f171.google.com with SMTP id hm2so7896439wib.10
        for <git@vger.kernel.org>; Wed, 02 Oct 2013 13:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gXa2y7WBKFcrxU9TtfEcztHiXbJaJsEc5413M/Vy2NU=;
        b=R/6E3JDR5drJX3Lkq1Igm2m02nB+YZWgzbcbj/0QaimyHVDwqOph+/21N26c93jO1o
         MRmxGo0pWM0yR+hvnOZRYuBBvB8gGCZX0HIrpkbLmhZhUF0SS4Jpe/yb0Rg5dBdGMi6n
         S6NAmuxWS2tfdAPRdxZWN/5xzW1NRYaQkj5nHM+FFROozZbL78FYdA2m7aOn0Qza/NDi
         sjT+wfKWM7TOgAiVnYL/JTp+I/IdPNHchV/3vpS7YcW/MVxXpzT9ElFksL1nm8KbXhlY
         OHDHfR4pDsFqrD8u+JBZxVltW6ox+IZAWXPtkyv6axk5PbE165M52VlLYfNBaFjhI0Lk
         oRuQ==
X-Received: by 10.180.210.243 with SMTP id mx19mr24944286wic.35.1380744605191;
 Wed, 02 Oct 2013 13:10:05 -0700 (PDT)
Received: by 10.194.165.163 with HTTP; Wed, 2 Oct 2013 13:10:05 -0700 (PDT)
In-Reply-To: <vpqsiwjlarx.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235672>

On Wed, Oct 2, 2013 at 9:42 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> Hi,
>>
>> recently I did a merge where a complete repo shall be
>> merged into a specific directory of another repo. I
>> tried both the "subtree" merge strategy and the option
>> "-Xsubtree=<dir>" of "recursive". I noticed that in both
>> cases somehow the history of single files were lost
>> during these merges (with history I mean 'git log <file>'
>> and 'git log --follow <file>').
>
> This is a known bug of "git log --follow": it does not follow accross
> subtree merge. But your history is still there (try gitk on your project
> for example).
>
> Technically, a subtree merge is a merge commit in which files are
> renamed compared to the second parent. --follow does not manage this
> case.
>

Thanks for explanation.
I knew the history of the repo is there, but the history of single files
(and the ability to look at it) is so important that subtree-merges aren't
an option for us. Such merges are rarely, luckily, but it would be nice
to get it work.

Thanks

>> diff --git a/t/t6029-merge-subtree.sh b/t/t6029-merge-subtree.sh
>> index 73fc240..e9a97d7 100755
>> --- a/t/t6029-merge-subtree.sh
>> +++ b/t/t6029-merge-subtree.sh
>> @@ -61,6 +61,14 @@ test_expect_success 'initial merge' '
>>       test_cmp expected actual
>>  '
>>
>> +test_expect_failure 'file keeps history after subtree merge' '
>> +     cd ../git-gui &&
>> +     git log --follow git-gui.sh >../git/expected &&
>> +     cd ../git &&
>> +     git log --follow git-gui/git-gui.sh >actual &&
>> +     test_cmp expected actual
>> +'
>> +
>
> That would actually be good to add a failing test to "document" the
> failure.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
