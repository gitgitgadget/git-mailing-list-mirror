From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 8/9] completion: fast initial completion for config
	'remote.*.fetch' value
Date: Sat,  8 Oct 2011 16:54:42 +0200
Message-ID: <1318085683-29830-9-git-send-email-szeder@ira.uka.de>
References: <1318085683-29830-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 16:56:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCYKb-0000sd-89
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 16:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827Ab1JHO4t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Oct 2011 10:56:49 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:56104 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747Ab1JHO4s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 10:56:48 -0400
Received: from localhost6.localdomain6 (p5B130863.dip0.t-ipconnect.de [91.19.8.99])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0M1kWE-1Qxmb63yjC-00tzSD; Sat, 08 Oct 2011 16:56:47 +0200
X-Mailer: git-send-email 1.7.7.187.ga41de
In-Reply-To: <1318085683-29830-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:MgG+yQHNtjbIquP8833hN4ZCwivYmiZv34telp5SAg/
 061zx7EpEDs+iwdtxv8CBxbpuvyOvaEXPpqUMaGjI//ulcwitL
 pv2dp5GXe1UWxpS62We0wHT1MNriX2cBb2zN9wbKflMrcKTToQ
 EMstfYOh7aypJ50Xs6vvN0jsJY3SGCA0cKLvho7ANs8OKlHMBW
 Kh/2KSUwj4qKXOcaiczDPXx0V7rrxWUPy+uepzW8TiErU7mZad
 4As4VTNGIEvCIMAByZ89kgoKloK7aa7mvFXP6zBfY65YXDviUC
 hOdKUZHrlX1IPkmQx79CoOyCbTBqcYbsyEOLUK0IpMoZo0qn/M
 mgSrGiHYOwQBLdBqefMtcLVRaPHwYjvuBggB+aMCBfiqW2zYMG
 lga2287HS7A+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183152>

Refspecs for branches in a remote repository start with 'refs/heads/',
so completing those refspecs with 'git config remote.origin.fetch
<TAB>' always offers 'refs/heads/' first, because that's the unique
part of the possible refspecs.  But it does so only after querying the
remote with 'git ls-remote', which can take a while when the request
goes through some slower network to a remote server.

Don't waste the user's time and offer 'refs/heads/' right away for
'git config remote.origin.fetch <TAB>'.

The reason for putting 'refs/heads/' directly into COMPREPLY instead
of using __gitcomp() is to avoid __gitcomp() adding a trailing space.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 658df3a7..d7151220 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1890,6 +1890,10 @@ _git_config ()
 	remote.*.fetch)
 		local remote=3D"${prev#remote.}"
 		remote=3D"${remote%.fetch}"
+		if [ -z "$cur" ]; then
+			COMPREPLY=3D("refs/heads/")
+			return
+		fi
 		__gitcomp_nl "$(__git_refs_remotes "$remote")"
 		return
 		;;
--=20
1.7.7.187.ga41de
