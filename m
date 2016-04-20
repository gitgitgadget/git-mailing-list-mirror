From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 06/12] wt-status.c: split rebase detection out of wt_status_get_state()
Date: Wed, 20 Apr 2016 20:54:27 +0700
Message-ID: <CACsJy8CV+MtLYumsej6VDkBZMqTmSHedpVhe6pwhz_Vokw3_fA@mail.gmail.com>
References: <1460897965-486-1-git-send-email-pclouds@gmail.com>
 <1461158693-21289-1-git-send-email-pclouds@gmail.com> <1461158693-21289-7-git-send-email-pclouds@gmail.com>
 <57178897.20509@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 15:55:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1assat-0005ko-S8
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 15:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbcDTNy7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 09:54:59 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36804 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbcDTNy7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2016 09:54:59 -0400
Received: by mail-lb0-f176.google.com with SMTP id ys16so9741272lbb.3
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 06:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jE7bZnnGn1BELBPufErSQ40f7JU2OPhia4GC2A/a+Xs=;
        b=uePfiyq8H84xhBQefB1f8X4RzevUEegRh66m6iin2sJQx+NMXfidNk/+OF5/i+7hcT
         FnDMgBGZnu9NXeygfTnSZ62zxCmrYBD3M7jBe6Zfek0vfywbsYDGqzlir3DMEK6JJLfq
         uvApHPxwPcvqAShyKQIfsVaxni7GQF956RLffTBv/stkPbHdLvVDprcCwOd2bLEf8zVg
         d518H2PUJD3HI2B0S53x3bN3pmJZIKrzh/h107IvSx2847rQEI0yccmlNXWiK6hgZPvB
         KX1q6Fpa5AakcZo6qnBpi7pIU8VxPMfOi063Lw0SrxOpYdNh/Gj2zSbuK98Dyj5NW42r
         q/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jE7bZnnGn1BELBPufErSQ40f7JU2OPhia4GC2A/a+Xs=;
        b=Lc29UljmysxINeAmjapjnktUAwx9miUWfbnH4NNkTWu3g1RY/QXXbpyl0PLRfgNWA0
         uf/aKuebB//uxiQzT8ivIKDdirOF1ZC3eKwURwcFYHBwhZYhdehiQOa3rxmyPf082V0e
         mkInQsyMWR1+YBydQzHL6m7UvGIlDOKTpwtj/kwNNrMk5ryQ2DPj929K/tOQiHq6UMte
         x5NjBDwPGr+iJUSBkPhSxGaYz5YgcKBETpp4Bfdu+lrDglrWKxABe0TYzFM35iGlzi1U
         XUsWfsgzA976dWgLfDJuI51KhzZBi1syeFpIxeP/4WB+C6zPwKxfOv7B6dT5/u3vv9gr
         RLzw==
X-Gm-Message-State: AOPr4FWc3am4P8xg+R+0KTdmksXIDUwdeL+2snIC/cOSIeA+TqC89r85qGIs7w7ACrmmtmSQELkyZbXzfxpfBg==
X-Received: by 10.112.130.41 with SMTP id ob9mr3690643lbb.81.1461160497286;
 Wed, 20 Apr 2016 06:54:57 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Wed, 20 Apr 2016 06:54:27 -0700 (PDT)
In-Reply-To: <57178897.20509@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292024>

On Wed, Apr 20, 2016 at 8:48 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 20/04/16 14:24, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> worktree.c:find_shared_symref() later needs to know if a branch is b=
eing
>> rebased, and only rebased only. Split this code so it can be used
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Err ... what?

wt_status_get_state() detects more than rebase, it does bisect,
cherry-pick, detached head as well. I "only" too much there though.
--=20
Duy
