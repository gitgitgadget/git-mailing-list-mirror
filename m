From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] mv: prevent mismatched data when ignoring errors.
Date: Sat, 15 Mar 2014 17:05:29 +0100
Message-ID: <8738ijzbue.fsf@thomasrast.ch>
References: <20140308183501.GH18371@serenity.lan>
	<1394306499-50871-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Guillaume Gelin <contact@ramnes.eu>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sat Mar 15 17:05:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOr5f-0002KW-DG
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 17:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756054AbaCOQFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 12:05:33 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:55510 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756011AbaCOQFc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 12:05:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id C58CB4D658F;
	Sat, 15 Mar 2014 17:05:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zefnUAM2GIFe; Sat, 15 Mar 2014 17:05:30 +0100 (CET)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id B4F374D64BD;
	Sat, 15 Mar 2014 17:05:29 +0100 (CET)
In-Reply-To: <1394306499-50871-1-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Sat, 8 Mar 2014 19:21:39 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244155>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We shrink the source and destination arrays, but not the modes or
> submodule_gitfile arrays, resulting in potentially mismatched data.  Shrink
> all the arrays at the same time to prevent this.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/mv.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index f99c91e..b20cd95 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -230,6 +230,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  					memmove(destination + i,
>  						destination + i + 1,
>  						(argc - i) * sizeof(char *));
> +					memmove(modes + i, modes + i + 1,
> +						(argc - i) * sizeof(char *));

This isn't right -- you are computing the size of things to be moved
based on a type of char*, but 'modes' is an enum.

(Valgrind spotted this.)

-- 
Thomas Rast
tr@thomasrast.ch
