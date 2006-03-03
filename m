From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: bug?: stgit creates (unneccessary?) conflicts when pulling
Date: Fri, 03 Mar 2006 22:07:38 +0000
Message-ID: <4408BE2A.1060601@gmail.com>
References: <20060227204252.GA31836@diana.vm.bytemark.co.uk> <44037A5C.6080409@gmail.com> <b0943d9e0602281445w7160d915y@mail.gmail.com> <20060303142413.GB16456@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 03 23:08:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFIR7-0003Rs-LZ
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 23:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWCCWHm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 3 Mar 2006 17:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWCCWHm
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 17:07:42 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:32158 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750808AbWCCWHm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Mar 2006 17:07:42 -0500
Received: from aamta11-winn.ispmail.ntl.com ([81.103.221.35])
          by mta07-winn.ispmail.ntl.com with ESMTP
          id <20060303220740.LQWZ15056.mta07-winn.ispmail.ntl.com@aamta11-winn.ispmail.ntl.com>;
          Fri, 3 Mar 2006 22:07:40 +0000
Received: from [192.168.1.101] (really [86.15.186.141])
          by aamta11-winn.ispmail.ntl.com with ESMTP
          id <20060303220740.LBB1217.aamta11-winn.ispmail.ntl.com@[192.168.1.101]>;
          Fri, 3 Mar 2006 22:07:40 +0000
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
In-Reply-To: <20060303142413.GB16456@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17160>

Karl Hasselstr=F6m wrote:
> On 2006-02-28 22:45:56 +0000, Catalin Marinas wrote:
>>I attached another patch that should work properly. It also pushes
>>empty patches on the stack if they were merged upstream (a 'stg
>>clean' is required to remove them). This is useful for the push
>>--undo command if you are not happy with the result.
>=20
> It appears to work for me. I still had to fix things up manually when
> pulling the uncommit patch though, since you had made a minor change
> in "uncommit.py":
>=20
>   Pushing patch "uncommit"...Error: File "stgit/commands/uncommit.py"=
 added in branches but different

Yes, I made some minor modifications (one of them was the copyright).

> Is there a way to make stgit not fall on its face when faced with thi=
s
> situation? Surely it ought to be possible to create a merged file wit=
h
> conflict markers? (I realize this is harder when there is no common
> ancestor, but these files are 95% identical!)

I've been thinking about this but it's not straight-forward. I tried
using /dev/null as the common ancestor but both diff3 and wiggle put th=
e
whole file text in the conflict regions. These tools are not smart
enough to compare the conflict regions and reduce them.

Another approach would be to have a script that creates the common
ancestor only with the common lines between the two files and pass this
file as an argument to diff3. This wouldn't probably be that difficult,
maybe some combination of diff and sed and apply the result to one of
the files to remove the diff'ed lines.

Catalin
