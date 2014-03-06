From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: Re: [RFC] make --set-upstream work for local branches not in
 refs/heads
Date: Thu, 06 Mar 2014 10:27:28 +0100
Message-ID: <1394098048.2050.19.camel@localhost.localdomain>
References: <1393942046-11488-1-git-send-email-krzesimir@endocode.com>
	 <xmqqlhwpkats.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 10:27:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLUaa-0003Sg-6L
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 10:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbaCFJ1e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2014 04:27:34 -0500
Received: from mail-bk0-f50.google.com ([209.85.214.50]:48413 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbaCFJ1c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 04:27:32 -0500
Received: by mail-bk0-f50.google.com with SMTP id w10so594753bkz.37
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 01:27:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=QIL72BQDz9qDRoQHZlXvMQh1NHRefV8cPWZ3VLsFXLk=;
        b=lC5nenMeD+IVLNPMqKit6jQqumHakGztRBm6z28kDf+Sc8CqewEKC0Q1lznaX58tth
         h61dHQ5bd2C+HsGWHQiSLUKHVx51submb6gRpD5JaDErontOsCepWhwzoh3jpH5TP6F7
         LArI+HRg2rFmx9naXJP+uHnQ2bulcPnVVK19lE2PE2HRh00yM08a/y2CtU4jdEHTRuLl
         K1IemP86+bNMl1wXnm3PhbjifrC1R0KKSE32ejqAHZBwYxNwTPULTIITzWmvvhN1IxXO
         o0XXAzaWLJQqhWo3b9ChndFuQUiKRJ/hIycPhZM4HIRFCZqP+RGA2/3JJYPdu7ZRcfRB
         d+Og==
X-Gm-Message-State: ALoCoQkMV47g4QZH1mf+e4Qm7U137xs1NnJIrYQRLkBzu5rUtypEtBgl1Wti5I4U3Dmq4vf8uodt
X-Received: by 10.204.61.200 with SMTP id u8mr115077bkh.64.1394098050870;
        Thu, 06 Mar 2014 01:27:30 -0800 (PST)
Received: from [192.168.178.31] (p579233CA.dip0.t-ipconnect.de. [87.146.51.202])
        by mx.google.com with ESMTPSA id oa10sm7975015bkb.14.2014.03.06.01.27.29
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 06 Mar 2014 01:27:30 -0800 (PST)
In-Reply-To: <xmqqlhwpkats.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243507>

On Tue, 2014-03-04 at 11:44 -0800, Junio C Hamano wrote:
> Krzesimir Nowak <krzesimir@endocode.com> writes:
>=20
> > It might be possible (in "Gerrited" setups) to have local branches
> > outside refs/heads/, like for example in following fetch config:
> >
> > [remote "origin"]
> > 	url =3D ssh://user@example.com/my-project
> > 	fetch =3D +refs/heads/*:refs/remotes/origin/*
> > 	fetch =3D +refs/wip/*:refs/remotes/origin-wip/*
> >
> > Let's say that 'test' branch already exist in origin/refs/wip/. If =
I
> > call:
> >
> > git checkout test
> >
> > then it will create a new branch and add an entry to .git/config:
> >
> > [branch "test"]
> > 	remote =3D origin
> > 	merge =3D refs/wip/test
> >
> > But if I create a branch 'test2' and call:
> >
> > git push --set-upstream origin test2:refs/wip/test2
> >
> > then branch is pushed, but no entry in .git config is created.
>=20
> By definition anything otuside refs/heads/ is not a branch, so do
> not call things in refs/wip "branches".  Retitle it to "work for
> local refs outside refs/heads" or something.

I always have problems with proper use of git's terminology. Sorry.

>=20
> Having said that, I do not see a major problem if we allowed
>=20
> 	[branch "test2"]
> 		remote =3D origin
>                 merge =3D refs/wip/test2
>=20
> to be created when "push --setupstream" is requested, making
> test2@{upstream} to point at refs/remotes/origin-wip/test2.
>=20
> I do not know what the correct implementation of such a feature
> should be, though.

Hm, have some idea about it, though I will leave its sanity to judge to
you.

Given the following config snippet:
[remote "origin"]
	url =3D ssh://user@example.com/my-project
	fetch =3D +refs/heads/*:refs/remotes/origin/*
	fetch =3D +refs/wip/*:refs/remotes/origin-wip/*

We could have get_local_ref_hierarchies function defined somewhat as
follows (memory management details are left out):

char **get_local_ref_hierarchies(char *remote)
{
	char **refspecs =3D get_fetch_refspecs_for_remote (remote);
	char **iter;
	char **local =3D NULL;

	for (iter =3D refspecs; iter && *iter; ++iter) {
		char *src =3D get_src_refspec_part (*iter);
		push (&local, src);
	}

	/* maybe filter dups and make refs/heads/ first */
	return local;
}

I'm sure that there are some corner-cases this code does not handle.

Also, maybe it would be good to add some information when --set-upstrea=
m
does nothing. Something like after doing "git push --set-upstream origi=
n
test:refs/wip/test":

"""
Could not set temp to track refs/wip/test. Either call:
git config branch.test.remote origin
git config branch.test.merge refs/wip/test

or (this part would appear if this solution in patch is accepted)

git config --add remote.origin.fetch \
"+refs/wip/*:refs/remotes/origin-wip/*
"""

Cheers,
--=20
Krzesimir Nowak
Software Developer
Endocode AG

krzesimir@endocode.com

------
Endocode AG, Johannisstra=C3=9Fe 20, 10117 Berlin
info@endocode.com | www.endocode.com

Vorstandsvorsitzender: Mirko Boehm
Vorst=C3=A4nde: Dr. Karl Beecher, Chris K=C3=BChl, Sebastian Sucker
Aufsichtsratsvorsitzende: Jennifer Beecher

Registergericht: Amtsgericht Charlottenburg - HRB 150748 B
