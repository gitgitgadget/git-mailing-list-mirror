From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/2] git rebase -i: Warn removed or dupplicated commits
Date: Wed, 27 May 2015 12:18:10 -0700
Message-ID: <xmqq1ti1n825.fsf@gitster.dls.corp.google.com>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1432676318-22852-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<CAPig+cQJMSjS=fiwMHE93efSsa2QYQ8TphyyfcLg7kAXRi_+cw@mail.gmail.com>
	<579982712.39028.1432732759119.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 27 21:18:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxgqK-0001h4-Tg
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 21:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbbE0TSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 15:18:16 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33318 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523AbbE0TSN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 15:18:13 -0400
Received: by iebgx4 with SMTP id gx4so21471148ieb.0
        for <git@vger.kernel.org>; Wed, 27 May 2015 12:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Q+5M4ajK3dfJKgryLhiKPXf4iV3XmzIlh09b5NwNT3k=;
        b=BJqIk5NaghVEbT+a2BUS/uPZTRW7KEtuDsldgCLZ9bAirdsk4/UPi7AEMBS/7nCiIs
         sEF1/pctaoaXbKkV7d29+QyHA94CAth5YV7pwvdF2taORzKvLrwZwVnWWx4okwGD3zSV
         6YODPMDvWPAMEMN6nrKiegEW7/z8Q2GeN9iTvbeuveYd96tmtvYTWdCzSTXZp4hZQNGl
         M2ioAOJEbqv6tN4zFYy0XMzUpMozzZ51c5xJq8G/kgItrZV1gCgG4j6dvuwfKcIxrIIJ
         trLugwiHUli9Lu9v+IBS47PSHuCtfPAUkmSWulHbSMibp+v/ZubFo926xbFO/QSt7h3/
         mBNg==
X-Received: by 10.107.162.147 with SMTP id l141mr44163759ioe.77.1432754292684;
        Wed, 27 May 2015 12:18:12 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id d4sm2477794igl.1.2015.05.27.12.18.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 12:18:12 -0700 (PDT)
In-Reply-To: <579982712.39028.1432732759119.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Galan Alfonso's message of "Wed, 27 May 2015 15:19:19 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270068>

Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
writes:

> Thank you for reviewing the code. 
>
> Eric Sunshine<sunshine@sunshineco.com> writes:
>> > +       # To uppercase
>> > +       checkLevel=$(echo "$checkLevel" | tr '[:lower:]' '[:upper:]')
>> 
>> Is there precedence elsewhere for recognizing uppercase and lowercase
>> variants of config values?
>
> It seems to be commonly used when parsing options in the C files
> through strcasecmp.  For exemple, in config.c:818 :
> if (!strcmp(var, "core.safecrlf")) {
> 	if (value && !strcasecmp(value, "warn")) {
> 		[...]
> However we didn't see any precedence in shell files. Do you think we
> should remove it?

I think there is a difference between (silently) accepting just to
be lenient and documenting and advocating mixed case uses.

Personally, I'd rather not to see gratuitous flexibility to allow
the same thing spelled in 47 different ways for no good reason.
