From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Q about git rev-parse {--is-inside-work-tree, --show-cdup}
Date: Fri, 03 Dec 2010 13:25:36 -0800
Message-ID: <7v4oauo8fj.fsf@alter.siamese.dyndns.org>
References: <4CF95BDC.60506@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Fri Dec 03 22:25:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POd8Z-00052G-Kn
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 22:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897Ab0LCVZq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 16:25:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47873 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab0LCVZq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 16:25:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EC87137F6;
	Fri,  3 Dec 2010 16:26:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kluQjnXFZoOM
	W1H02GQN169H6as=; b=nwCfisOb7ljx25U7noP6wyokqgr5WY3OrLxvN0aKYdzK
	3hicrKz9HSe+zL9mLyj/s10Ybrj1BeNvfLIAUWzZg4OdFh6HOtEfIOTTPcrg+Ja2
	m08YO4C1HppZ3U/85KojYjI1lsYhzCdwiavAt8bDwBgbkxO/IW/glOnayszihZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AYo0cO
	6/hOqClF8nsbeHhyGXoPPLj+IJWMH1tB5zf5RYSE3bNyGISk4aCG+ahn4pgHNAFq
	scBVCQE4HsOETm9giWQ8oet/irPgayjcM431Q6srr1ds4DPyAhQT8tMVSfUv+GEQ
	GEU+hvOU2apRATBw2TIbRAenwD8eg53NYi31k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BC83A37F5;
	Fri,  3 Dec 2010 16:26:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 99E5F37F3; Fri,  3 Dec 2010
 16:25:58 -0500 (EST)
In-Reply-To: <4CF95BDC.60506@dirk.my1.cc> ("Dirk =?utf-8?Q?S=C3=BCsserott?=
 =?utf-8?Q?=22's?= message of "Fri\, 03 Dec 2010 22\:06\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ED76F2C2-FF23-11DF-8209-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162859>

Dirk S=C3=BCsserott <newsletter@dirk.my1.cc> writes:

> Hi together,
>
> I wrote some shell scripts that do sth with my git repositories. I pl=
ace
> my scripts in my ~/bin folder (not in the repo). So the first step in=
 my
> scripts is always to check whether they get called from whithin a git
> repo and bail out if they don't.
>
>
> I do this like so:
>
> ---------------------
> if [ "$(git rev-parse --is-inside-work-tree)" =3D "true" ] # (1)
> then
>      here=3D$(pwd)
>      cdup=3D$(git rev-parse --show-cdup);    # (2a)
>      cdup=3D${cdup:-"."}                     # (2b)
>      cd $cdup                              # (2c)
>
>      [do sth useful from the topdir]
>
>      cd $here
>      exit 0;
> else
>      echo "Not inside a git working tree."
>      exit 1;
> fi
> ---------------------
>
> I have two questions:
>
> 1. Wouldn't it be useful, if "git rev-parse" (1) had an option "-q" t=
hat
> simply indicates whether "--is-inside-work-tree" is true by means of =
the
> return code? Actually it has an option "-q" but that doesn't work wit=
h
> "--is-inside-work-tree".

That would break existing scripts that expect "-q" to squelch only the
error output, no?  I think the risk of breaking existing scripts that
other people wrote over time that you (and I) haven't seen outweighs an=
y
benefit (i.e. "if test $(rev-parse...) =3D true" vs "if rev-parse...") =
you
are seeing here.

Another thing to consider is what the script should do when rev-parse
detects an error.  Do we know that all scripts want to behave exactly t=
he
same way in two cases: (1) when run outside the work tree; and (2) when
they cannot determine if they were run from inside or outside?  I don't
think so.

In your example, you are only interested to work inside work tree, and =
you
may find "if rev-parse... then do this interesting thing else fail fi"
sufficient, but a script by somebody else may want to make sure that it=
 is
not run inside any git controlled working tree, and it cannot say "if
rev-parse then punt else do this big thing fi" is not an appropriate wa=
y
to write it.

So in that sense, "if rev-parse ..." is not a huge improvement to begin
with, for people who want to write their script strictly.  They would
probably need to say something like:

	ans=3D$(git rev-parse ...) || {
		do the error thing
                exit 1
	}
       	case "$ans" in
        true)
		do the inside-work-tree thing ;;
	false)
		do the outside-work-tree thing ;;
	*)
        	do the oops thing;;
	esac
