From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: rebase: strange failures to apply patc 3-way
Date: Sat, 09 Mar 2013 13:32:23 -0500
Message-ID: <513B8037.7060107@gmail.com>
References: <7A483B92-D671-46CA-9EFD-83C6F4C97B5E@quendi.de> <494292C5-EBD9-487B-8846-9D9DD23ACB83@quendi.de> <CADeaMWp_R0HLwEYn7O3oX4-0OoSeqLfzz_2AYXT-Po88nM4HkQ@mail.gmail.com> <205D17C4-F737-46E9-BC48-D16D5948C707@quendi.de> <CADgNjan9v++__TSPE55j7+=BBZrVEkMD52O+9kXAm-C8SRV+Ww@mail.gmail.com> <B21B6CEC-7507-47A1-9BBB-FB95EA6B831F@quendi.de> <CADgNja=Ej8jnYn027GX986VrmuqVemM7aE59rynHzUpToPVaEw@mail.gmail.com> <3B5EA38E-9603-4321-AA3C-74354BBC8BFC@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Sat Mar 09 19:37:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEOeW-0002Ql-7u
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 19:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804Ab3CIShJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 13:37:09 -0500
Received: from mail-ia0-f177.google.com ([209.85.210.177]:57625 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737Ab3CIShI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 13:37:08 -0500
Received: by mail-ia0-f177.google.com with SMTP id y25so2370518iay.8
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 10:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=CMwmF8m2eQbu0NKFv1tXFHVAFw+5drP7PIQ8cpD9ZkY=;
        b=OW7Bx+AAXZl2FEZP7N2YAToLSKoZs6vEeHFTDGhO/m5CYggFUSK7LrMjBUxLLTbRnk
         xMOzEdtdjuNkgh+RQ8Pbp4YZ6YyYRZt9XbLnJzMPTXhSMMNHCHEXRWTbGrBTNiFRZWrs
         VTXr9e0uKEPzcqPydmqneAGWjrLpAZoVHP7yQJ1Ia3TaC0qLUImqK1Lje3AANuCsCt7z
         vlxvHkQl5dhT0hcRpU5iY+4SavdUbYtXjMgYt1P7zi7OizHGWLA1gAFuydN8LgzPLPlA
         o1NUH4YP8lxLCRXW6LwQlVzJeiMKRF++WZvXwT5dXNnzvfxcj52X7AliMDbV/u0/fr0X
         NgYA==
X-Received: by 10.50.192.165 with SMTP id hh5mr3039525igc.89.1362854227546;
        Sat, 09 Mar 2013 10:37:07 -0800 (PST)
Received: from [192.168.1.4] ([69.165.234.69])
        by mx.google.com with ESMTPS id ew5sm5245631igc.2.2013.03.09.10.37.05
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 10:37:06 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.11) Gecko/20121202 Thunderbird/10.0.11
In-Reply-To: <3B5EA38E-9603-4321-AA3C-74354BBC8BFC@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217734>

On 03/09/13 06:26, Max Horn wrote:
> It tends to fail in separate places, but eventually "stabilizes". E.g. I just did a couple test rebases, and it failed twice in commit 14, then the third time in commit 15 (which underlines once more that the failures are inappropriate).
>
> The fourth time, something new and weird happened:
>
> $ git rebase --abort
> $ git rebase NEW-PARENT 
> Cannot rebase: You have unstaged changes.
> Please commit or stash them.
> $
>
> This is quite suspicious. It appears that git for some reason things a file is dirty when it isn't. That could explain the other rebase failures too, couldn't it? But what might cause such a thing?
Yea, that's really suspicious. This could mean there's an issue with
when git is checking the index. Try running these a couple times in a
clean work tree:
    $ git update-index --refresh
    $ git diff-files

In a clean work tree, these commands should print nothing. But in your
case, these might print random files that git thinks have been modified...

If the commands do print out some files, check the timestamp from the
git index and the filesystem:
    $ git ls-files --debug file1 file2
    $ stat -f "%N %m %c" file1 file2

Is this repo on a network drive? Or is it local drive in your Mac?
