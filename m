From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v8 18/19] Add tracing to measure where most of the time is spent
Date: Sun, 8 May 2016 17:06:07 +0700
Message-ID: <CACsJy8At5uLxtfcwnd5XdW8YVD7t8Hj=WSeh8WKqir2gM9d_SA@mail.gmail.com>
References: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
 <1462484831-13643-19-git-send-email-dturner@twopensource.com> <xmqqoa8k86kl.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 08 12:07:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLbz-0000K6-KG
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 12:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbcEHKGj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 06:06:39 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34489 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbcEHKGi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2016 06:06:38 -0400
Received: by mail-lf0-f41.google.com with SMTP id m64so172515644lfd.1
        for <git@vger.kernel.org>; Sun, 08 May 2016 03:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OxUrcjH70vhPuSwko5MoKi66m3ICoSdZwbARwjih19c=;
        b=N1IWtGyaQzNqmS3GvzQO/UBWCRPRm+drT0k4cypUnAqGo1YN/Ik1VbGuDEuxCecrHi
         7hqc4CgHPPZT/2FFvmZ+hKO1WsoMuDmYadxGVAdSXzBLlU7GTf+I8pqGuOoaqitTadz3
         NfiiGRWg7lKV2ngp5xMrIMNDz24h5F8QO53hSdlL4ROZkDY04jrFNmweVm55C95mdiqC
         KelUKsB/FkwxKbKmF5mv3uuaPNKW1oiMSkFi+FnBtUZjA4xcs2FLsKWI+T11S2W094db
         +/uxbKxsSssI9GoEz6QjNvpQfzz7tHOyHsrLxd6O13iSd2X7UgeuAu0w8RLoASM99Mcl
         rblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OxUrcjH70vhPuSwko5MoKi66m3ICoSdZwbARwjih19c=;
        b=Ar5Yi9cmFZD3QkM0TM7pAHtg/QKc41ncOmBpWdmj3V2a/sAY9kcuhIL5Rxvp8+dQkW
         PvJh8g0AEWyfvMYCbYoQXt/mwISeK7RaiQ01z2B/pi2xDRFTlxJnv83qPRiMbWy9kZ5x
         ohpgatkA+Jz4VReEmJPaoRDBldan4J3V1YcLnm3hvLLq6BG9FSGaN3FG1MpFXJzqCHyA
         DKfrEcg5H7Nb2QBr9kXWjwmPJTumjtLMZ+ENUuHPAUjGlT1Ck9Hp8Fmw79uqxWlvqko0
         z/Dxu3dPEzHOIsdMw1ZDAoEnr2lt1HqVWtVH2HjES1+k/oGYNA3vBIFd5XepOJ+lT2Ag
         p3Gw==
X-Gm-Message-State: AOPr4FUHZLderbLGO0JDl5j3RSjQpiw+cCsSwG5izM1JFDH3dHIwYbb6RxuFYpsjJdPinVHI7Z/gQulsUTY1GQ==
X-Received: by 10.112.54.132 with SMTP id j4mr13143868lbp.3.1462701996988;
 Sun, 08 May 2016 03:06:36 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Sun, 8 May 2016 03:06:07 -0700 (PDT)
In-Reply-To: <xmqqoa8k86kl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293958>

On Fri, May 6, 2016 at 5:48 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> David Turner <dturner@twopensource.com> writes:
>
>> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>> Subject: Re: [PATCH v8 18/19] Add tracing to measure where most of t=
he time is spent
>
> trace: measure where the time is spent in the index-heavy operations


Right. All these involve index somewhat, except read_packed_refs().
--=20
Duy
