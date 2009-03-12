From: Brian Campbell <brian.p.campbell@dartmouth.edu>
Subject: Re: [PATCH 2/2] [TopGit] Portability: Don't use alternation ("|") in sed regular expressions
Date: Thu, 12 Mar 2009 11:00:00 -0400
Message-ID: <78BA729B-0026-45D0-96FC-330700519AAB@dartmouth.edu>
References: <1236837389-35687-1-git-send-email-brian.p.campbell@dartmouth.edu> <1236837389-35687-2-git-send-email-brian.p.campbell@dartmouth.edu> <7viqmfjklm.fsf@gitster.siamese.dyndns.org> <20090312074524.GA14844@pengutronix.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu Mar 12 16:22:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhmfU-0007Hk-9e
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 16:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756581AbZCLPQ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 11:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755964AbZCLPQZ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 11:16:25 -0400
Received: from mailhub24.dartmouth.edu ([129.170.5.24]:46900 "EHLO
	mailhub24.dartmouth.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755624AbZCLPQY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 11:16:24 -0400
X-Greylist: delayed 965 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2009 11:16:24 EDT
Received: from [130.189.179.215] ([130.189.179.215])
	(authenticated bits=0)
	by mailhub24.dartmouth.edu (8.13.5/DND2.0/8.13.5) with ESMTP id n2CExxsf014367
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 12 Mar 2009 11:00:00 -0400
In-Reply-To: <20090312074524.GA14844@pengutronix.de>
X-Mailer: Apple Mail (2.930.3)
X-Dartmouth.EDU-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: n2CExxsf014367
X-MailScanner: Found to be clean by mailhub21.dartmouth.edu
X-MailScanner-From: brian.p.campbell@dartmouth.edu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113075>

On Mar 12, 2009, at 3:45 AM, Uwe Kleine-K=F6nig wrote:

>> - You will be utterly confused by a local branch whose name is
>>   "refs/top-bases/foo"
> You mean a branch that has the full name refs/heads/refs/top-bases/=20
> foo?
> Well OK, valid concern.

Yes, you're right, this is a problem.

>> To fix these, you might want to do something like:
>>
>> 	if head_=3D$(git symbolic-ref HEAD)
>>        then
>>                case "$head_" in
>>                refs/heads/*)
>>                        echo "${head_#refs/heads/}"
>>                        ;;
>>                refs/top-bases/*)
>>                        echo "${head_#refs/top-bases/}"
>>                        ;;
>>                *)
>>                        echo "$head_"
>>                        ;;
>>                esac
>> 	else
>>        	whatever you want to do on a detached HEAD
>> 	fi
> Thanks Junio and Brian.
>
> Brian, do you update the series?

Sure, I'll send an updated patch.

I'm thinking that for the detached HEAD case, this function should die =
=20
with a message about not being on a valid branch, and then the call =20
site in tg-summary that doesn't care about being on a valid branch =20
should ignore the error and leave curname empty. Does that sound about =
=20
right? I'm fairly new to doing Bourne shell scripting, so I don't yet =20
have a good sense of how these things should be structured.

Also, has anyone considered writing a test suite for TopGit? I =20
actually got fairly deep in to a series of 10 or so patches before I =20
hit these problems, since tg-create worked fine as long as I only =20
supplied one dependency, and I didn't notice the second issue until I =20
tried to do a tg-update after modifying one of my base patches.

-- Brian