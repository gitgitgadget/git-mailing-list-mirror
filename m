From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] completion: avoid "words" as variable name for zsh portability
Date: Wed, 27 Apr 2011 13:09:28 +0300
Message-ID: <BANLkTikN7iMa_z7wRN8pUS07SMatpyoDPQ@mail.gmail.com>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
	<20110427013534.GA14286@elie>
	<7v62q0b8e0.fsf@alter.siamese.dyndns.org>
	<20110427064033.GB4226@elie>
	<BANLkTinA5hfddqpGwOBjk+2oFDpwqORrSg@mail.gmail.com>
	<20110427091140.GB14849@elie>
	<BANLkTi=3T2B=Gtyk7V_3DB3V+GkbXAaqPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stefan Haller <lists@haller-berlin.de>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Mark Lodato <lodatom@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 12:09:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF1gd-0002ky-Nm
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 12:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757554Ab1D0KJa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 06:09:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45556 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756Ab1D0KJ3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 06:09:29 -0400
Received: by fxm17 with SMTP id 17so1014588fxm.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 03:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PsDtemkQJ9ZI0NYAeWWcp2v04vTSOuhvr3W9gXw5VTg=;
        b=IKbNw7466xS0L3m/qXV3fF+zlMI78etXNZ4Vf8xMJI0kb/L2sxyL8cSUKm46XluieZ
         H7696coWzYRiMvDN333fwZ8kzEGiK9qE0ugrzlahBRUSxEF3mmJagUdrPWhLmV8bh/HW
         scoAXuQ905Ua4P33jKgE442DnCW5Mg5satWxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HvMX9t95BTRawgGRGqOm0HhGDCoseOXvkItaYNu3a3HxuswvyWYgwE0Elv5Pl/3fKV
         XngC8ivPX4YJPhOrynfdfJCEelBPcC9k5+rIB6RdnFFCkOYPNYSQT0XYcF3fybck0Rhw
         kLVGJ7C98jkJBzjdIi2LrHImAd9GHHh/vS58s=
Received: by 10.223.87.215 with SMTP id x23mr2145195fal.32.1303898968707; Wed,
 27 Apr 2011 03:09:28 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Wed, 27 Apr 2011 03:09:28 -0700 (PDT)
In-Reply-To: <BANLkTi=3T2B=Gtyk7V_3DB3V+GkbXAaqPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172212>

On Wed, Apr 27, 2011 at 12:49 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, Apr 27, 2011 at 12:11 PM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>> Thanks. =C2=A0It looks like to get the semantics I expect from "loca=
l"
>> in zsh, one needs to use "typeset -h" (which bash does not support,
>> unfortunately). =C2=A0Probably it is best to steer clear of zsh's sp=
ecial
>> variables anyway.
>
> Hmm, interesting, maybe we should try to find a way to replace those
> 'local' with 'typeset -h'.

This seems to do it:

--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -75,6 +75,10 @@

 if [[ -n ${ZSH_VERSION-} ]]; then
        autoload -U +X bashcompinit && bashcompinit
+
+       # 'words' has special meaning in zsh, and only typeset -h seems=
 to
+       # override that
+       alias local=3D"typeset -h"
 fi

 case "$COMP_WORDBREAKS" in

--=20
=46elipe Contreras
