From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [STGIT][PATCH] new: translate non word characters in patch name to '-'
Date: Wed, 31 Dec 2008 11:38:27 +0100
Message-ID: <20081231103827.GA29195@diana.vm.bytemark.co.uk>
References: <49562413.0437560a.287d.5133@mx.google.com> <20081228204938.GA13143@diana.vm.bytemark.co.uk> <154e089b0812291215h72dfe04aod080f665eb7f5592@mail.gmail.com> <20081229212119.GA3015@diana.vm.bytemark.co.uk> <154e089b0812310007j6642af70v4bfd64b784da8b4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Hannes Eder <hannes@hanneseder.net>
X-From: git-owner@vger.kernel.org Wed Dec 31 11:40:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHyUl-0004J3-H4
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 11:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755157AbYLaKiu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Dec 2008 05:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754962AbYLaKiu
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 05:38:50 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3185 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033AbYLaKiu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 05:38:50 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LHyT5-0007cc-00; Wed, 31 Dec 2008 10:38:27 +0000
Content-Disposition: inline
In-Reply-To: <154e089b0812310007j6642af70v4bfd64b784da8b4c@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104263>

On 2008-12-31 09:07:51 +0100, Hannes Eder wrote:

> On Mon, Dec 29, 2008 at 10:21 PM, Karl Hasselstr=F6m <kha@treskal.com=
> wrote:
>
> > There's a small inconsistency: you fail if the name contains "..",
> > but correct single bad characters.
>
> ".." is used to denote patch name ranges [<patch1>..<patch2>] for
> commands like "stg pop", "stg push", and so forth, therefore I think
> it is wise to exclude ".." from single patch names [<patch3>].

Yes. But what I meant was that it's a tad inconsistent to fail on some
illegal patch names, and correct others. You should either always fail
(my preference), or always correct.

> Maybe we should start defining what a 'valid' patch name has to look
> like, i.e. define
>
> def is_patch_name_valid(patchname)

Yes, exactly. This function could be called

  1. when validating user input in e.g. "stg new";

  2. in an assert at the end of the function that constructs a patch
     name from the commit message; and

  3. in an assert just before we try to actually create a patch with a
     given name.

(2) and (3) aren't really necessary, of course; they're just there to
catch bugs.

If you define such a function, be liberal in forbidding stuff. It's
easy to relax the rules later, but hard to tighten them since we have
to deal with existing repositories with illegal patch names. It's
probably a good idea to look at what git allows in its ref names, and
additionally forbid "/" and anything else you can think of.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
