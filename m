From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/4] recursive submodules: test for relative paths
Date: Thu, 31 Mar 2016 09:47:22 -0700
Message-ID: <CAGZ79kYiCetyhDJwBnJ9MSufZMkW_WZepESK+U_yAOJEgfzMXg@mail.gmail.com>
References: <1459383457-6848-1-git-send-email-sbeller@google.com>
	<1459383457-6848-2-git-send-email-sbeller@google.com>
	<xmqqpouappxp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Norio Nomura <norio.nomura@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 18:47:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alfkm-0001Ln-82
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 18:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756946AbcCaQrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 12:47:24 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35617 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbcCaQrX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 12:47:23 -0400
Received: by mail-ig0-f176.google.com with SMTP id cl4so130570046igb.0
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 09:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=668tMPWdk0oSVV63Av4L3umYpfIo2SM1zkLYf35pPU4=;
        b=MGhKzH3MQafKkIgcavm7SqWOB+NxxUKaWl5Cld5961d8ugRvwgK7IuTs+9nBrR3LET
         X/p6OQGk8/nAaQ7VjHy4WWVrZibNCuSFF6foDUyFTlHRhNiWaNQrPw6n9EoWozNCvLlC
         iWNsQpZLYYq5PbKff1UB4YL4pre/KcprnyDb++tvqthdZZGG2smmoc7DKeYbc1fJ3yaQ
         cqVkL48jxBGyUGW/a2u0QddWovVL5OuMSyhv2jXFOR7wRjjKnb1buycaC/TKxGZFs85J
         YyHH5wEF5EquxB78dBuod9g00N9VEW4DRRS9nh1ny4bUkYrlcUoeITaRkxi84vL8ZRou
         DLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=668tMPWdk0oSVV63Av4L3umYpfIo2SM1zkLYf35pPU4=;
        b=MwZTakwrgm1W1jrlpbPPLgJtMvTtjGIsZi/koLRblTAVUvSmMTf4kL3kNxYwcWwVEU
         85l7ncVWTERW4KsiKS76EAQTbS5SLby5VEy1NqcbuO+5gWkFwSp6FqQiVWXySVvHbR1M
         cHORI/gFZs+eJoVG7uD3kqoUF2EIxebSr8H9hJjyVc2dvPQl2AIL+SlU5lFnLM7NXXX9
         gyv5tIRBh5bNSfz+ktJVswQ+EgcudW6eli9pf7zzPv5iLTYhpnaDpiSW300PWjex7K9u
         whnzAHuBBdzFoXNb3AX3slkA0LudecyhLsP2OvAcQ/7zAQM7B9Cz6z8x7KpyVRuwQBUe
         bSjA==
X-Gm-Message-State: AD7BkJLnPCvUcInV5ZwErdbeK5RWa3Aj/hKDNqR36t3Ssa+UIhyPhS3yaUftfZ63InTnOpU5siMwrdW7JDy4ymxk
X-Received: by 10.50.57.50 with SMTP id f18mr613281igq.93.1459442842621; Thu,
 31 Mar 2016 09:47:22 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Thu, 31 Mar 2016 09:47:22 -0700 (PDT)
In-Reply-To: <xmqqpouappxp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290417>

On Thu, Mar 31, 2016 at 9:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This was reported as a regression at $gmane/290280. The root cause for
>> that bug is in using recursive submodules as their relative path handling
>> seems to be broken in ee8838d (2015-09-08, submodule: rewrite
>> `module_clone` shell function in C).
>
> I've reworded the above like so while queuing.
>
>     "git submodule update --init --recursive" uses full path to refer to
>     the true location of the repository in the "gitdir:" pointer for
>     nested submodules; the command used to use relative paths.
>
>     This was reported by Norio Nomura in $gmane/290280.
>
>     The root cause for that bug is in using recursive submodules as
>     their relative path handling was broken in ee8838d (2015-09-08,
>     submodule: rewrite `module_clone` shell function in C).
>
> Thanks.
>

Thanks!

I'll pickup the reworded version and resend the series as there seems
to be discussion
on the other patches which requires some work by me.
