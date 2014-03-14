From: John Butterfield <johnb003@gmail.com>
Subject: Re: Proposal: Write git subtree info to .git/config
Date: Thu, 13 Mar 2014 17:43:38 -0700
Message-ID: <CAJ2ZDLK2wGJ5PG585dQRmp7Ck9bctRRtz1unwQ9S0OfVe8G-Bg@mail.gmail.com>
References: <CAJ2ZDL+HuBCv_xJCXEBb3Pex-qt86ocEX9yu=uV+CzdvqwECDA@mail.gmail.com>
	<xmqqmwgthdsp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 01:44:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOGER-0001Yj-Js
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 01:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129AbaCNAn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 20:43:58 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:40026 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbaCNAnj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 20:43:39 -0400
Received: by mail-we0-f171.google.com with SMTP id t61so1536938wes.16
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 17:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WO900IrjLNb/6Hgt/ECc4qjTPcZ/gjZr4fLyzl/JlW8=;
        b=jVRcl0jwujKFIhoTlkOndWx3708ACeJiX1J1yV2ShcTfpVfC22QvTwMnP+rOp+3wQv
         fJog6GnWjaYLyuVuW9+KwBbRh0R0e6wP3V45gYFs/LC1CLFC6nAGCSTm8PkcekAjL4bE
         7wCXwITHwoJbQ1icRIa2EpMCANhMyF4/ycZ7VpkkaqbwxTpkUMK4ZI6KfDW298ZG+Ra6
         djxdRw58sC7BOFqQcJNgktyhnA8NP1rhtHuNiP/Pd6VzPaaUa+UpOhYFpw1j+KO+UVek
         JuhlZeV9HxhYG//Ka24QgVkSrqQX3kqL1VrAyFmUrs3cvRBSFr+yTnxJMhdeRPp43Sku
         pgXA==
X-Received: by 10.180.83.137 with SMTP id q9mr3729062wiy.55.1394757818377;
 Thu, 13 Mar 2014 17:43:38 -0700 (PDT)
Received: by 10.194.174.226 with HTTP; Thu, 13 Mar 2014 17:43:38 -0700 (PDT)
In-Reply-To: <xmqqmwgthdsp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244065>

> A subtree biding can change over time, but .git/config is about
recording information that do not change depending on what tree you
are looking at, so there is an impedance mismatch---storing that
information in .git/config is probably a wrong way to go about it.

I see. How about a .gitsubtrees config file in the root of a project?

> It might help to keep track of "In this tree, the tip of that other
history is bound as a subtree at this path", which means that
information more naturally belongs to each tree, I would think.

Anything in the subdirectory must be part of the contents of the
subtree repo. It should not know how it is linked to it's parent
project; parents should know how their children are fetched. Therefore
it cannot live in the subtree.

Subtrees could be nested. So, should the config be in the root of the
parent subtree? This makes sense to me.

Example:

/
  A/
  B/    # a subtree of (blah)
    X/
    Y/  # a subtree of (yada-yada)
    Z/

So, lets say B has many updates remotely, including pushing and
pulling changes to Y.

When pulling the changes from B, it would be convenient for it to come
with the meta data, (subtree repo and commit info) for Y.

So how does that sound; Could we store subtree repo and commit id
references per folder in a .gitsubtrees file in the root of every
project?

(Project B is technically it's own project so it would pull it's own
.gitsubtrees in /B/.gitsubtrees)

`John

On Thu, Mar 13, 2014 at 4:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> John Butterfield <johnb003@gmail.com> writes:
>
>> Has there been any talk about adding a stub for git subtrees in .git/config?
>
> I do not think so, and that is probably for a good reason.
>
> A subtree biding can change over time, but .git/config is about
> recording information that do not change depending on what tree you
> are looking at, so there is an impedance mismatch---storing that
> information in .git/config is probably a wrong way to go about it.
>
> It might help to keep track of "In this tree, the tip of that other
> history is bound as a subtree at this path", which means that
> information more naturally belongs to each tree, I would think.
