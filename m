From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv7 0/8] Expose submodule parallelism to the user
Date: Tue, 12 Jan 2016 15:59:09 -0800
Message-ID: <CAGZ79kZO=qLXK=tDt=DT=9og=aNgxk+ukoO4e5qDT=OAJCCS2A@mail.gmail.com>
References: <1452541321-27810-1-git-send-email-sbeller@google.com>
	<xmqqoacqs6g7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 00:59:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ8qJ-0008Nq-CY
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 00:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003AbcALX7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 18:59:11 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35905 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbcALX7K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 18:59:10 -0500
Received: by mail-ig0-f181.google.com with SMTP id z14so138825939igp.1
        for <git@vger.kernel.org>; Tue, 12 Jan 2016 15:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NeVTqxpusJxxdDX20cwjBXzPDNh5gDmOwyFhqhEYvtI=;
        b=EVJWDiB937EUU37fD42iyXoeKq+qr7zGF1C1AU5grDB9csVwVP7mkaoWzdflivhNjB
         ZnALKECxCbeyjTbYk8ex1HXx0bjeOqno6WlGVOJax7SvAO5qME6gRrBVpn05ON82QP94
         4CrSQ+CBTDS73dZtv7iBvkLPAAjc0pt4dSk7NbXEHS535iRcScx+xqtPM/h8q6y7Yc1v
         JDbpyr+LoBKzE2axB0s0B982/ZeIfDwDuEaR3NImTJlP+Sfm+NIRn/OJg/oOZ2t8WdYo
         qeiN/SgTp4TWOiszBn3xSMYvz6oaku74EgDUZp2OHVnvRiK3pO6gwZxEKHxmyzi4mVEL
         oKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=NeVTqxpusJxxdDX20cwjBXzPDNh5gDmOwyFhqhEYvtI=;
        b=PfCjqPCe2LGezRUInaScPy6tTYPIZ0DnCGVF74BGdIOKI3hqbvEcc3QdN7PmNZZHKL
         bbuLaqz9m4f/bEKrVinz5ffIkanagXhl8UeG4VACw+8cZkzEFZEg9s/qZZZvFz9CqhwH
         SPUqekSQ7ifMOqcIrIKbp7uegyR4h/B1nD/AF+jvSUdd23jAt+qSSMeUIOvvwqEibhcJ
         uCwQ15ljbFnZBrwfdPCCAP9R7IxKzKddV1lfGwchV6NnV/XzonsdHuHCizneVMvBRbGN
         CL88xmY7njiMcDwJlLWXgWEKAAzXntXJmX3B5qi8OKRTsAENjeH3ziwtZJtviXFY7Z9p
         h8sA==
X-Gm-Message-State: ALoCoQnmt7h0NkjfE9Yhg0xQbzsLpcGKBSurb6hK2EPBU07GaKqd6qod+8p2ISb9Xf3Iqq5hf43BdHDP/yQNQ/eNuROf9rfi7d4INGuRevkhKcjBK6OKNzg=
X-Received: by 10.50.66.179 with SMTP id g19mr21683648igt.94.1452643150025;
 Tue, 12 Jan 2016 15:59:10 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Tue, 12 Jan 2016 15:59:09 -0800 (PST)
In-Reply-To: <xmqqoacqs6g7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283857>

On Tue, Jan 12, 2016 at 3:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This is a resend of sb/submodule-parallel-update and is available
>> at github[1] as well.  It applies on top of
>> sb/submodule-parallel-fetch
>>
>> What does it do?
>> ---
>> This series should finish the on going efforts of parallelizing
>> submodule network traffic. The patches contain tests for
>>   clone
>>   fetch
>>   submodule update
>> to use the actual parallelism both via command line as well as a
>> configured option. I decided to go with "submodule.fetchJobs" for
>> all three for now.
>>
>> What changed to v5,6?
>> ---
>> No major changes, I just made it compile again as the order of parameters
>> to the parallel processing engine changed.
>
> OK, I am in the process of replacing it but I am also rewinding
> 'next' and updating 'maint' today, so this update may not be
> published until tomorrow's integration cycle.
>
> Here are the changes I noticed, just to double check:
>
>  - There is no change in [1-3/8] relative to the previous round;
>    I'll keep the one that has been in my tree to preserve their
>    committer/author dates.
>
>  - In the log message of [4/8], the misspelt "submodule.jobs" in the
>    previous round now reads "submodule.fetchJobs".
>
>  - There is no change in [5-8/8] relative to the previous round.

Yeah that's it.

Additionally to that I needed to switch the order of arguments for the
parallel processing calls, too, to make it compile again.
I assume I just did that work twice as the previous version
ought to compile, too.

But apart from these 2 things I did no other changes.

>
> Thanks.
