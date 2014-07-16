From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v9r2 1/2] add `config_set` API for caching config-like files
Date: Wed, 16 Jul 2014 19:06:14 +0200
Message-ID: <vpqzjg9z115.fsf@anie.imag.fr>
References: <1405434571-25459-1-git-send-email-tanayabh@gmail.com>
	<1405434571-25459-3-git-send-email-tanayabh@gmail.com>
	<xmqqk37ewr5r.fsf@gitster.dls.corp.google.com>
	<53C665A0.2060705@gmail.com> <vpqvbqxjzfx.fsf@anie.imag.fr>
	<53C66E70.3050507@gmail.com> <vpqha2h9tjw.fsf@anie.imag.fr>
	<53C6ABEB.3060205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 19:07:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Sfo-0008SP-AD
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 19:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965235AbaGPRHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 13:07:14 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49912 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027AbaGPRHM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 13:07:12 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6GH6Bik024067
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jul 2014 19:06:12 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6GH6ELH027755;
	Wed, 16 Jul 2014 19:06:14 +0200
In-Reply-To: <53C6ABEB.3060205@gmail.com> (Tanay Abhra's message of "Wed, 16
	Jul 2014 22:14:27 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 16 Jul 2014 19:06:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6GH6Bik024067
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406135174.75757@JeaYuwfKAPDXyn+nTimXSw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253677>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 7/16/2014 9:36 PM, Matthieu Moy wrote:
>> Tanay Abhra <tanayabh@gmail.com> writes:
>>> +static void git_config_check_init(void)
>>> +{
>>> +	if (the_config_set.hash_initialized)
>>> +		return;
>>> +	git_configset_init(&the_config_set);
>>> +	git_config(config_set_callback, &the_config_set);
>>> +}
>> 
>> So, you're now ignoring the return value of git_config. What is the
>> rationale for this? In particular, why did you reject the "die"
>> possibility (I understood that you were inclined to take this option, so
>> I'm curious why you changed your mind).
>>
>
> The errors (non accessible, non existent files etc) were already being caught by
> git_config_early(). Since git_config() only returns positive values except
> the weird race case you mentioned, I thought the die confused the reader
> of the patch more than it provided error checking. I also tried myself
> simulating the race condition but failed. All the callers of git_config()
> also ignore the return value, so I ended up ignoring the return value myself.

OK. My preference would be to die, but your argument makes sense.

> But I do think that an access_or_warn() check should be put on git config --file
> and git_configset_add_file since other parts of git follow it. What do
> you think about it, still I will send followup patch correcting the git config
> --file condition where it silently ignores the file access error and continues?

I think it should be done, but should not be your priority (i.e. it's
good to do it, but only if the patch is trivial enough).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
