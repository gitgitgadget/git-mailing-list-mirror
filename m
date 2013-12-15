From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH v2] t9605: test for cvsps commit ordering bug
Date: Sat, 14 Dec 2013 19:35:18 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20131215003518.GA18327@thyrsus.com>
References: <1357965556-25761-1-git-send-email-chris@rorvick.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Sun Dec 15 01:35:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrzg9-0002hK-Ge
	for gcvg-git-2@plane.gmane.org; Sun, 15 Dec 2013 01:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482Ab3LOAfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Dec 2013 19:35:22 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:56373
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382Ab3LOAfT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 19:35:19 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 88912380B87; Sat, 14 Dec 2013 19:35:18 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1357965556-25761-1-git-send-email-chris@rorvick.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239321>

Replying to very old but newly relevant mail:

Chris Rorvick <chris@rorvick.com>:
> Import of a trivial CVS repository fails due to a cvsps bug.

The t9605 test you sent me is now part of cvs-fast-export's 
regression-test suite, along with suitably adapted versions of
t960[1-4] from the git tree.  Here is a summary of the results:

t9601:
|========================================================================
|                                            | cvsps    | cvs-fast-export
|import a module with a vendor branch        | Succeeds | Succeeds 
|check master out of git repository          | Succeeds | Succeeds 
|check a file imported once                  | Fails    | Succeeds 
|check a file imported twice                 | Succeeds | Succeeds 
|check a file imported then modified on HEAD | Succeeds | Succeeds 
|...imported, modified, then imported again  | Succeeds | Succeeds 
|check a file added to HEAD then imported    | Succeeds | Fails
| a vendor branch whose tag has been removed | Succeeds | Succeeds
|========================================================================

t9602:
|========================================================================
|                                            | cvsps    | cvs-fast-export
|import module                               | Succeeds | Succeeds 
|test branch master                          | Succeeds | Succeeds 
|test branch vendorbranch                    | Succeeds | Fails
|test_branch B_FROM_INITIALS                 | Fails    | Succeeds
|test_branch B_FROM_INITIALS_BUT_ONE         | Fails    | Fails
|test_branch B_MIXED                         | Fails    | Succeeds
|test_branch B_SPLI                          | Succeeds | Succeeds
|test branch vendortag                       | Fails    | Succeeds
|test tag T_ALL_INITIAL_FILES                | Succeeds | Succeeds
|test tag T_ALL_INITIAL_FILES_BUT_ONE        | Fails    | Fails
|test_tag T_MIXED                            | Fails    | Succeeds
|========================================================================

t9603:
	cvsps fails this test; cvs-fast-export succeeds.

t9604:
	cvsps and cvs-fast-export both succeed at this test.

t9605:
	cvsps fails this test; cvs-fast-export succeeds.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
