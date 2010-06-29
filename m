From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: notify alternative to auto gc?
Date: Tue, 29 Jun 2010 08:46:47 +0200
Message-ID: <vpqtyom72ug.fsf@bauges.imag.fr>
References: <EA7717AE-DA72-48D7-A27E-C958896FD158@gmail.com>
	<AANLkTil8sHZrfvHetwzjhOsyprsqrf7-XRS3B8qKH7cs@mail.gmail.com>
	<5D3639C2-2528-4125-91E0-8D78D4844511@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Karl Stenerud <kstenerud@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 08:46:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTUav-0003oy-4B
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 08:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457Ab0F2Gqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 02:46:51 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53678 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629Ab0F2Gqv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 02:46:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5T6c5hY021551
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 29 Jun 2010 08:38:05 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OTUal-0006Du-NI; Tue, 29 Jun 2010 08:46:47 +0200
In-Reply-To: <5D3639C2-2528-4125-91E0-8D78D4844511@gmail.com> (Karl Stenerud's message of "Mon\, 28 Jun 2010 12\:52\:13 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 29 Jun 2010 08:38:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5T6c5hY021551
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1278398287.30764@vstC4K6T7HgEqjYN42dtxw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149887>

Karl Stenerud <kstenerud@gmail.com> writes:

> In the case which I observed, the time from typing "git pull" until
> the auto-gc notification was a few seconds.  The time from the
> notification until gc completion, however, was 3-4 minutes.

The missing bit here is how often this happens.

Once you did an actual "git gc", your repository is stored in a single
pack file, and only new files are stored unpacked or in separate
packs. Subsequent "git gc --auto" will just pack unpacked objects
together by groups of approximately "gc.auto" (i.e. 6700), which is
quick, until you reach "gc.packlimit" (i.e. 50). You'll trigger an
expansive repack only after that. So, roughly, you'll get an expansive
repack after creating 300,000 object files (unless you ran "git gc" in
the meantime). Unless you do very nasty things with your repo, that
really means "not often", and especially "not often enough that you
should care" in 99.9% cases.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
