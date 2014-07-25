From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH 1/3] config --global --edit: create a template file if needed
Date: Fri, 25 Jul 2014 19:52:35 +0200
Message-ID: <vpq61il9vh8.fsf@anie.imag.fr>
References: <1406295891-7316-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqioml732e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 19:52:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAjfj-0008B4-9x
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 19:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934758AbaGYRwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 13:52:43 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51583 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753394AbaGYRwn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 13:52:43 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6PHqXrN012393
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Jul 2014 19:52:33 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6PHqZfB022795;
	Fri, 25 Jul 2014 19:52:35 +0200
In-Reply-To: <xmqqioml732e.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 25 Jul 2014 10:36:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 25 Jul 2014 19:52:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6PHqXrN012393
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406915556.25432@HsA4rJ+qOR/dneh1lIqL7Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254243>

Junio C Hamano <gitster@pobox.com> writes:

> Probably a good idea; I do not think of any possible interactions we
> have to worry about with the configuration file init-db creates with
> possible templating.

The feature should trigger only for --global, so it shouldn't interfer
with .git/config and templates.

> Do we use "user-wide" as a phrase to refer to these?  It sounds
> somewhat funny to call anything specific to $frotz "$frotz-wide", at
> least to me.
>
> Surely, /etc/gitconfig is called "site-wide".  But .git/config is
> per-project (or project-specific), and I would always have thought
> that ~/.gitconfig was "per-user".

I'm not a native speaker, but to me, "user-wide" insists on the fact
that it applies to everything for this user, and "per-user" insists on
the fact that it does not apply to other users.

Perhaps just "Git's user configuration file" would be enough.

>>  builtin/config.c | 30 +++++++++++++++++++++++++++---
>>  cache.h          |  1 +
>>  ident.c          |  2 +-
>>  3 files changed, 29 insertions(+), 4 deletions(-)
>>
>> diff --git a/builtin/config.c b/builtin/config.c
>> index fcd8474..3821697 100644
>> --- a/builtin/config.c
>> +++ b/builtin/config.c
>> @@ -445,6 +445,20 @@ static int get_urlmatch(const char *var, const char *url)
>>  	return 0;
>>  }
>>  
>> +static char *default_user_config()
>
> static char *default_user_config(void)

Right. Doing too much C++.

>> +{
>> +	struct strbuf buf = STRBUF_INIT;
>> +	strbuf_addf(&buf,
>> +		    _("# This is Git's user-wide configuration file.\n"
>> +		      "[core]\n"
>> +		      "# Please, adapt and uncomment the following lines:\n"
>
> tangent: is it a French tradition to always have comma after please?

Perhaps. In French, the comma would be required after "S'il vous plait"
(litterally, "if you like"). I'll remove it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
