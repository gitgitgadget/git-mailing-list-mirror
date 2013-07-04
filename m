From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: git gui replaces amend message when prepare-commit-msg hook is
 used
Date: Thu, 4 Jul 2013 13:17:17 +0200
Message-ID: <20130704111717.GF17597@paksenarrion.iveqy.com>
References: <CAGHpTBKOX8G1PZqE2njQ1UbFJeC_L6WxjnTC5NyT8LSbiBNGXw@mail.gmail.com>
 <20130704103440.GH9161@serenity.lan>
 <CAGHpTB+ObJjqvQ-xfQOdGG+ZSZdCijVZXh1NBp97TZ=hO-QVgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Orgad Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 13:17:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuhXF-0007Dq-3Q
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 13:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756152Ab3GDLRI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jul 2013 07:17:08 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:39839 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab3GDLRG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 07:17:06 -0400
Received: by mail-la0-f51.google.com with SMTP id fq12so1128588lab.10
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 04:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5fN/onu2eFuBmml3XTcx5OOayu/wTK9y91FxGgC+z48=;
        b=rEUcLb5YmwrfznmbYwzkdrYrNLXcr3meJuXzV337sLvfW8PHvVpKm33WQJ/4K9eyT0
         25U8O+PO9PYFrMPZ6INb2DMeAKiT/U72APLn3VQZLk+jLvwxb3a6EqtyeRGK2hjEFJe9
         PwdSJw9dZCzXofYK4Eh7s51Oc0hKrQ9RV4cC0eSK/OnMWSpFTBexP8ptN+yCNhftybUz
         ZONoJhoGfg6sryMPiu0iW93dwM+6iyHy+X4rqSi63UhIGyS/tboz6lZ7BpKmlvHQ5q4N
         5pDlp/kC81IakhTAH2Fl9iiADdtlKi+RSGJegUU/gpkMLAnuhWaHb15sOGvbtpxTN7mm
         pcZA==
X-Received: by 10.152.27.195 with SMTP id v3mr2603154lag.73.1372936621492;
        Thu, 04 Jul 2013 04:17:01 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id u1sm945971lag.5.2013.07.04.04.17.00
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jul 2013 04:17:00 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UuhXJ-0003YA-LT; Thu, 04 Jul 2013 13:17:17 +0200
Content-Disposition: inline
In-Reply-To: <CAGHpTB+ObJjqvQ-xfQOdGG+ZSZdCijVZXh1NBp97TZ=hO-QVgQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229571>

On Thu, Jul 04, 2013 at 01:59:10PM +0300, Orgad Shaneh wrote:
> On Thu, Jul 4, 2013 at 1:34 PM, John Keeping <john@keeping.me.uk> wro=
te:
> > On Thu, Jul 04, 2013 at 12:47:28PM +0300, Orgad Shaneh wrote:
> >> Hi,
> >>
> >> If a prepare-commit-msg hook is used, git gui executes it for "New=
 Commit".
> >>
> >> If the "New Commit" is selected, and then immediately "Amend" (bef=
ore
> >> the hook returns), when the hook returns the message is replaced w=
ith
> >> the one produced by the hook.
> >
> > I think this is a problem with the hook you are running.  The hook =
is
> > given arguments specifying the message file and optionally the sour=
ce of
> > whatever is already in the file (see githooks(5) for details).
> >
> > It sounds like your hook is blindly overwriting the file, rather th=
an
> > preserving its contents in the cases where you wish to do so.
>=20
> Let me try to explain.
>=20
> When git gui is executed, it calls the prepare-commit-msg script with
> .git/PREPARE_COMMIT_MSG as an argument.
>=20
> When amend is selected, the hook is *not* called at all (what would i=
t
> prepare? The message is already committed)
>=20
> Use the following hook to reproduce:
> --- snip ---
> #!/bin/sh
>=20
> sleep 5
> echo "$@" >> /tmp/hook.log
> echo 'Hello hook' > "$1"
> --- snip ---
>=20
> Now run git gui (or press F5 if it is already running), and before 5
> seconds pass, click Amend last commit. You'll see the commit's
> message, but when the 5 seconds pass it is replaced with "Hello hook"=
=2E
> That's the bug.

Yeah I got what you mean, it looks like it's an update problem of the
test-box in git-gui. You can also get that textbox to be completely
empty if you click back and foward between "new commit" and "amend". Th=
e
hook is not always runned.

I can confirm this bug. I don't think it related to pure git but to
git-gui.

I imagine that "new commit" exectures the prepare-commit-msg hook and
replaces the textbox content with it. Something that should be correct,
but the you've already told the textbox to have an other value (the
value of the commit to amend).

There should be a check before writing to the textbox if "new commit"
still is set.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
