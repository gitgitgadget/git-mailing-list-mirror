From: Nikolaj Shurkaev <snnicky@gmail.com>
Subject: Re: git log -z doesn't separate commits with NULs
Date: Thu, 23 Feb 2012 16:48:43 +0300
Message-ID: <4F4643BB.8090001@gmail.com>
References: <4F46036F.3040406@gmail.com> <20120223102426.GB2912@sigill.intra.peff.net> <4F462E61.4020203@gmail.com> <m34nuhelnf.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 14:49:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Z2b-0006Vo-8j
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 14:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615Ab2BWNs4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Feb 2012 08:48:56 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54241 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218Ab2BWNsz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 08:48:55 -0500
Received: by bkcjm19 with SMTP id jm19so1035998bkc.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 05:48:54 -0800 (PST)
Received-SPF: pass (google.com: domain of snnicky@gmail.com designates 10.204.156.219 as permitted sender) client-ip=10.204.156.219;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of snnicky@gmail.com designates 10.204.156.219 as permitted sender) smtp.mail=snnicky@gmail.com; dkim=pass header.i=snnicky@gmail.com
Received: from mr.google.com ([10.204.156.219])
        by 10.204.156.219 with SMTP id y27mr693842bkw.110.1330004934301 (num_hops = 1);
        Thu, 23 Feb 2012 05:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=UPHp0Q9IN+gVZNi20qH7/hg2zFec93tJmPP3UEZYKRU=;
        b=Odm8LkXm2sKrhsZCrkSyXbgy/lwkTfAkHjgljM77eMaSjALjXZpMWrvJzyYDGmRCsY
         NYaviE1ggFzPbhDRayf8TjkXNoT27sN1LgjHnG+6avJNDv/WlTQsICtXlycaaEVqMq04
         Txu0fWtybaSNbiBt4SsxoOaDNtdHPfsNvZL2M=
Received: by 10.204.156.219 with SMTP id y27mr572791bkw.110.1330004934200;
        Thu, 23 Feb 2012 05:48:54 -0800 (PST)
Received: from [192.168.1.130] ([80.249.81.45])
        by mx.google.com with ESMTPS id jc4sm2901217bkc.7.2012.02.23.05.48.52
        (version=SSLv3 cipher=OTHER);
        Thu, 23 Feb 2012 05:48:53 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <m34nuhelnf.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191364>

=46or example there are commits that affect not only files in folder A =
but=20
files in folder B, C and so on.
If I do format-patch that will give me nice patches, but there are=20
modifications of folders B, C and so on there.
I do not know a way to generate patches via format-patch that affect=20
only files in folder A.

This is why I wrote those scripts.

23.02.2012 16:15, Jakub Narebski =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Nikolaj Shurkaev<snnicky@gmail.com>  writes:
>
>> Thank you very much for your tips. They really helped me. I was tryi=
ng
>> to create patches that would affect only some given files or
>> folders. By this moment I have the following:
>>
>> GeneratePatches.sh
>> ---------------------
>> #!/bin/bash
>> #parameter 1 -<since>..<to>
>> #parameter 2 - path to file
>> git log -z --reverse --format=3Demail --patch "$1" -- "$2" | xargs
>> --null --max-args=3D1 ./CreatePatchFile.sh
>> ---------------------
>>
>> and CreatePatchFile.sh
>> ---------------------
>> #!/bin/bash
>>
>> myPatchNumber=3D$(ls ./*-patch.patch 2>/dev/null | wc -l)
>> let "myPatchNumber +=3D 1"
>>
>> patchFile=3D"./"$(printf "%04d" $myPatchNumber)"-patch.patch"
>> echo "$@">  "$patchFile"
>> ---------------------
>>
>> I call
>> ./GeneratePatches.sh HEAD~3..HEAD SomePath
>> and that produces something very similar to what I want.
>>
>> Perhaps there is a better way to do that.
> So what git-format-patch is lacking?
>
