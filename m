From: =?UTF-8?B?UsOpbWkgUmFtcGlu?= <remirampin@gmail.com>
Subject: Re: [PATCH 1/2] Fixes _is_git
Date: Tue, 03 Feb 2015 10:52:25 -0500
Message-ID: <54D0EEB9.1090803@gmail.com>
References: <CAMto89CHf4OT_S05SaRrVRZvF-PH2_6DrcEpdGiUfaRGutJQHw@mail.gmail.com>	<1422897883-11036-1-git-send-email-remirampin@gmail.com> <CAFOYHZBHoXC34gBu_Lx347f=-uUcVM1nHYT87SzxfeMa=KdFgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 16:52:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIfmJ-0008P0-JR
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 16:52:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966006AbbBCPwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 10:52:35 -0500
Received: from mail-qa0-f47.google.com ([209.85.216.47]:63901 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965864AbbBCPwe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 10:52:34 -0500
Received: by mail-qa0-f47.google.com with SMTP id n8so34438279qaq.6
        for <git@vger.kernel.org>; Tue, 03 Feb 2015 07:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=DuBWoSTn+O+PkSHxT80GC+j0DOeHs+Wxaf7gChU3xmY=;
        b=sU8/SY+gauzC02N8nCVRmdTH/Cfk90bgPGQfwwQnSxseWC+kwyYUUoy086DL/lPatN
         bxKF8Plt/PhewnC6S2aRV/onnl6n4x02uIJVHdsoNyjnnDr8ZvJ35G7U1T0tZtY1skoi
         m33tVYKBvxkqXE4lhLnw3KWTjeywDxwDaptMojABsDIbQmqpHS96+F05q6VJIJZZiV/M
         28twvuaiXSTlmKQ51Gdt+yZZX42107UFS1+TWh868S9ZTC+UkNArMA9JAwvEt9r4Lr8z
         R855x/B5QZQl3aIlplxLAEgXe1Z9gvOXh1P5wzkiVFu2K7Z4wCdP7d8NGUEkva4zFSFI
         whsA==
X-Received: by 10.224.7.3 with SMTP id b3mr54355874qab.71.1422978747058;
        Tue, 03 Feb 2015 07:52:27 -0800 (PST)
Received: from [128.238.102.81] ([128.238.102.81])
        by mx.google.com with ESMTPSA id n4sm21591798qac.30.2015.02.03.07.52.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Feb 2015 07:52:26 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <CAFOYHZBHoXC34gBu_Lx347f=-uUcVM1nHYT87SzxfeMa=KdFgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263321>

2015-02-02 12:24 UTC-05:00, Remi Rampin <remirampin@gmail.com>:
>>  proc _is_git {path} {
>> +       if {[file isfile $path]} {
>> +               set fp [open $path r]
>> +               gets $fp line
>> +               close $fp
>> +               if {[regexp "^gitdir: (.+)$" $line line link_target]} {

2015-02-03 3:44 UTC-05:00, Chris Packham <judge.packham@gmail.com>:
> It might be simpler to use one of the 'string' commands e.g. string
> wordend "gitdir: " I also suspect the string functions would be faster
> than regexp but that probably doesn't matter.

I want to check that the file actually begins with "gitdir: " and then
extract the path, so I'm not sure if using string functions is that
simple/fast.

>> +                       return [_is_git [file join [file dirname $path] $link_target]]

> Do we want to avoid pathological cases of infinite recursion? Someone
> would have to maliciously create such a situation.

Limiting the recursion is very simple, but I'm not sure people are
supposed to stumble on that. More importantly this probably calls for a
different error message, thus a new error result that I am not ready to
implement. But it could be another patch.
But I suppose I can add a simple "return 0" limit to the recursion if
needed, let me know.
