From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Tue, 8 Jun 2010 11:39:38 -0300
Message-ID: <AANLkTilWg8hw5j20o-xGsVO-q_OeSmtKEKAO6O416qvH@mail.gmail.com>
References: <1275955088-32750-1-git-send-email-soft.d4rio@gmail.com>
	<1275955270-sup-2380@pinkfloyd.chass.utoronto.ca>
	<AANLkTinydWk3GqGDww8FS7pmW16jAVazRkmT_GsRMIhy@mail.gmail.com>
	<20100608053507.GB15156@coredump.intra.peff.net>
	<AANLkTilvvpy4TBQF6g8boQL87FRB7kFDrVfYiHvOv6xu@mail.gmail.com>
	<4C0E5103.7030501@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Ben Walton <bwalton@artsci.utoronto.ca>,
	git <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 08 16:40:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLzyq-00051f-W5
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 16:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323Ab0FHOjl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 10:39:41 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58267 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170Ab0FHOjk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 10:39:40 -0400
Received: by bwz11 with SMTP id 11so1183095bwz.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 07:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=x+NKmWuFn2zrxvxHcYz8rMxwRFM+UHl+3ES2tE8NDqA=;
        b=BW5AZWiUnf/hVGU8legFoz55fhqq0TsHz3fcSN2O0g/SnqR+Avk03dAmtcdzz6dJMs
         YaTuE6QbHHvo18MLhW/kIms7IZoRTBF+16UIYNYSLvdWRgwoLjkBkj9+HwE/QOazQKt1
         Vm4LFKK4CNYKWf+o4akrmtr7B0TydFnrUdm8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OgzrQITD+paAQp+/8bIiA2A46+lBE/Z9CA0NYXbTRZl2Pik3O8YaZvvhaKBk8FRDsp
         BOQkjgwvAbyNvXVbmpMEo4Tml6qYTxVVp+3CZaYCmiXQMRvSHGStqPQ6kO9yqvivK+AB
         iuSjh7D49InLyTM5+7E4UAE/Az8RvHvM//j7A=
Received: by 10.204.81.98 with SMTP id w34mr413848bkk.29.1276007978743; Tue, 
	08 Jun 2010 07:39:38 -0700 (PDT)
Received: by 10.204.46.80 with HTTP; Tue, 8 Jun 2010 07:39:38 -0700 (PDT)
In-Reply-To: <4C0E5103.7030501@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148678>

On Tue, Jun 8, 2010 at 11:17 AM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 6/8/2010 15:49, schrieb Dario Rodriguez:
>> we must correct
>> something... the other way is that if pager fails to execute, we
>> cannot simply return 0.
>
> But we do not return 0:
>
> =A0$ GIT_PAGER=3D/is/not/there git log
> =A0$ echo $?
> =A0141
>
> That's SIGPIPE, just as I would expect.
>

As I said in the original thread...

$ PAGER=3D/nothing/here ../git log
$ echo $?
0

$ GIT_PAGER=3D/nothing/here ../git log
$ echo $?
0

That's on AIX 5.2


> And with this change
>
> diff --git a/pager.c b/pager.c
> index dac358f..86519cc 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -89,9 +89,6 @@ void setup_pager(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0static const char *env[] =3D { "LESS=3D=
=46RSX", NULL };
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pager_process.env =3D env;
> =A0 =A0 =A0 =A0}
> -#ifndef WIN32
> - =A0 =A0 =A0 pager_process.preexec_cb =3D pager_preexec;
> -#endif
> =A0 =A0 =A0 =A0if (start_command(&pager_process))
> =A0 =A0 =A0 =A0return;
>
>
> I get:
>
> =A0$ GIT_PAGER=3D/is/not/there ./git log -1 --oneline
> =A0error: cannot run /is/not/there: No such file or directory
> =A01a16cee merge-recursive: demonstrate an incorrect conflict with su=
bmodule
>

Curious... I patched it on AIX and I get:

$ GIT_PAGER=3D/nothing/here ../git log
error: cannot run /nothing/here: No such file or directory
commit 3274a12f940680612e3bfd3d022a0eab460c0f1f
Author: usuario ####### <#######@Maquina01.(none)>
Date:   Thu Jun 3 20:02:23 2010 +0200

    OtherCom

commit acf110f7c878a37e4a5af8499134df28da0e8ab3
Author: usuario ####### <#######@Maquina01.(none)>
Date:   Thu Jun 3 20:01:37 2010 +0200

    inicial



However, the patch must delete the pager_preexec definition too... but
I wonder, do somebody still need it?

btw: I still think 'more' is much more sane fallback default than
'less'... look (with your patch applied):

$ ../git log
error: cannot run less: No such file or directory
commit 3274a12f940680612e3bfd3d022a0eab460c0f1f
Author: ####### <#######@Maquina01.(none)>
Date:   Thu Jun 3 20:02:23 2010 +0200

    OtherCom

commit acf110f7c878a37e4a5af8499134df28da0e8ab3
Author: ####### <#######@Maquina01.(none)>
Date:   Thu Jun 3 20:01:37 2010 +0200

    inicial
