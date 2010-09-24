From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Multiple checkouts active for the same repository
Date: Fri, 24 Sep 2010 13:07:27 +0000
Message-ID: <AANLkTikvyM9wXrewRiG7OdBp5LMfnHSkA9dqZGT1Twpc@mail.gmail.com>
References: <4C9C6F8B.3090806@tech.2degreesnetwork.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Gustavo Narea <gnarea@tech.2degreesnetwork.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 15:07:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz7zy-00070V-Cm
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 15:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893Ab0IXNH3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 09:07:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38870 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024Ab0IXNH2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 09:07:28 -0400
Received: by iwn5 with SMTP id 5so2409715iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 06:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=17lMQvlTWni2GifAUAqaL291kcWUPLv6rlNRbCz+h4k=;
        b=P6a80Zomkj7mfeWax+bFUTYzemkjA12Rsb2o3GnrFY+m/OYmYnzxUsHhtVjdkSlIKm
         JaUIZ+ziJ7H+k8ofkEdNGZQU4wd3GUVrnM+XPyBjmaBPU1jCIBMDDR3Yy98JnT/k0uhD
         i5JqNZjcWhJX3fMxyFi4yyqxbaUFvwEnzKtm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VWaJvh2usVQ2dLNvVVfsJcgj2KghCclJp4J0MIVtFaMXqAbpXEmm04FiCD8/8fTEc3
         U3rNJ8kTypnskWxM4b1GPWGH6lyKFQAZmUxQUNMMFuBEZrgRx0eXq4M54xVVuWriYuT9
         ZzurXxNAgDmPk/YtYM4xGlKaLyXuCgE8n3z/c=
Received: by 10.231.11.8 with SMTP id r8mr3626123ibr.135.1285333647802; Fri,
 24 Sep 2010 06:07:27 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 24 Sep 2010 06:07:27 -0700 (PDT)
In-Reply-To: <4C9C6F8B.3090806@tech.2degreesnetwork.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156984>

On Fri, Sep 24, 2010 at 09:29, Gustavo Narea
<gnarea@tech.2degreesnetwork.com> wrote:

> We're currently migrating from another DVCS.

Which one?

> We are a team of Web developers and testers working on an application=
=2E
> There are always a few development branches and a stable branch, and
> testers need all the branches with the very latest code available at =
all
> times.
>
> The way we handle it at the moment is very simple because the server
> hosting the remote repository is the same that hosts the deployed
> instances of each branch, so when we push to the remote repository, t=
he
> code for each site is automatically updated.
>
> We use the following structure:
> /srv/repositories/project/branch1
> /srv/repositories/project/branch2
> /srv/repositories/project/branch3
>
> Is there any simple way to do this with Git? I can only think of two
> options that involve hooks:
>
> =C2=A0 =C2=A0* Have a hook that exports each branch to a directory li=
ke
> =C2=A0 =C2=A0 =C2=A0/srv/repositories/project/branchN
> =C2=A0 =C2=A0* Have one Git repository per branch, so that each repos=
itory have a
> =C2=A0 =C2=A0 =C2=A0different checkout active. Then the main remote r=
epository will
> =C2=A0 =C2=A0 =C2=A0have post-receive hooks that trigger a pull on ea=
ch individual
>
> I'm not particularly happy with either way. Is there a better solutio=
n?

If you really need this the best solution is to just `git clone` the
project multiple times and check out each branch in its own dir. Then
have some shellscript to update them all.

But just using the Git workflow would be better.

> Apart from the situation I describe in the initial email, there's
> another limitation in the development environment: Our IDE, Eclipse +
> Pydev, assumes each project (i.e., branch/checkout) to be on differen=
t
> directories and each project should have different settings (e.g., pa=
ths
> to dependencies, which could be different), but with GIt everything
> would be a single project because it's all on the same path.

Can't you just modify your build environment to check the output of
`git symbolic-ref HEAD` or equivalent, instead of checking paths?
