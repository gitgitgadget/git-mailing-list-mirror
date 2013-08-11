From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: How can I automatically create a GIT branch that represents a sequence of tags?
Date: Sun, 11 Aug 2013 08:49:36 +0100
Organization: OPDS
Message-ID: <A728793F48D242F3BF93ACAA9D9F0F83@PhilipOakley>
References: <CAFw3YtRLgUGGn9JV5K3P9XtMBcBeO7=VSM7PekSxtW6xCsfZ1Q@mail.gmail.com> <20130810232026.GF25779@paksenarrion.iveqy.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git" <git@vger.kernel.org>
To: "Fredrik Gustafsson" <iveqy@iveqy.com>,
	"Kristian Freed" <kristian.freed@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 11 09:49:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8QPL-0006oY-9z
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 09:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971Ab3HKHtj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Aug 2013 03:49:39 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:28102 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751368Ab3HKHti (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Aug 2013 03:49:38 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AocGAElBB1JOl3GZ/2dsb2JhbABZgwaJVrYPgRcXdIIfBQEBBAEIAQEoAQUeAQEhBQYCAwUCAQMOBwMJJRQBBBoGBxcGARIIAgECAwGHeQq2XZA7gyJ2A4h1hg6FCpUogWGBOzs
X-IPAS-Result: AocGAElBB1JOl3GZ/2dsb2JhbABZgwaJVrYPgRcXdIIfBQEBBAEIAQEoAQUeAQEhBQYCAwUCAQMOBwMJJRQBBBoGBxcGARIIAgECAwGHeQq2XZA7gyJ2A4h1hg6FCpUogWGBOzs
X-IronPort-AV: E=Sophos;i="4.89,855,1367967600"; 
   d="scan'208";a="433625980"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip03ir2.opaltelecom.net with SMTP; 11 Aug 2013 08:49:37 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232127>

=46rom: "Fredrik Gustafsson" <iveqy@iveqy.com>
> On Sat, Aug 10, 2013 at 11:29:45PM +0100, Kristian Freed wrote:
>> In our current setup, we have automatic tagging in git of all
>> successful release builds. This makes it easy to go back to stable
>> points in history and compare functionality, check when bugs were
>> introduced etc.
>>
>> To help with this process further, it would be useful to be able to
>> use git bisect, but as these are just a sequence of tags, not commit=
s
>> on a branch, git bisect will not work as is.

I was going to say simply use `git describe --contains <sha1>` and chec=
k=20
the result is <tag>^0 first and then either skip the commit (git bisect=
=20
skip) or test it.

Unfortunately I think it will conflict with the binary search style=20
(i.e. a too sparse history with good tags). In such case it may be=20
useful to have an alternate search style but that would be a code=20
update.

>>
>> Is there any tooling for automatically recreating a branch from a
>> sequence of tags, where each generated commit is the calculated delt=
a
>> between each two neighbouring tags?
>
> I don't understand, why is it better to find between which tags a=20
> error
> was found and not in what commit. It's much easier to find a bug
> introduced in a commit than in a tag/release. It sounds like you're
> doing the bug hunting harder. Could you explain this further?
>
I can see that in many commercial environments that this would be=20
considered "best practice" (which actually equates to common practice,=20
rather than good practice). Obviously in a FOSS environment the=20
developers are willing to use the 'rebase until ready' approaches until=
=20
their patches are acceptable. In a large corporate it can be that the=20
fixes are locally good but globally bad, hence the extra tagging step.

> It would be very hard to do a tool such as you describe, the reason i=
s
> that there's no sane way to order your tags. Git today show tags
> alphabetically, all versions does not have a alphabtic order. You=20
> could
> argue that it should be in the order of the tagged commits commit=20
> date,
> however the commits are not ordered by date, an older commit can have=
=20
> a
> younger commit as a parent. You could say that the tag order is the
> order you find the tags if you go from a branch and backwards in the
> history, however how do you then choose which path to take when you=20
> find
> a merge?
>
> My suggestion if you want to do this, is to have your buildtool to
> checkout a special branch (let's call it tag_branch) do a git reset
> to get the worktree from the newly tagged commit and commit on that
> branch once for each tag it's creating, when it creates the tag.
>
> It would be quite easy to make a script that create such branch for=20
> you,
> if you only can sort the tags somehow.
>
> --=20
> Med v=E4nliga h=E4lsningar
> Fredrik Gustafsson
>
--
Philip=20
