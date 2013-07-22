From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Cygwin has trustable filemode
Date: Sun, 21 Jul 2013 23:30:14 -0400
Message-ID: <51ECA746.7040702@gmail.com>
References: <1373818390-14451-1-git-send-email-mlevedahl@gmail.com> <1374245631-15955-1-git-send-email-mlevedahl@gmail.com> <51EAEA76.9060502@ramsay1.demon.co.uk> <7v7ggjshk7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 22 05:30:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V16pM-0000kk-PJ
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 05:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117Ab3GVDaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 23:30:18 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:63639 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754873Ab3GVDaR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 23:30:17 -0400
Received: by mail-qc0-f172.google.com with SMTP id j10so3394406qcx.31
        for <git@vger.kernel.org>; Sun, 21 Jul 2013 20:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=sQ5q36jzjlh45cE9+NPNREifimNvSn3EJrlydoxmQIo=;
        b=swjDRIftgRhln2ZXBfZj11snlyR3rsjZHim8ylBspk25+mUb7YRbx8z4Vl82gtPlAj
         7nUeFtZnFTbleDCwKhvBvNTO7SF2F0IyuGjTMrZal2ILhkngWsWqMe0Q2iXNbWJ82X/Q
         cPVn40wolerQU+n1knHKGYnb9j9EEosz9FAPzd++Y96zCZsOv6VNwqjsUwOYbSwn/usS
         J22sM7AldP18Q1xWR11cYUQvoar57pFwDb2U0s/ty90I2kH6x1V1Xw6RZLB/6LhzxjRy
         XQWaJH6HuSPYX1E45m4GLtGQQaw/2yyAiyL3fPFLUocrj+PHW6MIOQocWhj+YlQfFvBK
         /eMg==
X-Received: by 10.224.163.72 with SMTP id z8mr30385248qax.59.1374463816572;
        Sun, 21 Jul 2013 20:30:16 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id b4sm39196626qas.3.2013.07.21.20.30.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 21 Jul 2013 20:30:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <7v7ggjshk7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230957>

On 07/21/2013 05:56 PM, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>
>> Mark Levedahl wrote:
>>> The supported Cygwin distribution on supported Windows versions provides
>>> complete support for POSIX filemodes, so enable this by default.
>>> ...
>>> Historical notes: Cygwin version 1.7 supports Windows-XP and newer, thus
>>> dropped support for all OS variants that lack NTFS and/or ...
>>> ...  Thus, POSIX filemode support
>>> could not be expected by default on a Cygwin 1.5 installation, but is
>>> expected by default on a 1.7 installation.
>>>
>> Again, I have to ask; should you not "revert" commit c869753e ("Force core.filemode
>> to false on Cygwin.", 30-12-2006)?  After this commit, there is no longer any user
>> of the NO_TRUSTABLE_FILEMODE build variable, and no real prospect of anyone else
>> wanting to use it.
> Thanks for raising this point.
>
> Reading c869753e once again:
>
>      The issue is that Cygwin and NTFS correctly supports the
>      executable mode bit, and Git properly detected that, but most
>      native Windows applications tend to create files such that
>      Cygwin sees the executable bit set when it probably shouldn't
>      be.
>
> In other words, the reason why "NO_TRUSTABLE_FILEMODE" was added was
> not because the Cygwin did not give us reliable filemodes.  It was
> because tools outside the control of Git and/or Cygwin that users
> use tend to misbehave, even when the working tree is on a filesystem
> on which Cygwin can give us trustable filemodes.
>
> So "1.7 always supports core.filemodes correctly because it no
> longer works on filesystems without trustable filemodes" is not a
> valid reason to justify Mark's change.
>
> There are only three possible ways going forward, I think:
>
>   (A) Drop Mark's patch, and do nothing else, because breakages of
>       other people's programs are not fixed by Cygwin 1.7's improved
>       filesystem support, and users still use those mode breaking
>       programs written by others;
>
>   (B) Drop Mark's patch, and revert c869753e, because it is not the
>       business of our project to sweep breakages of other people's
>       tools under the rug by crippling our software; or
>
>   (C) Drop NO_TRUSTABLE_FILEMODE for _all_ versions of Cygwin,
>       declaring that the spirit of c869753e to work around bugs in
>       other people's software by crippling Git is justified, but that
>       it is no longer necessary on Cygwin because people do not use
>       such misbehaving third-party tools anymore.
>
> These three each rely on its own precondition; I suspect it is
> likely that (A)'s is the most accurate description of the real world.
>

Perhaps the simplest approach is to just defer to the judgement of the 
Cygwin project maintainers here.

a) The Cygwin project has its stated objective of being as matching Linux.
b) The Cygwin project has always shipped git binaries built without 
NO_TRUSTABLE_FILEMODE

Also - users who do not want Cygwin's assumptions / environment are now 
free to use the msysgit version and frankly they should be so encouraged 
- it is faster than Cygwin's git. This option was not available in 2006.

Mark
