From: Bryan Turner <bturner@atlassian.com>
Subject: Re: git status / git diff -C not detecting file copy
Date: Sun, 30 Nov 2014 12:54:53 +1100
Message-ID: <CAGyf7-F9twCEUY-LN=xEf4=gfNW8oLEHJmTjHRQ2MncHZ2emZQ@mail.gmail.com>
References: <CAJxwDJzzNV77cTP4nbzgCvFjjqp3C4X8d3j6uwhYvK4+g4r1YQ@mail.gmail.com>
	<CAGyf7-E_y8zRUKh5RWvAhPXzSgpnVab6e=e1v92rSVVxf+LNJg@mail.gmail.com>
	<CAJxwDJzxUEd3czHpwDtKaERKDhvyCGOzGbKO4X9z44ugTJ2q4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Pol Online <info@pol-online.net>
X-From: git-owner@vger.kernel.org Sun Nov 30 03:06:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XutuQ-0005xq-JF
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 03:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbaK3Byy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2014 20:54:54 -0500
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:35303 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751717AbaK3Byy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Nov 2014 20:54:54 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]) (using TLSv1) by na3sys009aob114.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVHp47dO72gs9oQCbYWIZG58OHW9XCQeD@postini.com; Sat, 29 Nov 2014 17:54:53 PST
Received: by mail-ob0-f177.google.com with SMTP id va2so6291379obc.36
        for <git@vger.kernel.org>; Sat, 29 Nov 2014 17:54:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=3qqib+CjzmsQ6LCPYOqsBAuantSg4obVqskYv5sQ3k4=;
        b=cvKi+y+/duEj5Q+7zDEsl58rJ39TzECKSMwNq2tNCADdmGdryY1omzs/1lwszeZfvM
         gBvf3m+NKwkD/GLH8kUux/p7Mn87lRcCugzc7wUGOn/jGnCA6jskBXCIYyelVNDchjig
         0qzrFje4P3ymjidC7wCzBa/NjMzBjkpQqIxlGZu8jgMf6+N+HhcENDQojDVWbqo0QXwT
         MW9bUbA6fZoM/OmyHieFTUdwCgwlPpbgVPgl4/87d4URy9Gkr52qY2//4QIOJ+1JwfTw
         a+ziiulWzbG+t8HHyoR5JliHnMxP6gEWsG8KCYETr4699CrBUayVMeW2qlec3QBVXLxB
         fWKg==
X-Gm-Message-State: ALoCoQnBavwKdJ3Qv2H6gc3Iigf0GIIPENKTF3kKE2tdXDN45gMXQ0nxs3ae0xVGc4Im9+LfXEBbjRGIclW/O/3PyCrSiSZfHKXFRTvxpvozkBU/pP1+qLSNES8ku7+ohXBCEvV/dBhjpzizXhlLfLceGl2+ZamB+Q==
X-Received: by 10.182.50.168 with SMTP id d8mr31835028obo.2.1417312493206;
        Sat, 29 Nov 2014 17:54:53 -0800 (PST)
X-Received: by 10.182.50.168 with SMTP id d8mr31835023obo.2.1417312493061;
 Sat, 29 Nov 2014 17:54:53 -0800 (PST)
Received: by 10.182.245.170 with HTTP; Sat, 29 Nov 2014 17:54:53 -0800 (PST)
In-Reply-To: <CAJxwDJzxUEd3czHpwDtKaERKDhvyCGOzGbKO4X9z44ugTJ2q4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260384>

Pol,

It's the same set of limitations. Git does not track renames or copies
as such. It uses heuristics to compute a similarity index and then
decide. All the tree stores for your copy is a file add, and that's
the status you're seeing. I don't think there is any way to turn on
aggressive copy detection for git status. However, before you run git
commit, you could run git diff --find-copies-harder --cached instead
and it should show the copy.

I'll let someone a little more intimately familiar with the internals
of git status comment on why the documentation for that mentions
copies.

Hope this helps,
Bryan Turner

On Sun, Nov 30, 2014 at 12:30 PM, Pol Online <info@pol-online.net> wrote:
> Hi Bryan,
>
> OK that explains the behavior of git diff, but what about git status?
> The doc implies it should be able to detect copies in the index /
> staging area since it has a "C" state.
>
> - Pol
>
> On Sun, Nov 30, 2014 at 10:03 AM, Bryan Turner <bturner@atlassian.com> wrote:
>> Pol,
>>
>> By default, -C only finds copies when the source file was also
>> modified in the same commit. Since you did not modify hello.txt in the
>> same commit where you copied it to copied.txt, it will not be
>> considered.
>>
>> If you pass -C -C (twice), or use --find-copies-harder, Git will
>> consider all files in the repository. Note that this can be slower,
>> which is the reason why it's not the default.
>>
>> The documentation for git diff describes the -C (--find-copies) and
>> --find-copies-harder flags and their limitations.
>>
>> Hope this helps,
>> Bryan Turner
>>
>> On Sun, Nov 30, 2014 at 11:35 AM, Pol Online <info@pol-online.net> wrote:
>>> Hi,
>>>
>>> The documentation for git status at http://git-scm.com/docs/git-status
>>> implies that it should be able to detect both renames and copies (with
>>> the R and C states). The command git diff -C should do it as well.
>>>
>>> However I can't get either to detect copies in this simple test case -
>>> what is happening?
>>>
>>>
>>> mkdir test
>>> cd test/
>>> git init
>>> echo 'Hello World!' > hello.txt
>>> echo 'Goodbye World!' > goodbye.txt
>>> git add -A
>>> git commit -m "Initial commit"
>>>
>>> cp hello.txt copied.txt
>>> mv goodbye.txt moved.txt
>>> git add -A
>>>
>>> $ git status --short
>>> A  copied.txt  <------------ NO COPY DETECTED
>>> R  goodbye.txt -> moved.txt
>>>
>>> $ git diff -M -C --summary --cached
>>>  create mode 100644 copied.txt  <------------ NO COPY DETECTED
>>>  rename goodbye.txt => moved.txt (100%)
>>>
>>> $ git commit -m Test
>>> $ git diff -M -C --summary HEAD~
>>>   create mode 100644 copied.txt  <------------ NO COPY DETECTED
>>>   rename goodbye.txt => moved.txt (100%)
>>>
>>>
>>> -Pol
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
