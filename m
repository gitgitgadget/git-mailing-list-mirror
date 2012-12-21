From: Junio C Hamano <gitster@pobox.com>
Subject: Re: recommendation for patch maintenance
Date: Fri, 21 Dec 2012 14:17:11 -0800
Message-ID: <CAPc5daXp4cYG_Qy3_n__nSw4F_u73evzm7P1in_74Rs42mNSrg@mail.gmail.com>
References: <50D475EF.6060303@gmail.com> <7vvcbv1grr.fsf@alter.siamese.dyndns.org>
 <50D49C81.5060007@gmail.com> <7vip7v1d96.fsf@alter.siamese.dyndns.org> <50D4D511.4010003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 23:17:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmAue-0008Rj-ES
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 23:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382Ab2LUWRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 17:17:34 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:54473 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab2LUWRd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 17:17:33 -0500
Received: by mail-ob0-f176.google.com with SMTP id un3so5059763obb.21
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 14:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=l7gxfoXcxi3PM0ZCdLSAWRLJ+QdZz3JzY3DBQQrS52o=;
        b=LcnkKIYY/Epne63mnF22CoH0WPKPiAYHQN1zFtPGWQyfbfDE8YJLNQE0ADe+oEauW6
         D+TVgkH4pxhXI4hXV4/sVXMchXNdXgBQByTmwRJvZ4vakVFq8jGLD/rDEj/QUrk5zbHs
         I+iv+sCKIAyd+th60Sux5d5/MeAsRHZu3tmlY1D5ANl6Gm9kE8HznoIf8/ZabLeRC0iW
         g+T1VfHretcCHv/AoLP9DDcZytrgucKozG21A/BjlQQ3zs43/cHndWOa3gx6migB0gtz
         KVjhaI2/XH25/aOQFGEa9TASJnQCIhZkj1Y5gibSlaBNSdzK0m5fOG/JOZCD7jWfVdNS
         tssw==
Received: by 10.60.25.161 with SMTP id d1mr442299oeg.16.1356128252626; Fri, 21
 Dec 2012 14:17:32 -0800 (PST)
Received: by 10.60.13.102 with HTTP; Fri, 21 Dec 2012 14:17:11 -0800 (PST)
In-Reply-To: <50D4D511.4010003@gmail.com>
X-Google-Sender-Auth: Sv4_sTxW5LRadBtBnQrTjcBvh7E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212017>

On Fri, Dec 21, 2012 at 1:30 PM, Manlio Perillo
<manlio.perillo@gmail.com> wrote:
>
> By the way, I would also like to be able to set the default value for
> the --output option in config file; something like:
>
>   [format]
>   output = +mp/$(git symbolic-ref --short HEAD)
>
> where the string will be processed by the shell:
>
>    sh -c 'printf "+mp/$(git symbolic-ref --short HEAD)'"

My knee-jerk reaction is that, while it might make sense to give an
option to allow users to use a dedicated directory per branch, I am
not interested in that form; especially the part that lets the users too
long a rope to hang themselves with by allowing an arbitrary shell
expansions goes against my taste.

But you *can* prove me wrong; read on.

> I should be able to hack the patch in the weekend, but I'm not sure it
> will be accepted.

You got it backwards, just like many other new people who come and go on
this list. If something is very useful, you'd work on it even if the result may
not appear immediately in the upstream, and you'd keep maintaining a local
fork so that you can keep benefiting from it, once you have written such a
useful feature (whatever it is). If even the original "itch-holder"
does not think
that the benefit from his change outweighs the cost of such an effort, why
should *I* carry it in my tree?

The goal of a contributor who comes up with an idea, gets "It doesn't sound
like a good idea" during the review but disagrees and believes in his idea
ought to be to prove the reviewer(s) wrong by polishing the idea and the
implementation so much that the upstream comes begging for your change ;-)

The core part of the change to add --reroll $n option should be straight-forward
and will involve a few functions in builtin/log.c, but the existing
code is so badly
structured that it probably needs a couple of "preparatory steps" patch to clean
up the API between internal functions on that codepath, before the real change
can be made, I think.
