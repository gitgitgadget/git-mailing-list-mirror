From: Brian Campbell <brian.p.campbell@dartmouth.edu>
Subject: Re: [PATCH 2/2] [TopGit] Portability: Don't use alternation ("|") in sed regular expressions
Date: Thu, 12 Mar 2009 12:41:45 -0400
Message-ID: <F3665462-16BC-42D6-BE28-F66CF48CEB9B@dartmouth.edu>
References: <20090312152039.GA15626@pengutronix.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu Mar 12 18:02:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhoDV-0005PX-W2
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 17:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755755AbZCLQzj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 12:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755490AbZCLQzj
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 12:55:39 -0400
Received: from mailhub1.dartmouth.edu ([129.170.16.122]:46149 "EHLO
	mailhub1.dartmouth.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689AbZCLQzi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 12:55:38 -0400
X-Greylist: delayed 797 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2009 12:55:37 EDT
Received: from [130.189.179.215] ([130.189.179.215])
	(authenticated bits=0)
	by mailhub1.dartmouth.edu (8.13.5/DND2.0/8.13.5) with ESMTP id n2CGfjgf020429
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 12 Mar 2009 12:41:45 -0400
In-Reply-To: <20090312152039.GA15626@pengutronix.de>
X-Mailer: Apple Mail (2.930.3)
X-MailScanner: Found to be clean by mailhub.Dartmouth.EDU
X-MailScanner-From: brian.p.campbell@dartmouth.edu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113089>

On Mar 12, 2009, at 11:20 AM, Uwe Kleine-K=F6nig wrote:

>>>> To fix these, you might want to do something like:
>>>>
>>>> 	if head_=3D$(git symbolic-ref HEAD)
> Shouldn't git symbolic-ref -q HEAD be used here?

Yes, most likely.

>>>>       then
>>>>               case "$head_" in
>>>>               refs/heads/*)
>>>>                       echo "${head_#refs/heads/}"
>>>>                       ;;
>>>>               refs/top-bases/*)
>>>>                       echo "${head_#refs/top-bases/}"
>>>>                       ;;
>>>>               *)
>>>>                       echo "$head_"
>>>>                       ;;
>>>>               esac
>>>> 	else
>>>>       	whatever you want to do on a detached HEAD
> How do I  distinguish between a detached HEAD and another error?  I =20
> have
> the feeling that git symbolic-ref -q HEAD should exit(0) with a =20
> detached
> HEAD.

If you pass -q, it exits with status 1 on a detached head, 128 on =20
other errors, so we can use that to distinguish.

>
>>> Thanks Junio and Brian.
>>>
>>> Brian, do you update the series?
>>
>> Sure, I'll send an updated patch.
>>
>> I'm thinking that for the detached HEAD case, this function should =20
>> die
>> with a message about not being on a valid branch, and then the call =
=20
>> site
>> in tg-summary that doesn't care about being on a valid branch should
>> ignore the error and leave curname empty. Does that sound about =20
>> right?
> mmh, I would return "" and let the caller handle that.

=46air enough.

>> Also, has anyone considered writing a test suite for TopGit?
> Yes, but I didn't found the time for that until now.  If you'd =20
> volunteer
> that would be very welcome.

I would, but I'm not sure I'll be continuing to use TopGit for more =20
than the one patch series I'm using it for now; I was trying it out, =20
but it feels a little more heavy-weight than what I want. StGIT or =20
just rewriting a patch series with git rebase -i works better for my =20
uses; I'm not maintaining a lot of long-lived topic branches upon =20
which I need full history.

> IMHO we should reuse as much as possible from git.git.  For me even
> requiring a git.git checkout to use its files would be OK.  I conside=
r
> that even better then duplicating the relevant files.

Hmm. How would the tests find your git working tree? I'd be willing to =
=20
start the process off at least by writing test cases for the =20
functionality I'm changing here if I had a good idea of how to start. =20
Would it be sufficient to make something like "GIT_CHECKOUT=3D~/src/git=
 =20
make check" work?

-- Brian
