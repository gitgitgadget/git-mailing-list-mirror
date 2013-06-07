From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 05/18] Turn double-negated expressions into simple expressions
Date: Fri, 7 Jun 2013 16:25:50 -0400
Message-ID: <CAPig+cRamEU1jREcFnN4hzDaSXNFL2N1gRt98jEBJ7ogzor-ZA@mail.gmail.com>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
	<1370547263-13558-6-git-send-email-celestin.matte@ensimag.fr>
	<CAPig+cSDxhT=WVMQz_88z0xEmPVENDSyp5mE7XWCf_99yQTkTA@mail.gmail.com>
	<51B2129F.3040304@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 07 22:26:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul3ES-0007Pm-V6
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898Ab3FGUZx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 16:25:53 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:44660 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810Ab3FGUZw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 16:25:52 -0400
Received: by mail-la0-f44.google.com with SMTP id er20so4138350lab.31
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 13:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P40X99sXFqWLJN78D1RYBrWg8+24oHpW1K04j6D0+Es=;
        b=TJ4EnjeFq1TVBVnti69xwGOl0P8eQyjW9+5sSZHdzuJXXCkJnTiUNHDkeG5Zv5SsEb
         N5a1AZn8ldUr8MM1y/6EBh/44EhwwKGOgp5vtRWMIbMyz6DIraQob238b64wY9wMIfmo
         tf2NfFGw6ZpsS+YF9wmbOQill16CNh9HcEJGrbUPKxmYcwYSsnSgi5oZe+xCs+nsEQfC
         mKc7+6jMw4CgWFQVRXxGofj7kOvL5trd2MEzWqY2+H+HDJhhr7Fm/W5MDKptgaYuQ8vs
         UR6gonJO8WhHEhTs+MISKT/AOf9dQdz9E6rJGgjuS0h5GNj0k0H7GGyN3K85pyl+hvFz
         UI2g==
X-Received: by 10.112.159.202 with SMTP id xe10mr1908639lbb.52.1370636750758;
 Fri, 07 Jun 2013 13:25:50 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Fri, 7 Jun 2013 13:25:50 -0700 (PDT)
In-Reply-To: <51B2129F.3040304@ensimag.fr>
X-Google-Sender-Auth: ngWKE06DVnrNNsU01fsfdRaVz50
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226696>

On Fri, Jun 7, 2013 at 1:04 PM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> Le 07/06/2013 06:12, Eric Sunshine a =E9crit :
>> On Thu, Jun 6, 2013 at 3:34 PM, C=E9lestin Matte
>> <celestin.matte@ensimag.fr> wrote:
>>>                 } elsif ($cmd[0] eq "import") {
>>> -                       die("Invalid arguments for import\n") unles=
s ($cmd[1] ne "" && !defined($cmd[2]));
>>> +                       die("Invalid arguments for import\n") if ($=
cmd[1] eq "" || defined($cmd[2]));
>>>                         mw_import($cmd[1]);
>>>                 } elsif ($cmd[0] eq "option") {
>>> -                       die("Too many arguments for option\n") unle=
ss ($cmd[1] ne "" && $cmd[2] ne "" && !defined($cmd[3]));
>>> +                       die("Too many arguments for option\n") if (=
$cmd[1] eq "" || $cmd[2] eq "" || defined($cmd[3]));
>>
>> Not new in this patch, but isn't this diagnostic misleading? It will
>> (falsely) claim "too many arguments" if $cmd[1] or $cmd[2] is an emp=
ty
>> string. Perhaps it should be reworded like the 'import' diagnostic a=
nd
>> say "Invalid arguments for option".
>
> We could even be more precise and separate the cases, i.e., die("Too
> many arguments") when too many arguments are defined and die("Invalid
> arguments") when there are empty strings.
> Not sure if I should integrate it in this patch, though.

If you do choose to be more precise, it should be done as a separate
patch. Each conceptually distinct change should have its own patch.
Doing so makes changes easier to review and (generally) easier to
cherry-pick. For example, in this particular case, "simplify
doubly-negated expressions" is quite conceptually distinct from "emit
more precise diagnostics". (Textually the changes may happen to
overlap, but conceptually they are unrelated.)
