From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: looking for suggestions for managing a tree of server configs
Date: Sun, 21 Oct 2012 07:58:52 -0400
Message-ID: <CAM9Z-n=VGM4cjrZxMz=n5LwDsvuG6uwXymh4J3Gjq4mYJoGPcg@mail.gmail.com>
References: <alpine.DEB.2.02.1210131413240.6253@asgard.lang.hm>
	<7vpq4l1x86.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.2.02.1210132153040.6253@asgard.lang.hm>
	<CAM9Z-nmHxyqnyq1fChhv7hP_awgsaO2FT1t29PAwrvZkaA-hgg@mail.gmail.com>
	<alpine.DEB.2.02.1210201931130.31862@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Oct 21 13:59:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPuBP-0000A6-3g
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 13:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233Ab2JUL6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 07:58:55 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58940 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab2JUL6y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 07:58:54 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so688069bkc.19
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 04:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fbgYDPqeW4RSGCyUQea+0fpqVDsMqJ3GHB6Gq3GznUw=;
        b=J9w+xmh6KOyVpFMc7555AflBzsFSLbStKhHAr56l482Ko+l0XAaQWqS8aA9MkHF38Z
         lM5ymx0c/iUh6RsxcHVjd82FMrEIuhJq24uScEkdwEz6sbtOP3yO5+Bn4cdyQ4xF+dpv
         jm+ZGIu097P/LldTt0qbzr8u9B772YMitycZ7RVKGDBz0a0VoGUlG+9OGhiz7VMMKXi9
         wVj4+vmG7dU+XIFKluNWQNEZ2eDIXjeBKIDPr2lFhMR/rHe5exPV9vAExno2O8O4J/Ro
         HGmAEQYrF8474aPEL+3paAxk7rYA32qF/YExWYaZlQu8C/rCqJ1MYGGxOaXwrrAdVA3h
         Q/uQ==
Received: by 10.205.128.148 with SMTP id he20mr1799775bkc.99.1350820732708;
 Sun, 21 Oct 2012 04:58:52 -0700 (PDT)
Received: by 10.205.122.144 with HTTP; Sun, 21 Oct 2012 04:58:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1210201931130.31862@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208121>

On Sat, Oct 20, 2012 at 10:34 PM,  <david@lang.hm> wrote:
> On Sat, 20 Oct 2012, Drew Northup wrote:
>> On Sun, Oct 14, 2012 at 12:57 AM,  <david@lang.hm> wrote:
>>> On Sat, 13 Oct 2012, Junio C Hamano wrote:
>>>> david@lang.hm writes:
>>>>>
>>>>> today I have just a single git tree covering everything, and I make a
>>>>> commit each time one of the per-server directories is updated, and
>>>>> again when the top-level stuff is created.
>>>>
>>>> if a large portion of the configuration for these servers are
>>>> shared, it might not be a bad idea to have a canonical "gold-master"
>>>> configuration branch, to which the shared updates are applied, with
>>>> a branch per server that forks from that canonical branch to keep
>>>> the machine specific tweaks
>>>
>>> In an ideal world yes, but right now these machines are updated by many
>>> different tools (unforuntantly including 'vi'), so
>>> these directories aren't the config to be pushed out to the boxes, it's
>>> instead an archived 'what is', the result of changes from all the tools.

So you need to save what is there before pulling changes from the
master. That's no different from doing development work on an active
code base.

>> David,
>> Is there any particular reason you aren't using etckeeper?
>>
> not really, I've thought of that as a tool for managing a single system.
> Some of the data in configs is sensitive (and much of it is not in /etc),
> but I guess I should be able to work around those issues.

.gitignore and symlinks have been employed at times to deal with that.

> How can I sanely organize all these different, but similar sets of files on
> the central server?

The reason I asked about etckeeper is that you could, with proper
security in place, push those up to branches in a shared repository
(set up using gitolite, for instance) and not loose information about
the files in the process. This would allow you to make your changes on
one system using vi or whatever else is convenient, push the change up
to the shared repo, cherry-pick it into the other branches (using a
full check-out of all of the branches someplace safe as a workspace),
and pull that change out to the other systems.

If you are just looking to gather configuration information in the
large and don't want to engage in any shared management schemes (which
may involve symlinks in seemingly odd places to /etc and such) you may
wish to look at the System Configuration Collector [1] [2] which is a
nicely organized tool designed specifically to gather just the
important (and not highly confidential) information about common
software on a server and present it (and changes to it) to the admin
in a sensible manner. It is outside of the "Git Universe" but it does
what it sounds like you are doing now (if not what you wish to be
doing).

(1) http://www.qnh.eu/scc/
(2) http://sourceforge.net/projects/sysconfcollect/

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
