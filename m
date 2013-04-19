From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] cat-file: print tags raw for "cat-file -p"
Date: Thu, 18 Apr 2013 23:03:30 -0400
Message-ID: <CAPig+cSn1fQGwqrP6aoVbf9D_JzB30s3c_N_v8sc2VFPUyxfzg@mail.gmail.com>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
	<516D93C4.1000100@lsrfire.ath.cx>
	<7v61zml0ow.fsf@alter.siamese.dyndns.org>
	<516DBE2E.4060201@lsrfire.ath.cx>
	<7vzjwyi0ba.fsf@alter.siamese.dyndns.org>
	<7vli8hhgmn.fsf@alter.siamese.dyndns.org>
	<20130417063942.GA27703@sigill.intra.peff.net>
	<516EE300.7020200@lsrfire.ath.cx>
	<20130417180248.GA1839@sigill.intra.peff.net>
	<516EF2AD.9090403@lsrfire.ath.cx>
	<20130417210048.GA635@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Ivan Lyapunov <dront78@gmail.com>,
	Git List <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 19 05:03:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT1c5-0000uR-5R
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 05:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967855Ab3DSDDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 23:03:34 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:54293 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967546Ab3DSDDd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 23:03:33 -0400
Received: by mail-la0-f41.google.com with SMTP id er20so3173400lab.14
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 20:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=s+mofljAhlEIugjbDq/dtObMjhYIdZ5xbiYbE2X0/ZM=;
        b=uhoY3Lv1VxJCq5KjwGnfnsiC4hft1xmNQXcCObpagQJ+rINJUtzHvK5/6BXc1dzf+5
         f21l0YSUZ5sXlUxQCBJgugWP7UT3smvERyBGkqSNOWS2RiYX7S7rxLSpqVujYiHprUGO
         BAoHvAm7rYcOjap0nscaOaPXQJyXTRf5wLd95uDRCcPShrDyHsW9e+4KofnDTvRb0AQl
         onCJsy3+Y7E54bnhlR8lQJPkDf+tuJg7e2b9zeNSFkVi1fxXUvlwLn26OMLl6TJzz/qE
         ifRkKbp2BYZ1iqONYVi1B98aTiWFUKIZoSEWRW9GgM9kgxKmg6WlVbFyVN7L3ayUgjQt
         ONBg==
X-Received: by 10.112.148.65 with SMTP id tq1mr7092907lbb.104.1366340610466;
 Thu, 18 Apr 2013 20:03:30 -0700 (PDT)
Received: by 10.114.199.11 with HTTP; Thu, 18 Apr 2013 20:03:30 -0700 (PDT)
In-Reply-To: <20130417210048.GA635@sigill.intra.peff.net>
X-Google-Sender-Auth: h_LFYMGY2TYAIQIVY-TVEVm9RiU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221724>

On Wed, Apr 17, 2013 at 5:00 PM, Jeff King <peff@peff.net> wrote:
> Subject: [PATCH] cat-file: print tags raw for "cat-file -p"
>
> When "cat-file -p" prints commits, it shows them in their
> raw format, since git's format is already human-readable.
> For tags, however, we print the whole thing raw except for
> one thing: we convert the timestamp on the tagger line into a
> human-readable date.
> [...]
> Let's drop the tagger-date formatting for "cat-file -p". It
> makes us more consistent with cat-file's commit
> pretty-printer, and as a bonus, we can drop the hand-rolled
> tag parsing code in cat-file (which happened to behave
> inconsistently with the tag pretty-printing code elsewhere).
>
> This is a change of output format, so it's possible that
> some callers could considered this a regression. However,

s/considered/consider/

> the original behavior was arguably a bug (due to the
> inconsistency with commits), likely nobody was relying on it
> (even we do not use it ourselves these days), and anyone
> relying on the "-p" pretty-printer should be able to expect
> a change in the output format (i.e., while "cat-file" is
> plumbing, the output format of "-p" was never guaranteed to
> be stable).
>
> Signed-off-by: Jeff King <peff@peff.net>
