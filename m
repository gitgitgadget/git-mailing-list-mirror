From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] diffcore-pickaxe doc: document -S and -G properly
Date: Fri, 31 May 2013 17:34:54 +0530
Message-ID: <CALkWK0m+kUa0QUotHXSYK40vFviFFv2yETnf6sEZMh05gOgLKg@mail.gmail.com>
References: <1369391635-13056-1-git-send-email-artagnon@gmail.com>
 <1369391635-13056-3-git-send-email-artagnon@gmail.com> <7v38tcb7yx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 31 14:05:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiO5T-0006xp-Mf
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 14:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864Ab3EaMFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 08:05:36 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:47741 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125Ab3EaMFf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 08:05:35 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so3725416iea.32
        for <git@vger.kernel.org>; Fri, 31 May 2013 05:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DQ0uHKCT9ZLTXXzcj+daBCn9kHt++8gDBElj7Zv6eaA=;
        b=LccXDhsBRLDE6dfalkG4iZ6zXEcLjQuj/GKikHuq82dESpsHYNUrjB1wTA1Mny/mJ7
         H7HVJBdmmrYE0gVxH382kToS7nDpU/GeLsWs5hb2xQ2O+VmAaSZuXL2ilGlurGDuABA1
         bnVk8na2yB4tIZ+QRIW1MqTHKkE0he2SkOjSbDnd2ROxX55Ixe4YI2sQ5nj9a93SNFdX
         tWKfDvwX50iNdQOqP/g42v54tEnIADP18hl2eJCVLZ16MOh2L1ppDO4pyViQzaL5MfLv
         ukKGQIRRc/o3gaU5KBCg83Xngv6V/N+U54TtCuyXzFnDsvV5m7SddiYdKvhBoZ5ihbXE
         BTog==
X-Received: by 10.50.141.230 with SMTP id rr6mr1500608igb.89.1370001934436;
 Fri, 31 May 2013 05:05:34 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Fri, 31 May 2013 05:04:54 -0700 (PDT)
In-Reply-To: <7v38tcb7yx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226088>

Junio C Hamano wrote:
> [...]

I agree with everything else, and made changes accordingly.

>         This transformation limits the set of filepairs to those
>         that change specified strings between the preimage and the
>         postimage in a certain way.

Definitely good.

>         -S<block of text> and -G<regex> options are used to specify
>         different ways these strings are sought.

Definitely better than the "two kinds of pickaxe" thing.

>         Without
>         --pickaxe-all, only the filepairs matching the given
>         criterion is left in the output; all filepairs are left in
>         the output when --pickaxe-all is used and if at least one
>         filepair matches the given criterion.

Why do a poor-man's version of --pickaxe-all here, when the last
paragraph already does justice to this?

When `-S` or `-G` are used without `--pickaxe-all`, only filepairs
that match their respective criterion are kept in the output.  When
`--pickaxe-all` is used, if even one filepair matches their respective
criterion in a changeset, the entire changeset is kept.  This behavior
is designed to make reviewing changes in the context of the whole
changeset easier.

> I am not sure why it is necessary to say anything about what the
> previous step (diffcore-rename) might have done.  The input of this
> (or any other) step in the diffcore pipeline is a preimage-postimage
> filepairs, and to this transformation the filename does not matter.
> Whether a file was moved (either "wholesale", implying nothing
> changed, or renamed with modification at the same time) without
> touching the block of text, or a file did not get involved in any
> renaming, the only thing that matters is what the preimage and the
> postimage in a filepair has (or does not have).

While what you're saying is technically true, I think it is important
to explain the interaction between diffcore-pickaxe and
diffcore-rename as I have done.  Someone who wants to understand what
`git log -S` does will come to this page and read this section:
without reading diffcore-rename, she will have an incomplete picture;
what's the harm in explaining diffcore-rename in the context of
diffcore-pickaxe?

I did do a s/rename detection/diffcore-rename/ though, so the user
knows where to look for more on this rename thing.
