From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 11/19] bash prompt: use bash builtins to find out
	current branch
Date: Wed, 9 May 2012 23:11:43 +0200
Message-ID: <20120509211143.GE6958@goldbirke>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
	<1336524290-30023-12-git-send-email-szeder@ira.uka.de>
	<7vzk9hqg0u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 09 23:11:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSEAp-00073f-4M
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 23:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759268Ab2EIVLq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 17:11:46 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:62704 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758678Ab2EIVLp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 17:11:45 -0400
Received: from localhost6.localdomain6 (p5B1303EC.dip0.t-ipconnect.de [91.19.3.236])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MCC8K-1SJSkI40si-009ThL; Wed, 09 May 2012 23:11:43 +0200
Content-Disposition: inline
In-Reply-To: <7vzk9hqg0u.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:1U17xU3x81hXFJrRbNm1hWkNGQOV9jveODjklPkmuca
 /f0AFq/IRzFT3rkV/e/VPdTWF4FKhYZCPv3Yxj2Cc/w78CjCRk
 0eZLbuonzc6IHAanl7x/9VRn8qcnTwQDdC8LSQYtKogaAl1WNT
 zbyqpxW/pA6Xj3VhvEoJHZZwdwFD4/GKQm8v2UGRpr4lapsbp6
 jRAhpVHbqqa/nIZjhLEgrK/VI2lLYlRH5TLvWo65Rvah2UhDoV
 I8sXxIVCtriMLHo1xCsK+hL+4x/IXnR8OPw5KDc0PHuraowSkZ
 VMSqVWFfgoTxpqui8g9VdD8zPoWp1UqBQabYZuZJM6A9mPWZ15
 iCOb4mfYCP6kTGmzKaMw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197513>

On Wed, May 09, 2012 at 01:02:41PM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > Since HEAD is a single-line file and the symbolic ref format is qui=
te
> > simple to recognize and parse,...
>=20
> Strictly speaking, that is true only if you somehow know that HEAD is=
 not
> a symlinked symref.  You may end up reading [0-9a-f]{40} out of HEAD
> without learning where the symbolic link pointed at.
>=20
> I personally do not _know_ of anybody who is still using a symlinked
> symref, but the reasoning behind 9f0bb90 (core.prefersymlinkrefs: use
> symlinks for .git/HEAD, 2006-05-02) cannot go away by definition unti=
l
> every project that benefited from the configuration the commit introd=
uced
> goes extinct, so I wouldn't be surprised if you get complaints from t=
he
> users if we adopt this patch.

Symlinked symref, wow.  That was long before my time ;)

So, let's see whether I understand it correctly:

- If HEAD is a symlink, then it's a symlinked symref, and points to
  a real ref file somewhere under refs/.
- If HEAD is a regular file, then it's either a symref containing
  'ref: refs/...', or it's a detached HEAD containing 40 hexdigits.

If the above is right, then we could check with bash builtins whether
HEAD is a symbolic link, which is cheap, and stick to '$(git
symbolic-ref HEAD)' if it is, or use bash builtins if it isn't, right? =
=20
This way we could get most of the performance benefits for modern
HEADs, while still supporting symlinked symrefs.

G=E1bor
