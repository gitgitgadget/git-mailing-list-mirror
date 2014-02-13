From: Zachary Turner <zturner@chromium.org>
Subject: Re: Make the git codebase thread-safe
Date: Thu, 13 Feb 2014 15:09:41 -0800
Message-ID: <CAAErz9hzeiJ9f9tJ+Z-kOHvrPqgcZrpvrpBpa_tMjnKm4YWSXA@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>
	<CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>
	<CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com>
	<CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com>
	<CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com>
	<52FBC9E5.6010609@gmail.com>
	<loom.20140213T193220-631@post.gmane.org>
	<52FD4C84.7060209@gmail.com>
	<CAHOQ7J8syoQLGwwkwPEX3wZir8sWDQ+k8sgHAKn=n_-Q_S8ipA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 00:09:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE5Pe-0005bu-Ts
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 00:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbaBMXJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 18:09:43 -0500
Received: from mail-oa0-f49.google.com ([209.85.219.49]:42995 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517AbaBMXJm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 18:09:42 -0500
Received: by mail-oa0-f49.google.com with SMTP id i7so13389358oag.8
        for <git@vger.kernel.org>; Thu, 13 Feb 2014 15:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MQ6S6RU8El38UrCObZXLLMGrbJLhaBD4mS+vaacRaCQ=;
        b=ZjQ6mNVIDMcW5iih+iatgsRweog9X95nwpsj6QOjy5a38Nwna8A2HqZUKVtD+fIk1Z
         lV9Or0p997Kco2NoTReM4q8dNR3PQphX/3P6WCS0B2FopVkMeUaC5xzHxl28YM024rLE
         wS3VhpAkAQRPalKZRfGUQG6SVrP/Wxbl7BADe6sLvzh3J37li0KMuHcS4hWEUoEJ/Fck
         mxpvTEngpEnKo72h/32of1l9zHDDbmddM83lwc8PbjzsHX2pmPGvgggwRd6HwmOa4Udm
         eZzaw1mXfZt5/L/3hVsxf72t1d6zCmYSP0FGZUCDq6QSoHZdpJal7Vz+R6J7iWi1IvVG
         65Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MQ6S6RU8El38UrCObZXLLMGrbJLhaBD4mS+vaacRaCQ=;
        b=achw8pfixPr0qhD9s5Lfe4Fmxvf2vc1ks37GHU/h/oGt9qLxuiqTwwZOF3ohZO/BWu
         U8O6v1k4i0ZWf1E9XWMW5IGvSIVoufZaOr/v3JEUKxsupe9kDVRtslXUeXW9CxUOU9xY
         Ijlrmskw+V9c0bv5aYOCprCzRCtIxRxrjsYDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=MQ6S6RU8El38UrCObZXLLMGrbJLhaBD4mS+vaacRaCQ=;
        b=Sp4IoC74MoAhDeU1JYu5BIl3EG1zdCtt0ZaSCXRCd4wiDlk7juFk+UA5yLpACEIFwp
         AHXpGLzXG5d72HtRXR2MNgX+ZjbSCn2ixvFHaiTYsopvi/Vx/1SC0HdFogxDJNpGkEH6
         /jLgi/t/zCTMTvqzy4pPDnUIQN3if0Ts/m0vLKlI5YntDjXSidoXQl8wfelRsNZHM4nZ
         354b9SzemXBM5jbfNUnGFctwrlxy2533RW74VXrAXykU+K0PNTRi2yBuDVburQR0qRb1
         6E6BxviXQDIMorpQPnW1g8bjri2McG1kPmBl5eOaM38NqsEq8RARP6SvNUt4hy0izEMH
         CMfA==
X-Gm-Message-State: ALoCoQn8uAcSjgodUn1sOtzR+Kjy2MV8D7d4yzJ7uodWS3pG9pT3ZFOIcbGAZ5CniI7DNpe8qMfiT7CqWIVTVD3TV+O9Hy8YxJF+c9eDtrHBi/KvNlkqoU3WoL4HFBYn/AiJ8RpDBUlxzDcqV3lv/A+gcm4TKWTMOQqHxpmfQ7HpOKPG2o3DiC3Yufd1bGm8/3N6jacGxsrQ
X-Received: by 10.182.232.4 with SMTP id tk4mr3560027obc.9.1392332981772; Thu,
 13 Feb 2014 15:09:41 -0800 (PST)
Received: by 10.182.118.41 with HTTP; Thu, 13 Feb 2014 15:09:41 -0800 (PST)
In-Reply-To: <CAHOQ7J8syoQLGwwkwPEX3wZir8sWDQ+k8sgHAKn=n_-Q_S8ipA@mail.gmail.com>
X-Google-Sender-Auth: C07E_yKxekPW885GZHaAF2Dz7PM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242085>

To elaborate a little bit more, you can verify with a sample program
that ReadFile with OVERLAPPED does in fact modify the HANDLE's file
position.  The documentation doesn't actually state one way or
another.   My original attempt at a patch didn't have the ReOpenFile,
and we experienced regular read corruption.  We scratched our heads
over it for a bit, and then hypothesized that someone must be mixing
read styles, which led to this ReOpenFile workaround, which
incidentally also solved the corruption problems.  We wrote a similar
sample program to verify that when using ReOpenHandle, and changing
the file pointer of the duplicated handle, that the file pointer of
the original handle is not modified.

We did not actually try to identify the source of the mixed read
styles, but it seems like the only possible explanation.

On Thu, Feb 13, 2014 at 2:53 PM, Stefan Zager <szager@google.com> wrote:
> On Thu, Feb 13, 2014 at 2:51 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
>> Am 13.02.2014 19:38, schrieb Zachary Turner:
>>
>>> The only reason ReOpenFile is necessary at
>>> all is because some code somewhere is mixing read-styles against the same
>>> fd.
>>>
>>
>> I don't understand...ReadFile with OVERLAPPED parameter doesn't modify the HANDLE's file position, so you should be able to mix read()/pread() however you like (as long as read() is only called from one thread).
>
> That is, apparently, a bald-faced lie in the ReadFile API doc.  First
> implementation didn't use ReOpenFile, and it crashed all over the
> place.  ReOpenFile fixed it.
>
> Stefan
