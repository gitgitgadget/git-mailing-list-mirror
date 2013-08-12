From: David Jeske <davidj@gmail.com>
Subject: Re: ephemeral-branches instead of detached-head?
Date: Mon, 12 Aug 2013 01:37:33 -0700
Message-ID: <CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
 <7veh9z1gym.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 10:38:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8ndq-0000ye-Ea
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 10:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478Ab3HLIiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 04:38:15 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:46368 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754237Ab3HLIiO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 04:38:14 -0400
Received: by mail-oa0-f50.google.com with SMTP id i4so9282973oah.37
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 01:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9glnPIqndj15135oFFylWPA1u0Q7sKVpq0JOMZd5ubE=;
        b=ZOqvF69m77whTCTsi3VcSpdFqHG3Hi5Iyloe5+Fy7c1iYFunk8dZ0U8pdJYehT8+Jr
         5LHo8Rkxky6SejlR5Y12xd46fDpDhOtNb4VtbCozOxrpWh6PIZAFhe4sVvNLUhIEBJu0
         ASF7qeH4dE1HWInCaiM5Ed86pFEsGk0YrkiZG7/QFnR4/kWF6tCu6CN4dsoE3AwzXKSu
         v8QynEkaxTL7vrWaRuUaUtsJVzctXQn6n6TavrQT5OCW8LXpIP2Fr4e18ish1IDiIOJS
         rXZS1buc7A46zNHL3QSvDD1g8Pfs/PbGVQpgbj5Z+ckdywuyA9SP+6sllsvWGWMP4Fx+
         A/6Q==
X-Received: by 10.182.28.98 with SMTP id a2mr9852576obh.36.1376296693795; Mon,
 12 Aug 2013 01:38:13 -0700 (PDT)
Received: by 10.60.120.65 with HTTP; Mon, 12 Aug 2013 01:37:33 -0700 (PDT)
In-Reply-To: <7veh9z1gym.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232178>

> Would the temporary branch created by checking out a random commit be automatically deleted when checking out another branch, or would it be garbage-collected at some
> point later?


Yes, as I stated in my example, the ephemeral branch created from
checking out a random commit would be automatically deleted anytime
there was another downstream name for the ref (and the ref was no
longer in the working-directory). Another way to think of the proposal
is to allowed detached-HEADs, but automatically create ephemeral
branch-names when checking into a detached head.

On Mon, Aug 12, 2013 at 12:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> As Jonathan mentioned, your local branch namespace _is_ ephemeral in
> the larger picture, and you can and should use your regular branches
> as such.

This is not the case. To me "ephemeral" means that the branch name
automatically disappears if nothing gets checked into it. The local
branch names definitely do not operate this way.

> (1) is not a problem at all by itself with detached HEAD.  You can
> commit all you want, and the true problem people perceive that comes
> from (1) is (2), as they think they would lose commit that way.

It is not a matter of a commit being destroyed, as I know they are not
destroyed, it is a matter of "losing" as in it being a
pain-in-the-a-s-s to find the darn thing.

The reflog is only really useful for a short time. If you don't notice
until later, it's too late for this to be a reasonable way to find the
missing commit.. and this assumes you noticed at all.

For as long as I've used git, I simplu don't understand why I should
be able to commit something, and have it go "missing" in the branch
namespace without an explicit action on my part.

> A truely ephemeral branch that users do not consciously name would be referred to some random string (your etmp/4324 below) that is just as discoverable as an entry in
> the reflog of the HEAD, so you didn't solve any problem here.

This is simply not true.

The reflog is filled with every reflog action. Any checkout, push,
pull, existing commits, etc. The ephemeral space would *only* contain
dangling refs that were not named, merged, or discarded.

> ...the history leading to the tip commit will not be at the tip of any meaningfully
>
> named branch.  That is different from a commit getting lost, and I
> do not see how ephemerally created branches with random names would
> help people discover these commits better compared to reflog for the
> HEAD.

Is there currently any way to say "hey, git, show me what commits are
dangling that might be lost in the reflog?"

I'm not aware of one. This is the difference. It's making the action
of throwing away a dangling ref more explicit.
