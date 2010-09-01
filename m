From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] push: warn users about updating existing tags on push
Date: Wed, 1 Sep 2010 11:51:05 +0800
Message-ID: <AANLkTinn0Evi6tYMSt+FevJnFt1taQVzqhJKuiGKudOy@mail.gmail.com>
References: <20100828012101.GB2004@burratino>
	<1282983736-3233-1-git-send-email-cxreg@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 05:51:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqeLz-00011N-LU
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 05:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562Ab0IADvK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 23:51:10 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49917 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733Ab0IADvI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 23:51:08 -0400
Received: by eyb6 with SMTP id 6so323972eyb.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 20:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xxhlcvaYbjMtJGKB/a/BoiS1TKarM3Oc3xp6QxoSdzM=;
        b=DAU+MS0tsbOYowFpQpojyis+OFafs8Pwwh/jxs+HyMxzomW1WNeR4EdwUtRt0npCsY
         YL9m8T8bZuo1HrIXgFUgwCkgCMe3vsV1QyqAJv4NKXiMJQO1zXfKfUrn8Fmc6twSQ64i
         ncDWFeJw0P1KKXB4ndAj8ppF46eqbdtyt3Dko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fS8uXTpF77cXDvtCynTwf5C2ql2PK8MWTW9bTrIDhFX/XEP/PM8KXU4QfOcef5vxeb
         ukEIbqTPfvztRqAjgq7s9DTOvgLg6FpZpI0NS1e1kQXhxULnGVhGgOxS5fnknB4X5odc
         REuvU0yD0NGnlayAzQUfszu7CU2kZK+SI2E9Q=
Received: by 10.213.32.74 with SMTP id b10mr11249864ebd.13.1283313065994; Tue,
 31 Aug 2010 20:51:05 -0700 (PDT)
Received: by 10.213.105.73 with HTTP; Tue, 31 Aug 2010 20:51:05 -0700 (PDT)
In-Reply-To: <1282983736-3233-1-git-send-email-cxreg@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155012>

Hi,

On Sat, Aug 28, 2010 at 4:22 PM, Dave Olszewski <cxreg@pobox.com> wrote=
:
> Generally, tags are considered a write-once ref (or object), and upda=
tes
> to them are the exception to the rule. =A0This is evident from the
> behavior of "git fetch", which will not update a tag it already has
> unless --tags is specified, from the --force option to "git tag", and
> the fact that Git does not keep reflogs for tags.
>
> However, there is presently nothing preventing a tag from being
> fast-forwarded, which can happen intentionally or accidentally. =A0In=
 both
> cases, the user should be aware that they are changing something that=
 is
> expected to be immutable and stable.

Sounds like a pretty good idea.

I think we could also expose this as a command-line option - say, --for=
ce-tags.

Also, how will this handle a remote config like this?

  [remote "foo"]
    push =3D +refs/tags/*

> [snip]
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 05ec3fe..02dfc96 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> [snip]
> @@ -1545,6 +1548,10 @@ push.default::
> =A0* `tracking` push the current branch to its upstream branch.
> =A0* `current` push the current branch to a branch of the same name.
>
> +push.denyMovingTags::
> + =A0 =A0 =A0 Whether or not a user will be allowed to push a tag tha=
t already
> + =A0 =A0 =A0 exists on the remote for a different object. =A0False b=
y default.
> +
> =A0rebase.stat::
> =A0 =A0 =A0 =A0Whether to show a diffstat of what changed upstream si=
nce the last
> =A0 =A0 =A0 =A0rebase. False by default.

Hmm, it's a little weird to speak of "allowing" the user to do this
and that. Perhaps

	Whether or not a push will be allowed to proceed if a tag...

> @@ -1593,6 +1600,11 @@ receive.denyNonFastForwards::
> =A0 =A0 =A0 =A0even if that push is forced. This configuration variab=
le is
> =A0 =A0 =A0 =A0set when initializing a shared repository.
>
> +receive.denyMovingTags::
> + =A0 =A0 =A0 If set to true, git-receive-pack will deny an update to=
 a tag which
> + =A0 =A0 =A0 already points to a different object. =A0Use this to pr=
event such an
> + =A0 =A0 =A0 update via a push, even if that push is forced.
> +
> =A0receive.updateserverinfo::
> =A0 =A0 =A0 =A0If set to true, git-receive-pack will run git-update-s=
erver-info
> =A0 =A0 =A0 =A0after receiving data from git-push and updating refs.

Perhaps

	If set to true, git-receive-pack will refuse to update to a tag to poi=
nt the
	tag to a	different object.  Use this...

> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 658ff2f..1d53e04 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -112,7 +112,10 @@ nor in any Push line of the corresponding remote=
s file---see below).
> =A0 =A0 =A0 =A0Usually, the command refuses to update a remote ref th=
at is
> =A0 =A0 =A0 =A0not an ancestor of the local ref used to overwrite it.
> =A0 =A0 =A0 =A0This flag disables the check. =A0This can cause the
> - =A0 =A0 =A0 remote repository to lose commits; use it with care.
> + =A0 =A0 =A0 remote repository to lose commits; use it with care. =A0=
This
> + =A0 =A0 =A0 flag will also allow a previously pushed tag to be upda=
ted
> + =A0 =A0 =A0 to point to a new commit, which is refused if
> + =A0 =A0 =A0 push.denyMovingTags is set to true.
> =A0--repo=3D<repository>::
> =A0 =A0 =A0 =A0This option is only relevant if no <repository> argume=
nt is

Perhaps

	remote repository to lose commits; use it with care.

	Note that for tags that have already been pushed and have been updated
	locally, \--force will not update them if push.denyMovingTags is set t=
o true.

--=20
Cheers,
Ray Chuan
