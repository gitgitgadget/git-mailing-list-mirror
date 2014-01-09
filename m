From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Verifiable git archives?
Date: Thu, 9 Jan 2014 12:51:22 -0800
Message-ID: <CALCETrXTbvHQAWm2z13OwyHCmBZZNDSqyWCdiu6maHRp2mi-Pw@mail.gmail.com>
References: <CALCETrU88evB6VQrE8=8vrc+HYXAX8_Zx7TsYZp6YXeE4dZdvg@mail.gmail.com>
 <xmqqsiswapav.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 09 21:51:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1MZx-0006Ia-5D
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 21:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756568AbaAIUvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 15:51:45 -0500
Received: from mail-ve0-f181.google.com ([209.85.128.181]:60870 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754979AbaAIUvo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 15:51:44 -0500
Received: by mail-ve0-f181.google.com with SMTP id oy12so2791110veb.40
        for <git@vger.kernel.org>; Thu, 09 Jan 2014 12:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=2HwK4htw0roN0Z5wmnUU1hQQw8i6thbPzVuYiC1BsNw=;
        b=ccvJW0YY3RdWIQ6QY0cWCejbN03pNGMzr7CyYZYxWkORGmkDcWh3jNc9HrlTi3ZEX2
         rrG/jaCmygh1JNqiTd/2kWLgI7z7Ubwg1ScYuSwDf3GwPEwPXAehRnbabEMCNXeOHZdQ
         ao4X66zpS7iGMqv3ds8RAdEVd1KLwgIAGnU1K3QQmODYQSPYW2kxIDs2PRY3vEgBrSmV
         fjfzWAD9Y/RKSETM4SExdiK7oSCJd1Dz/T+PrGUNmsUwEnQMJHJ3Y7ShRU8nZ5IThGEJ
         puSS7RkqkhOG1JKCeMhwvT8bTN5wyRC5R6jbC9/t9zUCpVXDkhBcDWxUX9exbnddDKH3
         /pdg==
X-Gm-Message-State: ALoCoQnalBXdYpBikTy0ZbLy0urI2ORAFalSVFRXw6TKpT524WA3VQXTyEZ+sbdvSyeRScEJf/vx
X-Received: by 10.58.57.194 with SMTP id k2mr4789084veq.0.1389300703657; Thu,
 09 Jan 2014 12:51:43 -0800 (PST)
Received: by 10.58.75.131 with HTTP; Thu, 9 Jan 2014 12:51:22 -0800 (PST)
In-Reply-To: <xmqqsiswapav.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240272>

On Thu, Jan 9, 2014 at 12:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Andy Lutomirski <luto@amacapital.net> writes:
>
>> It's possible, in principle, to shove enough metadata into the output
>> of 'git archive' to allow anyone to verify (without cloning the repo)
>> to verify that the archive is a correct copy of a given commit.  Would
>> this be considered a useful feature?
>>
>> Presumably there would be a 'git untar' command that would report
>> failure if it fails to verify the archive contents.
>>
>> This could be as simple as including copies of the commit object and
>> all relevant tree objects and checking all of the hashes when
>> untarring.
>
> You only need the object name of the top-level tree.  After "untar"
> the archive into an empty directory, make it a new repository and
> "git add . && git write-tree"---the result should match the
> top-level tree the archive was supposed to contain.

Hmm.  I didn't realize that there was enough metadata in the 'git
archive' output to reproduce the final tree.  If I can make it work,
would you accept a patch to add another extended pax header containing
the commit object and the top-level tree hash to the 'git archive'
tarball output?

>
> Of course, you can write "git verify-archive" that does the same
> computation all in-core, without actually extracting the archive
> into an empty directory.

Hmm.  I'll play with this.

--Andy
