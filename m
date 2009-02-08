From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [PATCH] Make tig call the correct git config command
Date: Sun, 8 Feb 2009 08:49:52 +0100
Message-ID: <237967ef0902072349t784e1519m3561ef02545a72de@mail.gmail.com>
References: <237967ef0902072346x4537f70dua37ba897fac99361@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sun Feb 08 08:54:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW4Uc-0008TQ-MZ
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 08:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbZBHHtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 02:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752395AbZBHHty
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 02:49:54 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:23007 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbZBHHty (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 02:49:54 -0500
Received: by ey-out-2122.google.com with SMTP id 25so399995eya.37
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 23:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+0KauoCGTh79f66ZKphGvxX+40xcqJGQTzusRgKt0zA=;
        b=xei1BhYuWbb/GVHPT0wGk2Zx+Quh8c9SqTdXl2Vr3rOSERJak62So4mV+iI/dzRfZt
         xrpLnEDE48qdg1vQoKsXL0u4GeTEiKmPSjx2vb+SQ6wbJQt6rqzeTzcJ3P7xsuUco3R+
         UvWZSGU7WzsNsnBKSYkK9D2U/1iFLb0xBO3y8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J7Aqj86G5u97ZNL1eWCvHZlVzX+tIvju0rezSBipwhyG5JfL84vuJ60vObr3xfRryU
         5HN87Bw/jSpK3t8emP5dfZc8ZJaVVZ8IAgsgoXtwg6fJyQpyOLE5C8H8GUmOyRzVMM6+
         ozBUA4JOa5JAD0lz6EgTAzhdKt8TztsPonj9E=
Received: by 10.210.120.7 with SMTP id s7mr2814704ebc.184.1234079392145; Sat, 
	07 Feb 2009 23:49:52 -0800 (PST)
In-Reply-To: <237967ef0902072346x4537f70dua37ba897fac99361@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108927>

As it turns out I'm an idiot, that's just the configure help message.
Rerunning autoconf + configure in fact generates a completely correct
commandline. Sorry about the noise.

2009/2/8 Mikael Magnusson <mikachu@gmail.com>:
> 2009/2/7 Mikael Magnusson <mikachu@gmail.com>:
>> 2009/2/5 Jonas Fonseca <fonseca@diku.dk>:
>>> Hello,
>>>
>>> Here is a much needed update fixing multiple regressions from the
>>> introduction of the IO API in 0.13. Among improvements is the much
>>> requested ability to restore the position in the stage view when staging
>>> diff hunks. Also noteworthy is the many optimizations of the screen
>>> updating to make it work better across slow links. Finally, beware that
>>> a handful of incompatibilities can cause problems.
>>
>> I'm having a problem with tig taking 2 seconds to start up, which
>> seems to be related to the 'typo checking' feature of git. After
>> figuring out how to stop strace from helpfully saying
>> write(2, "WARNING: You called a Git program"..., 137) = 137
>> I got this (with -s 100):
>> [pid 29708] write(2, "WARNING: You called a Git program named 'git
>> config', which does not exist.\nContinuing under the assu"..., 137) =
>> 137
>> [pid 29708] write(2, "in 2.0 seconds automatically...\n"..., 32) = 32
>>
>> The output however also contains lots of git config strings, which is
>> confusing. Is tig running git config twice and failing one of the
>> times? (Running git config from the cmdline works fine).
>
> Turns out it was as simple as this:
>
> diff --git a/configure.ac b/configure.ac
> index b179389..bdea8de 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -28,7 +28,7 @@ AC_MSG_CHECKING([which config
>  GIT_CONFIG="repo-config"
>  git config --list >/dev/null && GIT_CONFIG="config"
>  AC_MSG_RESULT([$GIT_CONFIG])
> -AC_DEFINE_UNQUOTED(GIT_CONFIG,"$GIT_CONFIG",[git config subcommand])
> +AC_DEFINE_UNQUOTED(GIT_CONFIG,"$GIT_CONFIG",[config subcommand])
>
>  AC_CHECK_PROGS(ASCIIDOC, [asciidoc false])
>  AC_CHECK_PROGS(XMLTO, [xmlto false])
>
> --
> Mikael Magnusson
>



-- 
Mikael Magnusson
