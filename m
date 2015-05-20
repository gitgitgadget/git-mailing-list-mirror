From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/2] mergetools: add winmerge as a builtin tool
Date: Wed, 20 May 2015 14:00:11 -0700
Message-ID: <xmqq8ucjm0bo.fsf@gitster.dls.corp.google.com>
References: <1432112843-973-1-git-send-email-davvid@gmail.com>
	<1432112843-973-2-git-send-email-davvid@gmail.com>
	<xmqqtwv7m2hw.fsf@gitster.dls.corp.google.com>
	<CAHGBnuPyhG4y5ooR7KH0KrEhRYFu9BB+HKnnn+XhU5xL2TnL=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Aguilar <davvid@gmail.com>, Phil Susi <phillsusi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= <szeder@ira.uka.de>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 23:00:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvB6j-0005gv-Ke
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 23:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498AbbETVAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 17:00:20 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33946 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755425AbbETVAO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 17:00:14 -0400
Received: by igbhj9 with SMTP id hj9so72453722igb.1
        for <git@vger.kernel.org>; Wed, 20 May 2015 14:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4PwyNbY5a+31Kl+leJ+fxPbfC1wtiNspYeNw4y/y+Ac=;
        b=Wd8QbegCkwJscLfGU1phRGL8IS+FFJD+Y+OfvmqoTdfp4rjRbnupicoqGPHQSBeA6h
         HoWpzGDq/ZQ/4ofLDrJq2k1QVZmdUTfPChieyvjxZacA3FDnRNButEg0X3jhIEhmqKCj
         ej6hfAAIs1qOGp5scGeI1NRzgSTnJ5HcgXMuJPtcWcwjVT6JOhK0p6E9XAqk39XYs1XE
         eZ/3wwRzgMQsMibvcq1LBsv4rCc8RGsGdA8GX7LMQrMhjZi3vt+Eb3sya8YJ02aVw4ai
         lYpSpjzGgXlrib5VP1Vm/t9qZcl72/zHMhhaA8qcp+Gm9/n6VrUie6+Jhds431bGWx8r
         6ozQ==
X-Received: by 10.43.0.67 with SMTP id nl3mr3832879icb.59.1432155614321;
        Wed, 20 May 2015 14:00:14 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id j194sm13214343ioe.7.2015.05.20.14.00.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 14:00:12 -0700 (PDT)
In-Reply-To: <CAHGBnuPyhG4y5ooR7KH0KrEhRYFu9BB+HKnnn+XhU5xL2TnL=w@mail.gmail.com>
	(Sebastian Schuberth's message of "Wed, 20 May 2015 22:20:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269522>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Wed, May 20, 2015 at 10:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> David Aguilar <davvid@gmail.com> writes:
>>
>>> +     for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=' |
>>> +             cut -d '=' -f 2- | sort -u)
>>
>> Is the final "sort" really desired?  I am wondering if there are
>> fixed precedence/preference order among variants of %PROGRAMFILES%
>> environment variables that the users on the platform are expected
>> to stick to, but the "sort" is sorting by the absolute pathnames of
>> where these things are, which may not reflect that order.
>
> I did add the sort (and -u) by intention, to ensure that "C:\Program
> Files" (which is what %PROGRAMFILES% expands to by default) comes
> before "C:\Program Files (x86)" (which is what %PROGRAMFILES(X86)%
> expands to by default), so that programs of the OS-native bitness are
> preferred.

Yuck.  So even though %PROGRAMFILES% and %PROGRAMFILES(X86)% look as
if they are variables that can point at arbitrary places, they in
reality don't?  Otherwise %PROGRAMFILES% may point at D:\Program
while %PROGRAMFILES(X86)% may piont at C:\X86 and the latter would
sort before the former, which would defeat that "logic".

But of course if I view this not as a "logic" but as a "heuristics"
that happens to do the right thing in common environments, it is
perfectly OK ;-).

I've queued the patches as-is.

Thanks.
