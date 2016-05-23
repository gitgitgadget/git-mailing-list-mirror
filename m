From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6 3/3] bisect--helper: `write_terms` shell function in C
Date: Mon, 23 May 2016 15:58:52 +0200
Message-ID: <CAP8UFD1gjfFC_v23RDiHedzwQm3XoYJKv32GT7R9GNyK4pXJpQ@mail.gmail.com>
References: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-4-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cS=zcSVLwARZ5A8hdiE0wqgYPU2Jwnr0OcjDXZFO--cZw@mail.gmail.com>
	<alpine.DEB.2.20.1605161508230.3303@virtualbox>
	<CAFZEwPNkPZ6JnzqbTyhYMwEF-hor2rm39NcB84omrh+uCiVPNw@mail.gmail.com>
	<alpine.DEB.2.20.1605231301560.4122@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 15:59:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4qO0-0002JY-Nl
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 15:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbcEWN6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 09:58:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36435 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbcEWN6x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 09:58:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id q62so15378589wmg.3
        for <git@vger.kernel.org>; Mon, 23 May 2016 06:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=gCRMHVl7prdN7Hz2nI4k6c9m+fvtvjTNC/FdT7eRlaI=;
        b=PzsoEoT2weULmzWQfVUHA/N+70vmAiAn0kxX2UEozipTXGwHXKlpI9UdHYd+SK2bic
         PimPnItYdF5xy87eyvzpa0ZK9RBOY2/6EvbT29FGjYlQE3rlFwnHEgN6gouUQfcL4KAh
         chDoh+GZ0ZcIh7N22IkXHWHGtBkozs+ueBfQgqtQFaMZB7GyFDp0HQg0J73bH4zDaPbK
         6ci5xL1nkVS6IiiECzVQ/omyLR5gX8vHg3BnEw4TzkSzYo42/kp5n9KFLVHMVhqEiHFX
         iKS126I38xkwEbM9IpTGqM9pxqEKLwpcYtIzevEz+h6yKjMld6kSxLLkH3hCBkij1Ukj
         yG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=gCRMHVl7prdN7Hz2nI4k6c9m+fvtvjTNC/FdT7eRlaI=;
        b=XbjIey7YwkUpPQRfs6LcvvUDIgQ4IDxv7kDSOdZdYmZnxop7gAfSBDtHQvUSaqh3bJ
         fGi8JH4SOd7NGed/xd+W+ckNUWPCL8aCBkGrqVEei22nLxDJuG1P6Er2/tP/9CPqP+X/
         7rhNaymmAHtoJ1dRYT/3fbFW6roZO0u+2Ww0Zu+e1IE6TjCd6M0hrOmxErtTos6PfKmG
         v3UAI2TETM4nPIsOEkPMIZWFZ61EnNnAC5QIySxJA0F/TDQaoj7VX2HM7fwLmQutmTA7
         kbvyngrcWrJ+/h2CyDJLHSpE+C60gzBLAT8hHtWRw1Evdy8HvUK/S/KraxqDd/26FKPM
         EWgQ==
X-Gm-Message-State: AOPr4FUFn8/aC4i4q8tcZPJ8NOVPdKxk6UIGqmyO92YSoLb77C9lW/OSOSL8ttxoq3c9fTEMUC4dl70Byu80bQ==
X-Received: by 10.195.17.166 with SMTP id gf6mr16829408wjd.124.1464011932267;
 Mon, 23 May 2016 06:58:52 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Mon, 23 May 2016 06:58:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605231301560.4122@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295325>

On Mon, May 23, 2016 at 1:07 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Fri, 20 May 2016, Pranit Bauva wrote:
>
>> Frankly, I have no idea what you mean by libification but I will use
>> error() since efforts for libification have already started.
>
> The term "libification" is frequently used in the Git project: it means to
> convert code that was formerly used in a standalone program to make it
> usable as a library function.

Yeah, and Git standalone programs in C are builtin/*.c files, while
Git lib code in C is in *.{c,h} files at the root of the repo.

The build also generates libgit.a from all the lib code, for example:

$ touch bisect.c
$ make CFLAGS="-g3 -Wall"
    CC bisect.o
    AR libgit.a
...
