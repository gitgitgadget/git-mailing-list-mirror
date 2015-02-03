From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/4] apply: do not touch a file beyond a symbolic link
Date: Tue, 3 Feb 2015 18:40:37 -0500
Message-ID: <CAPig+cRw==UoX7-zjykuXZQ43YP3cGKYtGCmc2rkOtV8JeEJGQ@mail.gmail.com>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
	<1422919650-13346-5-git-send-email-gitster@pobox.com>
	<20150203011139.GC31946@peff.net>
	<xmqqy4oepv59.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 00:41:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIn5z-0002T0-Gn
	for gcvg-git-2@plane.gmane.org; Wed, 04 Feb 2015 00:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756539AbbBCXko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 18:40:44 -0500
Received: from mail-yh0-f52.google.com ([209.85.213.52]:38836 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932579AbbBCXkj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 18:40:39 -0500
Received: by mail-yh0-f52.google.com with SMTP id f10so19807013yha.11
        for <git@vger.kernel.org>; Tue, 03 Feb 2015 15:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=GmTCH6GevMJZUmQea5XG5qNuoAhZM/k5vfYSBmIIi7Y=;
        b=lqiXSNnTS6fwxxRVCmSP7c4uTLHPt7FKbkQSgd4sUJW9Q2rjVicQTf4QhrGlhHdlGa
         jd8536FqW0cZv2C/+KxrGG06m4jDUiKMX6AmzBD5fiRgYhB6WpecENSyZP34xlzlmZwR
         9mf4/AbBnrfZW0++V8ger7OsK3DaP3AmmsDJV1F0JGB3vgCs3ucFDOPQTutZMZax3pp1
         VekrZVdwVtCf+0NAsUaYNJKo/4eDDH1CW3mFqsJyhYqbJP2YTpZ6Gdu9yMOOOaL9OOwp
         YR7fMqCIYGk59qXKNOX4YJgRaanW36+4KzYHaZAsVmhnym84/fXpA41tgRZ5jMj/VVwu
         nBXw==
X-Received: by 10.236.70.100 with SMTP id o64mr11096012yhd.94.1423006837848;
 Tue, 03 Feb 2015 15:40:37 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Tue, 3 Feb 2015 15:40:37 -0800 (PST)
In-Reply-To: <xmqqy4oepv59.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 7AKyu3ucURH2scK4SLIZwpFL-KY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263340>

On Tue, Feb 3, 2015 at 4:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>> diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-inside.sh
>> index 942c5cb..fbba8dd 100755
>> --- a/t/t4122-apply-symlink-inside.sh
>> +++ b/t/t4122-apply-symlink-inside.sh
>> @@ -112,6 +113,20 @@ test_expect_success SYMLINKS 'do not follow symbolic link (same input)' '
>>       test_i18ngrep "beyond a symbolic link" error-ct &&
>>       test_must_fail git ls-files --error-unmatch arch/x86_64/dir &&
>>       test_must_fail git ls-files --error-unmatch arch/i386/dir

Broken &&-chain.

>> +
>> +     >arch/i386/dir/file &&
>> +     git add arch/i386/dir/file &&
>
> At this point, the target of the patch application has:
>
>         arch/i386/boot/Makefile
>         arch/i386/dir/file
>         arch/x86_64/boot/Makefile
>
> all of which are regular files.  The index and the working tree
> match.
