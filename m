From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2] mergetools: add winmerge as a builtin tool
Date: Wed, 13 May 2015 15:19:10 +0200
Message-ID: <55534F4E.60402@gmail.com>
References: <1431482407-63642-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>, Phil Susi <phillsusi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 15:19:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsWZP-0006Dj-Dm
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 15:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754382AbbEMNT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 09:19:27 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34833 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933388AbbEMNT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 09:19:26 -0400
Received: by widdi4 with SMTP id di4so198286301wid.0
        for <git@vger.kernel.org>; Wed, 13 May 2015 06:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=jFHmaPvbgvxiyygZA7d+swwL0yOZcv86OCpzwd0iTlk=;
        b=U3bbWNUIIB9wG0F1Ln7TT+h3MZvwR2qzo+5QuVGkASNNXnkt88BWVjDk9zPhN/CPCg
         0HJUsv73kzz+3QLrXI41G7dOyltmiweC7P16rPtj9Wa3sFP3nnpFjSXD/WExsE70R/1d
         VasuTcNAxIO8CxpwdxdRdTLga0RLz5yFR3FfGPDQahOs4Lyg/jvfOjvkWBcX47WLX8I3
         oH073cUs+fvYKVzMcPfgxynIe3IFyUHsUo+MlhbLKMD56vy54C6Z99BqdWyrkbTY5Rp7
         wq7Ba+0GJ6UlBBUPA7YfXF/0OfGJZ/z2f/AENtLH0Sf3PZN/oDipY/UhT5V+LmGpb4aq
         8VEg==
X-Received: by 10.180.84.8 with SMTP id u8mr39549154wiy.39.1431523164869;
        Wed, 13 May 2015 06:19:24 -0700 (PDT)
Received: from [192.168.188.20] (p4FF45E49.dip0.t-ipconnect.de. [79.244.94.73])
        by mx.google.com with ESMTPSA id ha4sm8083019wib.0.2015.05.13.06.19.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2015 06:19:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1431482407-63642-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268981>

On 13.05.2015 04:00, David Aguilar wrote:

> +	if test -n "$ProgramW6432" && test -x "$ProgramW6432/$winmerge_exe"
> +	then
> +		printf '%s' "$ProgramW6432/$winmerge_exe"

I don't think it makes sense to check "$ProgramW6432". The content of 
that variable depends on the bitness of the process requesting the 
environment. Just checking "$PROGRAMFILES" and "$PROGRAMFILES(X86)" 
should be sufficient and more clear.

Also, note that you should use all upper case names when referring to 
Windows environment variables. While it's true that on plain Windows 
environment variable names are case-insensitive, MSYS1/2 converts all 
variable names to upper case and *is* case sensitive. I.e. while "echo 
$PROGRAMFILES" works as expected from a Git Bash on Windows, "echo 
$ProgramFiles" results in an empty string.

 > +	elif test -x "/c/Program Files (x86)/$winmerge_exe"
 > +	then
 > +		printf '%s' "/c/Program Files (x86)/$winmerge_exe"
 > +	elif test -x "/c/Program Files/$winmerge_exe"
 > +	then
 > +		printf '%s' "/c/Program Files/$winmerge_exe"

I also think these fallbacks can simply go away. It is *very* unlikely 
that "$PROGRAMFILES" / "$PROGRAMFILES(X86)" point to something else but 
WinMerge still is installed there.

-- 
Sebastian Schuberth
