From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Tue, 13 Dec 2011 09:17:28 -0500
Message-ID: <CABURp0pPqpkWXdC+97wR8HZeX=Nbi0bn-3ji+k9LQnj0kFjCnQ@mail.gmail.com>
References: <20111109174027.GA28825@book.fritz.box> <7vr51htbsy.fsf@alter.siamese.dyndns.org>
 <20111129220854.GB2812@sandbox-rc.fritz.box> <loom.20111210T062013-538@post.gmane.org>
 <7vborhaqgw.fsf@alter.siamese.dyndns.org> <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com>
 <7vaa6x4m5l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Leif Gruenwoldt <leifer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 15:17:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaTB6-0003W5-Sw
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 15:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755209Ab1LMORv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Dec 2011 09:17:51 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50699 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295Ab1LMORu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2011 09:17:50 -0500
Received: by wgbdr13 with SMTP id dr13so13875489wgb.1
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 06:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Rr7XV3/5zJqhroOKKBjVP/HeYIs2nZT8ErdOJzNG0A8=;
        b=F7FZVs5FC2JTaiTeLCJ73hUj7TF7tWH7Fzdw2K93G3A24HgHGuZ0Yf1DkTWh1yTIzK
         pTWN39H58bUqjUcRSLy1yYK+t5nvnEe33zTKuR7M1xdJqG1JwxBko0rEVmX6b9rQ5r4t
         dWCL/MMVi82oTwmKrg/FZw5GbB4Doef/zWEe8=
Received: by 10.227.203.131 with SMTP id fi3mr20640614wbb.17.1323785869548;
 Tue, 13 Dec 2011 06:17:49 -0800 (PST)
Received: by 10.216.120.199 with HTTP; Tue, 13 Dec 2011 06:17:28 -0800 (PST)
In-Reply-To: <7vaa6x4m5l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187021>

On Mon, Dec 12, 2011 at 2:36 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
[...]
> Distro package dependency tracking is a poor analogy for many reasons=
, but
> I'll only touch a few.
[...]
> Naively, one might think that two branches, branch-1.0 and branch-2.0=
, can
> be defined in the repository of L, tell somebody (like "superproject =
that
> covers all the packages in the distro") that A wants branch-1.0 and B
> wants branch-2.0 of L respectively, to emulate this, but if one think=
s
> further, one would realize that it is insufficient. For one thing, it=
 is
> unclear what should happen when both A and B are asked to be checked =
out,
> but more importantly, in dependency requirements on real distro packa=
ging,
> the application C could say "I want v1.0 API but v1.4 is broken and n=
ot
> compatible with me", which won't fit on the two-branches model. A
> workaround to add more branches to L could be devised but any workaro=
und
> cannot be a good solution that allows a random application C among 47
> others to dictate how the branch structure of L project should look l=
ike.
>
> Fortunately, the dependency management is a solved problem by distro
> package management and build systems, and they do so without using
> anything from submodules. There is no point reinventing these logic i=
n git
> submodules and emulating poorly.
>
> The only remotely plausible analogy around distro packaging would be =
a
> superproject full of all the packages in a distro as its submodules, =
and
> records exact versions of each and every package that goes on a relea=
se
> CD (or DVD). In that case, you do want to have a central registry tha=
t
> records what exact version of each package is used to cut the CD and =
the
> mother of all modules superproject could be one way to implement it. =
But
> that is not an example of floating, but is a direct opposite.
>
> This exchange convinced me further that anybody who wishes to use
> "floating" is better off either by doing one or both of the following=
:
>
> =A0- using "exact" but not updating religiously, as the interdepency
> =A0 requirement in their project is not strict; or
>
> =A0- not using submodules at all, but merely keeping these unrelated =
A, B, C
> =A0 and L as standalone repositories next to each other in the direct=
ory
> =A0 structure.

My interdependency requirements are not so cut-and-dry.  We use
submodules to isolate controlled regions of code.  We may need to
share our project with a contractor who is allowed to see code
pertaining to "vendorA" but not that for "vendorB" or "VendorN".  But
our in-house developers want to have all the vendor code in one place
for convenient integration. Submodules do this nicely for us.  We can
give the contractor just the main modules and the VendorA modules and
he'll be fine.  In-house devs get all the submodules (using the
vendor-ALL superproject).

But this necessarily means there is too much coupling for comfort
between our submodules.   For example, when an API changes in the main
submodule, each of the vendor submodules is affected because they each
implement that API in a custom method.  Some of those vendor modules
belong to different people.  Submodule synchronization becomes a real
chore.

=46loating would help, I think.  Instead I do this:

  git pull origin topic_foo && git submodule foreach 'git pull origin t=
opic_foo'

  git submodule foreach 'git push origin topic_foo' && git push origin =
topic_foo

But not all my developers are git-gurus yet, and they sometimes mess
up their ad hoc scripts or miss important changes they forgot to push
in one submodule or another.  Or worse, their pull or push fails and
they can't see the problem for all the noise.  So they email it to me.

On my git server, I have a hook that automatically propagates each
push to "master" from the submodules into the superproject.  But this
is tedious and limited.  And it relies on a centralized server.

You may say this itch is all in my head, but it sure seems real to me.

Phil
