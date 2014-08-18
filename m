From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Location of git config on Windows
Date: Mon, 18 Aug 2014 17:25:20 +0200
Message-ID: <CABPQNSZ=BKqNPCWUmaCSz+gJtBRhjkWtpcDbirsV+KJX=c0kpg@mail.gmail.com>
References: <ygfvbpqooog.fsf@corbe.net> <CABPQNSZDizccths0b_RZ5FXYYq=+4_2N35DMj9h4Rha_2voekw@mail.gmail.com>
 <53F135F8.60508@gmail.com> <ygflhqlvni7.fsf@corbe.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Daniel Corbe <corbe@corbe.net>
X-From: git-owner@vger.kernel.org Mon Aug 18 17:26:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJOow-00079V-R1
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 17:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbaHRP0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 11:26:03 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:39692 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbaHRP0B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 11:26:01 -0400
Received: by mail-ig0-f172.google.com with SMTP id h15so8430569igd.5
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=GOB1mAbfBQc8ONO4ANFjagy5qxq2pAQxpuiUVRrDf9k=;
        b=IQ/zV9kcuONYlBxyctqxeY0+74r4Dkxa7PW8C7palvMuGRXBH3xjo2BLGaak/ZfEbA
         kib8CzSJ3eofjITo+NWAEEn06VYL9p6F1oQxmKR86qMWqHKL8KYfpyVGfKp7PwuJcLns
         HXHQz5QNaDXRplvmPMs0cNj9WaZeWujDiox7LDV2TznYzVkgmCYqAq+tmIDdfPRTzcPq
         nHwlItf1Omv7Jd3DOOZS7UgQlOWIDWlGJEhgIBBUmnXnxeZDHTlkXrG+uwRlxKwEFBrQ
         SxMdVev/RP6yrfeDncFXOO/SYlE5mQ0+ctIgUG1yc+HOe8QmCiLXMYH9EI4LxhUUZudJ
         sQNg==
X-Received: by 10.50.33.73 with SMTP id p9mr83557483igi.24.1408375560660; Mon,
 18 Aug 2014 08:26:00 -0700 (PDT)
Received: by 10.64.123.5 with HTTP; Mon, 18 Aug 2014 08:25:20 -0700 (PDT)
In-Reply-To: <ygflhqlvni7.fsf@corbe.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255390>

On Mon, Aug 18, 2014 at 5:14 PM, Daniel Corbe <corbe@corbe.net> wrote:
>
> Karsten Blees <karsten.blees@gmail.com> writes:
>
>> Am 18.08.2014 00:01, schrieb Erik Faye-Lund:
>>> On Sun, Aug 17, 2014 at 10:18 PM, Daniel Corbe <corbe@corbe.net> wrote:
>>>>
>>>> I installed git on my Windows machine while it was connected to my
>>>> corporate network.  It picked up on that fact and used a mapped drive to
>>>> store its configuration file.
>>>>
>>>> As a result, I cannot currently use git when disconnected from my
>>>> network.  It throws the following error message: fatal: unable to access
>>>> 'Z:\/.config/git/config': Invalid argument
>>>>
>>>> Obviously this value is stored in the registry somewhere because I made
>>>> an attempt to uninstall and reinstall git with the same results.
>>>>
>>>> Can someone give me some guidance here?
>>>
>>> Git looks for the per-user configuration in $HOME/.gitconfig, and if
>>> $HOME is not set, it falls back to $HOMEDIR/$HOMEPATH/.gitconfig. My
>>> guess would be some of these environment variables are incorrectly set
>>> on your system.
>>
>> To be precise, git checks if %HOME% is set _and_ the directory exists before
>> falling back to %HOMEDRIVE%%HOMEPATH%.
>>
>> If %HOMEDRIVE%%HOMEPATH% isn't set or the directory doesn't exist either, it
>> falls back to %USERPROFILE%, which is always local (C:/Users/<yourname>), even
>> if disconnected from the network (at least that's how its supposed to be).
>>
>>
>
> Awesome!  Thanks for the advice.
>
> %HOMEDRIVE% and %HOMEPATH% are indeed set by my system and point to an
>  (often disconnected) network drive.  I manually forced %HOME% to
>  %USERPROFILE% and it works like a charm now.
>
> I would argue that on Windows %USERPROFILE% should be checked first (or
> at least after %HOME%).

Why? Then people won't be able to have their config files on network-shares, no?

I think a somewhat better approach would be to resolve the home
directory lazily, unless %HOME% is set. That way we can check that
%HOMEDRIVE%%HOMEPATH% actually exists as it's being accessed. Or you
could just restart your shell when you disconnect...
