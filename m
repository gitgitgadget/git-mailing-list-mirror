From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [RFC 2/2] Don't push a repository with unpushed submodules
Date: Wed, 29 Jun 2011 01:02:49 +0200
Message-ID: <20110628230248.GA4436@paksenarrion.iveqy.com>
References: <1309112987-3185-1-git-send-email-iveqy@iveqy.com>
 <1309112987-3185-3-git-send-email-iveqy@iveqy.com>
 <4E0A506B.6040407@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	gitster@pobox.com, hvoigt@hvoigt.net, jens.lehmann@web.de
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Jun 29 00:48:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbh54-0003t2-03
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 00:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328Ab1F1WsZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Jun 2011 18:48:25 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59575 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab1F1WsY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 18:48:24 -0400
Received: by bwd5 with SMTP id 5so567558bwd.19
        for <git@vger.kernel.org>; Tue, 28 Jun 2011 15:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NWkshOJBv1lvxMLscYXIn5X6ubmYQ6g3FZS9dpVayJg=;
        b=VHswN354xQaqvyEygwfmaC7ZAsELUYL2Pw6U4410Py+m4GdewFn90UnA2D+R7/Kr2K
         dwL8UQZxvxY3qn0kwXAwPYOJHNZ8yNoC2hLDKfFqDPTeHSS9xO/iPG6wwWw9dqJtkUvn
         GISPsXt0y51PSNsqHDRgPEu36YSaj4Nw8k+qU=
Received: by 10.204.141.146 with SMTP id m18mr97295bku.25.1309301302691;
        Tue, 28 Jun 2011 15:48:22 -0700 (PDT)
Received: from paksenarrion.iveqy.com (h-185-240.A189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id g13sm592384bkd.10.2011.06.28.15.48.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Jun 2011 15:48:22 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1QbhIv-0001DK-0n; Wed, 29 Jun 2011 01:02:49 +0200
Content-Disposition: inline
In-Reply-To: <4E0A506B.6040407@xiplink.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176430>

On Tue, Jun 28, 2011 at 06:06:35PM -0400, Marc Branchaud wrote:
> On 11-06-26 02:29 PM, Fredrik Gustafsson wrote:
> > When working with submodules it is easy to forget to push a submodu=
le
> > to the server but pushing a super-project that contains a commit fo=
r
> > that submodule. The result is that the superproject points at a
> > submodule commit that is not avaliable on the server.
> >=20
> > Check that all submodule commits that are about to be pushed are pr=
esent
> > on a remote of the submodule and require forcing if that is not the
> > case.
>=20
> I have a few concerns about what this is trying to do.
>=20
> First, I expect performance will be terrible in repositories with lar=
ge
> and/or many submodules.  I'd go so far as to say that it's pretty muc=
h a
> show-stopper for our repository.

This is not acceptable (in my opinion). The point of making this (only)=
 a
client side check was to not have a huge performance impact.

Would you care for testing this in your enviroment or give me enough
data to be able to set up a test enviroment size-wize like yours?

> Second, there are many times where I'm working in a submodule on bran=
ch
> "TopicA" but not in branch "TopicB".  If I've made submodule changes =
in
> TopicA then try to push up TopicB, won't I have have to tell push to =
"-f"?
> But that turns off other checks that I'd rather keep.

I don't quite follow you here. Anyway, only the commits of the
superproject that you are about to push is checked, and only the
submodules that are changed in any of those commits are examined.

So if you're working in TopicA in a submodule and tries to push TopicB
in a superproject that uses TopicC in the submodule, TopicA will not be
required to be pushed. (if so, is it a bug).

> I'd feel a lot better about this patch if the check was *off* by defa=
ult and
> there was a config setting / command-line option to turn it on.
>=20
> I also agree with Junio that this kind of verification makes more sen=
se in a
> hook on the server side.

Serverside, we cannot guarantee that all submodules are reachable, they
might be on different servers, maybe not even connected to eachothers. =
Even
if they are connected this would requiring network traffic. Making this=
 check=20
an even bigger performance killer. This check is not supposed to guaran=
tee a=20
sane server-repo (that would be much harder) and therefore this check i=
s=20
"overkill" to have on the server-side. Client side we always have all
information needed for this.

Note the problem:
"Prevent the developer of pushing a superrepo that has submodule
(commits) only locally avaliable"

That's the problem we're trying to solve, NOT:

"Prevent the developer of pushing a superrepo that has submodule
(commits) not avaliable for an other developer"

The second problem is just too complex and too slow to solve in a gener=
ic
way.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
