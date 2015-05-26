From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] git-new-workdir: add windows compatibility
Date: Tue, 26 May 2015 18:48:55 +0200
Message-ID: <5564A3F7.8030305@gmail.com>
References: <CADBZQ5iAKsSrdvBnFcdPcm9psaJo5B-H1zqJj0aRc+xx6cCFMQ@mail.gmail.com> <xmqqfv6k7zp3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paul Smith <paul@mad-scientist.net>,
	Jeff King <peff@peff.net>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Richard Hartmann <richih@net.in.tum.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>,
	Daniel Smith <dansmith65@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 26 18:49:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxI2L-0006La-CQ
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 18:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175AbbEZQtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 12:49:01 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:35296 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951AbbEZQs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 12:48:56 -0400
Received: by wgme6 with SMTP id e6so34145269wgm.2
        for <git@vger.kernel.org>; Tue, 26 May 2015 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=lhBxB4v6sZ8zK/SduBu3HoE8vs1Ah4TQ789zH2atpdw=;
        b=A+s+7LyuAybq8MtDayWyPAQlWTq3TDno5cySf9HHnWhr2hl/FB916aPXbeRcFpylPm
         OoyixxmwIWgYbdClP5IASbNuTdt1Cj4wzau3xUm/sDty3+mFynynJetiwTotw7ogctuu
         Ts/5mNAl2NsoE0JmtyZLolzHMqDZCROlE6EHLoy8zIa3/SQmGRdMCt1JHS3tda+3VMF0
         lWK2dDDLYnGMr3ahp3Uf6WqAAx78Toic8H8LcKcojlvWq2EIZ0UHa14/1HZuN0QgmPOY
         +9AFPT2avpA9/uauxc9rluCu+fM6igueVMCAJLhcQJ4ZE4FTWzqJDU83VqcvhrE/TwUZ
         YynQ==
X-Received: by 10.180.206.45 with SMTP id ll13mr33679168wic.94.1432658935687;
        Tue, 26 May 2015 09:48:55 -0700 (PDT)
Received: from [10.1.116.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id mv11sm17720022wic.23.2015.05.26.09.48.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2015 09:48:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqqfv6k7zp3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269950>

Am 26.05.2015 um 06:03 schrieb Junio C Hamano:
> Daniel Smith <dansmith65@gmail.com> writes:
> 
>> When running on Windows in MinGW, creating symbolic links via ln always
>> failed.
>>
>> Using mklink instead of ln is the recommended method of creating links on
>> Windows:
>> http://stackoverflow.com/questions/18641864/git-bash-shell-fails-to-create-symbolic-links
>>
> 
> I'll defer to Windows folks if "mklink" is a sensible thing to use
> or not; I have no first-hand experience with Windows, but only heard
> that links are for admin user only or something like that, so I want
> to hear from people whose judgement on Windows matters I trust.
> 

mklink:
 - is not available on Windows XP
 - requires special permissions
 - does not work on network shares (unless enabled via 'fsutil behavior')
 - only works on file systems that support reparse points (e.g. NTFS, not FAT)

AFAICT, the MSys2 symlink() implementation is pretty smart to detect these conditions and fall back to deep copy (aka 'cp -a') if symlinks are not supported.

IOW, using 'ln -s' will hopefully "just work" in the upcoming Git for Windows 2, thus trying to fix it for MSys1 / Git for Windows 1.9x is probably a lost cause.

Karsten
