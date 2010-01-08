From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Difference between pull --rebase and fetch+rebase
Date: Fri, 8 Jan 2010 12:05:40 +0100
Message-ID: <adf1fd3d1001080305k138a2670k17a126cc0b8430b8@mail.gmail.com>
References: <27059158.post@talk.nabble.com>
	 <adf1fd3d1001070800k6fa501fej39b84f849b7e5b50@mail.gmail.com>
	 <1262889864880-4268064.post@n2.nabble.com>
	 <adf1fd3d1001071433j6cd36641sdd2dfd6a936d8483@mail.gmail.com>
	 <1262907485376-4269422.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: martinvz <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 12:05:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTCf6-0002no-0O
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 12:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862Ab0AHLFn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jan 2010 06:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752774Ab0AHLFn
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 06:05:43 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:41179 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab0AHLFm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 06:05:42 -0500
Received: by fxm25 with SMTP id 25so12506208fxm.21
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 03:05:40 -0800 (PST)
Received: by 10.102.182.6 with SMTP id e6mr1176165muf.63.1262948740721; Fri, 
	08 Jan 2010 03:05:40 -0800 (PST)
In-Reply-To: <1262907485376-4269422.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136425>

On Fri, Jan 8, 2010 at 12:38 AM, martinvz
<martin.von.zweigbergk@gmail.com> wrote:
>
>
> Santi B=E9jar-2 wrote:
>>
>> Can you provide, at least, a graph of your history (ala git log
>> --graph --oneline for example)? And plot also the reflog entries and
>> all the important commits.
>>
>
> $ git log --graph --format=3D%h --all
> * 2038a46 # topic-2
> * a7b93b2
> * f2501ae # origin/main
> * cd5aaa9
> * cb232f3
> ...
> * 5ed0d06
> * 3067862
> | * 6eba2fa # topic-1
> | * b09aaf4
> | * bc3b72a
> |/
> | * 03d0d84 # topic-3
> | * 5160773
> | * 3c25642
> |/
> | * 6e9b12b # topic-4
> | * 75f5ab2
> | * bdd08ce
> | * b5d5759
> |/
> * 486b580
> * a021696
> * 3ffe7df
> * d0f55c5
> ...
>
> I have topic-1 checked out and run "git pull" and expect it to rebase=
 (only)
> commits bc3b72a, b09aaf4, 6eba2fa onto f2501ae, but it starts by appl=
ying
> a021696 and 486b580.
>
> $ git reflog -g origin/main
> f2501ae refs/remotes/origin/mai =A0n@{0}: fetch origin: fast forward
> 3ffe7df refs/remotes/origin/mai =A0n@{1}: fetch origin: fast forward
> ...
>
> I hope that's all that's all you need. It seems that the problem is t=
hat the
> oldremoteref gets overwritten with the entry from the reflog. Is the =
problem
> that 3ffe7df appears in the reflog or that 486b580 doesn't appear the=
re? I'm
> not clear on what ends up in the reflog.
>
> I just realized that I myself created a021696 and 486b580 (but not 3f=
fe7df),
> probably by rebasing some now-dead branch against origin/main.

Yes, it is. The code expects that you always branch your topic
branches from the upstream branch, so all the possible fork points are
in the reflog. Your flow was to create the topic from a local commit
and then push that commit.

By the way, when Git tries to apply these two commits it should detect
that they are already applied so it should do nothing, isn't it?

HTH,
Santi
