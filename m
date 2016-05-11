From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 24/25] worktree move: accept destination as directory
Date: Wed, 11 May 2016 20:32:47 +0200
Message-ID: <57337ACF.3020402@kdbg.org>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
 <1460553346-12985-25-git-send-email-pclouds@gmail.com>
 <CAPig+cRtajkynLFj5Fknd72QQ=Eqevh1T9i9MvApwXfNmtMAFQ@mail.gmail.com>
 <CACsJy8CCAan9ALxULPFeGSU7wsfwbrywRWFr4Hsjx3=PGwosLA@mail.gmail.com>
 <CAPig+cTB8tdPo=wd5UdB84owKJ6c5hj6H9d4_YGDRecBdUE0vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 20:33:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0YwQ-0000jg-QH
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 20:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbcEKScx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 14:32:53 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:20994 "EHLO bsmtp2.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692AbcEKScw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 14:32:52 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 3r4l9D3ytHz5tlJ;
	Wed, 11 May 2016 20:32:48 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id CF2C15264;
	Wed, 11 May 2016 20:32:47 +0200 (CEST)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <CAPig+cTB8tdPo=wd5UdB84owKJ6c5hj6H9d4_YGDRecBdUE0vA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294359>

Am 11.05.2016 um 19:32 schrieb Eric Sunshine:
> On Wed, May 11, 2016 at 9:34 AM, Duy Nguyen <pclouds@gmail.com> wrote=
:
>> On Wed, May 11, 2016 at 11:43 AM, Eric Sunshine <sunshine@sunshineco=
=2Ecom> wrote:
>>> On Wed, Apr 13, 2016 at 9:15 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>>> +       if (is_directory(dst.buf)) {
>>>> +               const char *sep =3D strrchr(wt->path, '/');
>>>
>>> Does this need to take Windows into account?
>>
>> wt->path comes from $GIT_DIR/worktrees/xxx/gitdir, which normally us=
es
>> forward slashes, so we should be safe. We already rely on forward
>> slashes in get_linked_worktree()
>>
>>> Perhaps git_find_last_dir_sep()?
>>
>> But this is probably a good thing to do anyway, to be more robust in
>> future. But it could confuse the reader later on why it's necessary
>> when backward slashes can't exist in wt->path. I don't know. Maybe
>> just have a comment that backward slashes can't never appear here?
>
> As this path is read from a file git itself creates, and if we know
> that it will always contain forward slashes, then I agree that it
> could be potentially confusing to later readers to see
> git_find_last_dir_sep(). So, keeping it as-is seems correct.

Please allow me to disagree. There should not be any assumption that a=20
path uses forward slashes as directory separator, except when the path =
is

- a pathspec
- a ref
- a path found in the object database including the index

In particular, everything concerning paths in the file system (includin=
g=20
paths pointing to Git's own files) must not assume forward slashes.

We do convert backslashes to forward slashes in a number of places, but=
=20
this is only for cosmetic reasons, not to maintain an invariant.

> If we look at fspathcmp() as a function which performs whatever magic
> is needed to make comparisons work on a platform/filesystem, then it
> might indeed be reasonable to enhance it to recognize '/' and '\' as
> equivalent (with possible caveats for Windows corner cases).

That sounds reasonable.

-- Hannes
