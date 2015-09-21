From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG?] HEAD detached at HEAD
Date: Mon, 21 Sep 2015 09:42:40 +0200
Message-ID: <vpqk2rkcj67.fsf@anie.imag.fr>
References: <vpqk2rnirz0.fsf@anie.imag.fr>
	<CA+P7+xoeXiZd=WU460Xfjthe0U5BnAV69_KNKW39p10ZGLHx7g@mail.gmail.com>
	<vpqeghviqu1.fsf@anie.imag.fr>
	<CAGZ79kZxAwMvv6UoZLBd2wTOdj1DFWKQqSPBYL449KSokA8DQQ@mail.gmail.com>
	<vpqlhc3h7e7.fsf@anie.imag.fr> <55FFB267.3040106@drmicha.warpmail.net>
	<55FFB43B.5080002@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Sep 21 09:42:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdvkV-0000VJ-S5
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 09:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075AbbIUHmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 03:42:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33957 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756009AbbIUHmv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 03:42:51 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8L7gduY016418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 21 Sep 2015 09:42:39 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8L7gevr016787;
	Mon, 21 Sep 2015 09:42:40 +0200
In-Reply-To: <55FFB43B.5080002@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 21 Sep 2015 09:39:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 21 Sep 2015 09:42:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8L7gduY016418
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443426164.67317@jBuhbxeDz8SBQPwEnDSP0A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278283>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> ... in addition to my previous reply, looking at more context:
>
>>> --- a/wt-status.c
>>> +++ b/wt-status.c
>>> @@ -1319,6 +1319,13 @@ static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
>>>         hashcpy(cb->nsha1, nsha1);
>>>         for (end = target; *end && *end != '\n'; end++)
>>>                 ;
>>> +       if (!memcmp(target, "HEAD", end - target)) {
>>> +               /* Don't say "HEAD detached at HEAD" */
>>> +               unsigned char head[GIT_SHA1_RAWSZ];
>>> +               get_sha1("HEAD", head);
>>> +               strbuf_addstr(&cb->buf, find_unique_abbrev(head, DEFAULT_ABBREV));
>>> +               return 1;
>>> +       }
>>>         strbuf_add(&cb->buf, target, end - target);
>>>         return 1;
>>>  }
>>>
>>> What do you think?
>
> I think we should return (the hex repr. of) nsha1 instead of resolving
> HEAD at its current state. That should solve the present problem (and
> leave the more difficult reflog issue for the future).

Indeed, resolving HEAD to its current state is wrong. I'll submit a
proper patch soon.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
