From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 5/8] config: add `git_die_config()` to the config-set API
Date: Tue, 05 Aug 2014 17:15:27 +0200
Message-ID: <vpqiom72cj4.fsf@anie.imag.fr>
References: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>
	<1406912756-15517-6-git-send-email-tanayabh@gmail.com>
	<xmqqoaw0ruwf.fsf@gitster.dls.corp.google.com>
	<53DFD729.8090307@gmail.com> <vpqegwwauo2.fsf@anie.imag.fr>
	<53E0F057.1040706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 17:16:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEgTk-0006Gk-ED
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 17:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbaHEPQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 11:16:39 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56822 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752364AbaHEPQj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 11:16:39 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s75FFPJJ009530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 5 Aug 2014 17:15:26 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s75FFRNd014100;
	Tue, 5 Aug 2014 17:15:27 +0200
In-Reply-To: <53E0F057.1040706@gmail.com> (Tanay Abhra's message of "Tue, 05
	Aug 2014 20:25:19 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 05 Aug 2014 17:15:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s75FFPJJ009530
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407856527.82305@r1O32EBriMVg9NOTzArp/g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254807>

Tanay Abhra <tanayabh@gmail.com> writes:

> Matthieu, I have finished the new version, but instead of flooding the mailing list with
> a series again, I wanted to confirm if the new git_config_die() is alright.
>
> 	NORETURN __attribute__((format(printf, 2, 3)))
> 	void git_die_config(const char *key, const char *err, ...)
> 	{
> 		const struct string_list *values;
> 		struct key_value_info *kv_info;
>
> 		if (err) {
> 			va_list params;
> 			va_start(params, err);
> 			vreportf("error: ", err, params);
> 			va_end(params);
> 		}
> 		values = git_config_get_value_multi(key);
> 		kv_info = values->items[values->nr - 1].util;
> 		git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
> 	}
>
> Currently works like the old git_config() error reporting path. If err is set to "NULL",
> it would print no error message and just the die message. If given something like,
>
> 	 git_config_die(key, "value '%s' is not allowed", value);
>
> it would print,
>
> 	error: value '3' is not allowed
> 	fatal: bad config variable 'core.frotz' at file line 15 in .git/config

That seems to be a good step forward.

I think we would also want to improve the error message, but that
shouldn't block your series from inclusion: we can do that later without
API change.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
