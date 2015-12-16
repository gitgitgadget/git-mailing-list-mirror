From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] Introduce grep threads param
Date: Tue, 15 Dec 2015 19:26:46 -0500
Message-ID: <CAPig+cRTz=DMd6XyJ=co26d2c=PgVqhhsWQpgy53930MdC_=Rw@mail.gmail.com>
References: <1450193500-22468-1-git-send-email-vleschuk@accesssoftek.com>
	<1450193500-22468-2-git-send-email-vleschuk@accesssoftek.com>
	<xmqq60zzfpdz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Victor Leschuk <vleschuk@gmail.com>,
	Git List <git@vger.kernel.org>,
	Victor Leschuk <vleschuk@accesssoftek.com>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 01:26:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8zvh-00088R-Az
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 01:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549AbbLPA0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 19:26:48 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:33764 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750AbbLPA0r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 19:26:47 -0500
Received: by mail-vk0-f48.google.com with SMTP id a188so16876259vkc.0
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 16:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=u1U33470xli61xA4a5nJNSjzGjQw2hR1laO0EeFvLFk=;
        b=xb8xoszvMlWkAB3wl5p0Gu/vriz4yY4qS8W7gVZjb4I/vO4NroMeCZgkb24kHj2QXs
         cYh7/vRXU4hy/UIE+Z8HLxynfFCwsofO0GgZ2sNS+Yir1M1khDpviLVwb7y67+xLGf8/
         sscvMmCfDZdpJuFmCAf4Gubgxd7x+0lw+zhPh5Zg6dJ1Sneu6ofan59sHBGcrKoNWITR
         4iRGAivu1krVaK3KyOpiYvMHdfgCeTkIqPPBSws0t0srTnVXkSvP9e/v3UHUoD3F4jK2
         fzqBkte2K5/5qu2oizRqb+ucue2jvxdik5jDZZyXb2XO1349OkrMM3VYLhtmJNWYFJ5m
         EL4g==
X-Received: by 10.31.58.74 with SMTP id h71mr31332443vka.151.1450225606826;
 Tue, 15 Dec 2015 16:26:46 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Tue, 15 Dec 2015 16:26:46 -0800 (PST)
In-Reply-To: <xmqq60zzfpdz.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: 5Cdx_5WjqSEkIpIZHsr9XPM-lMo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282523>

On Tue, Dec 15, 2015 at 3:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Victor Leschuk <vleschuk@gmail.com> writes:
>> Subject: Re: [PATCH 1/2] Introduce grep threads param
>
> I'll retitle this to something like
>
>     grep: add --threads=<num> option and grep.threads configuration
>
> while queuing (which I did for v7 earlier).
>
> I think [2/2] and also moving the code to disable threading when
> show-in-pager mode should be separate "preparatory clean-up" patches
> before this main patch.  I'll push out what I think this topic
> should be on 'pu' later today (with fixups suggested above squashed
> in); please check them and see what you think.

I read over what was pushed to 'pu' and noticed a couple problems.

First, the 'online_cpus() == 1' check, which was removed in patch 1/3,
accidentally creeps back in with patch 3/3.

>> +grep.threads::
>> +     Number of grep worker threads, use it to tune up performance on
>> +     your machines. Leave it unset (or set to 0) for default behavior,
>> +     which is using 8 threads for all systems.
>> +     Default behavior may change in future versions
>> +     to better suit hardware and circumstances.
>
> The last sentence is too noisy.  Perhaps drop it and phrase it like
> this instead?
>
>     grep.threads::
>             Number of grep worker threads to use.  If unset (or set to 0),
>             to 0), 8 threads are used by default (for now).

Second, the stray "to 0)," on the second line needs to be dropped.

Other than that, the series looks reasonable.
