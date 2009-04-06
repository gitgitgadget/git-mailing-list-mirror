From: Klas Lindberg <klas.lindberg@gmail.com>
Subject: Re: Fetching SHA id's instead of named references?
Date: Tue, 7 Apr 2009 01:40:04 +0200
Message-ID: <33f4f4d70904061640j1b03c499x1765da1a72a411f3@mail.gmail.com>
References: <33f4f4d70904060513k320fb6a0ya928c714dcd11e89@mail.gmail.com>
	 <alpine.DEB.1.00.0904061431020.6619@intel-tinevez-2-302>
	 <20090406144047.GE23604@spearce.org>
	 <33f4f4d70904060922t5c868ec0x89ed5891cf4b19c2@mail.gmail.com>
	 <alpine.LFD.2.00.0904061245111.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Users List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 07 01:41:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqyRh-0006TX-Dh
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 01:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbZDFXkL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 19:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbZDFXkK
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 19:40:10 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:42564 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbZDFXkI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2009 19:40:08 -0400
Received: by bwz17 with SMTP id 17so2089693bwz.37
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 16:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HZb5owKCImEXLuWSeSrR/9lBKpcwyvBTko1pbD0VKl4=;
        b=R3ft4HsR0aVFbi5OHnHyLErXA+SvCHQjQ6aLkZCmOUecL9bqAgnblARRsXAngCm6Tg
         +C8iEPp7arQpUrnvC0J8L2v1iAfZRwXRRdNkBOq5Ohs1np/6A77kszhUq0tKqPciAhlm
         aNlzunLB2yG/aEcSsZUgeBtd+3bYllI7Cw8O8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=de2cueHiZhTMtl2R2yXMcUq/DM0evX/9tZxas3iwRuGocbiYMJVzC4Sk0izBb8Yo+O
         bmVxxznKUhXfua9vGyHoGKBv2/QfL1XNLegeW75LSN4lpTScQHKytHm0do2c7AwGsMqq
         DKpzQ7L1Jlomr8OI41GA1BnUahWXVBXKFWjyc=
Received: by 10.223.113.199 with SMTP id b7mr4007515faq.82.1239061204790; Mon, 
	06 Apr 2009 16:40:04 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0904061245111.6741@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115893>

On Mon, Apr 6, 2009 at 6:55 PM, Nicolas Pitre <nico@cam.org> wrote:

> Why can't you simply fetch the remote from its branch tip and then
> figure out / checkout the particular unnamed reference you wish local=
ly?

It is a pretty sane thing to do, but it makes me a bit nervous that
branches are not immutable. Let's say I decide on a manifest format
where each tree is listed as a branch name plus the current SHA key on
that branch. The branch name is needed to enable fetch, but if the
branch is later renamed because of a change in naming policy, or its
name simply reused to refer to something completely different (*),
then there is no guarantee that the SHA key is reachable through that
branch name.

(*) These situations cannot be discounted in an organization with,
say, a few thousand employees and several tens of really big projects
with considerable overlap. I have to take into account that the right
hand may not know what the left hand is doing all the time.

> Unlike with CVS/SVN, you don't need anything from the remote if you w=
ant
> to checkout an old version. In particular, there is no need for you t=
o
> only fetch that old version from the remote. =C2=A0You just fetch eve=
rything
> from the remote and then checkout the particular old version you wish=
=2E

Please consider when you have to recreate some particular forest that
you never worked on before, but now you have to fetch and recreate a 3
year old version so that you can work on that critical error report.
And I may really not want to fetch everything. Some projects are just
very very big.

I think that what I would need is either

 * Immutable tags, or
 * A way to maintain sets of indestructible commits based on SHA id's
and a way to fetch them without going through a named reference.

The second option seems better because it would allow for recursion on
submodules and it doesn't pollute the tag name space.

BR / Klas
