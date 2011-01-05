From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [BUG?] "git submodule foreach" when command is ssh
Date: Thu, 6 Jan 2011 11:50:58 +1300
Message-ID: <AANLkTini=GaGSHDX4e1jhPVxKaSayUJoWa=w4u4Rz-+5@mail.gmail.com>
References: <AANLkTi=x2i6NvDNRzbszhk-a-z5AYe46-iUBxQsxJJHC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 05 23:51:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PacC9-00062s-I7
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 23:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474Ab1AEWvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 17:51:00 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61849 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab1AEWu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 17:50:59 -0500
Received: by fxm20 with SMTP id 20so15534417fxm.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 14:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=80yGOHIOiPuBIZSR06/u/0ywo7eXxonbtHkzlYnDd9c=;
        b=u0dy93O+HK/frEkr1v2+DpYifutRRpJPLfbXRe91ZdEmNCJsaezvTYXd4ag5un4pNZ
         hccEAWyeqkUgxUIuBJ/BvTO9gfveJxfqbgqU2cv4RZNtobkrMSnkW6CkOqzqKK6GuT4m
         YOBwINip5kjgd5PefRpZlLBsFSFlmmjbqYVII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=kiVzADf7FEoXzP0VFdfWRZFlXy+oasRw5MUeMiZlYV6hQpjzwj+cIhcKO7jQWHcZ3A
         WTUSSz5tRO/W005K2Bw+l6o1+vSVzycdxdiHBwnFl3W8G5xItFGxBgVnZe9giLb/DgQc
         zmrZEYZf+jKpjkLcv39YoYERoHHHUoH3rpd7A=
Received: by 10.223.83.8 with SMTP id d8mr301605fal.94.1294267858163; Wed, 05
 Jan 2011 14:50:58 -0800 (PST)
Received: by 10.223.73.205 with HTTP; Wed, 5 Jan 2011 14:50:58 -0800 (PST)
In-Reply-To: <AANLkTi=x2i6NvDNRzbszhk-a-z5AYe46-iUBxQsxJJHC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164603>

On Thu, Jan 6, 2011 at 11:32 AM, Chris Packham <judge.packham@gmail.com> wrote:
> Hi All,
>
> I just noticed something odd with "git submodule foreach". I was
> running a script to create a backup of each submodule on a server I
> have ssh access to. I was surprised to find that git submodule foreach
> stopped silently after the first submodule.
>
> A little debugging and I find that
>
> git submodule foreach 'ssh localhost "ls /"' - stops silently after
> the first module (note that the command does produce the expected
> listing and there is no error about the command failing).
>
> git submodule foreach 'echo foo' - works as expected
>
> Any thoughts as to whats going on?
>
> ---
> git version 1.7.3.2
>

Actually this might be a ssh/bash bug (feature?). There is different
behaviour between

  find . -maxdepth 1 -type d -a ! -name '\.*' | while read; do echo
$REPLY && ssh localhost ls /; done

and

  find . -maxdepth 1 -type d -a ! -name '\.*' | while read; do echo
$REPLY && ls /; done
