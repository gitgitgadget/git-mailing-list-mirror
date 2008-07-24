From: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>
Subject: Re: [PATCH] Document disabling core.whitespace values trailing-space
 and space-before-tab
Date: Thu, 24 Jul 2008 11:41:42 +0200
Message-ID: <48884E56.6070801@sneakemail.com>
References: <4888144E.8090300@sneakemail.com> <20080724172912.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 11:42:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLxLU-0003dY-0S
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 11:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbYGXJlr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 05:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbYGXJlr
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 05:41:47 -0400
Received: from morch.com ([193.58.255.207]:34228 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbYGXJlq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 05:41:46 -0400
Received: from [192.168.1.214] (ANice-157-1-37-217.w90-28.abo.wanadoo.fr [90.28.176.217])
	by morch.com (Postfix) with ESMTP id 8BFA4281D;
	Thu, 24 Jul 2008 11:43:33 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <20080724172912.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89858>

Actually, it gets stranger and stranger!

Nanako Shiraishi nanako3-at-lavabit.com |Lists| wrote:
>> The '-trailing-space' syntax to disable the trailing-space setting=20
>> is not obvious and not documented as far as I can see. I would have
>> assumed a value of '' would disable it.
>=20
> Doesn't gitattributes(5) describe the overall syntax in detail?

=46irst, git-config.1 does not mention gitattributes except for specifi=
c
settings. core.whitespace is not one of these.

gitattributes.5 has:
> Sometimes you would need to override an setting of an attribute for a
>  path to unspecified state. This can be done by listing the name of=20
> the attribute prefixed with an exclamation point !.

note that this is ! before the *name* of the attribute, and for=20
"Checking whitespace errors / whitespace":

> The core.whitespace configuration variable allows you to define what=20
> diff and apply should consider whitespace errors for all paths in the
>  project (See git-config(1)). This attribute gives you finer control=20
> per path.
=2E..
> Unspecified: Use the value of core.whitespace configuration variable
>  to decide what to notice as error.
>=20
> String: Specify a comma separate list of common whitespace problems=20
> to notice in the same format as core.whitespace configuration=20
> variable.

So now, git attributes says to unspecify a setting with '!' in front of
the attribute *name*, which for core.whitespace means use the value fro=
m
git-config, which if not specified means to error on e.g. trailing-spac=
e.

Now, I notice that git's own .gitattributes has this:
> * whitespace=3D!indent,trail,space
> *.[ch] whitespace

Which I assume actually works, but is invalid according to git-config.1=
=20
and gitattributes.5 because:

=46or the first line, neither of the values 'indent', 'trail' nor 'spac=
e'
are valid for core.whitespace, and the '!' notation is not defined in
neither gitattributes.5 nor in git-config.1 for *values*.

=46or the second line, gitattributes states generally about attributes =
that:
> Set: The path has the attribute with special value "true"; this is=20
> specified by listing only the name of the attribute in the attribute=20
> list.

A value of true (unspecified would have required:"*.[ch] !whitespace")=20
is not valid for core.whitespace either.

So now (as I read it), neither git-config.1 nor gitattributes.5 specify=
=20
how to turn off core.whitespace "elements", but .gitattributes (from gi=
t=20
itself) uses one notation (!) with settings that are invalid for other=20
reaons, while "grep core.whitespace t/*" uses another notation (-) to=20
turn off elements.

Also in t/* the elements have various different names, such as: "trail"=
,=20
"trailing", "trailing-space". t/t4019-diff-wserror.sh also uses this:
> echo "F whitespace=3D-trail" >.gitattributes
just to make things interesting!

It seems that there is some inconsistency about this. Perhaps=20
documentation (and changing t/* and .gitattributes accordingly) isn't=20
such a bad idea! :D

Peter
--=20
Peter Valdemar M=F8rch
http://www.morch.com
