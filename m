From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: Re: more concerns about '--git-dir'
Date: Fri, 23 May 2014 16:02:15 -0700
Message-ID: <CAKpPgvcwVuvOqAE-SvECsCfPHMJr0qBaqz9DCOXQSAZj1903jQ@mail.gmail.com>
References: <CAKpPgvf_UfgtOkotPz+aF4=UqQTOmk0O8tXg4Cm3zjzFimUoHw@mail.gmail.com>
 <xmqq1tvkjo4c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 24 01:02:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnyU4-0000Fh-Ky
	for gcvg-git-2@plane.gmane.org; Sat, 24 May 2014 01:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbaEWXCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 19:02:37 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:58116 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbaEWXCg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 19:02:36 -0400
Received: by mail-ob0-f180.google.com with SMTP id va2so5964694obc.25
        for <git@vger.kernel.org>; Fri, 23 May 2014 16:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vlyEM763/ekWPPPkELeRLY7s0RhZnX6u7aC59e74MTM=;
        b=csxNslY2jOufrM2xbn3L3Fcz0hqxyKR6ePKr4Tuc5NPCVGbXBZc4WbU0DskE7WO2kN
         PS8+JrUSnJFLqZyFlhT3fj4+B/HvkB51B+LWlAXVG1KCqjf/Pps5+fqSbFPxHsUCUNJ+
         j4CpvnY5m3x70/dXW6vSEXg8GuhcUE5YX0ipUBTvGtwhfa+nsJ16rcNms2FeGSGoNQkB
         /ZfqffayqfFSQuhbz+WOdp9IkleobQQq4lJWfUe6ryTQve2IlY00x4twA/h8VDlVUiKh
         GZ4N0Ke5okjPo9IzorlSLqOmfENM/GUwAF+sLYfATauomab6mXTcssOXTdXv7vJyeTV/
         l5hQ==
X-Received: by 10.60.146.167 with SMTP id td7mr7613349oeb.6.1400886155998;
 Fri, 23 May 2014 16:02:35 -0700 (PDT)
Received: by 10.60.16.8 with HTTP; Fri, 23 May 2014 16:02:15 -0700 (PDT)
In-Reply-To: <xmqq1tvkjo4c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250046>

>> You won't notice anything different in the output of course, but the
>> environment will be odd:
>>     GIT_DIR=../tmp/./././.git
>>     GIT_WORK_TREE=$HOME/tmp
>> Notice how the work-tree has been normalized and git-dir hasn't. It's
>> kinda hard to imagine when this can lead to an error, but never know.
>
> I think this one is in the "if it hurts, don't do it then"
> territory.
I just find it inconsistent: one variable is always straightened
("normalized"), while the other one is or is not, depending on
circumstances

>> 2) "git --git-dir=meta status" complains:
>>
>> $ git --git-dir=meta init
>> $ git --git-dir=meta status
>>
>> yells that work-tree isn't setup and denies to run.
>
> Is that because meta/config does not say where the worktree is?
>
> Again, this smells like "if it hurts, don't do it then", even more
> so than the previous one.  Does it help if you add --git-work-tree
> to the command line, too?
I agree this one is on the edge, so wasn't sure. I don't specify
worktree at all, anywhere. And expect Git to guess it to be the
current directory. It does so only if GIT_DIR, whatever it is, ends
with "/.git". What's the logic? When the reader skims through the "man
git-config" page, they'll think that work-tree defaults to "." if no
value was provided. But it's only true if "core.bare" is set to false
