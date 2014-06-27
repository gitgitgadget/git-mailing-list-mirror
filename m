From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Fri, 27 Jun 2014 10:19:50 +0200
Message-ID: <vpqzjgyg3x5.fsf@anie.imag.fr>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
	<1403518300-23053-3-git-send-email-tanayabh@gmail.com>
	<53A84077.4010200@ramsay1.demon.co.uk>
	<xmqqsimv9pjx.fsf@gitster.dls.corp.google.com>
	<53A99FEB.5040808@ramsay1.demon.co.uk>
	<xmqq61joamcc.fsf@gitster.dls.corp.google.com>
	<vpq1tubinbx.fsf@anie.imag.fr>
	<xmqqpphv4hu6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 10:20:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0RO7-0003hc-EA
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 10:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbaF0IT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 04:19:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43729 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752934AbaF0IT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 04:19:57 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s5R8Jn22008214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 Jun 2014 10:19:49 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s5R8Jo3C022775;
	Fri, 27 Jun 2014 10:19:50 +0200
In-Reply-To: <xmqqpphv4hu6.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 26 Jun 2014 12:00:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 27 Jun 2014 10:19:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s5R8Jn22008214
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1404461990.4556@xM+HMOhl+NWa8JCMlVVd4w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252540>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> When the submodule script that uses "git config -f .gitmodules" is
>>> converted into C, if the updated config API is ready, it may be able
>>> to do something like these in a single program:
>>>
>>> 	const char *url;
>>> 	struct config_set *gm_config;
>>>
>>>         /* read from $GIT_DIR/config */
>>>         url = git_config_get_string("remote.origin.url");
>>>
>>>         /*
>>>          * allow us to read from .gitmodules; the parameters are
>>>          * list of files that make up the configset, perhaps.
>>>          */
>>> 	gm_config = git_configset_new(".gitmodules", NULL);
>>>
>>>
>>>         if (!git_configset_get_bool(gm_config, "submodule.frotz.ignore")) {
>>> 		/* do a lot of stuff for the submodule */
>>>                 ...
>>> 	}
>>>
>>>         /* when we are done with the configset */
>>>         git_configset_clear(gm_config);
>>
>> Isn't that a bit overkill? Why not just let the caller manage a hashmap
>> directly instead of a config_set?
>
> Because I had an experience under my belt of a painful refactoring
> of "the_index" which turned out to be not just a single array, I
> simply suspect that the final data structure to represent a "set of
> config-like things" will not be just a single hashmap, hence I do
> prefer to have one layer of abstraction "struct config_set", which
> would contain a hashmap and possibly more.

OK, I guess I overinterpreted what you meant by "struct config_set". If
it's a thin abstraction layer on top of the hashmap (i.e. essentially
contain the hashmap, and possibly a few more metadata), then it
definitely makes sense.

> Doesn't "is the hashmap initialized" bit belong there, for example?

Yes.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
