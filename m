From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] tests: add initial bash completion tests
Date: Tue, 17 Apr 2012 09:32:29 +0300
Message-ID: <CAMP44s1CTCPThri6mq0NTvD27WTEiwLTfhHCw+nD+8YwApwL=g@mail.gmail.com>
References: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
	<20120417003100.GB2299@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@fzi.de>
X-From: git-owner@vger.kernel.org Tue Apr 17 08:32:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK1xt-0002t1-Sv
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 08:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892Ab2DQGcc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 02:32:32 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47573 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab2DQGcb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 02:32:31 -0400
Received: by eaaq12 with SMTP id q12so1459642eaa.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 23:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=d80Hl/I3N+QmEAA4J1bJFwvjgH9uoSLgMYOMwoIDfW0=;
        b=w91YmgWUV1nce4aY7aTM9Z5zd74DG+a/D0KqwR3zL8E0yA6DqwVohRS/fqZNIedWdk
         UfLDpxBSNq8w8X012nctb5148aX5nWLUKNLQN4CoA6HvwInSTeXlHeagBnrZRY1TYWdu
         k2RVyxzTBJjXUlF9aXo81+jMRuC9hI45b4qdTFCdYOS+SujGhUZgaegu5VAIgf+VDnub
         HLHeLho91QKjjAkf6c3jH3J4AhQkVJsxAvn3F1eNSNrJemlAACIID8Zf8iHWeey4u1PD
         k9xsPUD9AVkhP3bfISfMFOf+E4Y5Pry0IOOzbNPpTPjYpiNKV1mB3Hn9Az96YV5rFwmT
         i5wA==
Received: by 10.14.39.197 with SMTP id d45mr1979249eeb.89.1334644350339; Mon,
 16 Apr 2012 23:32:30 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Mon, 16 Apr 2012 23:32:29 -0700 (PDT)
In-Reply-To: <20120417003100.GB2299@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195733>

On Tue, Apr 17, 2012 at 3:31 AM, SZEDER G=C3=A1bor <szeder@fzi.de> wrot=
e:
> Hi,
>
>
> I picked up Stephen Boyd's two-patch series[1] to use parse-options t=
o
> generate options for git commands, and the following test promply
> failed (taken from 5c293a6b (tests: add initial bash completion tests=
,
> 2012-04-12)):
>
> test_expect_success 'double dash "git checkout"' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sed -e "s/Z$//" >expected <<-\EOF &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--quiet Z
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--ours Z
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--theirs Z
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--track Z
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--no-track Z
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--merge Z
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--conflict=3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--orphan Z
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--patch Z
> =C2=A0 =C2=A0 =C2=A0 =C2=A0EOF
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_completion "git checkout --"
> '
>
> Not surprising, the completion script doesn't know about many 'git
> checkout' long options. =C2=A0So whenever 'git checkout' learns a new=
 long
> option, this list must be updated. =C2=A0This won't be more work than=
 the
> update of the completion script, so this is probably OK.
>
> But it got me thinking about what do we actually want to test here?
> Whether the completion script returns the right long options in a
> specific order upon 'git checkout --<TAB>'? =C2=A0Or whether _git() w=
orks
> properly and invokes the right command-specific completion function?
> Or whether regular options get a trailing space while options
> expecting an argument don't? =C2=A0Or is this sort of an integration =
test
> and basically all of the above?

I don't think the order is relevant, just that all the options are
there, and the ones with arguments have a =3D in there, and the ones
that don't, a space.

--=20
=46elipe Contreras
