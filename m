From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: =?UTF-8?Q?Re=3A_Git_messes_up_=27=C3=B8=27_character?=
Date: Tue, 20 Jan 2015 21:45:46 +0100
Message-ID: <CACBZZX58Di=m2YEKRuAsuU=bqUXjQhN21tvjRL8Z1Vbuyk2fKQ@mail.gmail.com>
References: <54BEB08D.9090905@tronnes.org> <54BEB585.2030902@web.de> <54BEB7ED.2050103@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <notro@tronnes.org>
X-From: git-owner@vger.kernel.org Tue Jan 20 21:46:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDfgi-0007gK-I9
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 21:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbbATUqH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 15:46:07 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59904 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbbATUqG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jan 2015 15:46:06 -0500
Received: by mail-ob0-f174.google.com with SMTP id wo20so26485051obc.5
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 12:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9ITHim6UKYlRra3ceQtOfAWb2INQXmSMDkqOwkctnYw=;
        b=YxR60sP4Ev/ij0sLG475Dlg1wRYG0eziPlTuPLSPNc7cYV+cG68o1Iu4awoq6np3wZ
         zSJ6fksVGcza5F7ZGJxoOPrsEY7df41cypdSE5FRtFfVOQiUD/nwqCih/pvvL1dlsscP
         wyR6kmhSfZ77yysqK8wTQDR2KrnYWDl9VG6EFPLNysDkiNozTx0MHUcxe1Ds/5XRrxdT
         MI1Vgipk9XC7d0pzZq4hNnuctU1aly0c6kAJc1j/2WJuIul2uGXWllWWnCeDuWrNTdDI
         577wISMkV0cAiZ+pDweuFmgwuvknaU91ULEbLg4+nqQDCNe5pKdqKN9I2wMsh857tsyN
         sVGA==
X-Received: by 10.60.114.40 with SMTP id jd8mr22947170oeb.12.1421786766141;
 Tue, 20 Jan 2015 12:46:06 -0800 (PST)
Received: by 10.76.50.70 with HTTP; Tue, 20 Jan 2015 12:45:46 -0800 (PST)
In-Reply-To: <54BEB7ED.2050103@tronnes.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262688>

On Tue, Jan 20, 2015 at 9:17 PM, Noralf Tr=C3=B8nnes <notro@tronnes.org=
> wrote:
> Den 20.01.2015 21:07, skrev Torsten B=C3=B6gershausen:
>>
>> On 2015-01-20 20.46, Noralf Tr=C3=B8nnes wrote:
>> could it be that your "=C3=B8" is not encoded as UTF-8,
>> but in ISO-8859-15 (or so)
>>
>>> $ git log -1
>>> commit b2a4f6abdb097c4dc092b56995a2af8e42fbea79
>>> Author: Noralf Tr<F8>nnes <notro@tronnes.org>
>>
>> What does
>> git config -l | grep Noralf | xxd
>> say ?
>>
> $ git config -l | grep Noralf | xxd
> 0000000: 7573 6572 2e6e 616d 653d 4e6f 7261 6c66  user.name=3DNoralf
> 0000010: 2054 72f8 6e6e 6573 0a                    Tr.nnes.
>
> $ file ~/.gitconfig
> /home/pi/.gitconfig: ISO-8859 text

What's happened here is that:

 1. You've authored your commit in ISO-8859-1
 2. Git itself has no place for the encoding of the author name in the
commit object format
 3. git-format-patch has a --compose-encoding which I think would sort
this out if you set it to ISO-8859-1, but it defaults to UTF-8
 4. Your patch is actually a ISO-8859-1 byte sequence, but is
advertised as UTF-8
 5. You end up with a screwed-up commit

You could work around this, but I suggest just joining the 21st
century and working exclusively in UTF-8, it makes things much easier,
speaking as someone with 3x more non-ASCII characters their his name
than you :)
