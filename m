From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 2/7] t5520: implement tests for no merge candidates cases
Date: Wed, 6 May 2015 14:04:25 +0800
Message-ID: <CACRoPnQ5EaCmO-tmDxmNW_snFLbFNOq06wdF_p4FPHHv+HiJBA@mail.gmail.com>
References: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
	<1430581035-29464-3-git-send-email-pyokagan@gmail.com>
	<vpqvbg8u5sq.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 06 08:04:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpsRd-0004PC-0A
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 08:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223AbbEFGE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 02:04:28 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:36809 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbbEFGE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 02:04:27 -0400
Received: by lagv1 with SMTP id v1so143714134lag.3
        for <git@vger.kernel.org>; Tue, 05 May 2015 23:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Aflu0pOkIKYESiS1QPRipB/BMWvnxUq8aOvm77MWdbs=;
        b=TiB5OGnwMkg4barMY2ky27Lcl0YUxclra8i+UXawXJlEFOE2qX+fy1DOLKwVRaVIt+
         8NkPYowKy6We093Nj4WlbJYGTnIL3tQL2btaazAu8C/cxW7eOEhZ18S4fK/EwKFsgUbi
         CeONy/EZpB4KJelbFTo1ZnUuVlzlsW7BaRSUJhjJhrE3l2ozSa7WbQiy2pEno7rJbYFP
         WfQBinqQ5KpIMetsPTNPdiaGAp1lrmUrCB6dYbugEtdWsTpc1SIJ2zuUJsTDJ5jSKWXZ
         FoQqwnqDog5WDieeLColGWOhxgAC3LMWvXWW6596HbuBsDRFKlj7MGfleq6eejtJ9bOo
         nXlg==
X-Received: by 10.112.42.16 with SMTP id j16mr26544580lbl.98.1430892265438;
 Tue, 05 May 2015 23:04:25 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 5 May 2015 23:04:25 -0700 (PDT)
In-Reply-To: <vpqvbg8u5sq.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268449>

Hi,

On Mon, May 4, 2015 at 4:04 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>> I'm having trouble hitting the 1st case without resorting to the hack below. A
>> detached HEAD will always have no remote configured, and the code flow would
>> make it such that case (4) is hit in the detached HEAD case instead of case
>> (1).
>
> This should appear in comments in the test 'fail if not on a branch'.
> People reading your [branch ""] in the future won't look for
> below-triple-dash comments in the mailing-list archives ...
>
> And actually, it would be more user-friendly to trigger this error
> message in the normal senario, i.e. check for 1. before 4. in the code.
> This was most likely the intension of the programmer who wrote this
> error message. You may want to fix this now, or add a
> test_expect_failure which will become a test_expect_success when you
> replace git-pull.sh with builtin/pull.c.

Ah, I just figured out how to trigger this error. Just for reference,
before I forget:

1. HEAD must be detached (such that there is no configured remote)

2. The default remote "origin" must exist, so that git-fetch will
succeed even though there is no configured remote for the detached
HEAD.

3. git pull must be called with no arguments, to avoid (4).

I guess everything is working as intended. I copied the different
cases from the commit message of a8c9bef4, but I think that they
should be re-ordered to match the logic in the code. Furthermore,
cases (1) and (2) could probably be explained as:

(1) git-fetch succeeded in fetching from the branch's or repo's
default remote, but:

(1a) We are not on a branch, so there will never be a configured
upstream branch to merge with.

(1b) We are on a branch, but there is no configured upstream branch to
merge with.
