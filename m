From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 3/8] git_remote_helpers: Force rebuild if python version
 changes
Date: Sun, 13 Jan 2013 17:52:38 +0000
Message-ID: <20130113175238.GO4574@serenity.lan>
References: <cover.1358018078.git.john@keeping.me.uk>
 <89f55d20da9a4c0a8490f95107cbf5d04219d0fb.1358018078.git.john@keeping.me.uk>
 <20130112233044.GB23079@padd.com>
 <20130113162605.GL4574@serenity.lan>
 <20130113171402.GA1307@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 18:53:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuRk7-0003uN-MK
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 18:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113Ab3AMRwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 12:52:51 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:52861 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab3AMRwt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 12:52:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 5F49B22ED7;
	Sun, 13 Jan 2013 17:52:49 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZvA1iADPxKmg; Sun, 13 Jan 2013 17:52:48 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 8FFD622E9E;
	Sun, 13 Jan 2013 17:52:48 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 78EFD161E550;
	Sun, 13 Jan 2013 17:52:48 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZIiJY+tJ9ner; Sun, 13 Jan 2013 17:52:48 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id F2F41161E547;
	Sun, 13 Jan 2013 17:52:40 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130113171402.GA1307@padd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213393>

On Sun, Jan 13, 2013 at 12:14:02PM -0500, Pete Wyckoff wrote:
> john@keeping.me.uk wrote on Sun, 13 Jan 2013 16:26 +0000:
>> On Sat, Jan 12, 2013 at 06:30:44PM -0500, Pete Wyckoff wrote:
>> > john@keeping.me.uk wrote on Sat, 12 Jan 2013 19:23 +0000:
>> >> When different version of python are used to build via distutils, the
>> >> behaviour can change.  Detect changes in version and pass --force in
>> >> this case.
>> >[..]
>> >> diff --git a/git_remote_helpers/Makefile b/git_remote_helpers/Makefile
>> >[..]
>> >> +py_version=$(shell $(PYTHON_PATH) -c \
>> >> +	'import sys; print("%i.%i" % sys.version_info[:2])')
>> >> +
>> >>  all: $(pysetupfile)
>> >> -	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build
>> >> +	$(QUIET)test "$$(cat GIT-PYTHON_VERSION 2>/dev/null)" = "$(py_version)" || \
>> >> +	flags=--force; \
>> >> +	$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build $$flags
>> >> +	$(QUIET)echo "$(py_version)" >GIT-PYTHON_VERSION
>> > 
>> > Can you depend on ../GIT-PYTHON-VARS instead?  It comes from
>> > 96a4647 (Makefile: detect when PYTHON_PATH changes, 2012-12-18).
>> > It doesn't check version, just path, but hopefully that's good
>> > enough.  I'm imagining a rule that would do "clean" if
>> > ../GIT-PYTHON-VARS changed, then build without --force.
>> 
>> I was trying to keep the git_remote_helpers directory self contained.  I
>> can't see how to depend on ../GIT-PYTHON-VARS in a way that is as simple
>> as this and keeps "make -C git_remote_helpers" working in a clean tree.
>> 
>> Am I missing something obvious here?
> 
> Not if it wants to stay self-contained; you're right.
> 
> I'm not thrilled with how git_remote_helpers/Makefile always
> runs setup.py, and always generates PYLIBDIR, and now always
> invokes python a third time to see if its version changed.

I don't think PYLIBDIR will be calculated unless it's used ('=' not
':=' means its a deferred variable).

I wonder if the version check should move into setup.py - it would be
just as easy to check the file there and massage sys.args, although
possibly not as neat.


John
