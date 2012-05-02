From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: New NULL dereference in sequence.c
Date: Wed, 02 May 2012 14:53:22 +0200
Message-ID: <4FA12E42.201@lsrfire.ath.cx>
References: <CANV9Rr9PFR7SA_3jB-6PRF_V+4yB-FsYEuX5gs-LMpoTAxGDCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>
To: Michael Mueller <mmueller@vigilantsw.com>
X-From: git-owner@vger.kernel.org Wed May 02 14:53:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPZ3o-0004PQ-8r
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 14:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226Ab2EBMx0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 08:53:26 -0400
Received: from india601.server4you.de ([85.25.151.105]:58183 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022Ab2EBMxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 08:53:25 -0400
Received: from [192.168.2.105] (p4FFD98FB.dip.t-dialin.net [79.253.152.251])
	by india601.server4you.de (Postfix) with ESMTPSA id 1D2FC2F805D;
	Wed,  2 May 2012 14:53:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <CANV9Rr9PFR7SA_3jB-6PRF_V+4yB-FsYEuX5gs-LMpoTAxGDCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196802>

[cc:ing the author of this commit]

Am 02.05.2012 10:45, schrieb Michael Mueller:
> Hi all,
>
> The last defect Sentry picked up has been removed, yay!  At the same
> time, a new NULL dereference bug appeared, in sequencer.c:
>
>      static int is_index_unchanged(void)
>      {
>          unsigned char head_sha1[20];
>          struct commit *head_commit;
>
>          if (!resolve_ref_unsafe("HEAD", head_sha1, 1, NULL))
>              return error(_("Could not resolve HEAD commit\n"));
>
>          head_commit =3D lookup_commit(head_sha1);
>          if (!head_commit || parse_commit(head_commit))
>              return error(_("could not parse commit %s\n"),
>                       sha1_to_hex(head_commit->object.sha1));
>
> In the last line quoted above, head_commit may be NULL, and it is
> dereferenced in the call to sha1_to_hex.  Assuming lookup_commit(head=
_sha1)
> can return NULL, this function will segfault.
>
> Introduced here:
> https://github.com/gitster/git/commit/b27cfb0#sequencer.c

Similar code in builtin/commit.c just reports "could not parse HEAD=20
commit" without any hash and thus no pointer dereference.

Ren=E9
