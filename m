From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [RFC][PATCH] grep: enable threading for context line printing
Date: Sun, 14 Mar 2010 21:03:04 +0100
Message-ID: <4c8ef71003141303h474429aegc0a2eb2f97e7ff69@mail.gmail.com>
References: <4B9D2864.9090808@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Mar 14 21:03:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nqu1r-0000Yh-CD
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 21:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947Ab0CNUDL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Mar 2010 16:03:11 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:54356 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab0CNUDI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Mar 2010 16:03:08 -0400
Received: by fxm27 with SMTP id 27so3185244fxm.28
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 13:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bO1vJ3B1WdwGAE/gKVH9bYy7PWSxcnEBJ9+0RJIYt+Y=;
        b=QcbJ7OSHPoTpys7WHIJy+t4yJiunGt0+GDVlDoJ7wQVnYemfNuib1RsryTK4Jw/CDz
         JnSJ0oVHEPLO+Hctipk5k6CRQYhs2d1Pk5md3+whHA63uZN/GTUK+xK6gg7wj6bZapxw
         y+Tqm8txOMPBrd59YTPaTI3hQ3urR0k8naxvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=S1gQEJJsZiVOQbz1QQ49HzXYv83un67DgeY4RvSrt9zwpB+p1d/rIVJLXCOYWMPvxh
         rjeW1QOcuQkf1/HXY+7eQRWcyGOslW+4GQ/YxVKWWYvGuC3jhpsz7NoZYe1hUF2KKwOR
         4uQUBQsZvn8EFgsAGLdJ422gYtzfVEii62z/8=
Received: by 10.239.129.206 with SMTP id 14mr810915hbg.9.1268596984816; Sun, 
	14 Mar 2010 13:03:04 -0700 (PDT)
In-Reply-To: <4B9D2864.9090808@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142150>

On Sun, Mar 14, 2010 at 19:18, Ren=E9 Scharfe <rene.scharfe@lsrfire.ath=
=2Ecx> wrote:
> This patch makes work_done() in builtin/grep.c print hunk marks betwe=
en
> files if threading is used, while show_line() in grep.c still does th=
e
> same in the other case. =A0The latter is =A0controlled by the struct =
grep_opt
> member show_hunk_mark: 0 means show_line() prints no hunk marks betwe=
en
> files, 1 means it prints them before the next file with matches and 2
> means it prints them before matches from the current file.
>
> Having two places for this is a bit ugly but it enables parallel grep
> for the common -ABC options. =A0Locking should be fine in add_work().
>
> Comments?

The implementation looks correct. As you say it is a bit ugly, but I
think it is worth it anyway. (The solutions I managed to come up with
when I wrote the original threaded grep patch were even uglier, that
is why I simply disabled the threading in that case.)

Symbolic constants for the magic values 0, 1, and 2 would make the
code more readable.

- Fredrik
