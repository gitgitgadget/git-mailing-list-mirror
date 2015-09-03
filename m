From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove perl dependant commands if NO_PERL is set
Date: Thu, 03 Sep 2015 13:15:20 -0700
Message-ID: <xmqqr3mfi7jb.fsf@gitster.mtv.corp.google.com>
References: <1441298147-83601-1-git-send-email-garga@FreeBSD.org>
	<xmqq7fo7jp1e.fsf@gitster.mtv.corp.google.com>
	<2CFFD89E-7059-4C1C-B715-15C5F6C2D295@FreeBSD.org>
	<xmqq37yvjmza.fsf@gitster.mtv.corp.google.com>
	<86C44806-98FB-4E67-83DF-197103B48BB2@FreeBSD.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Renato Botelho <garga@FreeBSD.org>
X-From: git-owner@vger.kernel.org Thu Sep 03 22:15:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXaut-0006Pi-0i
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 22:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbbICUPX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 16:15:23 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35743 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbbICUPW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 16:15:22 -0400
Received: by pacfv12 with SMTP id fv12so595548pac.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 13:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=YBNba3MWcjjESqeCUf0Dkk0y5hMjRAPpduaxSrj9SSc=;
        b=qh+UZw/Zgw9mUUlbRvokPH9OXAe7Ypm04N+U/xp/mR+WbImkRf2JFCliMiCtNEn28e
         lR1+htvIH1drfFVFP1z5fX+BK9Smbh6Rb8p5sNVjsYL4vcBfSbpDGyEao6kROLpx7lJd
         qB7D9X81eUVq41dNy3ju0S38jqKtrDWzwaCZi29bxVnio0X/zDN+TTIgOd6cjrnqjiE0
         Kpw8EFU/qvm15sJB0GLODJfqQNG2W1PgFbZ55tfkPISAcDO71fe0536Dl137Dfy5y+CS
         GlDbJP9dBXsizH4s5Q0ogh5aJcI+KcYPC/OnNCFqCETHDB6lSXFplf+mSAUzxkY7L/WR
         O7gQ==
X-Received: by 10.68.114.196 with SMTP id ji4mr71755887pbb.46.1441311321890;
        Thu, 03 Sep 2015 13:15:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id ps4sm26241956pdb.19.2015.09.03.13.15.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 13:15:21 -0700 (PDT)
In-Reply-To: <86C44806-98FB-4E67-83DF-197103B48BB2@FreeBSD.org> (Renato
	Botelho's message of "Thu, 3 Sep 2015 17:02:38 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277252>

Renato Botelho <garga@FreeBSD.org> writes:

>> Not really.  Anything brand-new that comes this late in the cycle
>> will not be in 2.6, so the earliest release this NO_PERL change can
>> appear in is one after the upcoming release.
>
> Even if it=E2=80=99s a bug that produce a broken installation?

Absolutely.

The way we do things around here is to do new features early in the
cycle before -rc0, fixes to pre-existing bugs before -rc1 and after
that we go to regression fixes only until the final.  And use of
Perl in submodule or request-pull is anything new in 2.6, I think.

This is a fix to pre-existing issue, and I haven't tagged -rc1 yet,
but speaking from experience, anything that I can poke a hole after
staring at it for only 20 seconds (see my other message about this
patch defining two different ways to build the same thing) has a
high chance of having other issues that will hurt other people in a
way other than the trivial "staring at it for 20-second" issue,
which would introduce a real regression.

Between an unknown regression and a known longstanding bug, we tend
to take the latter.

> Nevermind, I=E2=80=99ll add the patch into FreeBSD ports so FreeBSD u=
sers can
> have a sane package installed.

Sure.  That would help in the long term, as it will result in a
well-cooked fix in 2.7; by that time hopefully the 'submodule' bit
would not be necessary, but request-pull may still be using Perl.
