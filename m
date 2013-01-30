From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH v2] CodingGuidelines: add Python coding guidelines
Date: Wed, 30 Jan 2013 20:31:58 +0000
Message-ID: <20130130203158.GN1342@serenity.lan>
References: <20130129190844.GB1342@serenity.lan>
 <5108F056.9040406@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jan 30 21:32:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0eKc-0004t1-9q
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 21:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141Ab3A3UcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 15:32:07 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:33802 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122Ab3A3UcG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 15:32:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 96BDA1980A3;
	Wed, 30 Jan 2013 20:32:04 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X3mSOl6v3Ekl; Wed, 30 Jan 2013 20:32:04 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 326691980BD;
	Wed, 30 Jan 2013 20:32:04 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 1FAFD161E4E3;
	Wed, 30 Jan 2013 20:32:04 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3+QvCp0wpBEa; Wed, 30 Jan 2013 20:32:04 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 2BE52161E563;
	Wed, 30 Jan 2013 20:32:00 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <5108F056.9040406@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215072>

On Wed, Jan 30, 2013 at 11:05:10AM +0100, Michael Haggerty wrote:
> Nit: s/it is supported/it has been supported/

Thanks, I'll fix in the re-roll.

> I think this would be a good Python policy.
> 
> I would hate to junk up all Python code with things like
> 
>     ' '.encode('ascii')
> 
> though, so maybe we should establish a small Python library of
> compatibility utilities (like a small "six").  It could contain b().
> 
> Another handy utility function could be
> 
>     def check_python_version(minimum_v2=0x02060000,
>                              minimum_v3=0x03010000)
> 
> which checks our default Python requirements by default, but is
> overrideable by specific scripts if they know that they can deal with
> older Python versions.
> 
> But I haven't had time to think of where to put such a library, how to
> install it, etc.

If we want to go that route, I think restructuring the
"git_remote_helpers" directory and re-using its infrastructure for
installing the "Git Python modules" would be the way to go.  The
directory structure would become something like this:

    git/
    `-- python/
        |-- Makefile    # existing file pulled out of git_remote_helpers
        |-- < some new utility library >
        |-- git_remote_helpers
        |   |-- __init__.py
        |   |-- git
        |   |   |-- __init__.py
        |   |   |-- exporter.py
        |   |   |-- git.py
        |   |   |-- importer.py
        |   |   |-- non_local.py
        |   |   `-- repo.py
        |   `-- util.py
        |-- setup.cfg   # existing file pulled out of git_remote_helpers
        `-- setup.py    # existing file pulled out of git_remote_helpers


It looks like the GitPython project[1] as already taken the "git" module
name, so perhaps we should use "git_core" if we do introduce a new
module.

[1] http://pypi.python.org/pypi/GitPython


John
