From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 0/4] More helpful 'git status' during 'rebase -i'
Date: Wed, 01 Jul 2015 10:12:00 +0200
Message-ID: <vpq7fqkz48f.fsf@anie.imag.fr>
References: <1435669275-32102-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqpp4cbxz6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 10:12:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAD8A-0000E3-Gd
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 10:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbbGAIM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 04:12:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49901 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695AbbGAIMN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 04:12:13 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t618C0lv031446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Jul 2015 10:12:00 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t618C0mq009482;
	Wed, 1 Jul 2015 10:12:00 +0200
In-Reply-To: <xmqqpp4cbxz6.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 30 Jun 2015 16:03:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 01 Jul 2015 10:12:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t618C0lv031446
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436343123.3331@P/LHe/Rgt9PrJsCSf8jLkQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273137>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> This series makes "git status" provide an output like
>>
>>   interactive rebase in progress; onto $ONTO
>>   Last commands done (2 commands done):
>>      pick $COMMIT2 two_commit
>>      exec exit 15
>>   Next commands to do (2 remaining commands):
>>      pick $COMMIT3 three_commit
>>      pick $COMMIT4 four_commit
>>     (use "git rebase --edit-todo" to view and edit)
>>
>> in addition to the existing output, when ran during an interactive
>> rebase.
>
> I'd prefer to see these $COMMITn abbreviated, just like $ONTO.

Indeed. It's not as easy as it would seem because we're in wt-status.c
and can't call a shell function like collapse_todo_ids directly, but
I've re-implemented it in C, it's not that bad.

Patch follows. The first two patches are unchanged. wt-status.c now
abbreviates the sha1, and the tests are adapted (rev-parse -> rev-parse
--short) where needed in patch 3 and 4.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
