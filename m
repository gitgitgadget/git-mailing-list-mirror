From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 38/44] refs.c: pack all refs before we start to rename
 a ref
Date: Thu, 22 May 2014 08:50:09 -0700
Message-ID: <CAL=YDW=vY_09An0encywRoAexAEoQK=SbOe5Dt_FJmsFnwoCrg@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-39-git-send-email-sahlberg@google.com>
	<20140521235741.GN12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 17:50:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnVG5-0002g9-6z
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 17:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbaEVPuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 11:50:11 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:59265 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbaEVPuK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 11:50:10 -0400
Received: by mail-ve0-f172.google.com with SMTP id oz11so4696124veb.3
        for <git@vger.kernel.org>; Thu, 22 May 2014 08:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WDmZjU0uSW2Va2QgIK7LtYtTRPMgxX+UhLKQp232+6w=;
        b=Tdfa44/pCQt6InYB6rmjS3TyIC5/Ey0XV1QbCqUpNBf938KgKWga9T267eE4BrNJQ1
         Boltu9xJQzKY+MvXtHDQgB33b9JNoybDSAZgrsN4Wle2nU64XhQoAuFslT9gl+wAaWtV
         SgodevvfZGaweZKmjCn7HGYPKQOo9utnPhokWVsl1sacAG5XfzBzDza+PcShXzJgty5z
         oDm0VyV9pWm9PD3wAdjfSqNQcpwKIuWSe50J/4qlGcS+QLRHzcZMPEHYYUr3wqh3hPc+
         AhKxliNbNLfSIfitffpVN8oY3KbiEBaUh4er7WXhli3k+X63WmV/HjyJncxsFEbTA8Gx
         TNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WDmZjU0uSW2Va2QgIK7LtYtTRPMgxX+UhLKQp232+6w=;
        b=BbhEXlgXp9Oue5/SSgwRomsQnhl2ZS6xEsTpoMyL9BD9CUZDnHc1qcIJWSTmaiaJLE
         3A6Pnk6s+Rr3MdiQ0e9ABrCa3nFZoayWLa0e1VrBWKiec8wUozzebMHih94elCFjscY5
         JDUzeHlOSLwzstiSjnLxVwX9IAdTi3oPQA55iafTnfhFcdjd79v4sKuDxhdAhk7HvmiE
         2/vo5Jx7NLNtq8HNRDzxWuvna+Le4rcmsKgpPfC2QMAltVba/WTXIN38nM0XcU0Srtcy
         CdCuP4l7z9CRaLtxUyX2hSKkH/Wi3BSM3NjomhZAhBGdGT9vFxGmNORgevTIwoHxTnv3
         /3mQ==
X-Gm-Message-State: ALoCoQly9BYNb2dXHgSyL+yHrEjs2cJ9JhD5VPt7Fn51CdW3KVQ19yawMW1ULbIdaw9mL5YRXZeA
X-Received: by 10.220.47.201 with SMTP id o9mr1223656vcf.65.1400773809798;
 Thu, 22 May 2014 08:50:09 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 22 May 2014 08:50:09 -0700 (PDT)
In-Reply-To: <20140521235741.GN12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249911>

On Wed, May 21, 2014 at 4:57 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> This means that most loose refs will no longer be present after the rename
>
> Is this to handle the "git branch -m foo/bar foo" case or for some other
> purpose?

Yes. That is the main reason.

>
> [...]
>> --- a/t/t3200-branch.sh
>> +++ b/t/t3200-branch.sh
>> @@ -289,7 +289,7 @@ test_expect_success 'renaming a symref is not allowed' '
>>       git symbolic-ref refs/heads/master2 refs/heads/master &&
>>       test_must_fail git branch -m master2 master3 &&
>>       git symbolic-ref refs/heads/master2 &&
>> -     test_path_is_file .git/refs/heads/master &&
>> +     test_path_is_missing .git/refs/heads/master &&
>>       test_path_is_missing .git/refs/heads/master3
>
> It's kind of silly that this test is mucking about in the .git directory
> at all.  Shouldn't the check be something like
>
>         git rev-parse --verify refs/heads/master &&
>         test_must_fail git symbolic-ref refs/heads/master3 &&
>         test_must_fail git rev-parse refs/heads/master3
>
> ?

Thanks. I updated the test with your change.

There is a whole bunch of tests that are like and access files directly..
Testing if a path exists or not, or checking that a reflog file
contains x number of lines. etc.

All these tests will be updated to not access the files directly once
I start mucking around with a TDB based refs backend.
