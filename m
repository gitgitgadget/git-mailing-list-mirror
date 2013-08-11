From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 1/2] submodule: fix confusing variable name
Date: Sun, 11 Aug 2013 15:53:54 -0400
Message-ID: <5207EBD2.6050802@gmail.com>
References: <1375550060-5406-1-git-send-email-sandals@crustytoothpaste.net> <1375550060-5406-2-git-send-email-sandals@crustytoothpaste.net> <20130803181415.GF2893@elie.Belkin> <51FE90B8.8030203@web.de> <20130804212938.GL19369@paksenarrion.iveqy.com> <5203D8F6.2020102@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, judge.packham@gmail.com,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, gitster@pobox.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Aug 11 21:54:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8biJ-0007Dp-Tb
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 21:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874Ab3HKTyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Aug 2013 15:54:00 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:50877 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806Ab3HKTx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Aug 2013 15:53:59 -0400
Received: by mail-qa0-f53.google.com with SMTP id hu14so688958qab.12
        for <git@vger.kernel.org>; Sun, 11 Aug 2013 12:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=rmx0om5wz4SRr2era/Ig3qhzgG31twRH9a3pln37dIY=;
        b=T8xWAHmnXhwJyo3CJhj2KfSpmKmTxZq4zqry9IQRAVCKpv4oW3gkSdxu9OL2egZGzr
         3UTFJa0uBc9UQja/oJGhU79/Q33unv+mb6jH50DtdaWGLp3Dzb0Oep6c/L07d5jxK3XQ
         zj0Co5dQ6vQBX7y6n8a9EGLnZC9a6+Rj1vX4k1zNfVRMVLQBAWElwYDr4JaGnHem1+iw
         AssD0KlY12qbRiWU44vHlMfYOeUZ+07pFnRkGi7zqXk5tKpivgOZNyyApNvmGeayOi+T
         L1a7Ohjx4gk+R6+Xj0r63sqZrGORyclHw0LbXBybfFtMvsYtn+tbmx+RhrYe4NB816oL
         2+KA==
X-Received: by 10.224.24.134 with SMTP id v6mr21172096qab.58.1376250837944;
        Sun, 11 Aug 2013 12:53:57 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id e8sm33525274qai.1.2013.08.11.12.53.56
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 11 Aug 2013 12:53:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <5203D8F6.2020102@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232139>

On 08/08/2013 01:44 PM, Ramsay Jones wrote:
> Fredrik Gustafsson wrote:
>> On Sun, Aug 04, 2013 at 07:34:48PM +0200, Jens Lehmann wrote:
>>> But we'll have to use sm_path here (like everywhere else in the
>>> submodule script), because we'll run into problems under Windows
>>> otherwise (see 64394e3ae9 for details). Apart from that the patch
>>> is fine.
>>
>> We're still using path= in the foreach-script. Or rather, we're setting
>> it. From what I can see and from the commit message 64394e3ae9 it could
>> possible be a problem.
>
> Please do not use a $path variable in any script intended to be run on
> windows; those poor souls who would otherwise have to fix the bugs will
> thank you! :-D
>
> Actually, it's not so much the use of a $path variable, rather the act
> of _exporting_ such a variable that causes the problem. (Which is why
> using $path with eval_gettext[ln] is such a problem, of course.)
>

Please note that especially in this case, Cygwin != Windows. Cygwin 
allows $path, $Path, $PATH, etc., to all coexist and be accessed case 
sensitively. Exporting $path causes no problem, either. Should the eval 
invoke a Windows program, $PATH is converted to Windows format and 
exported, the other case-sensitive variants of path remain in the 
environment and can be accessed by any program implementing 
case-sensitive lookup as well. Not sure what will happen with 
case-insensitive lookups, but a quick test showed that cmd.exe is not 
bothered by $path given $PATH exists.

Mark
