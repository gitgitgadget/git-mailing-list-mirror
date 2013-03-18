From: Joydeep Bakshi <joydeep.bakshi@infoservices.in>
Subject: Re: building git ; need suggestion
Date: Mon, 18 Mar 2013 17:54:26 +0530
Message-ID: <9E0367AC-617A-440B-925E-5796CF2E1ADF@infoservices.in>
References: <868B103B-690E-477B-BF75-8F954F893E6F@infoservices.in> <20130315124415.GA23122@paksenarrion.iveqy.com> <00107242-04EB-423F-90FE-A6DCDEE7E262@infoservices.in> <20130315131403.GA27022@google.com> <C8080BF5-DC87-421D-97A1-DF5CF403A03A@infoservices.in>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?Magnus_B=E4ck?= <baeck@google.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 13:25:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHZ7j-0000lp-78
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 13:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120Ab3CRMYk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Mar 2013 08:24:40 -0400
Received: from static.88-198-19-49.clients.your-server.de ([88.198.19.49]:38695
	"EHLO zimbra.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750985Ab3CRMYj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 08:24:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.infoservices.in (Postfix) with ESMTP id E824CE21730;
	Mon, 18 Mar 2013 17:54:37 +0530 (IST)
X-Virus-Scanned: amavisd-new at zimbra.infoservices.in
Received: from zimbra.infoservices.in ([127.0.0.1])
	by localhost (zimbra.infoservices.in [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QXUOdkRBRa+T; Mon, 18 Mar 2013 17:54:36 +0530 (IST)
Received: from [192.168.1.116] (unknown [122.176.30.116])
	by zimbra.infoservices.in (Postfix) with ESMTPSA id 63304E2172B;
	Mon, 18 Mar 2013 17:54:35 +0530 (IST)
In-Reply-To: <C8080BF5-DC87-421D-97A1-DF5CF403A03A@infoservices.in>
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218408>

I'm closer to my requirement. I have found gitweb simply provide a GUI =
 for history check
and code comparison. And the git itself is good enough to do the ACL st=
uff with hooks.

I already have the following code to deploy the push into its work-tree

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
#!/bin/bash

while read oldrev newrev ref
do
  branch=3D`echo $ref | cut -d/ -f3`

  if [ "master" =3D=3D "$branch" ]; then
    git --work-tree=3D/path/under/root/dir/live-site/ checkout -f $bran=
ch
    echo 'Changes pushed live.'
  fi

  if [ "dev" =3D=3D "$branch" ]; then
    git --work-tree=3D/path/under/root/dir/dev-site/ checkout -f $branc=
h
    echo 'Changes pushed to dev.'
  fi
done
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

This code can be extended for as many branches as you have.

I now need a mechanism to restrict the user to it's own branch so that =
user can't push into
any other branch in mistake.

Say I have

master branch -> only admin user can push here.
dev branch -> only user dev1 , dev2  and master can push here.=20
testing branch -> only user test1 and test2 can push here.

I think this can also be done with pre-receive hook. Any suggestion on =
the hook design is
welcome. Also this can be implemented on the above hook or in a separat=
e hook.
A separate hook is better due to maintainability and then I need to cal=
l multiple
pre-receive hook. Please suggest.

Thanks



On 18-Mar-2013, at 11:14 AM, Joydeep Bakshi <joydeep.bakshi@infoservice=
s.in> wrote:

>=20
> On 15-Mar-2013, at 6:44 PM, Magnus B=E4ck <baeck@google.com> wrote:
>>>=20
>>=20
>> Right, but that's R/W permissions. Almost any piece of Git hosting
>> software supports restriction of pushes. Discriminating *read* acces=
s
>> between developers and maintenance people sounds like a disaster if =
it's
>> the same organisation.=20
>=20
> Just restriction on push access is what required.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
