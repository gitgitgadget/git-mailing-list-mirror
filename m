From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 3/4] Teach builtin-add to pass multiple paths to git-add--interactive
Date: Thu, 22 Nov 2007 11:28:17 +0100
Message-ID: <825BAB3C-FAB4-4A48-AB94-FAAF5B808CD1@wincent.com>
References: <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com> <1195689773-28601-1-git-send-email-win@wincent.com> <1195689773-28601-2-git-send-email-win@wincent.com> <1195689773-28601-3-git-send-email-win@wincent.com> <1195689773-28601-4-git-send-email-win@wincent.com> <20071122090828.GC7153@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 11:29:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv9Iv-0008CM-DG
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 11:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbXKVK2r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 05:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbXKVK2r
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 05:28:47 -0500
Received: from wincent.com ([72.3.236.74]:57176 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751802AbXKVK2q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 05:28:46 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAMASIv2010469;
	Thu, 22 Nov 2007 04:28:18 -0600
In-Reply-To: <20071122090828.GC7153@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65772>

El 22/11/2007, a las 10:08, Jeff King escribi=F3:

> On Thu, Nov 22, 2007 at 01:02:52AM +0100, Wincent Colaiuta wrote:
>
>> -int interactive_add(const char *path)
>> +int interactive_add(const char **argv, int argc)
>> {
>> -	const char *argv[3] =3D { "add--interactive", path, NULL };
>> -
>> -	return run_command_v_opt(argv, RUN_GIT_CMD);
>> +	int status;
>> +	const char **args =3D xmalloc(sizeof(const char *) * (argc + 1));
>> +	args[0] =3D "add--interactive";
>> +	memcpy((void *)args + sizeof(const char *), argv, sizeof(const =20
>> char *) * argc);
>
> The source for the memcpy (argv) is sometimes NULL. The standard =20
> forbids
> this, even when the size field is 0. I have no idea if any reasonable
> implementations actually care.

Good point. I've now conditionalized the memcpy with an "if (argc > =20
0)". While I was at it I also got rid of the unneeded cast to void *.

> But...
>
>> +		if (argc > 0)
>> +			exit(interactive_add(argv, argc));
>> 		else
>> -			exit(interactive_add(NULL));
>> +			exit(interactive_add(NULL, 0));
>
> There really is no reason to pass NULL at all (since the argc limits =
=20
> us
> anyway), so we can just get rid of the conditional and simplify to:
>
>  exit(interactive_add(argv, argc));
>
> for both cases.

Yes, that's a nice cleanup. Thanks for suggesting it.

Cheers,
Wincent
