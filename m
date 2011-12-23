From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2 3/3] grep: disable threading in all but worktree case
Date: Fri, 23 Dec 2011 23:37:55 +0100
Message-ID: <CACBZZX6hboo4wu3fOs+CHnxsdmedxw72GFMVttQzmHzpcZbqoQ@mail.gmail.com>
References: <cover.1322830368.git.trast@student.ethz.ch> <5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Eric Herman <eric@freesa.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Fredrik Kuivinen <frekui@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Dec 23 23:38:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ReDks-0000hc-O0
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 23:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757870Ab1LWWiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 17:38:18 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44181 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab1LWWiR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 17:38:17 -0500
Received: by eaad14 with SMTP id d14so3043219eaa.19
        for <git@vger.kernel.org>; Fri, 23 Dec 2011 14:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ljWe3e78KVdJFFkSd5rvFQi2m0bO+ySSBx3L7D4udP0=;
        b=WSC5SjoaqBzV6yK/8xO7tsl3jg35hdQ2OPb+8EcyaURspXWi4p+XbvzCreKruLOReO
         IFQaIRF8OySJl8NLOZD1Vmj1Vfa9r+7/Zp+fw7zHaulp4Zx9jKKyvcBQNgL9j47WL+Wu
         AdyQnf96RuEJTIbJgbFTINIMJuLCsF7KTfSis=
Received: by 10.205.126.18 with SMTP id gu18mr4407347bkc.79.1324679896317;
 Fri, 23 Dec 2011 14:38:16 -0800 (PST)
Received: by 10.204.181.83 with HTTP; Fri, 23 Dec 2011 14:37:55 -0800 (PST)
In-Reply-To: <5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187643>

On Fri, Dec 2, 2011 at 14:07, Thomas Rast <trast@student.ethz.ch> wrote:

> I conjecture that this is caused by contention on
> read_sha1_mutex. [...] So disable threading entirely when not
> scanning the worktree

Why does git-grep even need to keep a mutex to call read_sha1_file()?
It's inherently a read-only operation isn't it? If the lock is needed
because data is being shared between threads in sha1_file.c shouldn't
we tackle that instead of completely disabling threading?
