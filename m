From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/6] http-fetch: Use index-pack rather than verify-pack to check packs
Date: Thu, 15 Apr 2010 21:34:09 +0200
Message-ID: <201004152134.10555.j6t@kdbg.org>
References: <20100415141504.GB17883@spearce.org> <1271358560-8946-6-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Apr 15 21:36:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Urn-00021f-CF
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 21:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756179Ab0DOTgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 15:36:42 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:10917 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756049Ab0DOTgl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 15:36:41 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7A405CDF83;
	Thu, 15 Apr 2010 21:36:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id A62C619F5C0;
	Thu, 15 Apr 2010 21:34:10 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <1271358560-8946-6-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145014>

On Donnerstag, 15. April 2010, Shawn O. Pearce wrote:
> +test_expect_success 'fetch notices corrupt pack' '
> +	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git
> "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git && +	(cd
> "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
> +	 p=`ls objects/pack/pack-*.pack` &&
> +	 chmod u+w $p &&
> +	 dd if=/dev/zero of=$p bs=256 count=1 seek=1

Since the particular byte that overwrites the pack is irrelevant, please make 
this:

	printf %0256d 0 | dd of=$p bs=256 count=1 seek=1

for the benefit of us poor Windowsers who do not have /dev/zero.

Perhaps you want to add conv=notrunc.

Ditto in patch 6/6.

Thanks,
-- Hannes
