From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: Re: [PATCH v7 2/2] Verify index file before we opportunistically
 update it
Date: Fri, 11 Apr 2014 18:58:57 +0300
Message-ID: <20140411155857.GA12742@abyss.hitronhub.home>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
 <1397154681-31803-1-git-send-email-yiannis.marangos@gmail.com>
 <1397154681-31803-2-git-send-email-yiannis.marangos@gmail.com>
 <xmqqppkpvv9m.fsf@gitster.dls.corp.google.com>
 <53479DFD.4020702@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 11 17:59:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYdrP-0006Bs-CH
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 17:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754464AbaDKP7N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Apr 2014 11:59:13 -0400
Received: from mail-ee0-f48.google.com ([74.125.83.48]:52517 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759279AbaDKP7H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 11:59:07 -0400
Received: by mail-ee0-f48.google.com with SMTP id b57so4254609eek.7
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kqSuBQJpp4O3NDxX9CFUH+VSYgZp+DWAXoaf+xSfzao=;
        b=c8a1WKKqxzCnhl60aTytr2o0cd/J4PqsaD/UooJhL/aR2ND4BlGti1mxg9ezBThEHq
         nFfBRzGJTsJ54HmYwz0VgSXGBTBQHH/SlTrrtkXVp/TDCe6VS8lBntr35tPWQHcag/mv
         eYgLPpzUplGM+TaAXxY7LuUOTmfUaII80+AsFy3E8Kao525ffeRw9611CiVQ9yAZ/ou3
         wQjBSgXzQOfXhxwrH0Tcn2smDrlVXTonZMPaPjzuoKgbyqparJ589NGtgnrWPU0xWmYI
         bjm7MY8vV4F6xR8AqRFt3bQRH/w7vr0vSm21Sbf7u2xFjN8dteDrk29n2AjVzCtGc2yt
         iErw==
X-Received: by 10.14.198.197 with SMTP id v45mr30107347een.9.1397231946594;
        Fri, 11 Apr 2014 08:59:06 -0700 (PDT)
Received: from abyss.hitronhub.home ([46.251.117.183])
        by mx.google.com with ESMTPSA id q41sm18567597eez.7.2014.04.11.08.59.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 08:59:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53479DFD.4020702@web.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246104>

On Fri, Apr 11, 2014 at 09:47:09AM +0200, Torsten B=F6gershausen wrote:
>   6. process A applies a commit:
>       - read the index into memory
>       - take the lock
>       - update the index file on disc
>       - release the lock

So here we can have race condition. Maybe we should implement Duy's
idea of verifying the sha1 in write_index()?


> The new code works like this:
>
>   8. process B applies a commit:
>       - take the lock
>       - verifies tha the index file on disc has the same sha as the o=
ne read before
>       # And if not: What do we do? die() or retry() ?
>       - update the index file on disc
>       - release the lock

IMO, we must never die() if we want to do opportunistic update and we
should never retry because it's a bit expensive if we do opportunistic =
update.


--
Yiannis
