From: David Kastrup <dak@gnu.org>
Subject: Re: git-rebase (1.5.0.6) errors
Date: Fri, 18 May 2007 12:49:45 +0200
Message-ID: <86y7jmmmnq.fsf@lola.quinscape.zz>
References: <Pine.LNX.4.64.0705181130570.28356@kivilampi-30.cs.helsinki.fi> <34a7ae040705180331x1a86782fh3b2c6a87db32030e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 12:50:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp028-0002vg-6x
	for gcvg-git@gmane.org; Fri, 18 May 2007 12:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754335AbXERKt4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 May 2007 06:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754860AbXERKt4
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 06:49:56 -0400
Received: from main.gmane.org ([80.91.229.2]:41770 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754335AbXERKt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 06:49:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hp01z-00063M-AT
	for git@vger.kernel.org; Fri, 18 May 2007 12:49:55 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 May 2007 12:49:55 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 May 2007 12:49:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:wBcwjo8+mqW74/5ckk8DAQtPgWw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47591>

"Paolo Teti" <paolo.teti@gmail.com> writes:

> 2007/5/18, Ilpo J=E4rvinen <ilpo.jarvinen@helsinki.fi>:
>> Hi,
>>
>>
>> ijjarvin@kivilampi-30:~/work/src/submit$ git-rebase net-2.6.22-origi=
n
>> First, rewinding head to replay your work on top of it...
>> HEAD is now at d739437... [IPV4]: Correct rp_filter help text.
>> fatal: cannot convert from utf-8 to utf-8
>
>
> Now I can't test or try to reproduce your error,
> but looking at the source code (only with gitweb)
> I have found another bad use of size_t instead of ssize_t
> in the reencode_string(..) that take part at the conversion process.
>
> Using size_t in the next portion of code the check "count =3D=3D -1" =
is
> never true.

Only if size_t is a larger type than int (could be on x86-64 and alpha
architectures).  Other than that, this comparison would work.  Which
does not mean that this does not warrant fixing, but it is not
necessarily the cause of this problem.

>
> while (1) {
> 		size_t cnt =3D iconv(conv, &cp, &insz, &outpos, &outsz);
>
> 		if (cnt =3D=3D -1) {
> 			size_t sofar;
> 			if (errno !=3D E2BIG) {
> 				free(out);
> 				iconv_close(conv);
> 				return NULL;
> 			}
>
>
> Please someone could fixes this bad use of size_t?..

--=20
David Kastrup
