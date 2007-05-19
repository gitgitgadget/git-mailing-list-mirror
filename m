From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 2/2] Teach "delta" attribute to pack-objects.
Date: Sat, 19 May 2007 09:10:35 -0700
Message-ID: <56b7f5510705190910h7e5ed03bnbc5a1b9a1369fc9f@mail.gmail.com>
References: <11795608912129-git-send-email-junkio@cox.net>
	 <11795608922961-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 18:10:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpRW1-0000RA-V5
	for gcvg-git@gmane.org; Sat, 19 May 2007 18:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbXESQKi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 12:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754084AbXESQKi
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 12:10:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:32282 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbXESQKh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 12:10:37 -0400
Received: by ug-out-1314.google.com with SMTP id 44so741932uga
        for <git@vger.kernel.org>; Sat, 19 May 2007 09:10:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EoSGDpRO+2ZtosBUdRblPsyjLKHXYdijPuGaXLRzvr4bxeyZ+7l1OvP7ZZhsDNPlOL+G97Stx6Ln5bV9JHnd3NU55q2xfeBsKorGWEblEr2xRZ18Vik1ftmuilEywpZTnPy8P4iO4aVeBjl3pJQyiJymupkgg2HQy/hPoICUUg0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DSaHbni2nsZnD41rmahQQ64uv5l/kK12lyc/TvsHcvMkaozDVIQNrLewqNEHQK8g4g81S+Km7lg7QWmZBiPX16qN7wAKYKyzOutz+GwPCDEo5eWa4UxIRTBGSyBm5W+L79EJFZxDGMZhDQegUQAyKfv1pdbVayfDsgGM4psirvo=
Received: by 10.78.168.1 with SMTP id q1mr773953hue.1179591035669;
        Sat, 19 May 2007 09:10:35 -0700 (PDT)
Received: by 10.78.90.18 with HTTP; Sat, 19 May 2007 09:10:35 -0700 (PDT)
In-Reply-To: <11795608922961-git-send-email-junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47752>

On 5/19/07, Junio C Hamano <junkio@cox.net> wrote:
> This teaches pack-objects to use .gitattributes mechanism so
> that the user can specify certain blobs are not worth spending
> CPU cycles to attempt deltification.
>
> The name of the attrbute is "delta", and when it is set to
> false, like this:
>
>         == .gitattributes ==
>         *.jpg   -delta
>
> they are always stored in the plain-compressed base object
> representation.

And we could also have an attribute "repack" :
    == .gitattributes ==
    *.wmv    -repack
which would result in *.wmv files [enormous] not being packed.
Since add_object_entry() now gets the name and
can reject objects (e.g. currently on their current packing status),
a call to "no_pack" which mirrors your new "no_try_delta"
could be inserted there.  But such an attribute should be
ignored when --stdout is in effect -- it only affects on-disk
repacking, not packing for transfers, which is why it's named "repack".

-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
