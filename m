From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: From P4 to Git
Date: Mon, 3 Aug 2009 10:47:29 +0200
Message-ID: <81b0412b0908030147i34a7440dg982c7a6e7dc51bca@mail.gmail.com>
References: <85ljm84lat.fsf@oqube.com> <m3fxcg3473.fsf@localhost.localdomain>
	 <85r5vxbd8e.fsf@oqube.com> <200907311122.43918.jnareb@gmail.com>
	 <81b0412b0907310414x7157fecey947da960ff8be1cc@mail.gmail.com>
	 <4A76967B.7080502@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Arnaud Bailly <abailly@oqube.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Mon Aug 03 10:48:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXtDF-0007Ut-DJ
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 10:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbZHCIrc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Aug 2009 04:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754449AbZHCIrb
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 04:47:31 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:50259 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754444AbZHCIrb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Aug 2009 04:47:31 -0400
Received: by fxm17 with SMTP id 17so2496055fxm.37
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 01:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RV8+P0+IDsbIaDSo2PAnWoBIHN5Yqc254YCn/0IOEY0=;
        b=btz45yHE1c+nxNNwEM02y0zrvCMAMiihmH+dSWLCsNa8UqxyXWaw4M2eEbSf0/vOGu
         tcPLLhSYrMpw+7fqPGuDwCxGB1tOnJB1ZMOWc719dE/xZRu5/09h1MUqkabnh44PxHMo
         O/iXSHeLN4WhW3DjizCZMDfbe6VmQ358rmrDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XvDurxdO3bHiq0zboGvCX4RmOfvu3KuAK14kUN9DEixXg57mhS69K5ArQHepaRiNba
         PTbG+hxjGQKSOhJDsLT4IVNytQ3tLrHRdLWncqtNYX5eDQHCZVnYAKfZREAKgcb5WVx2
         GqEIsPThFHuHEiokdQ3Ur40uRDxG9ITf1S56I=
Received: by 10.204.112.11 with SMTP id u11mr4772906bkp.134.1249289249846; 
	Mon, 03 Aug 2009 01:47:29 -0700 (PDT)
In-Reply-To: <4A76967B.7080502@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124690>

On Mon, Aug 3, 2009 at 09:49, Sam Vilain<sam@vilain.net> wrote:
> Alex Riesen wrote:
>>> So it looks like you wouldn't _need_ to split source tree into sepa=
rate
>>> smaller repositories for performance reasons. =C2=A0Still it might =
be good
>>> idea to put separate (sub)projects into separate repositories. =C2=A0=
But
>>> I guess you can do that even at later time (although it would be be=
st
>>> to do this upfront).
>>>
>>
>> It looks like they use P4 branches. Which are NOT branches as Git
>> understands it (a line of history). The P4 "branches" are just direc=
tories
>> with some metadata regarding recording where the data in the directo=
ry
>> were before an act of "branching" (just a server-side recursive copy=
).
>>
>> In this case (and this must be, as there are no other branches in P4=
),
>> they'll have to split their repository.
>
> p4's branches are 'close enough'. =C2=A0My tool travels through the h=
istory
> of the repository forwards, detects paths where new content was place=
d
> and calls those roots. =C2=A0When branching is detected (recorded
> file-by-file in perforce), it puts the branch source as a new parent.
> When branches are 'integrated', it makes a fuzzy decision based on th=
e
> number of outstanding merges it thinks are due, also based on a merge
> base calculation on the current view of the derived history. =C2=A0It=
 allows
> manual correction of this fuzzy information, and arbitrary grafting
> along the way. =C2=A0Discrepancies between the fuzzy decision and the=
 actual
> integration records are recorded in the commit log along with other
> metadata including the commit ID.

Sounds dangerous. And interesting...

Is it an import-once tool, or can the process be restarted? (because it=
 looks
like the script needs a complicated setup).
Can it be used from a client machine? And more importantly:
can the branches be found from incomplete history,
restricted by path and changelist range? (because, in a corporate
setup, clients seldom have full access to all data).
