From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 4/7] bisect: introduce --no-checkout, --update-ref=<ref> support into porcelain.
Date: Sun, 31 Jul 2011 22:05:57 +0200
Message-ID: <201107312205.57488.chriscool@tuxfamily.org>
References: <1312113321-28760-1-git-send-email-jon.seymour@gmail.com> <CAP8UFD2uWRS4KznUAQCCF8sShGy6+sGWgNsLj8mmO7Ur1CDrCQ@mail.gmail.com> <CAH3Anrp+Jynon0O8mQJnKvCNtp0v6oR9pLetmg0B6GnoP2QWMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, gitster@pobox.com,
	j6t@kdbg.org, jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 22:06:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QncH8-0000VI-Lt
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 22:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213Ab1GaUGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 16:06:09 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:44212 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752039Ab1GaUGH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 16:06:07 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0F969A619A;
	Sun, 31 Jul 2011 22:05:58 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <CAH3Anrp+Jynon0O8mQJnKvCNtp0v6oR9pLetmg0B6GnoP2QWMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178272>

On Sunday 31 July 2011 21:48:40 you wrote:
> On Mon, Aug 1, 2011 at 4:35 AM, Christian Couder
> 
> <christian.couder@gmail.com> wrote:
> > On Sun, Jul 31, 2011 at 1:55 PM, Jon Seymour <jon.seymour@gmail.com> 
wrote:
> >> @@ -69,13 +71,18 @@ bisect_start() {
> >>        orig_args=$(git rev-parse --sq-quote "$@")
> >>        bad_seen=0
> >>        eval=''
> >> +       BISECT_UPDATE_REF=
> >>        while [ $# -gt 0 ]; do
> >>            arg="$1"
> >>            case "$arg" in
> >>            --)
> >> -               shift
> >> -               break
> >> -               ;;
> >> +               shift; break ;;
> > 
> > Please don't change this. We try to avoid having many instructions on
> > the same line like this.
> 
> Sure.
> 
> FWIW: there are two places in git-am.sh and git-repack.sh that put shift on
> the same line as another statement,. Also this:
> 
>      case "$arg" in --) has_double_dash=1; break ;; esac

Yeah, we are not always consistent.

> However, 'fixing' those can be another change, assessed on its own merits.

Yeah, but I don't think it's worth it at least for the line above.

> >> +           --no-checkout)
> >> +               BISECT_UPDATE_REF=HEAD; shift ;;
> > 
> > Perhaps:
> > 
> >                   test -z "$BISECT_UPDATE_REF" && BISECT_UPDATE_REF=HEAD
> > 
> > so that "--update-ref=someref --no-checkout" works the same as
> > "--no-checkout --update-ref=someref".
> 
> Got the intent, thanks.
> 
>  How about BISECT_UPDATE_REF=${BISECT_UPDATE_REF:-HEAD}?

Yeah, nice.

Thanks,
Christian.
