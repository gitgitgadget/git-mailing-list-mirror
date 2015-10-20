From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: import the ctypes module
Date: Tue, 20 Oct 2015 12:36:02 -0700
Message-ID: <xmqqwpuh72ot.fsf@gitster.mtv.corp.google.com>
References: <CAJA=mv5Kdsn1YEo4sUAwpTv=0Jc8Xg5V2WPMoCmsxNL4Hnk=kg@mail.gmail.com>
	<CAE5ih793+YDd30rpMSyTHjUNZS+-BLY9D-kJkF9RAogjdctPFw@mail.gmail.com>
	<xmqqy4ex8r8k.fsf@gitster.mtv.corp.google.com>
	<1445369506.8543.10.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Luke Diamand <luke@diamand.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Etienne Girard <etienne.g.girard@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Tue Oct 20 21:36:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zochk-0006sT-RX
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 21:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbbJTTgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 15:36:05 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33291 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbbJTTgE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 15:36:04 -0400
Received: by pabrc13 with SMTP id rc13so29933991pab.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 12:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=UGDJ1ki0mNA2yhahG8Z4d0G7oWRQmIZxVug0jKu2daA=;
        b=A1TDrrpDKthotqKhhK10dCwpfWPZe04CeTrQJJ3br1BAHlZLXqfB4gxfZm15QwM2K9
         K8sB6mKTX0i+Hlh40HHB0C3lT4EQrid92MNEzNbokXTG3kqA6npSpBTt/OtzKCBsJyqD
         bu7r+hSOUlXwCtd3WQfThu3/4cBUGIVqdYwJ+zHAoQiI9f4JHRZpvvUJVYX+v16/ykVS
         pOJtw5qJZkivAwD2CvCveRV69IYz4yYsikgCpwH9fLZ7MJ2Zzgycqjby4K4xca/AYLhE
         q07g3p8NE2aimgPDMaX2LG/SGO61+xEGpMkAjCLeuC+wojZ8zNCJ4OAKUFoRBo+583DJ
         qJUw==
X-Received: by 10.66.161.7 with SMTP id xo7mr5673498pab.57.1445369763871;
        Tue, 20 Oct 2015 12:36:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f0a2:278f:6a7e:e323])
        by smtp.gmail.com with ESMTPSA id lo9sm5183078pab.19.2015.10.20.12.36.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 12:36:03 -0700 (PDT)
In-Reply-To: <1445369506.8543.10.camel@kaarsemaker.net> (Dennis Kaarsemaker's
	message of "Tue, 20 Oct 2015 21:31:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279937>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

>> I do not follow Python development, but does the above mean that
>> with recent 2.x you can say ctypes without first saying "import
>> ctypes"?  It feels somewhat non-pythonesque that identifiers like
>> this is given to you without you asking with an explicit 'import',
>> so I am puzzled.
>
> No, you cannot do that. The reason others may not have noticed this bug is that
> in git-p4.py, ctypes is only used on windows.
>
>  111     if platform.system() == 'Windows':
>  112         free_bytes = ctypes.c_ulonglong(0)
>  113         ctypes.windll.kernel32.GetDiskFreeSpaceExW(ctypes.c_wchar_p(os.getcwd()), None, None, ctypes.pointer(free_bytes))
>
> The fact that it works for the OP with 2.7.10 is puzzling (assuming that it's
> on the same system).

Exactly.  That is where my "I am puzzled" comes from.

The patch looks obviously the right thing to do.  Luke?  Lars?

>
> diff --git a/git-p4.py b/git-p4.py
> index daa60c6..212ef2b 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -24,6 +24,7 @@ import shutil
>  import stat
>  import zipfile
>  import zlib
> +import ctypes
>  
>  try:
>      from subprocess import CalledProcessError
