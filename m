From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 8/9 v12] difftool: teach difftool to handle directory diffs
Date: Thu, 12 Apr 2012 19:53:27 -0700
Message-ID: <CAJDDKr4UbN3izmqa89CCH7OY4c9LOH0S2EbdUCxHK3G6GHd4xQ@mail.gmail.com>
References: <1334236726-18393-1-git-send-email-tim.henigan@gmail.com>
	<7viph46c1t.fsf@alter.siamese.dyndns.org>
	<CAFouetg6Ot8sKiNi45A0QRv6YYdL3Mwrb3tkVkajQQuZukSp3g@mail.gmail.com>
	<7v62d4692l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ramsay@ramsay1.demon.co.uk,
	Junio C Hamano <gitster@pobox.com>
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 04:53:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIWdi-0003ca-Sc
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 04:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756448Ab2DMCx3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 22:53:29 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37928 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab2DMCx2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 22:53:28 -0400
Received: by yenl12 with SMTP id l12so1457904yen.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 19:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XDmktsGdflMCP7G7uedbQ5tMTuZlw7wZ/TDyKl8kp7Q=;
        b=IRrprvz04awxF+4WiaGJKNK2UGwi9zkmDa3IUn7T9SY43uE9IOpZk5dDhvc1M0AKli
         brxIjnYfNG2BgFNnht7qzBU0/LEUOF6ZtHaFuUIdkx1xgYsFF2xR+8TadMXgOUIxXHrN
         +Mp+PwubniGrz0RSW4FzDqpZKCwwiUymZx+Qgndjmf9MUcNS8jTeXfe17PjzI9him+mi
         pZdjsrWpdQ3FKywUdunwjjxTtnPVm1vBhb1GJMDaGG72ysoYbeIFUZwIub/OPrUYtyV7
         mpqGxsPshqXLEpkUvI4oNAGCtL20RkA/4oes7l1kumo8kU/IyUY6q33skmhRSupCaxvU
         HYxg==
Received: by 10.100.213.8 with SMTP id l8mr80214ang.29.1334285608001; Thu, 12
 Apr 2012 19:53:28 -0700 (PDT)
Received: by 10.147.128.8 with HTTP; Thu, 12 Apr 2012 19:53:27 -0700 (PDT)
In-Reply-To: <7v62d4692l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195397>

On Thu, Apr 12, 2012 at 12:31 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Tim Henigan <tim.henigan@gmail.com> writes:
>
>> Would the following change be better?
>>
>> - =C2=A0 =C2=A0 my $cmd =3D "git diff --raw --no-abbrev -z " . join(=
" ", @ARGV);
>> + =C2=A0 =C2=A0 my $cmd =3D "git diff --raw --no-abbrev -z @ARGV";
>
> They look exactly the same to me.

The issue is that this does not properly handle shell characters, IFS, =
etc.

I think a simple solution would be to use git diff --exit-code --quiet =
here.

e.g.

    my $rc =3D system('git', 'diff', '--exit-code', '--quiet', @ARGV);

That avoids the shell and properly handles shell meta-characters, IFS, =
etc.
--=20
David
