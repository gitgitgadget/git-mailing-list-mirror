From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] add -u: get rid of "treewideupdate" configuration
Date: Sat, 9 Apr 2011 12:05:45 +0700
Message-ID: <BANLkTinSZeNizg+8wEu_wjc09E_1dius5Q@mail.gmail.com>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-3-git-send-email-gitster@pobox.com> <20110408175149.GA3917@sigill.intra.peff.net>
 <7vaag04k8m.fsf@alter.siamese.dyndns.org> <20110408202404.GA16540@sigill.intra.peff.net>
 <7vmxk01izn.fsf@alter.siamese.dyndns.org> <20110408223206.GA7343@sigill.intra.peff.net>
 <7vei5c1iat.fsf@alter.siamese.dyndns.org> <7vaag01gdl.fsf@alter.siamese.dyndns.org>
 <20110409043824.GA22543@do> <7v39ls10q6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 07:06:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8QNU-0001ri-WD
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 07:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460Ab1DIFGR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Apr 2011 01:06:17 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42676 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab1DIFGQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Apr 2011 01:06:16 -0400
Received: by bwz15 with SMTP id 15so3302812bwz.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 22:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=f6ognlCzUqcwjmbTHapY09s7xDZQWIFlFV94IGlrwXE=;
        b=xQ7jqa4S8kuHfvQ61bNIcqt26gnKGFiJiN9eWILnvDkvoDrKVaLSB0sEupGKl/MZbs
         0T8PXwNSMwucfGz7xOUs70NGkMz3IavQuEBhz2D2BJk+q7/aR8lOaP3CqJ4zVdAYXt1s
         HiOwN+cr0AUJrAt8xCQr+VJDYM+flLWcwYDGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=YwmIzN7v8tpjCe0pxGY0d6b8OzdmVgFD28P6CRRGT2wvgyOfFFm+g4lD2cAKwR/PxR
         SzXkTlGn3EEe2ZuIvfx3ebXQuPPKa4XXpjsORkSTw9IDznECnRvwrCYyox5AVkzEmPq1
         BsI/UkSnwscDClrzIA6AOSqdyLJJ3awpkedwQ=
Received: by 10.204.16.209 with SMTP id p17mr2095068bka.17.1302325575104; Fri,
 08 Apr 2011 22:06:15 -0700 (PDT)
Received: by 10.204.37.195 with HTTP; Fri, 8 Apr 2011 22:05:45 -0700 (PDT)
In-Reply-To: <7v39ls10q6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171183>

On Sat, Apr 9, 2011 at 11:56 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Instead, when we refactor get/init-pathspec API, we could expose an
> interface to turn one element from argv[] into a "struct pathspec_ite=
m".
> Then we can try to feed argv[i] to that string-to-pathspec_item funct=
ion,
> and consider that argv[i] _is_ a proper pathspec only if it parses
> correctly *and* if it matches either an item in the current working t=
ree.
>
> That would be a moral equivalent of the current verify_filename() che=
ck
> but is far more precise one; e.g. the current code rejects
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git grep -e foo '*.c' ;# bad
>
> because '*.c' is not an object name, but lstat("*.c") fails, and you =
need
> to disambiguate with '--'. =C2=A0If you rewrite the verify_filename()=
 in the
> way I outlined above, you wouldn't have to.

I considered that, but we may need to go through the whole worktree
just to verify "*.c" matches something. The worst case scenario can be
expensive (eg. doing that on a-forest-with-no-c-file gentoo-x86.git).
Alternative approach is recognize "*.c" has wildcard and let it pass
without actually matching.
--=20
Duy
