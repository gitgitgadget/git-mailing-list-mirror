From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [RFC 0/9] bisect: allow git bisect to be used with repos
 containing damaged trees.
Date: Tue, 26 Jul 2011 23:28:15 +1000
Message-ID: <CAH3AnroGQML+FV_Zh9u35bOBed00bk3qcQ1qA==RpmtTv1zz2w@mail.gmail.com>
References: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
	<7v1uxfwmq3.fsf@alter.siamese.dyndns.org>
	<CAH3AnrrVwodvtwWfaJCJqjuHThtv75jaWeDjvwRgdFbgXA3ziA@mail.gmail.com>
	<4E2DBA84.3090405@kdbg.org>
	<CAH3AnrrOdduUG_rS97fR_PRZAWb6y3uPa_oKDZenEX2gG-AvAQ@mail.gmail.com>
	<m3ei1dsd1x.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 15:28:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlhgL-0004Gk-KJ
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 15:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303Ab1GZN2R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jul 2011 09:28:17 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:65086 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883Ab1GZN2Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2011 09:28:16 -0400
Received: by vxh35 with SMTP id 35so297008vxh.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 06:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=/Ni/MeKyiNQmrnha6S0YXfbEmHY8xmLVmHRgO7wN+sA=;
        b=sAAcAlpMg00BmpTR9PO6QNiSCFKQIE1X0ERXgqxe74Pf6ys4fopXncR+vhOOiX27H/
         FJNCPo2Xf6U7uLiBYJf0R4bUjwnjqEHkERHgWgmNt7Cl3MNR1NppGmFWa8pp5pE5DOjd
         3RTWPhBD4PZye5npFbWiFUzQ4kfwXiKNJFCRQ=
Received: by 10.52.89.194 with SMTP id bq2mr5610337vdb.374.1311686895459; Tue,
 26 Jul 2011 06:28:15 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Tue, 26 Jul 2011 06:28:15 -0700 (PDT)
In-Reply-To: <m3ei1dsd1x.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177867>

> Which means that it works in this case:
>
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0bad bad bad
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BAD
> =C2=A0 good good good
>
>
> but won't work in this case:
>
>
>
> =C2=A0 good good good =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 good good good
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bad ba=
d bad
>

Of course, this doesn't mean that bisection is useless, only that you
have to choose the right kind of test!

So, while it is true that a commit local test such as those I was
proposing (e.g. git ls-tree or even my suggested tweak git rev-list
--objects --max-count=3D1) will be useless unless you happen to start
with the tip at the bad commit, it is not true that bisection in
general is useless.

=46or example, Junio's unconstrained git rev-list --objects | git
pack-objects test will be sufficient because a history that is

    good good good bad bad bad good good good

according to a commit local test, will be:

     bad bad bad bad bad bad bad good good good

from the point of view of a test that reaches the entire graph
reachable from a commit.

It will still be beneficial to do log(N) executions of git rev-list
--objects instead of  N executions of the same.

jon.
