From: Anders Waldenborg <anders.waldenborg@gmail.com>
Subject: Re: [PATCH] diff: Add diff.orderfile configuration variable
Date: Fri, 25 Oct 2013 12:24:42 +0200
Message-ID: <CADsOX3DvqrR66uKtGZr2MJta9F0R7QmU2MO6mr0XA_kut8mZ-Q@mail.gmail.com>
References: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
	<20131021184040.GX9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Anders Waldenborg <anders@0x63.nu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 12:24:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZeZT-00016t-W4
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 12:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab3JYKYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 06:24:44 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:38560 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab3JYKYn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 06:24:43 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so6189717iec.0
        for <git@vger.kernel.org>; Fri, 25 Oct 2013 03:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Qp/8JXdPS0QB1PXDa+SgkFfeHGNmUGchu7Xj15ZUmDw=;
        b=Vw6lBLqCgS5fOaKuVuUIUebKkB3kh60xitwJ5SKWXtAg+6OfszEFXgyBDqN+STYibc
         Lin7m4OWI2YGH4RlZ/He8sAAVRg4UxHG1Yw6I+xFq+Hfhugza71D48yvVfcgpeAFVM/a
         S5GYoLeS9ksfNaLdPArMxby9QCp2KwXQg3ONraqXtA2oJxNELkbAaiwSMt7QmL3bRs6e
         UDwowgQ2adaIvvB1Z3gUoS/IKCemXGF6AgWYbjDlSKmjMd3PLXZNBacCdWZqa+uwvNoe
         uBAjdaQu2rBh2B9TyM/m0z4eTkt5cCmL+XbiDv6ytCt2wRuaEPVT38jys7eMij5L405m
         nvmg==
X-Received: by 10.43.138.134 with SMTP id is6mr55192icc.88.1382696682504; Fri,
 25 Oct 2013 03:24:42 -0700 (PDT)
Received: by 10.64.59.33 with HTTP; Fri, 25 Oct 2013 03:24:42 -0700 (PDT)
In-Reply-To: <20131021184040.GX9464@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236699>

(Jonathan, sorry if you got this multiple times, it seems I forgot to Cc list)

On Mon, Oct 21, 2013 at 8:40 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Should the git-diff(1) manpage get a note about this setting as
> well (perhaps in a new CONFIGURATION section)?

I'll add a reference to the documentation for the -O option at least.
That is how --check, --color, --dirstat and others do it, I guess that
could be moved to a CONFIGURATION section later?

> Should Documentation/technical/api-diff.txt be tweaked to mention that
> the options set by diff_setup() depend on configuration now?

It already did, didn't it? At least diff.context, diff.renames and
diff.color seems to affect diff_setup(), no?

> If a caller wants to parse diff config and also wants to make a diff
> without using the config (the example I'm imagining is an alternative
> implemention fo "git log -p --cherry-pick"), can they do that?  It's
> tempting to move handling of configuration into a separate function.
> (Perhaps it's not worth worrying about that until someone needs the
> flexibility, though.)

Right, patch-ids are not stable wrt ordering. That might be a problem
if some tool stores patch-ids. But maybe that even is a separate bug?
Should patch-id always reorder the files internally? Is it expected
that "git diff -Oorder1  | git patch-id" and "git diff -Oorder2 | git
patch-id" gives same patch id?

It gets very interesting in an imaginative "git log -p --cherry-pick"
which caches patch-ids on disk, one would want one stable ordering for
calculating the patchid, while the displayed patch should respect the
user requested order.

I guess that in most cases one would want to respect user configured
ordering. Should diff_setup grow an argument "ignore_config"? Or
should we maybe add an --no-order-file option that easily be set as a
flag in diff_options in those cases?

> Hope that helps,

It does. Thanks! I have updated patch as per your other comments.

 anders
