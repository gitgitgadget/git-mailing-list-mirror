From: James Blackburn <jamesblackburn@gmail.com>
Subject: Re: git log --follow doesn't follow a rename over a merge
Date: Thu, 16 Jun 2011 19:21:33 +0100
Message-ID: <BANLkTimmKnzD7LTApxzw5oTpvLU7oM0yjw@mail.gmail.com>
References: <BANLkTimjEp0ntq80qttT9uZN2YGuhsnZBw@mail.gmail.com>
	<m362o5vrhd.fsf@localhost.localdomain>
	<BANLkTik1-UvEXqzgdXwcK3x6_o8fDiwB7g@mail.gmail.com>
	<20110616173451.GB6584@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 16 20:21:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXHCF-0005qG-L6
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 20:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757620Ab1FPSVe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jun 2011 14:21:34 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:49168 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab1FPSVe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jun 2011 14:21:34 -0400
Received: by qyg14 with SMTP id 14so940152qyg.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 11:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Nqc8WBINi8jrlrJ82TrTMXkejSMOBOGYOcFN4KgjT3w=;
        b=ZOLoUoUWz058S8hfmUKArxtbuDBLgiM3azTDHvQzPxydjxwhbbGdNjQ/j1wNz+OZj3
         p3EzjIMFTJAC2gSncYjjfrseLfPRfKdSMMZBSHdwMqvkab/KacxU1EC1WZTAkBBx5hAy
         kR3gaHvigUMM1np9VfuxluscOHrVgaI0I1DTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g51Vx1RwZ1Uahse8lc1C9kTxMjjtsylXJIjB46jh9Mb5veXiatawxVd1L+VPYBQgkp
         +fUDpZXLS3QdbWC1Wf0kzO19HIw0gmRY85XSHMrFb+42rw4/oGGYnLzTBDWFdfJoXERO
         dQZy0IdKVSAVEEC1toWFyQ9AfDEAKhytD8Kp4=
Received: by 10.229.106.69 with SMTP id w5mr1107980qco.41.1308248493342; Thu,
 16 Jun 2011 11:21:33 -0700 (PDT)
Received: by 10.229.214.203 with HTTP; Thu, 16 Jun 2011 11:21:33 -0700 (PDT)
In-Reply-To: <20110616173451.GB6584@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175911>

> Doesn't:
> =A0git log -- plugins/org.eclipse.dd.dsf.debug/src/org/eclipse/dd/dsf=
/debug/service/IBreakpoints.java
> do that?

Unfortunately that returuns no output.

If I add --follow, I get history:
git log --follow --oneline --
plugins/org.eclipse.dd.dsf.debug/src/org/eclipse/dd/dsf/debug/service/I=
Breakpoints.java
10580b5 Updated copyright statements.
=2E..

Where 10580 is a distant parent of c1e6da which was merged in to 5b4718=
7.

On 16 June 2011 18:45, Jeff King <peff@peff.net> wrote:
> Usually you would graft the tip of the old history to the root commit=
 of
> the new history. So it's not a merge, but makes it look like a
> contiguous linear history near the graft. But that's only a
> per-repository thing. If you want to join two histories in the actual
> history graph, you would merge them; if one supersedes the other, the=
n
> you would use the "ours" merge strategy to ignore the other side.

In this case the commit is a 'merge' commit as history looks like:

  2002 ---o----o-----o-----o-----X-----o-----o-----o--- 2011         (C=
DT)
                                     /
  2006 ---o----o-----o-----o--   (2009)                                =
  (DSF)

CDT has existed since 2002. In 2006, at X, DSF was committed onto HEAD
of  CDT.  Basically wholesale apart from the path (Java package)
change (+some minor changes to 'import's).

So I created a graft from the commit which made it appear from CDT
onto the HEAD of a DSF as it was when the import happened.  Which
makes X have two parents.

Cheers,
James
