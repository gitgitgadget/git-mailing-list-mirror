From: Bryan Turner <bturner@atlassian.com>
Subject: Re: git status / git diff -C not detecting file copy
Date: Sun, 30 Nov 2014 12:03:35 +1100
Message-ID: <CAGyf7-E_y8zRUKh5RWvAhPXzSgpnVab6e=e1v92rSVVxf+LNJg@mail.gmail.com>
References: <CAJxwDJzzNV77cTP4nbzgCvFjjqp3C4X8d3j6uwhYvK4+g4r1YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Pol Online <info@pol-online.net>
X-From: git-owner@vger.kernel.org Sun Nov 30 02:03:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XusvU-0003iV-Mc
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 02:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbaK3BDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2014 20:03:38 -0500
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:35132 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751804AbaK3BDh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Nov 2014 20:03:37 -0500
Received: from mail-oi0-f51.google.com ([209.85.218.51]) (using TLSv1) by na3sys009aob105.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVHps6PZkzqx/UQfRZ3DJpiD8kovtSEj7@postini.com; Sat, 29 Nov 2014 17:03:37 PST
Received: by mail-oi0-f51.google.com with SMTP id e131so6018976oig.38
        for <git@vger.kernel.org>; Sat, 29 Nov 2014 17:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Qg4OXO1esQhFrEADAxlIoxSc2yqxgg7L/j4EtBA6A6o=;
        b=jWl41x7qc3FDXsQCimwpQxFgOCAjclmLPzBFg/6hnapH6C4nKpWzByMJuHVnwpIaat
         qAj3lU7us6VmkmKqNXrYVCjsP0juxY2JXW4RxhZHE0Q4Be07pOy5DdPzzqol2e2TKKYv
         jM1RCiplvvHsaV3CGZ9ATzO7eEovQfKh5H+juu8bHo2vXBwMEhFyB5R8FfJAumdsurUD
         myMZgioERrgcEsPjCN9ijr+K1a9URkHoU+k+cPmOT5TRcTgWRTHJrE2B/a04n9owRfUJ
         54dI1/Tp/+1KnkwF22XRNHHIPPkMkuTGwbCKrGXjG8aM1Khy5dMRi9OVorToJE86vSmK
         nuBw==
X-Gm-Message-State: ALoCoQng9JMTTGqsMvW7jgu/3lIt2MeDs3Jlt4NuXAiZqa8hcfjMwefzP/uYmkOL7UTsNTp4RI3rRV4XkLq8+HJiGofrgQGdNLGvC7n4+lBkwoNhzoeX+kRpFL8bKvcHt7cZS3Wd9YsBbWEMbcY3iULWrv3Nd2gExQ==
X-Received: by 10.202.204.208 with SMTP id c199mr30467838oig.42.1417309415768;
        Sat, 29 Nov 2014 17:03:35 -0800 (PST)
X-Received: by 10.202.204.208 with SMTP id c199mr30467828oig.42.1417309415616;
 Sat, 29 Nov 2014 17:03:35 -0800 (PST)
Received: by 10.182.245.170 with HTTP; Sat, 29 Nov 2014 17:03:35 -0800 (PST)
In-Reply-To: <CAJxwDJzzNV77cTP4nbzgCvFjjqp3C4X8d3j6uwhYvK4+g4r1YQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260382>

Pol,

By default, -C only finds copies when the source file was also
modified in the same commit. Since you did not modify hello.txt in the
same commit where you copied it to copied.txt, it will not be
considered.

If you pass -C -C (twice), or use --find-copies-harder, Git will
consider all files in the repository. Note that this can be slower,
which is the reason why it's not the default.

The documentation for git diff describes the -C (--find-copies) and
--find-copies-harder flags and their limitations.

Hope this helps,
Bryan Turner

On Sun, Nov 30, 2014 at 11:35 AM, Pol Online <info@pol-online.net> wrote:
> Hi,
>
> The documentation for git status at http://git-scm.com/docs/git-status
> implies that it should be able to detect both renames and copies (with
> the R and C states). The command git diff -C should do it as well.
>
> However I can't get either to detect copies in this simple test case -
> what is happening?
>
>
> mkdir test
> cd test/
> git init
> echo 'Hello World!' > hello.txt
> echo 'Goodbye World!' > goodbye.txt
> git add -A
> git commit -m "Initial commit"
>
> cp hello.txt copied.txt
> mv goodbye.txt moved.txt
> git add -A
>
> $ git status --short
> A  copied.txt  <------------ NO COPY DETECTED
> R  goodbye.txt -> moved.txt
>
> $ git diff -M -C --summary --cached
>  create mode 100644 copied.txt  <------------ NO COPY DETECTED
>  rename goodbye.txt => moved.txt (100%)
>
> $ git commit -m Test
> $ git diff -M -C --summary HEAD~
>   create mode 100644 copied.txt  <------------ NO COPY DETECTED
>   rename goodbye.txt => moved.txt (100%)
>
>
> -Pol
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
