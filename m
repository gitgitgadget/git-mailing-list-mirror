From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: How to hierarchically merge from the root to the leaf of a
 branch tree? (Patch stack management)
Date: Thu, 1 Aug 2013 00:50:51 +0200
Message-ID: <20130731225051.GI19369@paksenarrion.iveqy.com>
References: <ktc2sl$d4f$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jens =?iso-8859-1?Q?M=FCller?= <blog@tessarakt.de>
X-From: git-owner@vger.kernel.org Thu Aug 01 00:48:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4fBn-0003Fp-WE
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 00:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760869Ab3GaWsM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Jul 2013 18:48:12 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:56466 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757890Ab3GaWsK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 18:48:10 -0400
Received: by mail-la0-f49.google.com with SMTP id ev20so914104lab.8
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 15:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Qcsbd+4pQkYjcUbgvZW5dtj3nmEP7OPUZHvrkVRyG9k=;
        b=LQPF/w22EMPDV2rwN/um0encuwLrtQW58dHsf15W0YP7tXNq0Cv1nc3CEGpWNAqQEb
         ld/x+wuhiCCp1VUrkxdvNrev1SwVy4ApjOyj1l70Ba5O1n70D1sh3W3pdd4pEJo74VzM
         OLhpJ6dxLzxLux8CMO/xT/wfe/PIgE+d0NJ1UfvR8iUlm5p8HzPwN/osBsEFhuCb7gmw
         yCpMvrukZp+AzlWcIOfHj6RxdJsKOm/TYFCtEMtT0nAtyN9h7tPMJNgqvU0+i7oY3/qL
         TAokx/LR4uk5ZkHPWy/tljWMxm51b3x3qhUILiX3PWavDX+8hHJHJyYyidYtkhkePCLO
         Px1A==
X-Received: by 10.152.29.103 with SMTP id j7mr8848111lah.7.1375310889298;
        Wed, 31 Jul 2013 15:48:09 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id c4sm161780lae.7.2013.07.31.15.48.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 15:48:08 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1V4fEJ-0005WI-Qu; Thu, 01 Aug 2013 00:50:51 +0200
Content-Disposition: inline
In-Reply-To: <ktc2sl$d4f$1@ger.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231475>

On Thu, Aug 01, 2013 at 12:25:32AM +0200, Jens M=FCller wrote:
> Hi all!
>=20
> I mainly use Git for version control, but have also tried out Mercuri=
al.
> While I don't really like Mercurial in general, the idea of maintaini=
ng
> clearly separated patches with Mercurial Queues (MQ) is quite appeali=
ng.
> Therefore, I am looking for something similar (but easier to use, mor=
e
> "gitty" and maybe even more powerful) in Git.
>=20
> So I will first explain what I have in mind:
>=20
> As an example, let's say I am doing test-driven development. My maste=
r
> branch follows the main repository of the software. Branched out from
> that, I have a branch called "feature-test", and branched out from th=
at,
> "feature-implementation":
>=20
>     master
>     |_ feature-test
>        |_ feature-implementation
>=20
> For each branch, I remember the parent branch.
>=20
> Implementation would then work like this: I checkout feature-test and
> write some test. Then I checkout feature-implementation, rebase it to
> the current status of feature-test and write the implemenation. And s=
o on.
>=20
> At some point, I update master, and then rebase both feature-test and
> feature-implementation.
>=20
> As a side note: Instead of rebasing the branches, an alternative woul=
d
> be to merge the changes from the parent branch. This makes conflict
> resolution easier. The cascading merge through the chain of branches =
is
> like a rebase, anyway.
>=20
> Of course, the process described above contains a lot of tedious manu=
al
> work. So I am looking for tooling for tasks like the following:
>=20
>  * While on a branch, pull master from a remote branch it tracks and
> merge the changes down the chain of branches. When a conflict is
> encountered, switch to the branch where it occured, allow the user to
> resolve the conflict, and then continue the cascading merge (similar =
to
> what git rebase does when it encounters a conflict).
>  * When checking out a branch, cascadingly merge from the ancestor
> branches automatically. Conflict handling should work as in the previ=
ous
> point.
>=20
> The cascading merge should not check out master and the branches belo=
w
> it (unless necessary to resolve conflicts), in order to avoid rebuild=
s
> due to touched but unchanged files.
>=20
> Do these requirements make sense? Is there some existing tool with a
> similar workflow?
>=20
> BR - Jens
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Since all commits in feature-test is in feature-implementation,
how about rebase feature-implementation on master and then move the
branch pointer for feature-test to the new commit (git reset)?

If it's still not trivial enough, a script for this would be fairly eas=
y
to implement (if I don't miss anything big here).

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
