From: Pang Yan Han <pangyanhan@gmail.com>
Subject: Re: [PATCH/RFC 0/2] Teach receive-pack not to run update hook for
 corrupt/non existent ref
Date: Sun, 25 Sep 2011 17:48:22 +0800
Message-ID: <20110925094822.GA1702@myhost>
References: <1316927182-14212-1-git-send-email-pangyanhan@gmail.com>
 <CAMK1S_hadzaqixaW3Fx81pf=hVsvAMpVvVGqVtZ8ncfUsie_9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 25 11:51:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7lMm-00034R-T0
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 11:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755Ab1IYJvG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Sep 2011 05:51:06 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:36092 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601Ab1IYJvD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2011 05:51:03 -0400
Received: by pzk1 with SMTP id 1so11757008pzk.1
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 02:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ylKsr/1Qkq3J5M6w8V/uf56aHdOdp82oijbKQ91CeRw=;
        b=N0PCK0A4XwIAyVHRd/XMC82VyvjTXlmesc7guYXlrX7wiXGHhthNL7wLE/3lzMUDWI
         OhO58cMoQa6PuIhds/Q2iYopTcIp4Lv0/kREgFdRxoZG1KHteRkoeYLY8SA4EVTO6Lzb
         2fDq6FyYepUNXsZJiUiKEqg8qufpfI30jOu1s=
Received: by 10.68.28.37 with SMTP id y5mr21926221pbg.1.1316944261543;
        Sun, 25 Sep 2011 02:51:01 -0700 (PDT)
Received: from localhost (bb116-14-109-35.singnet.com.sg. [116.14.109.35])
        by mx.google.com with ESMTPS id 2sm44431923pbu.1.2011.09.25.02.50.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Sep 2011 02:51:00 -0700 (PDT)
Mail-Followup-To: Pang Yan Han <pangyanhan@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <CAMK1S_hadzaqixaW3Fx81pf=hVsvAMpVvVGqVtZ8ncfUsie_9w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182063>

On Sun, Sep 25, 2011 at 01:28:31PM +0530, Sitaram Chamarty wrote:
> On Sun, Sep 25, 2011 at 10:36 AM, Pang Yan Han <pangyanhan@gmail.com>=
 wrote:
> > Hi list,
> >
> > Currently, receive-pack runs the pre-receive, update, post-receive =
and
> > post-update hooks during a push to delete corrupt or non-existent r=
efs, eg:
> >
> > =A0 =A0 =A0 =A0git push origin :refs/heads/foo
> >
> > where refs/heads/foo is missing from the remote origin.
> >
> > The issue is reported here [1]
>=20
> I did not report an issue.  I asked if this was expected and could be
> relied upon.  I'm actually happy with the current behaviour because i=
t
> solves a problem very neatly for me, but before documenting it I
> wanted to make sure it would not one day disappear.
>=20
> > This is a patch series which teaches receive-pack not to run update=
 hook for
> > corrupt or non existent refs during a push.
> >
> > Patch 1/2 isn't really relevant to the topic. It's just something I=
 stumbled
> > across while reading the code. It removes a redundant assignment in=
 the is_url
> > function.
> >
> > Patch 2/2 teaches receive-pack not to run update hook for corrupt o=
r non
> > existent refs. In summary, I reordered the statements in the update=
 function
> > so that the update hook is not run for corrupt / non existent refs.
> >
> > Perhaps this isn't a good enough solution since the pre-receive, po=
st-receive
> > and post-update hooks are still run. Also the tests aren't exactly =
good looking.
>=20
> It doesn't make sense to disable only the update hook.  And although =
I
> did not come right out and say it, it is the post-update that I care
> about.  If that still runs, my "issue" still exists.

Um I'm rather new to Git and the reason why I didn't reply this initial=
ly was
because I didn't know what to reply. Sorry but you sound rather aggress=
ive and
I was really taken aback by this.

I've taken a look at the code again and here's another approach which w=
ill
result in heavier changes to builtin/receive-pack and may possibly work=
:

Check through the list of refs to be updated before even executing the
pre receive hook. Ensure that there is at least one "valid" ref update.
Essentially this is kind of like "dry running" the update function.

One way to do it is to shift the bulk of work determining valid and inv=
alid
ref updates from the update function to a separate function.
We maintain 2 lists, one to store valid refs to be updated and another =
to
store non-existent/corrupt refs which will be deleted. Specifically, we=
 will
be storing 'struct command'.

The update function can be cut down to these parts:
- determining namespaced_name
- lock_any_ref_for_update
- write_ref_sha1

The pre receive hook will only be executed if the list containing valid=
 ref
pushes is non-empty. Same goes for the post receive and post update hoo=
ks.

What do you think of this approach (if it's even correct)?

>=20
> > Any advice is highly appreciated. Thanks!
> >
> > [1] http://thread.gmane.org/gmane.comp.version-control.git/181942
> >
> > Pang Yan Han (2):
> > =A0is_url: Remove redundant assignment
> > =A0receive-pack: Don't run update hook for corrupt or nonexistent r=
ef
> >
> > =A0builtin/receive-pack.c | =A0 50 +++++++++++++++++++++++++++-----=
---------------
> > =A0t/t5516-fetch-push.sh =A0| =A0 33 ++++++++++++++++++++++++++++++=
+
> > =A0url.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 -
> > =A03 files changed, 62 insertions(+), 22 deletions(-)
> >
> > --
> > 1.7.7.rc3.2.g29f2e6
> >
> >
>=20
>=20
>=20
> --=20
> Sitaram
