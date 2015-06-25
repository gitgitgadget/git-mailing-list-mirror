From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2015, #06; Wed, 24)
Date: Thu, 25 Jun 2015 06:14:31 -0700
Message-ID: <xmqqtwtw0w20.fsf@gitster.dls.corp.google.com>
References: <xmqqwpys95bm.fsf@gitster.dls.corp.google.com>
	<CAGZ79kby0RaKiS2e4o7O7OyLGCftMYVJppvATyPxpzJUOe59jw@mail.gmail.com>
	<d825b05938778f4ee911cbb8c3c8573b@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 25 15:14:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z86zN-0003eW-PJ
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 15:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbbFYNOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 09:14:42 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37904 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbbFYNOk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 09:14:40 -0400
Received: by igin14 with SMTP id n14so55007380igi.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 06:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nmo9bcY2HTg76p4zJbaCaLbYTWum9NxIpNH/vmG3tMQ=;
        b=pBgv6ImXrg4s7nq4E+6slrKmd7Kt9HERa7SLfSTItJDWgfzVe9QMAx9guv7VZyHIhK
         DjrW9iC22ooWPLUy1XEh50mY+Gg7bRgQ9FFG5IwDtmNtJa6XbvfqEeRYWUyL6+UcU7pu
         ZBxMn51BkFsASIgfb/DYvgJKgENtaGfCpCOKUG1PJHjh+3c6zu8kksyowpiqpliBoDOb
         ZWj+xyHdxR6ewpcifsW/7AFT913LeIbRsNEvrkEuMvc3P0s6s9yuPQ8twwdrZNNL6hpn
         1jlROQ4S4mxk7oXtnLLV+IsdBZiL+uViGvTBW5qX53yy1HnUKvT4PYBw891+jrOh1btZ
         HeVA==
X-Received: by 10.50.61.234 with SMTP id t10mr3880733igr.19.1435238080209;
        Thu, 25 Jun 2015 06:14:40 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id rr5sm3299001igb.7.2015.06.25.06.14.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 06:14:32 -0700 (PDT)
In-Reply-To: <d825b05938778f4ee911cbb8c3c8573b@www.dscho.org> (Johannes
	Schindelin's message of "Thu, 25 Jun 2015 13:04:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272674>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> - I *think* that the current `recreate_opt()` is fine, but if it
> is used more, we will have to quote the arguments to guard against
> spaces and quotes and whatnot

I admit that that was the reaction I had when I saw it for the first
time, until I realized how it is used.  And this one I have to
disagree.  recreate-opt is used to munge a single argument, suitable
to be placed into argv[] for execv() like thing---there is no need
for shell quoting there.  It is a job for the caller that gets its
result to shell quote if it wants to pass the result to a shell.

So I think this is fine as-is.

> - There is a loop
>
>         for (; *argv; argv++)
>                argv_array_push(array, *argv);
>
>   which might want to be written as
>
>         while (*argv)
>                argv_array_push(array, *(argv)++);

Yeah, the latter is certainly more readable, but I agree this is not
a showstopper.  I'd gladly take an incremental to update it, though
;-)

Thanks, both.
