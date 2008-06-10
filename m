From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stg pull/rebase
Date: Tue, 10 Jun 2008 11:02:18 +0100
Message-ID: <b0943d9e0806100302j159f5b7fq6d970316b902b39b@mail.gmail.com>
References: <20080607172202.GA5179@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 12:03:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K60h6-0005rE-AP
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 12:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482AbYFJKCV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2008 06:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757840AbYFJKCU
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 06:02:20 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:55327 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760222AbYFJKCT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 06:02:19 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2111674waf.23
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 03:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=bfIu+uYzvdIforfN+NfytJNPUYs+ev1mRHQKhfRGzGA=;
        b=HYqx/sav+PP5SKTab0ErY78rO/oGsAySFqPfrdhSEMOr1v9rJ42TAu/5C2N3OunFiR
         0oW/1tH4llgfn6+RtfVpurUkYPEj7uFa2tpdKHhqCuLMcH18cRD1U7NUp37XecGzOB9/
         qHCXLuLlfVEp+XBm3p4YYt1he2b6qA6E88yXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PPcXrWuVfaczr8BZEL+8PDquMIgXlpvRwFunsLeXaKXYOqagWzwIbJZrkVG1iuV1tm
         Ms7UMTzPyWCHUlyIYnIPY0kexbd0WUk3dRdE6rWrzMttw7LYZCgxKKKbn32bIkRQSXtM
         HZnjT503hkOhYnT8DG6rM5kQolAh+Jv/vs5bw=
Received: by 10.115.50.5 with SMTP id c5mr4610649wak.60.1213092138980;
        Tue, 10 Jun 2008 03:02:18 -0700 (PDT)
Received: by 10.114.171.16 with HTTP; Tue, 10 Jun 2008 03:02:18 -0700 (PDT)
In-Reply-To: <20080607172202.GA5179@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84490>

2008/6/7 Karl Hasselstr=F6m <kha@treskal.com>:
> As I said, I've been thinking a bit about stg pull and stg rebase
> recently (though I haven't written any code; I don't want to be
> juggling too many balls at once).
>
> Currently, there's stg rebase which only does rebasing, and stg pull
> which does either rebase or merge depending on a config option. And o=
n
> top of that there's config stuff like stgit.pullcmd that is invoked i=
n
> some cases but not others.

This would need some clean-up indeed or maybe better documentation.
They might be a bit difficult and I have to look at the code from time
to time. However, I found some these policies useful. For example, I
just do a "stg pull" from a Subversion repository with the config
below:

[stgit]
        pull-policy =3D fetch-rebase
        fetchcmd =3D git svn fetch
        rebasecmd =3D git svn rebase

> What I think I'd like is the following:
>
>  * Just one command, stg pull. stg rebase is removed.

I still find "rebase" useful and use it in some situations when I
don't need a pull. As Jakub mentioned, maybe we could keep the
"rebase" functionality outside of the "pull" command (make it part of
Stack with a corresponding Branch.rebase?) and have "rebase" use it.

>  * When pull is invoked, the following happens:
>
>      1. The branch we pull from may be updated, depending on the
>         configuration. (e.g. git fetch or git svn fetch)

OK.

>      2. Depending on the configuration (overridable by the
>      --fast-forward, --rebase, and --merge options), one of these
>      three things happen:

But "pull" always suggests fetching something. Adding "--rebase" would
mean that it doesn't fetch. Shouldn't we leave this functionality to
"rebase" only?

>         1. We pop all patches, fast-forward to the new base, and push
>            them back. If it's not a fast-forward, we error out.
>
>         2. We pop all patches, reset to the new base, and push them
>            back.
>
>         3. We pop all patches, merge with the other branch, then push
>            the patches back.

These are OK, with the comment on have rebase functionality in "rebase"=
 only.

>      Fast-forward is the default if no configuration or command-line
>      flag is given.

OK.

> I've personally never had a need for the merge case, but I recall you
> arguing to keep it, Catalin?

I don't use it either but there might be people that have complicated
configurations and they mix Git commits with StGIT patches. Not sure
though.

--=20
Catalin
