From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] commit, write-tree: allow to ignore CE_INTENT_TO_ADD
 while writing trees
Date: Tue, 17 Jan 2012 08:50:46 +0700
Message-ID: <CACsJy8B_qGphVz8PFhPNLsOe-Ve7xb+biNP8Ok7dXiygu3KoSg@mail.gmail.com>
References: <1326681407-6344-1-git-send-email-pclouds@gmail.com>
 <1326681407-6344-3-git-send-email-pclouds@gmail.com> <7vaa5nutbp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 02:51:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmyCq-00012Y-Bo
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 02:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649Ab2AQBvT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jan 2012 20:51:19 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43200 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785Ab2AQBvS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2012 20:51:18 -0500
Received: by bkas6 with SMTP id s6so1134569bka.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 17:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=HIE7ZeYfpI8CyT2WjAhC3h1rfNJt0VSr61JYTXBubMM=;
        b=JqS1EKPEXqMmhLdXZNM43f9p4yFBjotamKZQkwrE4YPM/KUwJRnk7bGptVvaDfgAZc
         Zr5XkzSELkfSSGbGnrOjh6JW8/3NEAqaILN1nJbyKH85q6cNMPTRz0zMp+VEDiZFO7C9
         MFb1gzpu/cHraOg4687K/12azz1lLp83vPPKE=
Received: by 10.205.133.129 with SMTP id hy1mr2722319bkc.76.1326765077486;
 Mon, 16 Jan 2012 17:51:17 -0800 (PST)
Received: by 10.205.123.145 with HTTP; Mon, 16 Jan 2012 17:50:46 -0800 (PST)
In-Reply-To: <7vaa5nutbp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188679>

2012/1/17 Junio C Hamano <gitster@pobox.com>:
> A new command line option "--no-check-intent-to-add" to "commit" with=
out
> any configuration bit may be a useful addition as a first cut, and in
> order to help users to which "there are situations" is more than 50% =
of
> the time, a configuration that can be overriden by "--check-intent-to=
-add"
> may be a usability improvement over that first cut, but if this is re=
ally
> about "there are situations", then a configuration that cannot be
> overriden by command line option feels a wrong way to go about it.

"git -c key=3Dvalue commit" may help.

> Is this really about "there are situations" to begin with? I am suspe=
cting
> that this patch is either:
>
> =C2=A0(1) making it easier to use a wrong workflow, by promoting a wa=
y to
> =C2=A0 =C2=A0 bypass a useful safety measure;
>
> =C2=A0(2) fixing an earlier UI mistake (iow, the interpretation #2 in=
 the old
> =C2=A0 =C2=A0 discussion is always the right one and the existing saf=
ety measure is
> =C2=A0 =C2=A0 misguided) in such a way that allows you to work around=
 an objection
> =C2=A0 =C2=A0 from a bonehead maintainer who refuses to admit that ea=
rlier mistake;
> =C2=A0 =C2=A0 and/or
>
> =C2=A0(3) splitting the Git userbase into two and making the resultin=
g system
> =C2=A0 =C2=A0 harder to teach.

This patch is towards (3). I agree that "add -N" can be confusing to
new users because it does not actually add anything. Those who do not
read manual carefully and commit without checking the result may fall
into that trap. So a user is expected to "level up" a bit and
hopefully by the time he/she feels the need to get around the safety
check and discover this flag, they should be ready to go without the
safety check.

Although I would not oppose deprecating the old behavior if you go with=
 (2) ;)

> In any case, for this change to help people who add more than one pat=
hs
> with "add -N" and want to include only a subset of them in the commit=
, we
> may want to explicitly teach them to add what they want to before
> committing with the new command line option in the documentation.

yeah, keep telling people "this does not add any thing, you need to
git-add again without -N" after running "add -N" using advice
framework when this config is on?
--=20
Duy
