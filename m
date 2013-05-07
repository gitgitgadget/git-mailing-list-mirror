From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Mon, 6 May 2013 23:47:37 -0500
Message-ID: <CAMP44s3vGKv-Z6sx0sjAPH7_U1+AiJjFHjKz8ke+EUqW-u2Y=A@mail.gmail.com>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-5-git-send-email-felipe.contreras@gmail.com>
	<87y5bw3q1s.fsf@hexa.v.cablecom.net>
	<CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com>
	<518785B3.3050606@alum.mit.edu>
	<87ip2wflg0.fsf@linux-k42r.v.cablecom.net>
	<518789D1.4010905@alum.mit.edu>
	<CAMP44s1Nk7YAjNkTq=ShQbzkMasw6bpcEPTXLb8x+2q-vXLRGg@mail.gmail.com>
	<518874A5.5050002@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 07 06:47:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZZoY-0002oI-GY
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 06:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757915Ab3EGErm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 00:47:42 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:52426 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757580Ab3EGErl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 00:47:41 -0400
Received: by mail-lb0-f170.google.com with SMTP id t11so278632lbd.1
        for <git@vger.kernel.org>; Mon, 06 May 2013 21:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=pqB1QLHF/mlbq2wTEsyTiVjaiS0KfgwUHk8Wc4VKMcs=;
        b=tTgvms/A9Xpe5Pen6xHvhenRL1XQqZADfBcoOmg+WaLmIiZerdY1JLUgAngw135k/P
         iggaRzU0291b5vXyaKAJKxyJexQqi/rqA8Zi5XfDaGpvR9SB8Mez7N2HRijgs1hq7XPk
         I8HN0R9HAfebtFuIYQaWn0DJSxaiVGAAKTEJMJRHs21C6DKx728IuDJEpDk2t0JTFZF0
         UckNDXEwODTXdcS2NOqYUWXwD5HzS6DLFO8ri43e4qC7A3SLKBryIZiDUhy1utgOecrn
         iw77tFW66CqVmDxCRh09tDtDtNuy/4WDdIS93NYWD8yHAqhksjHKfWZuh5vknGKD6wqY
         zi/A==
X-Received: by 10.152.29.165 with SMTP id l5mr175653lah.8.1367902057547; Mon,
 06 May 2013 21:47:37 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 6 May 2013 21:47:37 -0700 (PDT)
In-Reply-To: <518874A5.5050002@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223545>

On Mon, May 6, 2013 at 10:27 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:

> You conjectured earlier that nobody uses blob marks, and I provided a
> counterexample.  Then you proposed a workaround that would require
> changes to the cvs2git documentation, and I even explained how your
> proposed workaround is not as flexible as the status quo.

cvs2git does *not* need blob marks, it does not need marks at all.

The use-case that you mentioned has nothing to do with cvs2git, in
fact. I can be described as this:

% ./generate-blobs > blobs
% git fast-import --export-marks=marks < blobs
% ./generate-commits > commits
% git fast-import --import-marks=marks < commits

In this example 'generate-commits' has no notion of marks at all, and
'git fast-import' doesn't need marks to process both blobs and
commits.

> Do you want
> to go through the same argument with every possible user of git-fast-import?

I don't care about possible users, I care about *real* users.

> It would be insanity to change the default behavior when a workaround on
> the Git side (namely adding an option that tells git-fast-import *not*
> to emit blob marks) would be quite straightforward to implement and have
> little maintenance cost.

And nobody would benefit from that.

>>> Making the export of blob marks optional would of course be OK, as long
>>> as the default is to export them.
>>
>> Nobody benefits from leaving the default as it is.
>
> Sure they do.  Any tool that *knows* that it doesn't need blob marks can
> pass the new option and benefit.  Other tools benefit from not being
> broken by your change.

Which the *vastly* more common case? That blobs are needed, or that
they are not?

-- 
Felipe Contreras
