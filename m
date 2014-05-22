From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 38/44] refs.c: pack all refs before we start to rename
 a ref
Date: Thu, 22 May 2014 11:02:27 -0700
Message-ID: <CAL=YDWn8qh7SMHR+T1rsxB8u=Qd6MOSTc9Wo8pUc-jy5tNDdjg@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-39-git-send-email-sahlberg@google.com>
	<20140521235741.GN12314@google.com>
	<CAL=YDW=vY_09An0encywRoAexAEoQK=SbOe5Dt_FJmsFnwoCrg@mail.gmail.com>
	<20140522175153.GQ12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 20:02:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnXK7-00032S-Fs
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 20:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbaEVSCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 14:02:30 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:43621 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbaEVSC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 14:02:29 -0400
Received: by mail-ve0-f174.google.com with SMTP id jw12so4833462veb.5
        for <git@vger.kernel.org>; Thu, 22 May 2014 11:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=I+nucfOonKz8JND+b7IaIB4cZZYYFNnlZqXLSe3NdpY=;
        b=hpmf2j8wjy5CpfBxJ3feBWYPzZc2Tc+FljjM4jJzhyNPn1by950fUB1pmrViQZ0FHd
         woWis4M+RhsdikuinsmWP8dUQl7HgaDQV8J60akxvyYHTMyAA9VvUGKLTdNIv/7n9lhG
         643PAaXzs1n6McoXvtlPLQ8AJFBxuBAoeDC1vxL0pTKkVMF4itrkzoGybgtqNi2qr2ai
         Jz63StduTssmYCheNFR0TmNkMDelfTubY0lmvgRZdYmv0/Ul6JjusHWPXze4Kg5z0srz
         fL+UBR09dsNqLf1fiAGemoY/Vg0m2cD7LGd94uMyc2ykobHkz/NsGJkNEO2kV8F5wJvY
         6h8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=I+nucfOonKz8JND+b7IaIB4cZZYYFNnlZqXLSe3NdpY=;
        b=YAvubma8sNaznKB7wRK4PftoaPRgXiTd+Ox8CHYgZDdxhnneU02YosUUdEnSXVNVVj
         l2w37EhDUYQ9DOCBQ/K6rwuvm7GWvPFdLw99L6WmaunJm+ifWhqgu7Q+hlABrhDpRcVu
         2QTrbQRZhMBXfOvLJ2Bz++IwNNZud5U0GPOEamALw9A8PaQbbO+MVOiYCRw+hJ7tX0NS
         O3PCk3NfuT7oBN4r9Higov8qb+Tz6Xh5Rhl6UTMnCoEK/JmroDay/vOzXRH/AzIpFWBP
         B8cP3Op3m2Ic9iF39u+rezuBddDh/FfXH5Z6c4/OrBBzGqFFxcKNyCOQ6sFQAVgmruGI
         zodA==
X-Gm-Message-State: ALoCoQk7/2rF2RKs0KMXH8IlGKxglifI1Kg0zILNkaZrjwWtiW0srt0Lzs/EnkhQYkw+wCiVK3dO
X-Received: by 10.58.46.83 with SMTP id t19mr1823153vem.60.1400781748077; Thu,
 22 May 2014 11:02:28 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 22 May 2014 11:02:27 -0700 (PDT)
In-Reply-To: <20140522175153.GQ12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249925>

On Thu, May 22, 2014 at 10:51 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>> On Wed, May 21, 2014 at 4:57 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>> Ronnie Sahlberg wrote:
>
>>>> This means that most loose refs will no longer be present after the rename
>>>
>>> Is this to handle the "git branch -m foo/bar foo" case or for some other
>>> purpose?
>>
>> Yes. That is the main reason.
>
> Thanks.  Please say so in the log message.  Remember that people of
> the future debugging and trying to figure out how to fix the latest
> regression without breaking something else and whether to just revert
> your patch cannot read your mind. ;-)
>

Done.
