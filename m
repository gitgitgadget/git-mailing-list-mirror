From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] refs_from_alternate: helper to use refs from alternates
Date: Sat, 12 Mar 2011 00:08:27 +0100
Message-ID: <201103120008.27973.j6t@kdbg.org>
References: <1299876671-12838-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 12 00:08:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyBRn-0005Tr-6G
	for gcvg-git-2@lo.gmane.org; Sat, 12 Mar 2011 00:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151Ab1CKXId convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Mar 2011 18:08:33 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:13426 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751533Ab1CKXId (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 18:08:33 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 82AD6130049;
	Sat, 12 Mar 2011 00:08:28 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2F4C019F5AA;
	Sat, 12 Mar 2011 00:08:28 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1299876671-12838-1-git-send-email-gitster@pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168932>

On Freitag, 11. M=E4rz 2011, Junio C Hamano wrote:
> +count_objects () {
> +	(
> +		echo 0 &&
> +		git count-objects -v |
> +		sed -n -e 's/^count: \(.*\)/\1 +/p' \
> +		    -e 's/^in-pack: \(.*\)/\1 +/p' &&
> +		echo p
> +	) | dc
> +}

Can we have this without using dc? (We don't have it on Windows.)

diff --git a/t/t5501-fetch-push-alternates.sh=20
b/t/t5501-fetch-push-alternates.sh
index 564ef7c..eb844cf 100755
--- a/t/t5501-fetch-push-alternates.sh
+++ b/t/t5501-fetch-push-alternates.sh
@@ -4,13 +4,11 @@ test_description=3D'fetch/push involving alternates'
 . ./test-lib.sh
=20
 count_objects () {
-	(
-		echo 0 &&
+	echo $(( $(
 		git count-objects -v |
 		sed -n -e 's/^count: \(.*\)/\1 +/p' \
-		    -e 's/^in-pack: \(.*\)/\1 +/p' &&
-		echo p
-	) | dc
+		    -e 's/^in-pack: \(.*\)/\1/p'
+		) ))
 }
=20
=20
