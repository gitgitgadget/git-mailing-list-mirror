From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] path-list.c: always free strdup'ed paths
Date: Sat, 07 Jul 2007 22:03:42 +0200
Message-ID: <468FF19E.8020406@lsrfire.ath.cx>
References: <468FEC54.307@lsrfire.ath.cx> <Pine.LNX.4.64.0707072036530.4093@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 07 22:03:57 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7GVY-0003wv-Cl
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 22:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbXGGUDr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 7 Jul 2007 16:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753256AbXGGUDr
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 16:03:47 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:60306
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752998AbXGGUDr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jul 2007 16:03:47 -0400
Received: from [10.0.1.201] (p508E3CFB.dip.t-dialin.net [80.142.60.251])
	by neapel230.server4you.de (Postfix) with ESMTP id DE2D016022;
	Sat,  7 Jul 2007 22:03:45 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
In-Reply-To: <Pine.LNX.4.64.0707072036530.4093@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51839>

Johannes Schindelin schrieb:
> Hi,
>=20
> On Sat, 7 Jul 2007, Ren? Scharfe wrote:
>=20
>> Always free .paths if .strdup_paths is set, no matter if the=20
>> parameter free_items is set or not, plugging a minor memory leak.=20
>> And to clarify the meaning of the flag, rename it to free_util,=20
>> since it now only affects the freeing of the .util field.
>=20
> The rational was that it might very well be possible that the
> pointers you hand to the path_list are already strdup()ed. So you do
> not set strdup_paths, but you want them free()d.

The patch doesn't take that away, i.e. .path fields are not freed if
=2Estrdup_paths is not set, both before and after the patch.  And the
workaround used in builtin-shortlog.c, viz. setting .strdup_paths just
before calling path_list_clear(), still works.

> The .util field is in many cases something that is not trivially
> free()d, but has to call a type-specific function, such as
> path_list_clear() itself.

Indeed; this is a good reason to separate freeing of .util and .path, n=
o?

Ren=E9
