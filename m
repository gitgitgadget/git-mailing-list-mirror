From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: update the default build options for AIX
Date: Wed, 07 May 2008 09:04:11 -0700
Message-ID: <7vfxsudrt0.fsf@gitster.siamese.dyndns.org>
References: <1210149355875-git-send-email-mike@abacus.co.uk>
 <4821992F.4060201@viscovery.net>
 <e2b179460805070551x7a0072e0w4d406ef4112849ce@mail.gmail.com>
 <4821AB32.8090700@viscovery.net> <4821BECA.8020509@nrlssc.navy.mil>
 <e2b179460805070815u6cc627feo6137084fe7c5a635@mail.gmail.com>
 <4821CD5C.5010506@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed May 07 18:06:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtm9P-0005uV-8H
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 18:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758560AbYEGQEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 12:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758174AbYEGQE3
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 12:04:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378AbYEGQE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 12:04:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3F6484D85;
	Wed,  7 May 2008 12:04:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 41C774D82; Wed,  7 May 2008 12:04:21 -0400 (EDT)
In-Reply-To: <4821CD5C.5010506@nrlssc.navy.mil> (Brandon Casey's message of
 "Wed, 07 May 2008 10:40:12 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 44285940-1C4F-11DD-B7FC-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81456>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Mike Ralphson wrote:
>> 2008/5/7 Brandon Casey <casey@nrlssc.navy.mil>:
>>> Johannes Sixt wrote:
>>>  > The #define fopen in git-compat-util.h essentially defeats the effect of
>>>  > _LARGE_FILES as far as fopen() calls are concerned: If
>>>  > FREAD_READS_DIRECTORIES is not defined, fopen() would be redirected to
>>>  > fopen64(), but when it is defined, it is redirected to git_fopen(), which
>>>  > in turn uses fopen() instead of fopen64() (due to the #undef in
>>>  > compat/fopen.c).
>>>  >
>>>
>>>  How about something like this?
>>>
>>>  diff --git a/compat/fopen.c b/compat/fopen.c
>>>  index ccb9e89..70b0d4d 100644
>>>  --- a/compat/fopen.c
>>>  +++ b/compat/fopen.c
>>>  @@ -1,5 +1,5 @@
>>>  +#undef FREAD_READS_DIRECTORIES
>>>   #include "../git-compat-util.h"
>>>  -#undef fopen
>>>   FILE *git_fopen(const char *path, const char *mode)
>>>   {
>>>         FILE *fp;
>>>
>>>
>>>  -brandon
>>>
>> 
>> Ta. I still get all the warnings with that, was that what you were
>> trying to solve? The 64 bit specific tests in t5302 do still pass.
>
> Ah, yes. You would still get the warnings for every other file that
> includes git-compat-util.h, except compat/fopen.c. I didn't think
> about all of those. :) In this case those are indeed harmless. And now
> the git provided git_fopen() will use the compiler selected fopen()
> which should avoid any of the gotchas that Hannes brought up.

In any case, that #undef then #include dance needs a big comment on why it
has to be so.
