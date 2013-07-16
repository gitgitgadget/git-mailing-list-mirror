From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Cygwin has trustable filemode
Date: Tue, 16 Jul 2013 19:22:05 -0400
Message-ID: <51E5D59D.1010807@gmail.com>
References: <1373818390-14451-1-git-send-email-mlevedahl@gmail.com> <51E5B903.9050601@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jul 17 01:22:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzEZT-0005BT-8q
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 01:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933755Ab3GPXWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 19:22:10 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:65003 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933699Ab3GPXWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 19:22:09 -0400
Received: by mail-qc0-f181.google.com with SMTP id u12so746385qcx.12
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 16:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=X/6dIX7NbRuj2UHRGQzYSGtIcDzssyHaPcb9D35xdZE=;
        b=AMljkxv7BFkJmkNnhC11NaB2T4Vc/FvkZgahbisZ2kWnoN/O8I3Fceec2tM20KM+tZ
         W7WOJa7KMatSy+VRJzYZ2HnyA4Cj98H/zFtoRzHMvxRs9M4J7/5QZlZG3E0wG3I1cFac
         ZO6l2aIqRsuhqh3yPugGJqC6bQAkPhKvbFkOMbhkZwH1r3Ze6uPhspCDHOwFHsQcXDfx
         OshWAVHL+OR9KFS5ze8+F+zghZ3OJeYz2jRrp4yZAmvdeaSh8w2usuquIJHyUTBAJigY
         VhBnpICuB1d5t92oJyIGZzU96ZTjzwJsmjhQd+H9YuN01aVvkM6J7r7zSY0oX3LZtCj/
         m8KQ==
X-Received: by 10.224.136.193 with SMTP id s1mr6588104qat.15.1374016928283;
        Tue, 16 Jul 2013 16:22:08 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id y4sm8151192qai.5.2013.07.16.16.22.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 16:22:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <51E5B903.9050601@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230595>

On 07/16/2013 05:20 PM, Ramsay Jones wrote:
> Mark Levedahl wrote:
>> The supported Cygwin distribution on supported Windows versions provides
>> complete support for POSIX filemodes, so enable this by default. git as
>> distributed by the Cygwin project is configured this way.
>>
>> This fixes one testsuite failure:
>> t3300 test 17 (diff-index -M -p with mode change quotes funny filename)
> Huh? How is it running that test? Does cygwin 1.7 somehow allow tabs in
> filenames? For me, on cygwin 1.5, that test reports:
>
>      $ ./t3300-funny-names.sh
>      1..0 # SKIP Your filesystem does not allow tabs in filenames
>      $
Cygwin 1.7 accesses the file system in a very different way than 
1.5/earlier, so handles funny names with alacrity.
>>   
> The motivation for the original patch had more to do with "windows people"
> using win32 text editors which set the executable bit inappropriately.
> (see commit c869753e).
>
> Since I use cygwin tools (vim), I don't have this problem. :-D
This is a perfect use for the pre-commit script. I've been doing this 
for years, changing line endings and executability based upon file type. 
This could no doubt also be handled by gitattributes now as well. 
(Almost) all windows editors are perfectly happy with \n line endings, 
and none I know of care about execute permissions. I strongly believe 
that making the file line ending mode and execute status conform to 
cross-platform standards is the "right" approach rather than ignoring 
these on Windows then making others on other platforms clean up the mess 
later.

Mark
