From: Gustavo Narea <gnarea@tech.2degreesnetwork.com>
Subject: Re: Multiple checkouts active for the same repository
Date: Fri, 24 Sep 2010 15:42:14 +0100
Organization: 2degrees Limited
Message-ID: <4C9CB8C6.1050101@tech.2degreesnetwork.com>
References: <4C9C6F8B.3090806@tech.2degreesnetwork.com> <AANLkTikvyM9wXrewRiG7OdBp5LMfnHSkA9dqZGT1Twpc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 16:42:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz9Tq-0006Db-01
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 16:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754955Ab0IXOmS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 10:42:18 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60964 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897Ab0IXOmS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 10:42:18 -0400
Received: by wyb28 with SMTP id 28so1966709wyb.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 07:42:17 -0700 (PDT)
Received: by 10.227.142.136 with SMTP id q8mr3033153wbu.95.1285339336804;
        Fri, 24 Sep 2010 07:42:16 -0700 (PDT)
Received: from [192.168.1.3] (cpc1-oxfd19-2-0-cust970.4-3.cable.virginmedia.com [86.30.183.203])
        by mx.google.com with ESMTPS id e31sm1854362wbe.23.2010.09.24.07.42.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 07:42:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9pre) Gecko/20100217 Lightning/1.0b1 Shredder/3.0.3pre
In-Reply-To: <AANLkTikvyM9wXrewRiG7OdBp5LMfnHSkA9dqZGT1Twpc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156995>

Hello,

On 24/09/10 14:07, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Fri, Sep 24, 2010 at 09:29, Gustavo Narea
> <gnarea@tech.2degreesnetwork.com> wrote:
>=20
>> We're currently migrating from another DVCS.
>=20
> Which one?

Bazaar.


>> We are a team of Web developers and testers working on an applicatio=
n.
>> There are always a few development branches and a stable branch, and
>> testers need all the branches with the very latest code available at=
 all
>> times.
>>
>> The way we handle it at the moment is very simple because the server
>> hosting the remote repository is the same that hosts the deployed
>> instances of each branch, so when we push to the remote repository, =
the
>> code for each site is automatically updated.
>>
>> We use the following structure:
>> /srv/repositories/project/branch1
>> /srv/repositories/project/branch2
>> /srv/repositories/project/branch3
>>
>> Is there any simple way to do this with Git? I can only think of two
>> options that involve hooks:
>>
>>    * Have a hook that exports each branch to a directory like
>>      /srv/repositories/project/branchN
>>    * Have one Git repository per branch, so that each repository hav=
e a
>>      different checkout active. Then the main remote repository will
>>      have post-receive hooks that trigger a pull on each individual
>>
>> I'm not particularly happy with either way. Is there a better soluti=
on?
>=20
> If you really need this the best solution is to just `git clone` the
> project multiple times and check out each branch in its own dir. Then
> have some shellscript to update them all.
>=20
> But just using the Git workflow would be better.

OK, I'll do it that way.


>> Apart from the situation I describe in the initial email, there's
>> another limitation in the development environment: Our IDE, Eclipse =
+
>> Pydev, assumes each project (i.e., branch/checkout) to be on differe=
nt
>> directories and each project should have different settings (e.g., p=
aths
>> to dependencies, which could be different), but with GIt everything
>> would be a single project because it's all on the same path.
>=20
> Can't you just modify your build environment to check the output of
> `git symbolic-ref HEAD` or equivalent, instead of checking paths?

Yes, that's what I intend to do for the build system, but that wouldn't
solve the problem with the IDE:

Eclipse and PyDev (Python plugin) store their settings in the project
directory. For example, the one from PyDev contains the absolute paths
to all the dependencies, which makes features like auto-completion work=
;
I would have to mark these files are ignored because they change from
machine to machine, and sometimes from branch to branch.

So, no matter what the active branch is, I will always get the settings
for the first branch I configured. And if I change them, all the other
branches will be affected.

Any suggestions?

I tried playing with --git-dir and --work-tree, so that I could have th=
e
repository in one place and the checkout for each branch on different
repositories, but it doesn't seem to be a good solution because we
cannot specify the branch in commands like git-status.

Thank you very much.
--=20
Gustavo Narea.
Software Developer.
2degrees, Ltd. <http://dev.2degreesnetwork.com/>.
