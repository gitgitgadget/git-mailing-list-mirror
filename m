From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v10 2/2] pull --rebase: add --[no-]autostash flag
Date: Fri, 25 Mar 2016 19:37:06 +0100
Message-ID: <vpq7fgql7zh.fsf@anie.imag.fr>
References: <1458584283-23816-1-git-send-email-mehul.jain2029@gmail.com>
	<1458591170-28079-1-git-send-email-mehul.jain2029@gmail.com>
	<vpqshzfuduv.fsf@anie.imag.fr>
	<CA+DCAeTNv-2RkbGo+ciKP_bfCvThKjGAsJEr=xuBYBFgrTvGtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 19:37:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajWbu-0004Eo-B8
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbcCYShQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:37:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51587 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753207AbcCYShM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:37:12 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u2PIb4Ta016030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 25 Mar 2016 19:37:04 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u2PIb6Ni003867;
	Fri, 25 Mar 2016 19:37:06 +0100
In-Reply-To: <CA+DCAeTNv-2RkbGo+ciKP_bfCvThKjGAsJEr=xuBYBFgrTvGtg@mail.gmail.com>
	(Mehul Jain's message of "Fri, 25 Mar 2016 23:40:04 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Fri, 25 Mar 2016 19:37:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u2PIb4Ta016030
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1459535824.87811@eUv3A3L/otvVd8FyZGqN6w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289936>

Mehul Jain <mehul.jain2029@gmail.com> writes:

> On Fri, Mar 25, 2016 at 2:35 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Mehul Jain <mehul.jain2029@gmail.com> writes:
>>
>>> +--autostash::
>>> +--no-autostash::
>>> +     Before starting rebase, stash local modifications away (see
>>> +     linkgit:git-stash[1]) if needed, and apply the stash when
>>> +     done. `--no-autostash` is useful to override the `rebase.autoStash`
>>> +     configuration variable (see linkgit:git-config[1]).
>>> ++
>>> +This option is only valid when "--rebase" is used.
>>
>> This does not have to be added to this series (I don't want to break
>> everything at v10 ...), but I think it would be nice to allow "git pull
>> --autostash" even without --rebase if pull.rebase=true.
>
> This is a nice observation. As current patch allow "git pull --autostash"
> to be run without --rebase if pull.rebase=true,

OK, I misread the patch assuming that opt_rebase was only reflecting the
options, but it is also set by the config:

	if (opt_rebase < 0)
		opt_rebase = config_get_rebase();

> hence correct documentation should be something like this
>
>     This option is only valid when "--rebase" is used or pull.rebase=true.

... or just "when pull is used in rebase mode", which is shorter and
still technically accurate. I don't think you need to be exhaustive in
this kind of documentation, the user will notice anyway if he tries to
use --autostash in a forbidden situation.

> But OTOH users who knows about pull.rebase understands that
> pull.rebase=true means "git pull --rebase ..." will be executed whenever
> "git pull ..." is called, thus for those users it might be easy to deduce that
> need of "--rebase" for validity of "--autostash" is not necessary if
> pull.rebase=true.

I'd rather have something technically correct.

I think you should also change one of the tests to use pull.resbase=true
so that this behavior is properly tested.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
