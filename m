From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
Subject: Re: git format-patch doesn't exclude merged hunks
Date: Wed, 16 May 2012 20:04:57 +0100
Message-ID: <4FB3FA59.1010707@draigBrady.com>
References: <4FB3CAE3.6040608@draigBrady.com> <7vhavgc660.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 16 21:05:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUjX8-0000W8-M8
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 21:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756227Ab2EPTFJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 15:05:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36330 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754161Ab2EPTFI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 15:05:08 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q4GJ4xOi026014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 16 May 2012 15:05:02 -0400
Received: from [10.36.116.83] (ovpn-116-83.ams2.redhat.com [10.36.116.83])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q4GJ4vGr007707
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Wed, 16 May 2012 15:04:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <7vhavgc660.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.2
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197893>

On 05/16/2012 07:49 PM, Junio C Hamano wrote:
> P=C3=A1draig Brady <P@draigBrady.com> writes:
>=20
>> For reference the two commits in question are:
>> https://github.com/openstack/nova/commit/7028d66
>> https://github.com/openstack/nova/commit/26dc6b7
>> Notice how both make the same change to Authors.
>=20
> If you compare the changes these two commits introduce, you will also
> notice that the "Authors" file is the _only_ common part of them.
>=20
> "format-patch" (more precicely, the "git cherry" machinery that ident=
ifies
> the same patch) does not _selectively_ drop only a part of a patch wh=
ile
> keeping the other parts.  It is not per "hunk", it is not even per "f=
ile".
>=20
> This is very much on purpose, and I think it is a good design decisio=
n.
>=20
> In this particular case, the behaviour does look suboptimal, but if y=
ou
> think about it harder, you will realize that the perception comes lar=
gely
> because in this particular commit, the change to the "Authors" file i=
s the
> least interesting part of the change.
>=20
> Imagine a case where you were replaying a commit that changes a file
> significantly and also changes another file in a trivial way, and whe=
re it
> were the significant change that has already been applied to the rece=
iving
> codebase, not the insignificant change to "Authors" file.
>=20
> Now imagine that format-patch dropped the part that brings in the
> significant change as duplicate, and replayed only the insignificant =
part.
> Most likely, the log message of the original commit explains what iss=
ue
> that significant change tried to solve, and how the implementation in=
 the
> patch was determined to be an acceptable approach to solve it, and th=
at is
> what you will be recording for the replayed commit that only introduc=
es
> the remaining insignificant change.
>=20
> I am not fundamentally opposed to the idea of (optionally) detecting =
and
> selectively dropping parts of a patch to an entire file or even hunks=
 that
> have already applied, but it needs to have a way remind the user some=
where
> in the workflow that it did so and the log message may no longer desc=
ribe
> what the change does.  Most likely it would have to be done when prod=
ucing
> format-patch output, but an approach to make it a responsibility to n=
otice
> and fix the resulting log message to the person who applies the outpu=
t, I
> would imagine.

Yep agreed, it would have to be optional.
Maybe --ignore-duplicate-changes ?

Appending a marker to the commit message of the adjusted patch would ma=
ke sense,
similar to how a 'Conflicts:' list is auto generated for commit message=
s.

cheers,
P=C3=A1draig.
