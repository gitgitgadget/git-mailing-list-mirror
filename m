From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] optimize adjust_shared_perm() in path.c:
Date: Tue, 2 Apr 2013 23:55:24 -0400
Message-ID: <CAPig+cT1quUK52hXnQE6-jVTMi7GUjtgL9njmRvNe6+mPNNvUg@mail.gmail.com>
References: <201303301053.49140.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	j6t@kdbg.org, Erik Faye-Lund <kusmabite@gmail.com>,
	mlevedahl@gmail.com, ramsay@ramsay1.demon.co.uk
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 03 05:55:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNEnj-0008KS-87
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 05:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759763Ab3DCDz0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Apr 2013 23:55:26 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:51647 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759571Ab3DCDz0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 23:55:26 -0400
Received: by mail-lb0-f171.google.com with SMTP id v10so1159100lbd.16
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 20:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ySpzDcFakywGAN7m3I/ZWHsmouG4LZ1ETBtrl0YlLno=;
        b=uK9NKBz9g8KGOsUW62XOvAKhx19917BL7GaBnclfdEFmnPV5VFTecwrDg1mZR7nxC4
         o/MMdVzaM8aAiotbIK/bn1ZytOTsxQ+dWLKBVrz7ospbzRWkQjVZ/21hUjzwdPk5NzP+
         otSa8RweawHpttE2SY+WAPFb+0cGpC55b5yNC6kzQqDnYWb9bxRBGKj1EYgcsunuOnGP
         8CR6iHdWwolBq3UIPKTdmBhBPFeJUwn4DF+NkJZxR4HRu/VzntpI6mmsYJk313jJORUc
         g5KY8Tv/2QrPlkIzTtXlfW0alE1PcWk/VfeRKStzrk7CAo4CuZ+R61OnkztSIaunG4+T
         iDRw==
X-Received: by 10.152.105.244 with SMTP id gp20mr9792lab.34.1364961324422;
 Tue, 02 Apr 2013 20:55:24 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Tue, 2 Apr 2013 20:55:24 -0700 (PDT)
In-Reply-To: <201303301053.49140.tboegi@web.de>
X-Google-Sender-Auth: ZzgOrJkPzNYT__mACTClPx2EuEU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219912>

On Sat, Mar 30, 2013 at 5:53 AM, Torsten B=F6gershausen <tboegi@web.de>=
 wrote:
> sometimes the chown() function is called even when not needed.
> (This can be provoced by running t1301, and adding some debug code)

s/provoced/provoked/

> Save a chmod from 400 to 400, or from 600->600 on these files:
>  .git/info/refs+
>  .git/objects/info/packs+
>
> Save chmod on directories from 2770 to 2770:
>  .git/refs
>  .git/refs/heads
>  .git/refs/tags
