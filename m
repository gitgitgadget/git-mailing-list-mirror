From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/12] attr.c: use strchrnul() to scan for one line
Date: Mon, 16 May 2016 16:45:13 -0700
Message-ID: <CAPc5daXz59fX6MGfmAZ31GR_=Ph=_zZY35W4vfXkD1noK571dg@mail.gmail.com>
References: <20160516210545.6591-1-gitster@pobox.com> <20160516210545.6591-3-gitster@pobox.com>
 <CAGZ79kbSFp5e6-AeSbqk4hFxcuzTo-4oSG_z5nGTpAY0uvLAuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 17 01:45:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2SCh-0007fF-F7
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 01:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbcEPXpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 19:45:35 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:35874 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbcEPXpe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 19:45:34 -0400
Received: by mail-yw0-f175.google.com with SMTP id x189so26905591ywe.3
        for <git@vger.kernel.org>; Mon, 16 May 2016 16:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=utc0s/hH6LWgkKk1wvvl8/PZkae1Y8c9sc+gekg5uLY=;
        b=EwJCZ71RrWgUHQsKOWTVL8ia9dcmM7DgxymbwgUtaoeO3VVpGz3AaeIE/AaQXLe3UE
         pCBjeWL5UoT4jKuSLmvo/C5YA6xFi91MpTgGqmIKQuFX/jK+6GpgbTJgMRpK+kNXQEwj
         dMOcvhZMNakHS7XBOyrndbJmh+hJILS2hSWzbvYYPqnmgPisVMiv7IGlYryvHgEM0+NL
         h32xrKOz/jJXYWJcNImO60j/Lpydt8ksv544oL/KR3xHyqNw2Edqr5tfJDlVubiqcayA
         Vc7HGnZeh/3doTUbKNXN77cuQBnQjacvFLGvcYKmcPCySlseHFMHLeONTKRRXYgbCS9m
         SbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=utc0s/hH6LWgkKk1wvvl8/PZkae1Y8c9sc+gekg5uLY=;
        b=DMc/IY663qc4IpNJnoeRQTurrfl4tR1BOewAuwRgA2Rg8akiOCZWLWlXCnXH9fByCd
         ZwkGJJjI1qrMuHRQUYDLLgoNAcT5m0GOgW/PkR4HygP8EjfwSpTX4HrOPse5hVZ7g5nF
         lcxtUQQDtXgRmLJm3hxJsrYKIY6H6upxy/J+TVD9xBzfPsjxoyqtf2OLwgnEAK+cvtN6
         VHJXBjeKBZb83klQfDkVKGrQNNI2whtYikjtfortjQboEYprKTOuTcGKi0bUtlrAaXnL
         paNUZTevzp2zPRuTWa5kv1jpXTwh1PMJBT3LFbd2txtT1D43PSaYFZqEggA/WEkaOXT3
         F4Qg==
X-Gm-Message-State: AOPr4FX8BJdq456HbO/yVqYQfOEy6B6GvPo5dSw+13SZvZ5A1rvVHHVu6IMlLRuV0BMAq2D/K0h6sy0nDT/FPA==
X-Received: by 10.37.57.201 with SMTP id g192mr14909269yba.41.1463442333210;
 Mon, 16 May 2016 16:45:33 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Mon, 16 May 2016 16:45:13 -0700 (PDT)
In-Reply-To: <CAGZ79kbSFp5e6-AeSbqk4hFxcuzTo-4oSG_z5nGTpAY0uvLAuw@mail.gmail.com>
X-Google-Sender-Auth: guCcM_SRdNpRLUd1BnqNC9CYJ7A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294821>

On Mon, May 16, 2016 at 4:28 PM, Stefan Beller <sbeller@google.com> wrote:
>>         for (sp = buf; *sp; ) {
>>                 char *ep;
>>                 int more;
>> -               for (ep = sp; *ep && *ep != '\n'; ep++)
>> -                       ;
>> +
>> +               ep = strchrnul(sp, '\n');
>
> (Even lesser nit as in patch 1)
> You could directly assign ep and more when declaring them.

I'd prefer not to.

"A declaration block, blank and statement" pattern allows you
to have the declaration of variables to group related things
together and in an order that makes it easier to explain.
If you throw in initialization there, you cannot do that anymore
(e.g. ep must be initialized before you can compute more).
