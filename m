From: Stefan Beller <sbeller@google.com>
Subject: Re: Re* [PATCH 10/15] commit.c: fix a memory leak
Date: Tue, 24 Mar 2015 14:20:31 -0700
Message-ID: <CAGZ79kZrYn9C=asYoszjJY3PxYGGd=fJw3h0g92L=Hnr3MG4xg@mail.gmail.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
	<1426897692-18322-11-git-send-email-sbeller@google.com>
	<xmqqk2ybatm1.fsf@gitster.dls.corp.google.com>
	<CACsJy8A3CptGYNAZ=+k0ykBCp6SGoOLY0nX20WkWQp=qUnxwWg@mail.gmail.com>
	<xmqq7fu65c4y.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 22:20:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaWFb-0004U6-ME
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 22:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbbCXVUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 17:20:34 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35584 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbbCXVUc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 17:20:32 -0400
Received: by ieclw3 with SMTP id lw3so8225227iec.2
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 14:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YFrCy0RyCp4VS760WnBV4I2U25ib1TGksRm9rLVaNPc=;
        b=NfGiAzGtJB2OgYuH1hIAtLPN9ltJaVQeF48e51mB2NqO0HKK5AbW383H2bgEN7UHrr
         1YselpZooVEZ4QylEpFuxpHgWNvK6dRzNBH1U99jtVX292hGPDQLMMsSGDadiPi36pSv
         UUBVk8iFwFtjDWiHa5TDwuhKctaiphLX92pzg97uvetNO1YgEhhTe9C+DHuuqb7P2VfR
         6WEvJ3e9WM4KKNrtuUADo1mbZb0MsIIoXTE6q+DcABybd0raat/Gh/TJf86PWnxTDvNO
         awda6J91fLwLQt5SnfCyQCxp13qCOVoVu70MDC7ZP/MKzN3ZrNfJIkef03py1/LkVp+b
         TYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=YFrCy0RyCp4VS760WnBV4I2U25ib1TGksRm9rLVaNPc=;
        b=QIL9JxoRmUNwCFTYBdeFLJrTGeUzpAVNqTr77ZNg5tAalsLUgXVOaEX0r0Q0IxG0vC
         Fl6gV8aUZAOagPqPq3W6yfI39gWzYFIVTX3y/EjOYbmJqAC6wSL4wNbH37JBs/GqhMYy
         cIi2rOi2+QBwmhbhBW0s+GMeZC+r+8I4iRPMyElFR8wZfwTwpM6EmFEc+vHXHX3uTLME
         3CL/oFB1mFGwzqTKXVW7UqrT+xz3VZHNQNE2WiZQkpt5MMjZdlCZJnKZKP9vfUhDVOnK
         EdO6ZZDsI82ajKa6Cj/AH++zsHnSqy30L6pwHOOBrTnW7mpIdgFAzXEuPa9YJxNCtapA
         lIPA==
X-Gm-Message-State: ALoCoQnEGMY1osJqMGH0FBQnun7LDk0ROz+eh3Urvs5tcJrspX37/9Ypx/eUU5Sxj8jDcZQcKKdI
X-Received: by 10.50.39.65 with SMTP id n1mr25148889igk.37.1427232031195; Tue,
 24 Mar 2015 14:20:31 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Tue, 24 Mar 2015 14:20:31 -0700 (PDT)
In-Reply-To: <xmqq7fu65c4y.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266229>

On Tue, Mar 24, 2015 at 2:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Move it to dir.c where match_pathspec() is defined.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Reviewed-by: Stefan Beller <sbeller@google.com>
