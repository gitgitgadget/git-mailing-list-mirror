From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: Git completion not using ls-remote to auto-complete during push
Date: Thu, 18 Jun 2015 17:55:36 +0200
Message-ID: <20150618175536.Horde.csrWs9ln__S_ZM2wEkboXw1@webmail.informatik.kit.edu>
References: <CAHd499Dk44Fq5c_wadxT_kuCs5BdkRwKZWOHyAgE4oi7pezxPw@mail.gmail.com>
 <1434626973-4801-1-git-send-email-szeder@ira.uka.de>
 <CAHd499DeUOqsuSoysaOAAYORk3B=XBXco9yEKdXt8m4XJYFyZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan =?utf-8?b?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>,
	Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 17:55:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5cAL-0004id-J2
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 17:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755579AbbFRPzm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2015 11:55:42 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:46800 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754188AbbFRPzk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 11:55:40 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1Z5cAE-00065u-Pf; Thu, 18 Jun 2015 17:55:38 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1Z5cAC-0000ZO-EJ; Thu, 18 Jun 2015 17:55:36 +0200
Received: from x590cb72b.dyn.telefonica.de (x590cb72b.dyn.telefonica.de
 [89.12.183.43]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Thu, 18 Jun 2015 17:55:36 +0200
In-Reply-To: <CAHd499DeUOqsuSoysaOAAYORk3B=XBXco9yEKdXt8m4XJYFyZw@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1434642938.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272018>


Quoting Robert Dailey <rcdailey.lists@gmail.com>:

> On Thu, Jun 18, 2015 at 6:29 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de=
> wrote:
>> Quoting Robert Dailey <rcdailey.lists@gmail.com>
>>> I do the following:
>>>
>>> $ git push origin :topic
>>>
>>> If I stop halfway through typing 'topic' and hit TAB, auto-completi=
on
>>> does not work if I do not have a local branch by that name (sometim=
es
>>> I delete my local branch first, then I push to delete it remotely).=
 I
>>> thought that git completion code was supposed to use ls-remote to a=
uto
>>> complete refs used in push operations. Is this supposed to work?
>>
>> It's intentional.  Running 'git ls-remote' with a far away remote ca=
n
>> take ages, so instead we grab the refs on the remote from the locall=
y
>> stored refs under 'refs/remotes/<remote>/'.
>>
>> See e832f5c096 (completion: avoid ls-remote in certain scenarios,
>> 2013-05-28).  The commit message mentions that you can "force"
>> completion of remote refs via 'git ls-remote' by starting with the f=
ull
>> refname, i.e.  'refs/<TAB>', however, that seems to work only on the
>> left hand side of the colon in the push refspec.
>>
>> G=C3=A1bor
>>
>
> If that's indeed the case, then completion should work. I have a
> 'refs/remotes/origin/topic'. Why will auto complete not work even
> though this exists? Do multiple remotes cause issues (in theory there
> is no reason why it should cause problems, since it should know I'm
> auto-completing a ref on 'origin')?

The number of remotes doesn't matter.
What matters is which side of the colon the ref to be completed is.

You can complete

   git push origin refs/<TAB>

and

   git fetch origin refs/<TAB>

will even list you refs freshly queried via 'git ls-remote'.
However,

   git push origin :refs/<TAB>
   git push origin branch:refs/<TAB>

don't work, because there are no refs starting with the prefix =20
':refs/' or 'branch:refs/'.

G=C3=A1bor
