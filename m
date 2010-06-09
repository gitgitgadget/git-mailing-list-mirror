From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: RFC: Making submodules "track" branches
Date: Wed, 9 Jun 2010 18:54:34 +0000
Message-ID: <AANLkTiknGcteTjrHWM02H2KOMMDPZKHY1w0ZOIswddFn@mail.gmail.com>
References: <AANLkTilBQPHgkCLJ7ppNo5TwC9Bdmqo-OMRpaDFwbQPd@mail.gmail.com>
	<201006080912.31448.johan@herland.net>
	<4C0E6A8A.70608@web.de>
	<7vbpblruj8.fsf@alter.siamese.dyndns.org>
	<4C0F3FA9.7000800@web.de>
	<4C0FB50F.3020403@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 20:54:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMQQG-0006Mq-W2
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 20:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364Ab0FISyi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 14:54:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48361 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932363Ab0FISyf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 14:54:35 -0400
Received: by iwn37 with SMTP id 37so6141861iwn.19
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tDtlIkTOiP7m5Foee4LfwFqTIvgGX4JVHKOz1YtBLmM=;
        b=AYt0drHkndb3Gf6l8HYN2yD9JWyGCfU1eYK+EEdz2qUR9sNh8yhLyi0XjU0fIxNZGr
         ko9Q1sdEGkmDhMQXHByG2oXpG7vUVSH/P5r4/Qgjl9kmoPt3DQXWfUyOrp3WqaRmbcPj
         MZ2hbbjphmn8/bbWHG+/WA+BTPfO+ohI34bzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MD2N3fiCCu50Q6hDe9Kfnxb5QmN66ZY6K64WrJT517p7XwoC/+qdF0X/4rT6quilLb
         VNfp2DUIckmSwupCU3u700dzFP2KAxEKPiQMRfvF/K8G8YcpgtTI+u9T6HVZekLacIto
         D9Y7ZTheziJ8oCy9O6YEZ/zh7DRP3fD+K8F0o=
Received: by 10.231.157.201 with SMTP id c9mr8349534ibx.116.1276109674599; 
	Wed, 09 Jun 2010 11:54:34 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Wed, 9 Jun 2010 11:54:34 -0700 (PDT)
In-Reply-To: <4C0FB50F.3020403@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148805>

On Wed, Jun 9, 2010 at 15:36, Marc Branchaud <marcnarc@xiplink.com> wro=
te:
> I wish I could come up with some way to reconcile clean branch-tracki=
ng
> submodules with historical consistency, but alas my imagination is so=
 far too
> limited. =C2=A0:(

I think the two concepts are fundimentally at odds with each other,
and that that's completely fine.

Sometimes you're promiscuous enough with your history that you don't
care about being able to go back in time, beyond checking out both
trees as they were at some given time that is. As Johan and others
point out above you could get around that with tags if you wanted
snapshots.

I think we might actually have several different modes of operation:

  * Disconnected head + commit sha1 in the superproject's tree: This
   is what we have now.

  * The same, but make it branch aware. I've scripted this locally
    with the $toplevel patch to git-submodule that started this
    thread. But it could be expanded.

    It would be really neat for example to do:

        # Or some shorter way of doing this, perhaps even with
        # git-pull
        git submodule foreach 'git fetch'

        # Tells you that "submodule xyz which you've pinned to SHA1SUM
        # on the FOOBAR branch is 20 commits behind the upstream
        # FOOBAR branch"
        git status --submodules

    You'd still have to take action to update the module and move the
    SHA1SUM in the parent project, but something like this would make
    cases where you've e.g. included a lot of plugins in your project,
    and would like Git to tell you if they get new updates.

  * Branch-only: What I proposed in this thread. It's certainly not
    for everyone, but there's a lot of cases where you just want a
    quick meta-repository but aren't very interested in 100%
    historical consistency.

  * More? Actually if we're doing multiple strategies I see no reason
    not to e.g. include a foreign scm interface. That would be really
    useful to some projects that are in a SVN -> Git transition:

       [submodule "svn-lib"]
           ;; type defaults to git
           type =3D svn
           path =3D src/svn-lib
           url =3D svn://example.net/path/to/include
           ;; driver-specific attributes
           svn:revision =3D r54238
