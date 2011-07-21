From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git-archive and tar options
Date: Wed, 20 Jul 2011 21:13:08 -0500
Message-ID: <4E278B34.70300@gmail.com>
References: <ivla29$liu$1@dough.gmane.org> <20110714015656.GA20136@sigill.intra.peff.net> <4E1F2468.6080409@lsrfire.ath.cx> <20110714172718.GA21341@sigill.intra.peff.net> <4E2477E1.5090406@gmail.com> <4E249C94.3040002@lsrfire.ath.cx> <4E24CBFD.9090909@gmail.com> <4E25C54D.2070007@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Neal Kreitzinger <neal@rsss.com>,
	git@vger.kernel.org
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jul 21 04:13:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjilU-0003WL-Hp
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 04:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724Ab1GUCNN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jul 2011 22:13:13 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60629 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab1GUCNM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 22:13:12 -0400
Received: by ywe9 with SMTP id 9so412458ywe.19
        for <git@vger.kernel.org>; Wed, 20 Jul 2011 19:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ScXTcmJSxTcGvI5mITDOXMy28hX0jHEFqiU+BxIGAi8=;
        b=lGeQA7xbpdjLtfN/RldUoX8vNq6hhQsUNlMkyuPadUQ7z1iJj4Frr1H/hVI4XTB/+4
         Pxj8nMim4naVsVa8XG1d9zrw6wifXTHHqrTBaLvL5wbwUr4kTnuQTj6kSu3O+1aM8RpF
         dJ1LCC5bLpwkRvnzYyYg4jBVP07ZliR90SThM=
Received: by 10.150.194.1 with SMTP id r1mr37613ybf.182.1311214391780;
        Wed, 20 Jul 2011 19:13:11 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id s3sm1643271ybe.14.2011.07.20.19.13.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Jul 2011 19:13:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <4E25C54D.2070007@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/19/2011 12:56 PM, Ren=C3=A9 Scharfe wrote:
> Am 19.07.2011 02:12, schrieb Neal Kreitzinger:
>> On 7/18/2011 3:50 PM, Ren=C3=A9 Scharfe wrote:
>>> Am 18.07.2011 20:13, schrieb Neal Kreitzinger:
>>>> However, the permissions also need to change to 777 and tar --mode=
 would
>>>> not effect this in combination with --catenation or -x.  Is there =
a way
>>>> I can change the permissions without having to untar->chmod->retar=
, and
>>>> without having to use a non-bare repo as an intermediary?
>>> You can use the configuration setting tar.umask to affect the
>>> permissions of the archive entries.  Set it to 0 to pass the permis=
sion
>>> bits from the repo unchanged.
>>>
>> The permissions in my repo are 775 and 664 and I want to change them=
 to
>> 777.
> Git doesn't store all permission bits.  If a file is marked as
> executable then you get 777, otherwise 666 -- minus the umask, which =
is
> 0002 by default.  So in order to achive rwx permissions for all in th=
e
> archive, you need to A) mark the files as executable in the repositor=
y
> and B) set tar.umask to 0 to get allow the world to write.
>
> However, what's the reason for requiring this lack of access control?
> Why o+w?
tar.umask worked.  Thank you for explaining how the permissions work in=
=20
this context.  I now see that 775 and 664 would work for the apache=20
component and for executing our binaries.  Thanks for pointing this=20
out.  However, another element of our application is a proprietary=20
runtime that runs on top of linux and runs our core binaries.  This=20
allows us to store our binaries in git and deploy them directly on the=20
customer server from git (via git-archive).  That runtime needs o+w in=20
order to update the 'last run date' in the binary which is critical to=20
our troubleshooting in the field.  o+w is needed because the user's=20
runtime instance runs with user permissions when executed from a linux=20
command line terminal and our users are not setup in the same group as=20
the binaries.  Therefore, with tar.umask =3D 0000 I can deploy 777 and =
666=20
permissions and everything will work.

I suppose I could write a script to change the tar.umask entry to 0000=20
only when running git-archive for the binary portion, and use tar.umask=
=20
0002 when extracting the other portions.  I could also change our setup=
=20
to put the users and the runmodules in the same group and use tar.umask=
=20
0002 across the board.  These would be more correct than the chmod 777=20
shotgun that we currently use to blast away our permissions problems.

git-archive is a "quick" solution to our immediate deployment needs. =20
Eventually, I plan on using git on the source and target machines as th=
e=20
core mechanism to "promote to production" (ie. deploy to customer=20
servers).  It looks like others are using git for deployment also.  In=20
my previous shops which used other VCS's on minicomputers and=20
mainframes, "promote to production" meant the universal run path for al=
l=20
users (and especially for productional data transactions) on that=20
central machine.  In my current shop (my first linux shop) we have=20
multiple concurrent versions of production on a multitude of=20
productional machines and even concurrently on an individual=20
productional machine in some cases.  The main reason we chose git is=20
because it is the only VCS that can handle this.

v/r,
neal
