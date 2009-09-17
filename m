From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 04/15] Set _O_BINARY as default fmode for both MinGW and
 	MSVC
Date: Thu, 17 Sep 2009 11:03:53 +0200
Message-ID: <4AB1FB79.5070903@viscovery.net>
References: <cover.1253088099.git.mstormo@gmail.com>	 <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com>	 <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com>	 <4AB10F01.9010703@viscovery.net>	 <e2480c70909161300o3db4b416k8f33ccce2f987c55@mail.gmail.com>	 <4AB1E118.70504@viscovery.net> <4AB1E4C5.80102@gmail.com>	 <4AB1E6E4.1040100@viscovery.net> <4AB1EB02.2090308@gmail.com>	 <4AB1EF0E.5010600@viscovery.net> <e2480c70909170139x9580bb4pcc1ad8e1b93aef17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com,
	raa.lkml@gmail.com,
	Marius Storm-Olsen <marius.storm-olsen@nokia.com>
To: Alexey Borzenkov <snaury@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 11:04:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoCuT-0007JR-Py
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 11:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096AbZIQJEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 05:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754801AbZIQJED
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 05:04:03 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:35728 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757AbZIQJEC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 05:04:02 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MoCuA-0006Xm-BM; Thu, 17 Sep 2009 11:04:02 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 061C5BC81; Thu, 17 Sep 2009 11:03:53 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <e2480c70909170139x9580bb4pcc1ad8e1b93aef17@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128736>

Alexey Borzenkov schrieb:
> On Thu, Sep 17, 2009 at 12:10 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Marius Storm-Olsen schrieb:
>>> BTW, I ran all the tests (make /k test) before and after the
>>> whole series, with msysgit 'devel' branch + plain git.git 'next',
>>> and it turns out that 2 more tests pass after this series :)
>> Sorry to disappoint you: these 2 tests only passed by chance. For a
>> work-around see e95a73ef in mingw.git (it papers over an undetected
>> racily-clean index).
> 
> Maybe we should just implement nsec for mingw? The code is already almost there:

First thing to do is to understand what is going on: There are other
architectures that do not have nsec and that do *not* have the problem;
why do we have a problem on Windows? If you cannot answer this question,
an nsec solution would still just be "it happens to work", and not "it
works by design".

I think I had analyzed this particular case, and I understood it, but did
not make notes why I found it satisfactory to just paper over the issue,
and today I don't remember anymore. :-/

> Since we already reimplement stat/lstat/fstat it should be relatively
> simple and we don't care about usage of mingw's stat.

Don't forget utime().

> Do you want me to cook up a patch?

I consider an answer to the question "why do we need nsec?" more important.

BTW: t4130-apply-criss-cross-rename.sh fails quite often as well. This
time it is because we fill in st_ino = 0 instead of some useful value. The
test moves files around that happen to have identical sizes. After the
operation, the dirty working tree could be noticed because st_ino differs
from the index. But since we always set it to 0, it is not noticed.
(That's my theory.)

If you make a patch, can you think about this issue as well?

-- Hannes
