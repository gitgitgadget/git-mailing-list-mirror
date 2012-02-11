From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Sat, 11 Feb 2012 14:45:32 +0100
Message-ID: <201202111445.33260.jnareb@gmail.com>
References: <201202042045.54114.jnareb@gmail.com> <201202102038.55710.jnareb@gmail.com> <CALKQrgdWOgG3y2HzM694zDykGJWa4QDetsEVXf0AGpf=FNFaVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Feb 11 14:46:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwDHC-0000JP-98
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 14:46:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109Ab2BKNpj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 08:45:39 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37549 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150Ab2BKNpi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 08:45:38 -0500
Received: by eaah12 with SMTP id h12so1208569eaa.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 05:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=1s8MAR/bXoy7pynXmZW7fEIGgU69m7p4Xk2W2Quw1Ak=;
        b=M352qdFwIwEMXxyAEfU7kFuzOEA+leOxjZGdSPaW22gFzlzsjnQuEXE7LRWcBqJSQg
         g2kp4hKMwf/6Lpy6h2F1FjelOKe+9w1KtJ5rfcxW1hORw3stT5BkwNp55PvfC3IZA4Xn
         39jdzHSX8nRFOD3wh/Sgmtb9jpf9Esd1ZhujM=
Received: by 10.14.28.194 with SMTP id g42mr3229110eea.44.1328967937254;
        Sat, 11 Feb 2012 05:45:37 -0800 (PST)
Received: from [192.168.1.13] (abwi47.neoplus.adsl.tpnet.pl. [83.8.232.47])
        by mx.google.com with ESMTPS id a58sm35443015eeb.8.2012.02.11.05.45.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 05:45:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CALKQrgdWOgG3y2HzM694zDykGJWa4QDetsEVXf0AGpf=FNFaVg@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190513>

On Sat, 11 Feb 2012, Johan Herland wrote:
> On Fri, Feb 10, 2012 at 20:38, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> > On Tue, 7 Feb 2012, Johan Herland wrote:
[...]
> > > I am unsure whether the 'secret'-ness of a commit should follow a=
cross
> > > the push, but if you do (assuming we store the 'secret' flag usin=
g
> > > git-notes) this is simply a matter of synchronizing the
> > > refs/notes/secret to the same remote.
> >
> > I think it should, so that 'secret' commit would not escape by acci=
dent
> > via a group secret repository.
> >
> > What makes it hard (I think) is that we would prefer to transfer
> > 'secret'-ness only for pushed commits. =C2=A0That might be problem =
for notes
> > based implementation of 'secret' annotation and 'secret'-ness trans=
fer...
> > though I guess knowing that there exist 'secret' commit with given =
SHA1
> > which we do not have and should not have is not much breach of
> > confidentiality. =C2=A0Still...
>=20
> If you don't want to transfer all of refs/notes/secret, you would
> probably have to extend the git protocol with a per-commit 'secret'
> flag (which would then be applied to the receiving repo's
> refs/notes/secret).

Or create per-remote custom notes ref, for example for 'foo' remote it
would be 'refs/remotes/foo/notes/secret'... assuming that canonalizatio=
n
of remote-tracking refs goes in (refs/remotes/foo/{heads,tags,notes,rep=
lace})

This would be updated with 'secret'-ness state of comits being pushed
before actual push, and secretness notes ref would be pushed together
with actual push.

> Still, this is all specific to the 'secret' feature, which IMHO is
> much less important then the 'public' feature. Implementing the
> barebones 'public' feature (i.e. refuse rewrite of commits reachable
> from upstream) is much less work, and would be enough for 90% of git
> users, I believe.

Hmmm... I thought that is 'public' feature that is more work, especiall=
y
in full incarnation.  But perhaps bare bones (no 'pre-push' or 'pre-rew=
rite'
hooks, no traits info in "git log" output, per remote tracking of 'publ=
ic'
status only, no support for bundles or send-email, etc.) could be as ea=
sy
or easier.

As to what is more important for git users... perhaps short survey woul=
d
help here?  I wonder if asking Mercurial users about their use of "phas=
es"
on their mailing would help us...

--=20
Jakub Narebski
Poland
