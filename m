From: Evgeny Sazhin <euguess@gmail.com>
Subject: Re: Git performance results on a large repository
Date: Fri, 3 Feb 2012 20:25:59 -0500
Message-ID: <6E708713-3DEF-40A2-9585-690707166BDF@gmail.com>
References: <CB5074CF.3AD7A%joshua.redstone@fb.com> <CACBZZX4BsFZxB6A-Hg-k37FBavgTV8SDiQTK_sVh9Mb9iskiEw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Redstone <joshua.redstone@fb.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 02:26:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtUOb-00086C-So
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 02:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149Ab2BDB0F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 20:26:05 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37954 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300Ab2BDB0D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 20:26:03 -0500
Received: by qadc10 with SMTP id c10so1119318qad.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 17:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=Y72Tx2C5vSqb3joNtH0w9LCOmy0AcR3UR3HVEhz43oc=;
        b=s/QB/e+8beywr/QjGGBz3rspNTjNT6cQnxRmHPMwlMq+vqK5r2du/nDu5S31F1RYZh
         OpWpfDtp4YHmxIfdkLO565QWWaJA35E3YPRKr0nVxDQDkyiBidOgss994MIoywk7/t/W
         ZspKxlEL9/WOfgipZJc2wdRWu0s+zO59oeSkM=
Received: by 10.224.183.81 with SMTP id cf17mr11664749qab.48.1328318762732;
        Fri, 03 Feb 2012 17:26:02 -0800 (PST)
Received: from 192.168.1.20 (ool-44c70b0d.dyn.optonline.net. [68.199.11.13])
        by mx.google.com with ESMTPS id g13sm15254300qah.0.2012.02.03.17.26.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 17:26:00 -0800 (PST)
In-Reply-To: <CACBZZX4BsFZxB6A-Hg-k37FBavgTV8SDiQTK_sVh9Mb9iskiEw@mail.gmail.com>
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189835>

=20

On Feb 3, 2012, at 9:56 AM, =C6var Arnfj=F6r=F0 Bjarmason wrote:

> On Fri, Feb 3, 2012 at 15:20, Joshua Redstone <joshua.redstone@fb.com=
> wrote:
>=20
>> We (Facebook) have been investigating source control systems to meet=
 our
>> growing needs.  We already use git fairly widely, but have noticed i=
t
>> getting slower as we grow, and we want to make sure we have a good s=
tory
>> going forward.  We're debating how to proceed and would like to soli=
cit
>> people's thoughts.
>=20
> Where I work we also have a relatively large Git repository. Around
> 30k files, a couple of hundred thousand commits, clone size around
> half a GB.
>=20
> You haven't supplied background info on this but it really seems to m=
e
> like your testcase is converting something like a humongous Perforce
> repository directly to Git.
>=20
> While you /can/ do this it's not a good idea, you should split up
> repositories at the boundaries code or data doesn't directly cross
> over, e.g. there's no reason why you need HipHop PHP in the same
> repository as Cassandra or the Facebook chat system, is there?
>=20
> While Git could better with large repositories (in particular applyin=
g
> commits in interactive rebase seems to be to slow down on bigger
> repositories) there's only so much you can do about stat-ing 1.3
> million files.
>=20
> A structure that would make more sense would be to split up that gian=
t
> repository into a lot of other repositories, most of them probably
> have no direct dependencies on other components, but even those that
> do can sometimes just use some other repository as a submodule.
>=20
> Even if you have the requirement that you'd like to roll out
> *everything* at a certain point in time you can still solve that with
> a super-repository that has all the other ones as submodules, and
> creates a tag for every rollout or something like that.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



I concur. I'm working in the company with many years of development his=
tory with several huge CVS repos and we are slowly but surely migrating=
 the codebase from CVS to Git.=20
Split the things up. This will allow you to reorganize things better an=
d there is IMHO no downsides.=20
As for rollout - i think this job should be given to build/release syst=
em that will have an ability to gather necessary code from different re=
pos and tag it properly.

just my 2 cents

Thanks,
Eugene
