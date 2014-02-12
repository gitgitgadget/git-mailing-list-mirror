From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Make the git codebase thread-safe
Date: Wed, 12 Feb 2014 20:22:13 +0100
Message-ID: <52FBC9E5.6010609@gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com> <CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com> <CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com> <CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com> <CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com> <CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stefan Zager <szager@chromium.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com, Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 20:22:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDfNz-0004vS-Aj
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 20:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099AbaBLTWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 14:22:15 -0500
Received: from mail-bk0-f50.google.com ([209.85.214.50]:64237 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753756AbaBLTWO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 14:22:14 -0500
Received: by mail-bk0-f50.google.com with SMTP id w16so2821561bkz.9
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 11:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6K3BZDtT7gYcisk7blR2ndmwRYsv4ki/krGR6eBCII8=;
        b=NZAMsS1UUBsEWYY0k91ussoi2/zpEm3c2G242WPIPj9e82X8LX3m5tp8BlZb2KqrKw
         vxowKsX3nVVByyah1+0gdyPvvBfRMc/RmvKKqks0PUnRCQvafT6Z3y63HqoQ8+0Mencq
         wXU4mjbqxYTHYXOLBbAAkmqLb93CTB7V/wASFRIBvqR7oOalPKcU+HAdbhCljem09Rjk
         nDL6foR258R1I4jgpJevR2BD/HrhkwJZ+ig16XBjkrV2RZnFHoBuW1hGZVZZ0neXcCcm
         B4uyUaFgrztWSdajxvNxsh+71C9jkt+U0mG03q54g0C7jP7xz5mMeK9hmmV0ZElEoBAQ
         +okg==
X-Received: by 10.204.167.81 with SMTP id p17mr258323bky.59.1392232933053;
        Wed, 12 Feb 2014 11:22:13 -0800 (PST)
Received: from [10.1.100.54] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id dj6sm18539786bkc.5.2014.02.12.11.22.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Feb 2014 11:22:12 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242015>

Am 12.02.2014 19:37, schrieb Erik Faye-Lund:
> On Wed, Feb 12, 2014 at 7:34 PM, Stefan Zager <szager@google.com> wrote:
>> On Wed, Feb 12, 2014 at 10:27 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>> On Wed, Feb 12, 2014 at 7:20 PM, Stefan Zager <szager@google.com> wrote:
>>>>
>>>> I don't want to steal the thunder of my coworker, who wrote the
>>>> implementation.  He plans to submit it upstream soon-ish.  It relies
>>>> on using the lpOverlapped argument to ReadFile(), with some additional
>>>> tomfoolery to make sure that the implicit position pointer for the
>>>> file descriptor doesn't get modified.
>>>
>>> Is the code available somewhere? I'm especially interested in the
>>> "additional tomfoolery to make sure that the implicit position pointer
>>> for the file descriptor doesn't get modified"-part, as this was what I
>>> ended up butting my head into when trying to do this myself.
>>
>> https://chromium-review.googlesource.com/#/c/186104/
> 
> ReOpenFile, that's fantastic. Thanks a lot!

...but should be loaded dynamically via GetProcAddress, or are we ready to drop XP support?
