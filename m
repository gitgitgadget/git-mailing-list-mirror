From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Makefile: update the default build options for AIX
Date: Wed, 07 May 2008 10:40:12 -0500
Message-ID: <4821CD5C.5010506@nrlssc.navy.mil>
References: <1210149355875-git-send-email-mike@abacus.co.uk>	 <4821992F.4060201@viscovery.net>	 <e2b179460805070551x7a0072e0w4d406ef4112849ce@mail.gmail.com>	 <4821AB32.8090700@viscovery.net> <4821BECA.8020509@nrlssc.navy.mil> <e2b179460805070815u6cc627feo6137084fe7c5a635@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 17:43:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtln3-000395-EQ
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 17:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760719AbYEGPlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 11:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760048AbYEGPlL
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 11:41:11 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:45183 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764199AbYEGPlG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 11:41:06 -0400
Received: from starfish.gems.nrlssc.navy.mil (starfish.nrlssc.navy.mil [128.160.50.76])
	by mail.nrlssc.navy.mil (8.13.8/8.13.8) with ESMTP id m47FeCxF018435;
	Wed, 7 May 2008 10:40:12 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 May 2008 10:40:12 -0500
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <e2b179460805070815u6cc627feo6137084fe7c5a635@mail.gmail.com>
X-OriginalArrivalTime: 07 May 2008 15:40:12.0884 (UTC) FILETIME=[A39FF940:01C8B058]
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81452>

Mike Ralphson wrote:
> 2008/5/7 Brandon Casey <casey@nrlssc.navy.mil>:
>> Johannes Sixt wrote:
>>  > The #define fopen in git-compat-util.h essentially defeats the effect of
>>  > _LARGE_FILES as far as fopen() calls are concerned: If
>>  > FREAD_READS_DIRECTORIES is not defined, fopen() would be redirected to
>>  > fopen64(), but when it is defined, it is redirected to git_fopen(), which
>>  > in turn uses fopen() instead of fopen64() (due to the #undef in
>>  > compat/fopen.c).
>>  >
>>
>>  How about something like this?
>>
>>  diff --git a/compat/fopen.c b/compat/fopen.c
>>  index ccb9e89..70b0d4d 100644
>>  --- a/compat/fopen.c
>>  +++ b/compat/fopen.c
>>  @@ -1,5 +1,5 @@
>>  +#undef FREAD_READS_DIRECTORIES
>>   #include "../git-compat-util.h"
>>  -#undef fopen
>>   FILE *git_fopen(const char *path, const char *mode)
>>   {
>>         FILE *fp;
>>
>>
>>  -brandon
>>
> 
> Ta. I still get all the warnings with that, was that what you were
> trying to solve? The 64 bit specific tests in t5302 do still pass.

Ah, yes. You would still get the warnings for every other file that
includes git-compat-util.h, except compat/fopen.c. I didn't think
about all of those. :) In this case those are indeed harmless. And now
the git provided git_fopen() will use the compiler selected fopen()
which should avoid any of the gotchas that Hannes brought up.

-brandon
