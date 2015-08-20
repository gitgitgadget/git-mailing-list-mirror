From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] wt-status: move #include "pathspec.h" to the header
Date: Fri, 21 Aug 2015 00:35:06 +0200
Message-ID: <20150821003506.Horde.cIQHHynKCAfMFot8jSGGhg7@webmail.informatik.kit.edu>
References: <1440079587-26491-1-git-send-email-szeder@ira.uka.de>
 <xmqq61497pc1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 00:35:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSYQd-0005dw-UA
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 00:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbbHTWfS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2015 18:35:18 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:40289 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751732AbbHTWfR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 18:35:17 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1ZSYQT-0003IZ-Na; Fri, 21 Aug 2015 00:35:13 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1ZSYQM-0000io-Sa; Fri, 21 Aug 2015 00:35:06 +0200
Received: from x590d6ed3.dyn.telefonica.de (x590d6ed3.dyn.telefonica.de
 [89.13.110.211]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Fri, 21 Aug 2015 00:35:06 +0200
In-Reply-To: <xmqq61497pc1.fsf@gitster.dls.corp.google.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1440110113.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276268>


Quoting Junio C Hamano <gitster@pobox.com>:

> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>> The declaration of 'struct wt_status' requires the declararion of 's=
truct
>> pathspec'.
>
> I think this is fine.
>
> I am guessing that you are saying it is wrong to force wt-status.c
> to include pathspec.h before including wt-status.h; I am fine with
> that.

> This is a tangent, but the above is different from saying that with
> a single liner test.c that has
>
>   #include "wt-status.h"
>
> your compilation "cc -c test.c" should succeed.

Sort of, but not quite, rather a combination of both.  My point is a
builtin command, starting with #include "builtin.h" as it should, that
wanted to use only struct wt_status_state and wt_status_get_state()
from the wt-status machinery and has nothing to do with pathspecs, yet
it's not sufficient to #include "wt-status.h", because the required
pathspec.h is included in the .c file instead of the header itsef.
(Actually, that's exactly how I noticed.)


> But for that goal,
> direct inclusion of <stdio.h> to wt-status.h is also iffy.  We
> include the system headers from git-compat-util.h because some
> platforms are picky about order of inclusion of system header files
> and definitions of feature test macros.
>
> Right now, the codebase is correct only because it is NOT our goal
> to guarantee that such a single-liner test.c file compiles.
> Instead, everybody is instructed to #include "git-compat-util.h" as
> the first thing, either directly or indirectly.
>
> So in that sense, we should also remove that inclusion from
> wt-status.h, I think.
>
> Thanks.
