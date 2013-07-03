From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 2/7] wrap-for-bin: Make bin-wrappers chainable
Date: Wed, 03 Jul 2013 22:38:19 +0200
Message-ID: <vpqvc4r751g.fsf@anie.imag.fr>
References: <1372804789-12732-1-git-send-email-benoit.person@ensimag.fr>
	<1372804789-12732-3-git-send-email-benoit.person@ensimag.fr>
	<vpqfvvvq5bl.fsf@anie.imag.fr>
	<7v38rve6i9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: benoit.person@ensimag.fr, git@vger.kernel.org,
	Celestin Matte <celestin.matte@ensimag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 22:38:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuToy-0002T5-69
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 22:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933075Ab3GCUic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 16:38:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38763 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756179Ab3GCUib (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 16:38:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r63KcHvN029775
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 3 Jul 2013 22:38:17 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UuToi-0001Sk-1A; Wed, 03 Jul 2013 22:38:20 +0200
In-Reply-To: <7v38rve6i9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 03 Jul 2013 13:24:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 03 Jul 2013 22:38:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r63KcHvN029775
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1373488699.53724@mX1N3BZ5nHk0G86f5tertg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229527>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> benoit.person@ensimag.fr writes:
>>
>>> diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
>>> index 53a8dd0..dbebe49 100644
>>> --- a/wrap-for-bin.sh
>>> +++ b/wrap-for-bin.sh
>>> @@ -14,7 +14,7 @@ else
>>>  	GIT_TEMPLATE_DIR='@@BUILD_DIR@@/templates/blt'
>>>  	export GIT_TEMPLATE_DIR
>>>  fi
>>> -GITPERLLIB='@@BUILD_DIR@@/perl/blib/lib'
>>> +GITPERLLIB='@@BUILD_DIR@@/perl/blib/lib:'"$GITPERLLIB"
>>
>> Then you need to do something like this to prevent broken $GITPERLLIB in
>> user's configuration from interfering with the testsuite:
>>
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -92,6 +92,7 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e '
>>         print join("\n", @vars);
>>  ')
>>  unset XDG_CONFIG_HOME
>> +unset GITPERLLIB
>>  GIT_AUTHOR_EMAIL=author@example.com
>>  GIT_AUTHOR_NAME='A U Thor'
>>  GIT_COMMITTER_EMAIL=committer@example.com
>
> Yes, that is a good point.
>
> It introduces a chicken-and-egg circularity for git-mw tests to use
> the common test infrastructure by dot-sourcing this file, though,
> no?

I don't get it. It Git Mediawiki's tests, the tests scripts source
test-lib.sh, that unsets GITPERLLIB. Then, it calls the
mw-to-git/bin-wrapper/git that sets it properly, and calls the
toplevel's bin-wrapper.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
