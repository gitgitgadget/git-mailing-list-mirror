From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2] mergetools: add winmerge as a builtin tool
Date: Wed, 13 May 2015 22:36:15 +0200
Message-ID: <5553B5BF.7040408@gmail.com>
References: <1431482407-63642-1-git-send-email-davvid@gmail.com>	<55534F4E.60402@gmail.com>	<3d7e3b09b89c46c39befca7564f5c1d6@www.dscho.org> <CAHGBnuPDSdCyVNM+Gagang1Cf9yw0Tyios45i6pnZSSzaJJC2Q@mail.gmail.com> <5553AD43.9010807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, Phil Susi <phillsusi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 13 22:36:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsdOW-0006Lz-Ko
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 22:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965364AbbEMUgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 16:36:39 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:36408 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965275AbbEMUgg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 16:36:36 -0400
Received: by wgbhc8 with SMTP id hc8so21677210wgb.3
        for <git@vger.kernel.org>; Wed, 13 May 2015 13:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=e9etzB1owRqykInfaavJlZE+xQv6ce/dMcyzh1BKdJk=;
        b=JFv2gQBpQzyHk6QUVxp7FoicKOxNuuSPPRG7HpybTt511vmSHMJucbUCgQ5Nfvcj8h
         qMhvPoBO3VaEGKc0KTZK5UotuVNfRd0e/Bgbw4Rp/TPYZMbApyXtpX0/if2VLaLwDCOB
         //CwrmFcxWUS6fdaFAW+es78rNT4uVjEHYHAg9sMomgYv4vPYhBha/+R2ro03x4uPiFp
         DLTB5vipI1fWUBvdEsxgTJhTouZ0tTvw6e9pniiPWISezSAd4FQ6F6bAlCyZP9aeAaPG
         pdFAjjACauxvZsK2DSu4MPsxDYld+nW+OxjImfq+jmkZgTpLE4uW0l+xJpbQ+dKM+4to
         Q94A==
X-Received: by 10.180.90.43 with SMTP id bt11mr17316749wib.4.1431549395044;
        Wed, 13 May 2015 13:36:35 -0700 (PDT)
Received: from [192.168.188.20] (p4FF45E49.dip0.t-ipconnect.de. [79.244.94.73])
        by mx.google.com with ESMTPSA id n8sm9777882wiy.19.2015.05.13.13.36.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2015 13:36:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <5553AD43.9010807@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269007>

On 13.05.2015 22:00, Sebastian Schuberth wrote:

> So how about something like this which hopefully covers all cases (including case-sensitivity issues regarding environment variable names and the problem of querying a variable that contains parentheses as part of its name):
> 
> for directory in "$(env | sed -nr 's/^PROGRAM(FILES(\(X86\))?|W6432)=//pI')"
> do
>      test -n "$directory" &&
>      test -x "$directory/$winmerge_exe" &&
>      echo "$directory/$winmerge_exe" &&
>      break
> done
> 
> sed's "I" seems to be a GNU extension that's not available with OS X' BSD sed. This shouldn't be an issue as WinMerge is Windows only anyway. If it still turns out to be an issue we probably should come up with an equivalent Perl expression.

Or even better, as that does not rely on GNU sed, sorts matches so that "C:\Program Files" for sure comes before "C:\Program Files (x86)" and removes any duplicates:

for directory in "$(env | grep -E '^PROGRAM(FILES(\(X86\))?|W6432)=' | cut -d '=' -f 2 | sort -u)"
do
     test -n "$directory" &&
     test -x "$directory/$winmerge_exe" &&
     echo "$directory/$winmerge_exe" &&
     break
done

-- 
Sebastian Schuberth
