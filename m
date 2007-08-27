From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] In Examples, explain option -r and refer to git-rev-list[1]
Date: Mon, 27 Aug 2007 01:33:49 -0700
Message-ID: <7vbqctl6ky.fsf@gitster.siamese.dyndns.org>
References: <r6lqfgnp.fsf@cante.net> <46D28502.3030003@etek.chalmers.se>
	<7vy7fxl7hx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Lukas =?utf-8?Q?Sandstr=C3=B6m?= <lukass@etek.chalmers.se>
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Aug 27 10:33:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPa2o-0004Qz-8b
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 10:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbXH0Idz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 27 Aug 2007 04:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbXH0Idz
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 04:33:55 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:36201 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbXH0Idy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2007 04:33:54 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 20A4D127DC4;
	Mon, 27 Aug 2007 04:34:13 -0400 (EDT)
In-Reply-To: <7vy7fxl7hx.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 27 Aug 2007 01:14:02 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56781>

Junio C Hamano <gitster@pobox.com> writes:

> Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se> writes:
>
>> Jari Aalto wrote:
>>> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
>>> ---
>>>  Documentation/git-log.txt |    3 ++-
>>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>>=20
>>> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
>>> index 49bb539..aa42f0e 100644
>>> --- a/Documentation/git-log.txt
>>> +++ b/Documentation/git-log.txt
>>> @@ -76,7 +76,8 @@ git log -r --name-status release..test::
>>> =20
>>>  	Show the commits that are in the "test" branch but not yet
>>>  	in the "release" branch, along with the list of paths
>>> -	each commit modifies.
>>> +	each commit modifies. Opton -r (see gitlink:git-rev-list[1])
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ spelling mistake (option)
>
> I think it makes more sense to make Porcelain including "git
> log" to always recurse in its diff operations (when diff output
> is asked for), in which case the example should simply lose
> the "-r" option.
>
> But that is a post-1.5.3 change.  That's why I am planning to
> drop this patch for now.

The change would probably look something like this.  Testing is
left as an exercise to the readers ;-).

---

 Documentation/git-log.txt     |    2 +-
 Documentation/user-manual.txt |    2 +-
 builtin-log.c                 |    1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 1e6dbd9..5ec547c 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -96,7 +96,7 @@ git log --since=3D"2 weeks ago" \-- gitk::
 	The "--" is necessary to avoid confusion with the *branch* named
 	'gitk'
=20
-git log -r --name-status release..test::
+git log --name-status release..test::
=20
 	Show the commits that are in the "test" branch but not yet
 	in the "release" branch, along with the list of paths
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
index 06ab79f..35298e6 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -921,7 +921,7 @@ file such that it contained the given content eithe=
r before or after the
 commit.  You can find out with this:
=20
 -------------------------------------------------
-$  git log --raw -r --abbrev=3D40 --pretty=3Doneline -- filename |
+$  git log --raw --abbrev=3D40 --pretty=3Doneline -- filename |
 	grep -B 1 `git hash-object filename`
 -------------------------------------------------
=20
diff --git a/builtin-log.c b/builtin-log.c
index 13bae31..d6cf9d5 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -258,6 +258,7 @@ int cmd_log(int argc, const char **argv, const char=
 *prefix)
 	git_config(git_log_config);
 	init_revisions(&rev, prefix);
 	rev.always_show_header =3D 1;
+	rev.diffopt.recursive =3D 1;
 	cmd_log_init(argc, argv, prefix, &rev);
 	return cmd_log_walk(&rev);
 }
