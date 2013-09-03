From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Tue, 3 Sep 2013 17:08:55 +0200
Message-ID: <20130903150855.GK29840@goldbirke>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
 <1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
 <20130903071256.GD3608@sigill.intra.peff.net>
 <20130903075107.GA25540@goldbirke>
 <20130903080358.GA30158@sigill.intra.peff.net>
 <CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
 <20130903111006.GJ29840@goldbirke>
 <CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 17:09:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGsES-0007QW-AN
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 17:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770Ab3ICPJV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Sep 2013 11:09:21 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:58377 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095Ab3ICPJH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 11:09:07 -0400
Received: from localhost6.localdomain6 (85-238-67-243.pool.digikabel.hu [85.238.67.243])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MGbuW-1VCQG01Oim-00DF2H; Tue, 03 Sep 2013 17:08:56 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:WeYlJrl9IIwsRiZeHraRW5wUR8PEUPVsyXuQMYJblGq
 w5aX7rBRic6CDiolzzl7Fb8DV1/3zJXcJkPFJT7UUae8kidcW+
 o9rOsPEec8wQaDgPRzRA/hYd4Fnfd2k3hjpsujlVtt06GXFL8V
 /+JngUCSWh8N5BUnOI6NgKqjKC3ZjcRQXF4BcBBUPKdCWSys4l
 7YYfsgcBAGFn6TiBfC9e3VowuXi3QOV9U2fEw2qVzlNiZFWs9O
 hohwRMH1B5u5EpW6BfMHu4SgbSL7XJXV43CR851ai994jpReRe
 5KgGtcV5f9NzapKTJzxG9pwiCOZwH/L8pMtmfgBB/b4dxYCe3+
 +pZtFctJZJv0rzGWSpg15jI5Ky5lRX8bvbjHcTkwo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233727>

On Tue, Sep 03, 2013 at 08:39:54AM -0500, Felipe Contreras wrote:
> On Tue, Sep 3, 2013 at 6:10 AM, SZEDER G=E1bor <szeder@ira.uka.de> wr=
ote:
> > On Tue, Sep 03, 2013 at 05:45:06AM -0500, Felipe Contreras wrote:
> >> On Tue, Sep 3, 2013 at 3:03 AM, Jeff King <peff@peff.net> wrote:
> >> > On Tue, Sep 03, 2013 at 09:51:07AM +0200, SZEDER G=E1bor wrote:
> >> >
> >> >> > I wonder if we should have a:
> >> >> >
> >> >> >   test_cmp_args () {
> >> >> >           echo "$1" >expect &&
> >> >> >           echo "$1" >actual &&
> >> >> >           test_cmp expect actual
> >> >> >   }
> >> >> >
> >> >> > to let these remain one-liners like:
> >> >> >
> >> >> >   test_cmp_args "$(git rev-parse start)" "$(git rev-parse fin=
al^1^1^1)"

BTW, why not just use the already existing

  test_cmp_rev start final^1^1^1

helper function to get usable output on error and still keep these as
one-liners?

> >> >> This idea come up before, but there is one flaw which makes thi=
s
> >> >> function less useful: a non-zero exit code of the commands in t=
he
> >> >> command substitutions would be lost.
> >> >
> >> > Good point. You'd probably have to do something gross with eval,=
 like:
> >> >
> >> >   test_cmp_args () {
> >> >     eval "$1" >expect &&
> >> >     eval "$2" >actual &&
> >>
> >> I don't see any reason to perpetuate these yoda comparisons.
> >>
> >> eval "$2" >expect &&
> >> eval "$1" >actual &&
> >
> > I do.  Your proposal requires the arguments in the reverse order
> > compared to test_cmp.  That inconsistency would be far worse than
> > test_cmp_args "$expect" "$actual".
>=20
> There are two ways to fix an inconsistency, the other way is to fix
> test_cmp. But that would be a change, and change is not welcome in
> Git.

It depends on the change, I suppose.  I agree, changing 3k+ lines just
to avoid yoda conditions...  I doubt the gain worth the code churn.


Best,
G=E1bor
