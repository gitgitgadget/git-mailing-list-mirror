From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Rewriting git-repack in C
Date: Wed, 14 Aug 2013 09:12:27 +0200
Message-ID: <vpqbo50oiec.fsf@anie.imag.fr>
References: <1376421797-26443-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, iveqy@iveqy.com,
	gitster@pobox.com, apelisse@gmail.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 09:12:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9VGC-0005sd-5K
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 09:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755767Ab3HNHMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 03:12:44 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47538 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754157Ab3HNHMo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 03:12:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7E7CRs7006521
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 14 Aug 2013 09:12:27 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V9VFr-0006g3-Uv; Wed, 14 Aug 2013 09:12:28 +0200
In-Reply-To: <1376421797-26443-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Tue, 13 Aug 2013 21:23:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 14 Aug 2013 09:12:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7E7CRs7006521
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1377069150.81751@ke7Jyl1vSKxs9KRuqNaWNQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232266>

Stefan Beller <stefanbeller@googlemail.com> writes:

> Also I'd like to propose a small technical change:
> I found no easy way to get a subset of files in a specific directory,
> which is very easy in the shell version via * (rm file/in/dir/startswithprefix-*),
> So maybe instead of just prefixing the temporary files such as:
> $PACKDIR/.tmp-$PID-pack-*

If it's just a prefix, you can iterate over the full list of files, and
then use prefixcmp(...) to find the right files. May seem inefficient,
but AFAIK it's how the shell does wildcard expansion.

You should be carefull that if the operation is interrupted, the next
"git gc" must remove all the garbage, so if you change the naming
convention, you must also change the place where the cleanup is done.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
