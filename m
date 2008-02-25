From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 3/3] help: respect aliases
Date: Sun, 24 Feb 2008 21:10:00 -0500
Message-ID: <76718490802241810m5f473156nc350eea07016e8f9@mail.gmail.com>
References: <cover.1203890846.git.peff@peff.net>
	 <20080224221737.GD31309@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 03:10:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTSnk-00085u-JM
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 03:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbYBYCKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 21:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752351AbYBYCKE
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 21:10:04 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:17743 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbYBYCKB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 21:10:01 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1638032wah.23
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 18:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=oj5brWl82eWEtGwPToGVg2z5P30j43VS9jK1TUyKDRM=;
        b=xoGLFGD5qLRaNa8pMCsisCOFhiL3W9SZisdjIdCfodzNhw3/5fIblfywDN42IHomDr+zRT0M6B6W8uHdk7URsRduR883NqJCcz4HS0IlfXvcMKS73zamgEELLjdSWlo4npqkANCpAdJKLmfBJwEcEQXLcNbN8a9Ob5wxK4Qtovo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hvYBxRN6KvWEu88kY9uY9V6r0XLYIvckjlhGtlm1pTFufxhE3jeUQCt7ZKtyvvV8jsk/Jv7WXvyNPTQ418ryMeXdyyk8uVHsITKuuOFjaL6fnJVDXQ7fRzk83Z2472+oZxmUzAZN5YEH/+M8Y97w9mj0evbrl+nEA7/4irHzGDI=
Received: by 10.114.39.16 with SMTP id m16mr2756240wam.146.1203905400121;
        Sun, 24 Feb 2008 18:10:00 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Sun, 24 Feb 2008 18:10:00 -0800 (PST)
In-Reply-To: <20080224221737.GD31309@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74982>

On Sun, Feb 24, 2008 at 5:17 PM, Jeff King <peff@peff.net> wrote:
> If we have an alias "foo" defined, then the help text for
>  "foo" (via "git help foo" or "git foo --help") now shows the
>  definition of the alias.

Heh, now I can kill this alias of mine:

    h          = "!sh -c 'git alias \"$1\" || git help \"$1\"' -"

:-)

This too would be less ugly as a built-in:

    alias      = "! sh -c 'if test -z \"$1\"; then git config --list \
                  | expand \
                  | sed \"/^alias\\./!d; s/^alias\\.//; s/=/ /; s/  */ /g\" \
                  | sort | while read n v; do \
                  printf \"%-16s\" \"$n\"; echo \"$v\" | gnused \
                  \"s/\\(.\\{68\\}\\) /\\1\\n\t\t/g\" | expand; \
                  done; else git config \"alias.$1\"; fi' -"
:-)

j.
