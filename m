From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: propagating repo corruption across clone
Date: Sun, 24 Mar 2013 20:01:33 +0100
Message-ID: <CACBZZX6czzJRF9TEsc8c+=LND6SxaVvrZdbcZ+TfUZTWQOpW0Q@mail.gmail.com>
References: <20130324183133.GA11200@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 24 20:02:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJqBT-0004gg-KD
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 20:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456Ab3CXTB4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Mar 2013 15:01:56 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:42101 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062Ab3CXTBz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Mar 2013 15:01:55 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so5783185oag.15
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 12:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=s+wTIzfW52Ng1gEcs11gbeHebzv6cwrpjYc4GsVA7rY=;
        b=nVxoEwYcnYpjO8dfHsGfnGuuPsjQGX9LSJS9T5AZX/xvupTctwTAOG6BpLkufWjtL+
         urDejBd12u4qpqqE3P1rbZwq9HcHWNC9Or4/bDe/jVdcLeZ1U/2nOKNEfBgoHixkRCOB
         mlCXiTZAAhr8NOwZLWKm7we9MjN48CqPEeMwIeLvzC0uTN0AXYrLw+z5tj54vc9d0Bba
         bUXGeV5RoCr7BRBMjZtvyHC3j4xV0sBWwPYtLDhDotLkPywCY/QxW6ItcgTVCAQC2UFR
         w0ieLttEXdMFQCb4etfjSm4mY9XY+znnMbBQEZy9Q7Xz5T6v6LiRsMQVLWceGJIk2vwM
         nTcQ==
X-Received: by 10.60.25.4 with SMTP id y4mr8438024oef.114.1364151714915; Sun,
 24 Mar 2013 12:01:54 -0700 (PDT)
Received: by 10.76.167.34 with HTTP; Sun, 24 Mar 2013 12:01:33 -0700 (PDT)
In-Reply-To: <20130324183133.GA11200@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218965>

On Sun, Mar 24, 2013 at 7:31 PM, Jeff King <peff@peff.net> wrote:
>
> I don't have details on the KDE corruption, or why it wasn't detected
> (if it was one of the cases I mentioned above, or a more subtle issue=
).

One thing worth mentioning is this part of the article:

"Originally, mirrored clones were in fact not used, but non-mirrored
clones on the anongits come with their own set of issues, and are more
prone to getting stopped up by legitimate, authenticated force pushes,
ref deletions, and so on =E2=80=93 and if we set the refspec such that =
those
are allowed through silently, we don=E2=80=99t gain much. "

So the only reason they were even using --mirror was because they were
running into those problems with fetching.

So aside from the problems with --mirror I think we should have
something that updates your local refs to be exactly like they are on
the other end, i.e. deletes some, non-fast-forwards others etc.
(obviously behind several --force options and so on). But such an
option *wouldn't* accept corrupted objects.

That would give KDE and other parties a safe way to do exact repo
mirroring like this, wouldn't protect them from someone maliciously
deleting all the refs in all the repos, but would prevent FS
corruption from propagating.
