From: Nico Williams <nico@cryptonector.com>
Subject: Re: cherry picking and merge
Date: Wed, 6 Aug 2014 11:26:50 -0500
Message-ID: <CAK3OfOj4_ttmv6gQ4zkvG1tod9rUBMvLfwvtVVbbdttqZWcECA@mail.gmail.com>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
	<20140801200201.GS12427@google.com>
	<20140801205040.GT12427@google.com>
	<CAK3OfOhbJJqLB4yPbuJyufytxNUSBLzKF6axc4jeU7eAjvXtgA@mail.gmail.com>
	<53E25090.7010803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Mike Stump <mikestump@comcast.net>,
	git discussion list <git@vger.kernel.org>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 18:27:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF43E-0005II-EQ
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 18:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbaHFQ0w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2014 12:26:52 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:51893 "EHLO
	homiemail-a66.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753449AbaHFQ0w convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Aug 2014 12:26:52 -0400
Received: from homiemail-a66.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a66.g.dreamhost.com (Postfix) with ESMTP id D951335007A
	for <git@vger.kernel.org>; Wed,  6 Aug 2014 09:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type:content-transfer-encoding; s=
	cryptonector.com; bh=rjq8HP12yxKo9U4Mu57vPvmonLs=; b=CWBGDL+VQU+
	XmyNRzRLevKhj665iJzPJwPq3YdggebfIxB2qehFJCrRTNlXoTvqjLS0ClTuLHs7
	vvIKfvovMb35V3StMlMsi9N3jX+gm5QcUAj7IOcfPdXm+btdxbcp8cg0UZfbua73
	8mYgfOo7L7TQMahmdQBqT2mCgKj9I+zo=
Received: from mail-ig0-f170.google.com (mail-ig0-f170.google.com [209.85.213.170])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a66.g.dreamhost.com (Postfix) with ESMTPSA id B0C8E350079
	for <git@vger.kernel.org>; Wed,  6 Aug 2014 09:26:51 -0700 (PDT)
Received: by mail-ig0-f170.google.com with SMTP id h3so10649706igd.3
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 09:26:50 -0700 (PDT)
X-Received: by 10.43.149.200 with SMTP id kl8mr16379671icc.52.1407342410864;
 Wed, 06 Aug 2014 09:26:50 -0700 (PDT)
Received: by 10.107.128.169 with HTTP; Wed, 6 Aug 2014 09:26:50 -0700 (PDT)
In-Reply-To: <53E25090.7010803@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254875>

On Wed, Aug 6, 2014 at 10:58 AM, Jakub Nar=C4=99bski <jnareb@gmail.com>=
 wrote:
> W dniu 2014-08-01 22:55, Nico Williams pisze:
>> It would help if cherry-pick history where recorded somewhere (beyon=
d
>> the reflog)...
>>
>> Cherry-picks should record two parents, like merges.
>>
>> (Of course, it does no good to know about an unreachable parent, whe=
n
>> a commit with two parents is pushed to a repo that doesn't have one =
of
>> those parents, which can happen when topic branches aren't pushed
>> upstream.)
>
> There was (long time ago) a long thread about idea of adding some
> kind of 'weak' references (links), 'weakparent' that can be automatic=
ally
> used by Git but do not pollute the commit message,
> and do not affect reachability calculations.  Ultimately it went
> nowhere (as you can see) - there were many problems.

My proposal was to put this sort of ancillary history info in a
"branch object" (and that branches should be objects).  This would
have a number of benefits, not the least of which is that at push time
you can drop such ancillary history without having to alter the
commits being pushed.

> For example: how it would work for reverts and rebases?

Reverts upstream?  The revert should record the commit hash of the
commit it reverts (but file-level reverts lose), so that this could be
noticed.

Rebases upstream?  Well, that shouldn't happen, but if it does then
you must rebase --onto and any cherry-picks of upstream rebased
commits lose their ties to those (but this can be detected).

In general recording more metadata (assuming there's not privacy
issues to consider) can't hurt.  Using it might, but having the option
to can also help.

Nico
--
