From: =?iso-8859-1?Q?M=E5rten?= Kongstad <marten.kongstad@gmail.com>
Subject: Re: [PATCH v2] diff --shortstat --dirstat: remove duplicate output
Date: Sun, 1 Mar 2015 16:58:18 +0100
Message-ID: <20150301155818.GA5307@laptop>
References: <xmqqegp9gyof.fsf@gitster.dls.corp.google.com>
 <1425195546-15637-1-git-send-email-marten.kongstad@gmail.com>
 <54F2E931.7020200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, johan@herland.net, marten.kongstad@gmail.com
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 01 16:58:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YS6GF-0006pu-Fy
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 16:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbbCAP61 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2015 10:58:27 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:42557 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbbCAP60 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 10:58:26 -0500
Received: by lamq1 with SMTP id q1so2702381lam.9
        for <git@vger.kernel.org>; Sun, 01 Mar 2015 07:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Zgnozs5al/xGxEC1+u1xTDJwX2NGTJuHsjWhUNQvpZs=;
        b=U6KifpCrhuwG1PEGxLIF7aHCsTiV388UtWgdjt00XdelTw8shvnetQuXIoofjx/Evk
         tY9BWQRnUVS6+jAMnubM2KK765Oa29VH9dYeHWJ292tng49m7/pRvh9hpKsiHi0kVV9Q
         gXCR7chvfsYsOnlo+9X/S0QLBBGtyOqO9klwWJOygep+ah/oN+OA7ef47uyg8AGJxHFm
         z3c+Rlkv1Ezxt7DIH+Ndd0KrCgXt/hBxmgv4sAoS2r0wSZcLAmdU2hNK50+vyzhkQgpM
         WLjXX0Yt/Pl65W26gzB/AzaZ59vuorbOV6IAL4C3kdWj8Xx92fK2Wl/kM8YD541xU8+Y
         5wlQ==
X-Received: by 10.112.167.136 with SMTP id zo8mr20643707lbb.17.1425225504913;
        Sun, 01 Mar 2015 07:58:24 -0800 (PST)
Received: from laptop ([95.109.106.222])
        by mx.google.com with ESMTPSA id bt10sm1991588lbd.39.2015.03.01.07.58.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 01 Mar 2015 07:58:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54F2E931.7020200@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264560>

On Sun, Mar 01, 2015 at 11:25:53AM +0100, Torsten B=F6gershausen wrote:
> On 2015-03-01 08.39, M=E5rten Kongstad wrote:
> []
> > +test_expect_success '--shortstat --dirstat should output only one =
dirstat' '
> > +	git diff --shortstat --dirstat=3Dchanges HEAD^..HEAD >actual_diff=
_shortstat_dirstat_changes &&
> > +	test $(grep -c " dst/copy/changed/$" actual_diff_shortstat_dirsta=
t_changes) =3D 1 &&
> How portable is the "grep -c" usage ?
> (I don't now it either, do we have other opinions ?), but the followi=
ng seems to be more "Git-style":
>=20
> test_expect_success '--shortstat --dirstat should output only one dir=
stat' '
> 	git diff --shortstat --dirstat=3Dchanges HEAD^..HEAD >actual_diff_sh=
ortstat_dirstat_changes &&
> 	grep " dst/copy/changed/$" actual_diff_shortstat_dirstat_changes >ac=
tual &&
> 	test_line_count =3D 1 actual
>=20
=46rom what I can see, both 'grep -c' and 'grep >file && test_line_coun=
t'
are used in the tests.

'grep -c' is used in these tests:
- t3404-rebase-interactive.sh
- t3507-cherry-pick-conflict.sh
- t4036-format-patch-signer-mime.sh
- t4150-am.sh
- t7810-grep.sh
- t8003-blame-corner-cases.sh
- t9350-fast-export.sh

'grep >file && test_line_count' is used in this test:
- t9400-git-cvsserver-server.sh

And to make matters more confusing, both 'grep -c' and 'grep >file &&
test_line_count' is used in this test:
- t9001-send-email.sh

Granted I didn't miss anything while trawling the tests for the above
numbers, it feels like the 'grep -c' option is more in line with the
existing tests. That said, I don't know if there is an ongoing trend to
deprecate 'grep -c' in favour of 'test_line_count'.
