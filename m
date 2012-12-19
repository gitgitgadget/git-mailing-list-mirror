From: Tomi Belan <tomi.belan@gmail.com>
Subject: Re: [BUG?] git-subtree behavior when the -P tree is removed and recreated
Date: Wed, 19 Dec 2012 16:40:03 +0100
Message-ID: <CACUV5odJx1+47ggOAppN7whJhLABrRP-3mRWo8adQqbxF4mA5A@mail.gmail.com>
References: <CACUV5ofmuUku=byR1_+Cq+g0SdzqZbH1Z1tPfQf4eNABVyYb_Q@mail.gmail.com>
 <CACUV5odffQoCxr=hTuP+S+DU4+6qD7y=YkTCN3iRr7rjar1bLQ@mail.gmail.com>
 <CACUV5ocT56iOS3dZsJ4JLo70o1HJv2TSrvBHE646SyQVmOuYRg@mail.gmail.com> <877gozuooz.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	"David A.Greene" <greened@obbligato.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Dec 19 16:40:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlLlM-0004y1-Cf
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 16:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477Ab2LSPkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 10:40:35 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43852 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab2LSPke (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 10:40:34 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so2138332obb.33
        for <git@vger.kernel.org>; Wed, 19 Dec 2012 07:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SqopOARxYodbTaqKeZCa8yS5l7bN9PdJ5RoQ/gxmsWU=;
        b=BouOoOBsH7oYQRH0ZKqEN0bJm6JnsC+NHxHS2X4zqSklh9th/uBxUDYA94MqKLV8W3
         4uK9uG+wJTH8LusYDxdZR+5u/mlgrGScLn9ud0nF9RgyCjtilGLl0JeGemSI1/eXvGcg
         702s3+4V5PbIjBQIvNYp+gTnuo6dYANAHFT7jR5Vz2oLPrzNhuUpwNSjW19X9A3QGyO+
         wk9OKxz8yRnKRDQRB6fb9xwduHOva2/+Uodkl0lmsmizEQhCdiCHm7rgnMJVMxMimw5v
         EZ/pRlb8ObSKIpIZ5zNUTGGE31cUXdpaTucAdJEVpXENEnHQJKNN30sJIAORiunBUP7w
         XqHA==
Received: by 10.182.174.34 with SMTP id bp2mr5170734obc.16.1355931633486; Wed,
 19 Dec 2012 07:40:33 -0800 (PST)
Received: by 10.76.173.198 with HTTP; Wed, 19 Dec 2012 07:40:03 -0800 (PST)
In-Reply-To: <877gozuooz.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211828>

Thanks. Here's one more bump. Avery? David?

(Apologies if my bumping is annoying -- because there's no bug
tracker, it feels like the bug will be lost in the ML archives forever
unless I keep calling attention to it. How can I help to get this
issue fixed?)

Tomi

On Mon, Dec 3, 2012 at 4:42 PM, Thomas Rast <trast@student.ethz.ch> wrote:
>
> Tomi Belan <tomi.belan@gmail.com> writes:
>
> > Another bump. I reported this back in October, but there hasn't been
> > any response yet...
> >
> > Note that the bug is still present in git 1.8.0.1.
>
> Probably it would be a good idea to bring it to the attention of people
> who have worked on it: Avery and David (cc'd).
>
> >> On Sat, Oct 13, 2012 at 3:47 PM, Tomi Belan <tomi.belan@gmail.com> wrote:
> >>>
> >>> Hello folks,
> >>>
> >>> I think I might've found a bug in git-subtree: I have a repository
> >>> containing a directory "foo". I'd like to use its code in other
> >>> projects, so I want to split it off into its own repository with
> >>> git-subtree. But it doesn't work as it should. I found out that long
> >>> ago, my repository contained an unrelated directory also called "foo"
> >>> which has since been deleted.
> >>>
> >>> Steps to reproduce (after installing git-subtree from contrib):
> >>> git init repo
> >>> cd repo
> >>> mkdir foo; touch foo/v1
> >>> git add -A .; git commit -m v1
> >>> rm -rf foo; touch v2
> >>> git add -A .; git commit -m v2
> >>> mkdir foo; touch foo/v3
> >>> git add -A .; git commit -m v3
> >>> git subtree split -P foo -b splitfoo --annotate="split "
> >>>
> >>> What should happen: Either (A) splitfoo only contains "split v3", or
> >>> (B) splitfoo contains "split v1" and "split v3"
> >>>
> >>> What happens instead: The parent of "split v3" is "v2", so splitfoo's
> >>> full history is: "v1" -> "v2" -> "split v3".
> >>>
> >>> Git version: 1.7.12.2
> >>>
> >>> Bonus questions:
> >>> - which is the intended behavior, (A) or (B)?
> >>> - if it's (B), how do I convince git-subtree to do (A) once this bug
> >>> gets fixed? (I might be getting too far ahead of myself here...)
> >>>
> >>> Tomi
>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
