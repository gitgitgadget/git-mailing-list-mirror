From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH 1/2] Changed rebasing safety check to look for reachability of stack base (gna bug #9181).
Date: Mon, 04 Jun 2007 15:42:22 +0200
Message-ID: <878xazbzup.fsf@morpheus.local>
References: <20070603133006.1681.1742.stgit@gandelf.nowhere.earth> <20070603134152.1681.82748.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 15:43:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvCpm-0002J8-Vt
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 15:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbXFDNmt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 4 Jun 2007 09:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbXFDNmt
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 09:42:49 -0400
Received: from main.gmane.org ([80.91.229.2]:55908 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793AbXFDNms (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 09:42:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HvCpS-0005f0-Ll
	for git@vger.kernel.org; Mon, 04 Jun 2007 15:42:38 +0200
Received: from dns.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 15:42:38 +0200
Received: from davidk by dns.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 15:42:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dns.vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:vO53puNyUJvZWVxfLi2rhmvggPQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49102>

Yann Dirson <ydirson@altern.org> writes:

> --- a/stgit/commands/pull.py
> +++ b/stgit/commands/pull.py
> @@ -77,16 +77,12 @@ def func(parser, options, args):
>      check_conflicts()
>      check_head_top_equal()
> =20
> -    if policy =3D=3D 'pull':
> -        must_rebase =3D 0
> -    elif policy =3D=3D 'fetch-rebase':
> -        must_rebase =3D 1
> -    elif policy =3D=3D 'rebase':
> -        must_rebase =3D 1
> -    else:
> +    if (policy !=3D 'pull') \
> +           and (policy !=3D 'fetch-rebase') \
> +           and (policy !=3D 'rebase'):
>          raise GitConfigException, 'Unsupported pull-policy "%s"' % p=
olicy

Minor nit: I think this is much more clearly written as

    if policy not in ('pull', 'fetch-rebase', 'rebase'):

--=20
David K=C3=A5gedal
