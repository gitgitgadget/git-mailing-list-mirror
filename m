From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [bug] generic issue with git_config handlers
Date: Mon, 04 Feb 2008 18:01:55 +0100
Message-ID: <47A74503.4090201@viscovery.net>
References: <20080131091627.GB24403@artemis.madism.org> <7v1w7ye48j.fsf@gitster.siamese.dyndns.org> <20080131101037.GG24403@artemis.madism.org> <200802040727.44522.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git ML <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Feb 04 18:03:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM4ir-0005XD-Ge
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 18:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803AbYBDRCF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Feb 2008 12:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754386AbYBDRCE
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 12:02:04 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:14297 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298AbYBDRCB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2008 12:02:01 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JM4hN-0005PD-V5; Mon, 04 Feb 2008 18:01:39 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1ED4E6EF; Mon,  4 Feb 2008 18:01:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200802040727.44522.chriscool@tuxfamily.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72525>

Christian Couder schrieb:
> Le jeudi 31 janvier 2008, Pierre Habouzit a =E9crit :
>> On Thu, Jan 31, 2008 at 09:25:32AM +0000, Junio C Hamano wrote:
>>> Pierre Habouzit <madcoder@debian.org> writes:
>>>>   One of my co-workers stumbled upon a misfeature of the git confi=
g
>>>> parser. The following syntax is allowed:
>>>>
>>>>     [section]
>>>> 	 foo
>>> Yeah, that is how "truth" value of boolean is spelled.
>>>
>>>> [user]
>>>>     name
>>> That's very unfortunate.  Whatever is expecting string value
>>> should check for NULL.  Fix should probably be easy enough for
>>> any git-hacker-wannabe to tackle ;-)
>>   I think so too, though my count is something like 40 functions to
>> investigate (the 40 handlers) and where it recurses into ;) Too much
>> work for the time I have right now.
>=20
> I would suggest this patch:
>=20
> ---8<---
> diff --git a/config.c b/config.c
> index 526a3f4..92613c5 100644
> --- a/config.c
> +++ b/config.c
> @@ -139,7 +139,7 @@ static int get_value(config_fn_t fn, char *name,=20
> unsigned in
>                 if (!value)
>                         return -1;
>         }
> -       return fn(name, value);
> +       return fn(name, value ? value : "");
>  }

You can't. The reason is that get_config_bool() treats value =3D=3D NUL=
L and
*value =3D=3D '\0' differently. *That's* the most unfortunate part of i=
t. :-(

-- Hannes
