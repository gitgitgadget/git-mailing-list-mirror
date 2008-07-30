From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Wed, 30 Jul 2008 21:25:58 +0200
Message-ID: <56C07978-D6C9-4219-8B92-6217BD33F6D4@zib.de>
References: <488772BC.80207@workspacewhiz.com> <alpine.DEB.1.00.0807232041570.8986@racer> <3B9933A6-9637-41AE-9133-9B6EA9204E6B@orakel.ntnu.no> <alpine.DEB.1.00.0807250159420.4140@eeepc-johanness> <E0666371-5C5E-4AA9-B67A-16C42477865B@orakel.ntnu.no> <20080725140142.GB2925@dpotapov.dyndns.org> <42C252B2-85B9-4D05-B3A2-2A0250D7F5D6@orakel.ntnu.no> <20080729134619.GB7008@dpotapov.dyndns.org> <A8BF9951-AB9D-4391-A6CB-E9778064F4A8@orakel.ntnu.no> <80518F08-A9A9-4190-9AC4-D24DD6A1188B@zib.de> <32541b130807301133w4bfc8288oa2d15911b2317dca@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Eyvind Bernhardsen" <eyvind-git@orakel.ntnu.no>,
	"Dmitry Potapov" <dpotapov@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Joshua Jensen" <jjensen@workspacewhiz.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 21:27:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOHKE-0007Ku-Pt
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 21:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156AbYG3T0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 15:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755117AbYG3T0E
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 15:26:04 -0400
Received: from mailer.zib.de ([130.73.108.11]:39921 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754877AbYG3T0B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 15:26:01 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6UJPYhq015304;
	Wed, 30 Jul 2008 21:25:39 +0200 (CEST)
Received: from cougar.zib.de (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6UJPWqe008000
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 30 Jul 2008 21:25:33 +0200 (MEST)
In-Reply-To: <32541b130807301133w4bfc8288oa2d15911b2317dca@mail.gmail.com>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90839>


On Jul 30, 2008, at 8:33 PM, Avery Pennarun wrote:

> On 7/30/08, Steffen Prohaska <prohaska@zib.de> wrote:
>
>> What matters is that git gives you exactly back what you  
>> committed.  It
>> does so with core.autocrlf=true, unless you check out with a  
>> different
>> setting for autocrlf.
>
> You can tell that this statement isn't quite true because if you have
> a file with mixed LF and CRLF line endings, which I do (thanks,
> Windows!) then CRLF->LF conversion is not a reversible operation.
> Interestingly LF->CRLF still is (because an LF->CRLF'd file will never
> have a bare LF, and on such a subset of files, CRLF->LF is
> reversible).
>
> Also note that core.autocrlf=input is *definitely* not a perfectly
> reversible operation.

You are absolutely right.  The files your describe are modified by git,
because they are "invalid" text files, as git defines them.  For git's
autocrlf mechanism to work, a text file is only allowed to have a
*single* type of line endings.  Otherwise it is broken and git tries to
help you fixing it.


> And so here's the problem: svn hands you a file.  It may or may not
> have CRLFs in it, and the line endings may actually be a random mix of
> LF and CRLF, as I am actually experiencing at the moment in a
> particular repository at work.  If core.autocrlf is anything other
> than "false", git will modify the file, and git-svn won't be apply the
> diff on the next revision.

This sound like a specific problem with svn, not a general problem
of git's autocrlf concept.  I work with a git-only workflow and I
never see the problems you describe.


> It's conceivable that core.autocrlf=true will work if your svn
> repository is pure and svn hands you files only with CRLF endings.
> It's somewhat unlikely that most svn repositories are in that state
> (remember: it has to be perfect in *every revision* for git-svn to
> work).
>
> So anyway, I can't see how git-svn can possibly work in the general
> case if core.autocrlf is anything other than false *at git-svn fetch
> time*.

That might be the case.  Note though that I cannot contribute
much to this discussion because I never use git-svn.


> And that's what I do, and it works great, modulo a bunch of
> stupid CRLFs that sneak into the repo via svn, but those can be fixed.
> Someday we'll stop using svn, and git-filter-branch can fix them all
> retroactively so that "blame" will work right.
>
> Perhaps git-svn needs to actually ignore the core.autocrlf setting?

 From what you describe, I get the impression that git-svn's handling
of line endings could certainly be improved.

	Steffen
