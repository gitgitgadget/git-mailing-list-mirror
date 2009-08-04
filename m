From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Please make git-am handle \r\n-damaged patches
Date: Tue, 4 Aug 2009 08:35:24 +0200
Message-ID: <81b0412b0908032335s3363849aj32a0e93efa15c012@mail.gmail.com>
References: <4A7735B0.2040703@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 08:35:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYDcT-0004tj-1y
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 08:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbZHDGfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 02:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbZHDGfZ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 02:35:25 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:49592 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932431AbZHDGfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 02:35:25 -0400
Received: by bwz19 with SMTP id 19so2887200bwz.37
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 23:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=atuhrji4Q+dDKntVVlITEWEqZJEjhov2w+vT4vA900I=;
        b=AMlnxTFEfjvrsDSO4oU+XRmblPHd9syxmVyeSX91LuTj7A9+jLID8aeaxx9o9R4fBg
         w7I2HLKjaMP5jaFKsHN8F66RGni0cUo5Ckf7ZDQFuZI/zquTn6epwTi++SdNPf0A/E3A
         BFTUW+mQyFArKNwaCV7BuEKpov1aWG234+7dc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HorezMScDMy5BnW+ZyU4iRguVA+vjMCykDlCViL9nR3/avwa+IigGtzVBq/LQ+K+Ml
         AU+8FA8Nwo5uvTxs/H8H2UsCu8AdkzSTqpYraJ4KBl4SPCK4lwK3JRGgD9QSteu3UZvP
         WTkIJpMenYexLHDRvDfPzjC+EAuueogwXECYo=
Received: by 10.204.56.4 with SMTP id w4mr5554004bkg.25.1249367724603; Mon, 03 
	Aug 2009 23:35:24 -0700 (PDT)
In-Reply-To: <4A7735B0.2040703@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124757>

On Mon, Aug 3, 2009 at 21:08, H. Peter Anvin<hpa@zytor.com> wrote:
> In a serious case of craniorectal immersion, the Thunderbird developers
> have started using \r\n line endings on saved emails:
>
> https://bugzilla.mozilla.org/show_bug.cgi?id=503271
> https://bugzilla.mozilla.org/show_bug.cgi?id=507530
>
> It would be nice if git-am could handle this case automatically.
>

Maybe it is as simple as that (not tested yet,
and sent through gmail, so please be careful):

diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index ad5f6b5..02c1c92 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -58,6 +58,8 @@ int read_line_with_nul(char *buf, int size, FILE *in)
 		if (c == '\n' || len + 1 >= size)
 			break;
 	}
+	if (len && buf[len - 1] == '\r')
+		--len;
 	buf[len] = '\0';

 	return len;
