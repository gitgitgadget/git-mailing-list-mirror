From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: "git -c web.browser=w3m help -w help" still kicks firefox
Date: Mon, 23 Aug 2010 21:02:36 +0200
Message-ID: <AANLkTi=R6ZdD9GUO6T6uCUkF+KVPbG1FGrieOfeusKct@mail.gmail.com>
References: <7viq3119yn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 21:02:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OncI8-0003IO-JP
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 21:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548Ab0HWTCk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Aug 2010 15:02:40 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42953 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258Ab0HWTCi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Aug 2010 15:02:38 -0400
Received: by gxk23 with SMTP id 23so2250596gxk.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 12:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=X2C8kxGXGX1dvF4OQF4H2npUw0MPhDsmGJ42qE4wwSs=;
        b=hkeP1hMe/ClxuyN137cBPOOtMY8e4EflBm7ugJTWXermWFtTGj+YW3fZTxcMrZSsyb
         gfH8rwAhv3gKCqu0/V+uLRQ/g5aTXWRjA2hwHlHFconZidjuGpjZcljtkNd5G6gfjstK
         NgyQM/OLgRsx51sZuDbuR5kNpjXiXFFCvLLb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PaGJHcFnR/BpCKWUOMexXgOLOtpN3P6oaozQnF2iYRM7k2H4EnxFB/dikDy+iwGnux
         7wIMKqMmXPlRM8KpWhCXPgP2bHHFe7/B57I9Xmyvk+6G3k7ltuKvfFHTSI+Pg1xgWwPR
         nXD+gVxBtyOHnF5aoQgpBr6bBBSrC15xzdqXw=
Received: by 10.90.118.19 with SMTP id q19mr3776226agc.89.1282590157048; Mon,
 23 Aug 2010 12:02:37 -0700 (PDT)
Received: by 10.231.186.213 with HTTP; Mon, 23 Aug 2010 12:02:36 -0700 (PDT)
In-Reply-To: <7viq3119yn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154244>

On Mon, Aug 23, 2010 at 20:05, Junio C Hamano <gitster@pobox.com> wrote=
:
> I know exactly why this happens---we save the config from the command=
 line
> on a list only so that we can apply them in the correct order after i=
tems
> coming from files, but we do not use the saved values to pass them ar=
ound
> to sub-git invocations.
>
> =C2=A08b1fa77 (Allow passing of configuration parameters in the comma=
nd line, 2010-03-26)
>
> A "trivial fix" would be to pass this info through the execv_git_cmd(=
)
> interface by either exporting it via an environment variable or by
> modifying the command line options, but I am not sure about the possi=
ble
> fallouts from such a change. =C2=A0For example, does "git -c var=3Dva=
lue config ..."
> work sensibly when what "config" is told to do (say, remove a section=
)
> contradicts with having the named var with a given value?
>
> I am wondering if this is worth fixing it in the first place.
>
> Opinions? =C2=A0Patches ;-)?
>

Maybe it is worth fixing, but on a case-by-case basis?

I mean changing the execv_git_cmd interface (or create a new execv func=
tion),
so that it can get the list of config vars to pass down to the callee. =
A trivial
case of its use would be to just pass the current config (or, more
likely, none).
Or, one could give it its own list of config parameters.
