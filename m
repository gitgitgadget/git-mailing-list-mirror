From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: ghost refs
Date: Tue, 20 Apr 2010 09:33:42 -0400
Message-ID: <s2m76718491004200633la1cb07a6n8bc0d8d8e71b4e92@mail.gmail.com>
References: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com>
	 <r2h32541b131004070958pa66bb7a3g6a1ecfaea0419965@mail.gmail.com>
	 <20100407210010.GB27012@coredump.intra.peff.net>
	 <loom.20100420T085842-887@post.gmane.org>
	 <20100420115124.GB22907@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <yann.dirson@bertin.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 20 15:33:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4DaI-0004bV-Tr
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 15:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754679Ab0DTNdq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Apr 2010 09:33:46 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38030 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754632Ab0DTNdp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Apr 2010 09:33:45 -0400
Received: by pwj9 with SMTP id 9so4179238pwj.19
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 06:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RgG2eK9RvuhIMxKEp3N/Sd/k8ZWp+nGIbLPROA53v78=;
        b=w2bbAO1pjHDA6+uP7+MbM1BX6cEI/Dji8acJ2jG2OjXXMWePu8QF7RPz5Kvr7jgvQW
         uspR+XE36eJVAiTc6s+IKqEvB3awrepkZCVCxaSCOwTvkvI7bS1vJzL6qnJUIharzivj
         ckxInY55qYiHlXYtPnbpzK+9RTqKc3H6RIqSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IXmNyhodDzPi7SyvUHuZftPsNBeRm26kXP8gSKgu+7PROljg1IEB3TU4/o1nn25Q6o
         VWYU30x2fv+Io5yGqNpbPIZsDqZw01iGMjfQaoxLK0omK1gFzkYb4Wg7yCRJRfGnjFbd
         oHDoMu14q3YKnwakuTwAVB2uphgT8eqnage3Q=
Received: by 10.231.36.9 with HTTP; Tue, 20 Apr 2010 06:33:42 -0700 (PDT)
In-Reply-To: <20100420115124.GB22907@coredump.intra.peff.net>
Received: by 10.141.13.8 with SMTP id q8mr530460rvi.269.1271770422567; Tue, 20 
	Apr 2010 06:33:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145375>

On Tue, Apr 20, 2010 at 7:51 AM, Jeff King <peff@peff.net> wrote:
> Almost. The complication is that a branch "foo" prevents any branch
> "foo/bar" from being created. So if you leave the reflog in place, yo=
u
> are blocking the creation of the reflog for a new branch.
>
> So you need some solution to that problem. Things I thought of are:
>
> =C2=A01. Leave the reflog in place until such a foo/bar branch is cre=
ated.
>     [...]
> =C2=A02. Make a refs/dead hierarchy so that the reflogs don't interfe=
re with
>     [...]
> =C2=A03. Stick everything in a big "graveyard" reflog. I think there =
are
>     [...]

4. Just append to the existing reflog? Given:

$ git checkout -b topic origin/master # 1
$ git add; git commit ...
$ git checkout master
$ git merge topic
$ git branch -d topic
$ git checkout -b topic origin/master # 2

Whose to say that the branch named topic from (1) and the branch named
topic from (2) are unrelated? Isn't the fact that they have the same
name is an indication that they are likely to be related. And even if
they are unrelated, what's wrong with re-using the same reflog?

Wouldn't it be obvious what happened? e.g.:

64c7587 topic@{0}: branch: Created from HEAD
abcdef3 topic@{1}: branch: deleted topic    <---- I made this one up
3568c4b topic@{2}: commit: turned the knob to 11
707d9fb topic@{3}: branch: Created from HEAD

j.
