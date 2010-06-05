From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] grep: Add the option '--open-files-in-pager'
Date: Fri, 4 Jun 2010 20:40:21 -0500
Message-ID: <20100605014021.GA1778@progeny.tock>
References: <20100605005116.GA8774@progeny.tock>
 <20100605005322.GB8774@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 05 03:40:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKiNN-0004W8-CZ
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 03:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265Ab0FEBkf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 21:40:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61265 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511Ab0FEBkf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 21:40:35 -0400
Received: by iwn37 with SMTP id 37so1650862iwn.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 18:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=LZbFlBKnVn4GuDvB6ixR4jhmwb5naUwThvcbEadhA4Q=;
        b=dxrA5l7Q/e8udPyypRTIeoGLymVHn9gSYUAZEvMd+qtYbNfgEKKCyXcjkztbPEU4zB
         to3GxvnRqKr/Z6IFmOETRyOWzmAfHkzLAruL/SyXXNwwKJkuhGpMhdcZ919sdh5qCDl0
         SxY1yEiF5U/Ume1cAvRxJd+gVUNSBiUJHkck4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Ycen3Txs67fVX7ItfR2kEnFeS0z+wI6PxPfyAzYg7K64PJP0FwKVspO5X3PDyLQ2VZ
         qg8mT8RLWu3N+t5f3QfTtdvwCqXukLz/+FvWd8Vg6GGJyLF2jNUFO4JHLmD6TbdMzHaw
         i+WrWMkHyjSdgStbJuWwkm0NN2MCGmRlIgjHM=
Received: by 10.231.35.195 with SMTP id q3mr4887872ibd.14.1275702034523;
        Fri, 04 Jun 2010 18:40:34 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r12sm7937398ibi.20.2010.06.04.18.40.32
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 18:40:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100605005322.GB8774@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148445>

Jonathan Nieder wrote:

> +test_expect_success 'git grep -O jumps to line in less' '
> +	cat >expect <<-\EOF &&
> +	+/*GREP_PATTERN
> +	grep.h
> +	EOF
> +	>empty &&
> +
> +	GIT_PAGER=3D./less git grep -O GREP_PATTERN >out
> +	test_cmp expect actual &&

Ugh.  We need a static analyzer for shell scripts. :)  Short of that,
here=E2=80=99s a fixup to squash in.

Sorry for the trouble.

diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
index 72e4023..fcfc56e 100644
--- a/t/t7811-grep-open.sh
+++ b/t/t7811-grep-open.sh
@@ -97,7 +97,7 @@ test_expect_success 'git grep -O jumps to line in les=
s' '
 	EOF
 	>empty &&
=20
-	GIT_PAGER=3D./less git grep -O GREP_PATTERN >out
+	GIT_PAGER=3D./less git grep -O GREP_PATTERN >out &&
 	test_cmp expect actual &&
 	test_cmp empty out
 '
@@ -134,7 +134,7 @@ test_expect_success 'run from subdir' '
 		cd subdir &&
 		export GIT_PAGER &&
 		GIT_PAGER=3D'\''printf "%s\n" >../args'\'' &&
-		git grep -O "enum grep_pat_token" >../out
+		git grep -O "enum grep_pat_token" >../out &&
 		GIT_PAGER=3D"pwd >../dir; :" &&
 		git grep -O "enum grep_pat_token" >../out2
 	) &&
--=20
