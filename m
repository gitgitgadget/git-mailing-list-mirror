From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] bash: support user-supplied completion scripts for
	user's git commands
Date: Fri, 26 Feb 2010 16:27:10 +0100
Message-ID: <20100226152710.GA17460@neumann>
References: <9b69cfcf1001290457s6b7fad6cs5a915f16a11f5782@mail.gmail.com>
	<20100129151127.GA21821@spearce.org>
	<7v4om4kdt3.fsf@alter.siamese.dyndns.org>
	<20100129175950.GE21821@spearce.org>
	<7vockciyb8.fsf@alter.siamese.dyndns.org>
	<20100129190642.GA31303@neumann>
	<7viqakireb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	David Rhodes Clymer <david@zettazebra.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 16:28:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl269-0002ZW-3m
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 16:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042Ab0BZP1S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2010 10:27:18 -0500
Received: from francis.fzi.de ([141.21.7.5]:20237 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965011Ab0BZP1R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 10:27:17 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 26 Feb 2010 16:27:11 +0100
Content-Disposition: inline
In-Reply-To: <7viqakireb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 26 Feb 2010 15:27:11.0660 (UTC) FILETIME=[2A9DA6C0:01CAB6F8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141133>

Hi,

On Fri, Jan 29, 2010 at 12:32:12PM -0800, Junio C Hamano wrote:
> Admittedly, we have already taken over _git_foo (and "_git") namespac=
e,
> and anybody who uses bash with the completion support cannot write th=
eir
> own shell function with these names for purposes that are unrelated t=
o
> completion,

Actually, the "_" namespace is taken over by bash completion in
general, so writing shell functions starting with "_" is probably
not a good idea anyway.  E.g. to see all non-completion-related shell
functions you can do a "declare -F |grep -v ' _'", but if you name
shell functions not related to completion as _git_foo(), then this
will no longer work.

> so in that sense, the patch is not introducing a new problem,
> but making it a documented interface and casting it in stone will mak=
e the
> namespace contamination issue harder to rectify later.
>=20
> So if we were to go in the direction as the patch proposes (which I t=
hink
> is a good idea), we might want to rename them to __git_completion_foo=
 or
> something that is less likely to collide with whatever names users mi=
ght
> want to use. It is my understanding that the only published interface=
 so
> far is __git_ps1.

I would say that __git_ps1() is the only interface that is advertised
as being public.  If someone is unsatisfied with the completion
script, because he wanted completion for a custom git command or for a
frequently used plumbing command, then I bet he just reused existing
functions, e.g. when he needed refs, he just used __git_refs(), or
when he needed git log's options, he used _git_log().  I did that,
probably others too.  If we were to rename completion functions, these
people's setup will break (although they will likely get merge
conflicts caused by this patch anyway).  On the other hand: should we
really care that much about such users, who use non-pulic interfaces
from contrib/ ?

Having said all that, I don't really care either way.  If you or Shawn
would prefer to have the completion functions renamed, I will do a
s/this/that/ preparation patch for the series.  BTW, Mercurial's
completion script uses _hg_cmd_foo() for hg commands and
_hg_ext_bar() for extensions, so we might as well be a bit consistent,
and call our completion functions _git_cmd_foo().


Best,
G=E1bor
