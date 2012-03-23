From: Lucian Poston <lucian.poston@gmail.com>
Subject: Re: [PATCH v2 2/3] Adjust stat width calculations to take --graph
 output into account
Date: Thu, 22 Mar 2012 21:44:48 -0700
Message-ID: <CACz_eye13q0BkBTTGgx8VDBKgBydOrAM8Wx6dx+j90ibbpRszA@mail.gmail.com>
References: <1332444461-11957-1-git-send-email-lucian.poston@gmail.com>
	<1332444461-11957-2-git-send-email-lucian.poston@gmail.com>
	<7vd384wejl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Bo Yang <struggleyb.nku@gmail.com>,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 05:44:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAwMw-0000x0-C3
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 05:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812Ab2CWEou convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Mar 2012 00:44:50 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51042 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab2CWEot convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Mar 2012 00:44:49 -0400
Received: by yenl12 with SMTP id l12so2451023yen.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 21:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=U593NQw2gsXLStVSrux1twxTvFU9wpugy5V0gqMAAoo=;
        b=DBeLcGoZdjM4Kpr80ZuoCzgH63haFB3CFxmRFjc6xDKzNxibyV53Xu6Z32ExMnIIiI
         dguIYNk4nIKQ+oMOLI+GYijE9wmOa7+AXq48XtvW496jLLqwDYQMPYvneBRdfqFr5bkM
         4wSh+1S5yOB9Z/T1b1mQb9IdSHfW3lK3pTYEWEMMJ4Argyl6F9dXZgC8TilX6bk2i+M8
         hpAjIq1lKrqjLT+cVpw2dRC8rJI9pYZYThCqpQFcWh3IKBRQXQNYA1bgVdGws4XQ3DB4
         Ms4D5r6BAgBMdKcKljZV+J9q+/SzZZpsL7AG8gGBpBMwhjbzCc9VQn1IgVh7keZVmDWe
         yQIw==
Received: by 10.68.230.99 with SMTP id sx3mr25977507pbc.55.1332477888244; Thu,
 22 Mar 2012 21:44:48 -0700 (PDT)
Received: by 10.68.47.232 with HTTP; Thu, 22 Mar 2012 21:44:48 -0700 (PDT)
In-Reply-To: <7vd384wejl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193744>

2012/3/22 Junio C Hamano <gitster@pobox.com>:
> That explains the regression you are introducing, but does not justif=
y it.
>
> When you start showing that line, do you already know how many column=
s at
> the left edge of the display will be consumed by the ancestry graph p=
art?
>
> When the command is run without "--graph" option, the answer would
> obviously be zero, but if it is non-zero, wouldn't it be a more sensi=
ble
> solution to the problem to subtract that width from the total allowed
> display width (e.g. on 200-column terminal, if the ancestry graph par=
t at
> the left edge uses 20-columns, you do exactly the same as the current
> algorithm but use 180 as the width of the terminal). =C2=A0When --sta=
t-width is
> explicitly given, that specifies the width of whatever comes after th=
e
> ancestry graph part, so there is no need to change anything.
>
> Am I missing something, or is there something deeper going on?

The approach you describe would work. The only issue is the current
calculations slightly run off the rails when the number of columns is
less than 26 or so (or, similarly and more frequently, when the
difference between the terminal columns and ancestry graph columns is
less than ~26). To keep the diff-stat output (more or less)
unmodified, I'll simply add a conditional to address this case, rather
than my more drastic approach.
