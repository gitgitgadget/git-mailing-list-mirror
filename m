From: Ilya Basin <basinilya@gmail.com>
Subject: Re[2]: State of CVS-to-git conversion tools (Was: Re: cvsps: bad usage: invalid argument --norc)
Date: Tue, 23 Apr 2013 22:30:07 +0400
Message-ID: <538486753.20130423223007@gmail.com>
References: <323381594.20130414121834@gmail.com> <673219382.20130414124800@gmail.com> <20130414113351.GA1299@thyrsus.com> <1762779000.20130415215818@gmail.com> <20130418094326.GB11038@thyrsus.com> <214169596.20130420142251@gmail.com> <20130423175000.GA25994@thyrsus.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 20:31:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUi0L-0005Br-PQ
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 20:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757107Ab3DWSbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 14:31:45 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:60468 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756508Ab3DWSbo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 14:31:44 -0400
Received: by mail-la0-f41.google.com with SMTP id fq13so851780lab.0
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 11:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=4KEHCMPDzR2Z1F8uGG4lXQI/eHzSEJTvTOqiFKRZnF8=;
        b=EyTGIncs0Nm3GflceU8jGvQwu30nd02an8HQHer3zKClj6Vo5Z6sbGaiCNCF6ptdq9
         VrgJrxgq9bPFFTlrpAYLmcoLmNUG2pMhvlcPfnwZV/+IcgO22LRSLTmuG+wasQUmcDJN
         1O+Lc59ZBKPVuQ3Z8h6BsMjTSKA807AO9Fe++2dO1x7w1iQqLUGrsn1lZqwXEQ7KgJaP
         yqpV2fz8u7ekGErLU2U12xqfIPdSq3BQTxJsTmpxrnipD9eIeBgDi8LuIw/yuMjpdMQp
         +t7V/yRF2J5zvRyun8AHZojalW8cH+bLNSzydy3LWVnhGuXh+Ai63+m/zjzbQx/eh2Xj
         fMMQ==
X-Received: by 10.112.137.9 with SMTP id qe9mr15882999lbb.126.1366741902724;
        Tue, 23 Apr 2013 11:31:42 -0700 (PDT)
Received: from [192.168.0.78] (92-100-225-174.dynamic.avangarddsl.ru. [92.100.225.174])
        by mx.google.com with ESMTPS id a9sm13256473laf.2.2013.04.23.11.31.40
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 23 Apr 2013 11:31:41 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <20130423175000.GA25994@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222205>

>> But if the branch is new, but it's parent commit is already imported,
>> I guess, the only way to refer it is by its SHA-1
>> Eric, what parent information can cvsps provide for the first commit
>> in a branch, when invoked with the '-d' flag?

ESR> At the moment it doesn't provide any at all.  That case wasn't on my
ESR> radar when I was fixing the code.  If you can specify a behavior you
ESR> think would be useful, I'm listening.

For new branches the 'from' command can refer the common ancestor in
an existing branch. For example:

         /----------E thebranch
        /
    A---B---C---D master

Commit E is newer than D; we already imported D; thebranch is new.
Instead of:
    from refs/heads/thebranch^0
refer the parent as:
    from refs/heads/master^2



ESR> Look at the -i option.  That may do what you need.
ESR>

OK, something's wrong with the man page: starting with '-A' the
description is unstructured:

       -A authormap
           Apply an author-map file to the attribution lines. Each line must be of the form

               ferd = Ferd J. Foonly <foonly@foo.com> America/Chicago

           and will be applied to map the Unix username ferd to the DVCS-style user identity specified after the equals
           sign. The timezone field (after > and whitespace) is optional and (if present) is used to set the timezone
           offset to be attached to the date; acceptable formats for the timezone field are anything that can be in the TZ
           environment variable, including a [+-]hhmm offset. Whitespace around the equals sign is stripped. Lines
           beginning with a # or not containing an equals sign are silently ignored. -R revmap:: Write a revision map to
           the specified argument filename. Each line of the revision map consists of three whitespace-separated fields: a
           filename, an RCS revision number, and the mark of the commit to which that filename-revision pair was assigned.
           -v:: show very verbose parsing messages. -t:: show some brief memory usage statistics. --summary-first:: when
           multiple patchset diffs are being generated, put the patchset summary for all patchsets at the beginning of the
           output. --diffs-opts option string:: send a custom set of options to diff, for example to increase the number
           of context lines, or change the diff format. --debuglvl bitmask:: enable various debug output channels. -Z
           compression:: A value 1-9 which specifies amount of compression. A value of 0 disables compression. --root
           cvsroot:: Override the setting of CVSROOT (overrides working directory and environment). -i:: Incremental
           export. Each commit with no ancestor gets a from pointer name. When importing to an existing repository, this
           will attach each such commit as a child of the last commit on $BRANCH in the existing repository. -k:: Kill
           keywords: will extract files with -kk from the CVS archive to avoid noisy changesets. -T:: Force deterministic
           dates for regression testing. Each patchset will have a monotonic-increasing attributed date computed from its
           patchset ID. --fast-export:: Emit the report as a git import stream. --convert-ignores:: Convert ..cvsignore
           files to .gitignore files. --reposurgeon:: Emit for each commit a list of the CVS file:revision pairs composing
           it as a bzr-style commit property named "cvs-revisions". From version 2.12 onward, reposurgeon can interpret
           these and use them as hints for reference-lifting. -V:: Emit the program version and exit.  module-path::
           Operate on the specified module. If this option is not given, either the CVSROOT environment variable must be
           set to point directly at the module or cvsps must be run in a checkout directory or repository module
           subdirectory.

--
 
