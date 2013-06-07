From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] t0005: skip signal death exit code test on Windows
Date: Fri, 7 Jun 2013 12:03:49 +0200
Message-ID: <CABPQNSZMae0F3PDDp+h6zy7fC1jfAzSDbO--i1aSk2HTjVkSiw@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <51AEE1C3.9020507@viscovery.net>
 <20130605071206.GC14427@sigill.intra.peff.net> <51B02D81.3000700@viscovery.net>
 <CABPQNSa+nZY2V44B-L47aqwt=4eKr96jtadgKHhS__29tTvsdg@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 07 12:04:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UktX8-00048F-CM
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 12:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677Ab3FGKEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 06:04:30 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:58450 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab3FGKE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 06:04:29 -0400
Received: by mail-ie0-f172.google.com with SMTP id 17so9946744iea.17
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 03:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=wjIu5CXAkJmZXq8yn6+OICaG+W2st8/5/MoOj/KoDnU=;
        b=Q54Gy9k+LSy303+vI2eQ6MfM45aRqjHcRqMO5IwBrRX0iQ5w46bCdU/G9Hps+fhsVK
         RTQRXchZxNgOg3auPyhQYazO2n7nN/j/0yyDO6aWfLWe+IrHUK7TqZLPGx0HfVc4sjJI
         SaZGbO3BffLAO5wU69AcpA7TnfrBQPtq6aYlCFx0GJAi2XLJlaGc/OjDTuOVdD43Knr3
         w3ol+rG12e1nIjgrzMbCusXylaPNRqi+cfKyQElCT6YQmdm9SiUclXzCli4D5F/6DFhV
         MGi4BafWaXGD6QGumcwboi1pBBq3301+7srOlgD+qBsoo7wtySYgwIkEcL+Km7pRQcPg
         bUfg==
X-Received: by 10.50.43.234 with SMTP id z10mr988279igl.92.1370599469132; Fri,
 07 Jun 2013 03:04:29 -0700 (PDT)
Received: by 10.64.23.199 with HTTP; Fri, 7 Jun 2013 03:03:49 -0700 (PDT)
In-Reply-To: <CABPQNSa+nZY2V44B-L47aqwt=4eKr96jtadgKHhS__29tTvsdg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226616>

On Fri, Jun 7, 2013 at 12:01 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Thu, Jun 6, 2013 at 8:34 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> From: Johannes Sixt <j6t@kdbg.org>
>>
>> The test case depends on that test-sigchain can commit suicide by a call
>> to raise(SIGTERM) in a way that run-command.c::wait_or_whine() can detect
>> as death through a signal. There are no POSIX signals on Windows, and a
>> sufficiently close emulation is not available in the Microsoft C runtime
>> (and probably not even possible).
>>
>> The particular deficiency is that when a signal is raise()d whose SIG_DFL
>> action will cause process death (SIGTERM in this case), the
>> implementation of raise() just calls exit(3).
>>
>> We could check for exit code 3 in addition to 143, but that would miss
>> the point of the test entirely. Hence, just skip it on Windows.
>>
>
> Huh? We do "exit(128 + sigint);" in mingw_raise these days, no?
>
> Or is the signal triggered from a non-git process?

Argh, I'm blind. Yeah, SIGTERM, not SIGINT...
