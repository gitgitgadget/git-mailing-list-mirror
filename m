From: Martin von Gagern <Martin.vGagern@gmx.net>
Subject: Re: [BUG] resolved deltas
Date: Fri, 22 Aug 2014 21:41:23 +0200
Message-ID: <53F79CE3.60803@gmx.net>
References: <53F5D98F.4040700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 21:50:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKuqm-0002PQ-9O
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 21:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbaHVTuJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Aug 2014 15:50:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:45846 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783AbaHVTuF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 15:50:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1XKuqZ-0002K9-S1
	for git@vger.kernel.org; Fri, 22 Aug 2014 21:50:03 +0200
Received: from ipb21b23f8.dynamic.kabel-deutschland.de ([178.27.35.248])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Aug 2014 21:50:03 +0200
Received: from Martin.vGagern by ipb21b23f8.dynamic.kabel-deutschland.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Aug 2014 21:50:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ipb21b23f8.dynamic.kabel-deutschland.de
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
In-Reply-To: <53F5D98F.4040700@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255697>

On 21.08.2014 13:35, Petr Stodulka wrote:
> Hi guys,
> I wanted post you patch here for this bug, but I can't find primary
> source of this problem [0], because I don't understand some ideas in =
the
> code.
>
> [=E2=80=A6]
>=20
> Any next ideas/hints or explanation of these functions? I began study
> source code and mechanisms of the git this week, so don't beat me yet
> please :-)
>=20
> Regards,
> Petr
>=20
> [0] https://bugzilla.redhat.com/show_bug.cgi?id=3D1099919

Some pointers to related reports and investigations:

https://groups.google.com/forum/#!topic/mapsforge-dev/IF6mgmwvZmY
https://groups.google.com/forum/#!topic/mapsforge-dev/f2KvFALlkvo
https://code.google.com/p/support/issues/detail?id=3D31571
https://groups.google.com/forum/#!topic/mapsforge-dev/nomzr5dkkqc
http://thread.gmane.org/gmane.comp.version-control.git/254626

The last is my own bug report to this mailing list here, which
unfortunately received no reaction yet. In that report, I can confirm
that the commit introducing the assertion is the same commit which
causes things to fail:
https://github.com/git/git/commit/7218a215efc7ae46f7ca8d82442f354e

In this https://code.google.com/p/mapsforge/ repository, resolve_delta
gets called twice for some delta. The first time, type and real_type ar=
e
identical, but by the second pass in find_unresolved_deltas the real
type will have chaned to OBJ_TREE. This caused the old code to simply
scip the object, but the new code aborts instead.

So far my understanding. I'm not sure whether this kind of duplicate
resolution is something normal or indicates some breakage in the
repository in question. But aborting seems a bad solution in either cas=
e.

Greetings,
 Martin von Gagern
