From: Jakub Narebski <jnareb@gmail.com>
Subject: Git benchmarks at OpenOffice.org wiki
Date: Tue, 1 May 2007 23:46:14 +0200
Message-ID: <200705012346.14997.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: releases@openoffice.org, Jan Holesovsky <kendy@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 00:15:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj0dN-0007m0-On
	for gcvg-git@gmane.org; Wed, 02 May 2007 00:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946043AbXEAWPe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 18:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946046AbXEAWPe
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 18:15:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:8250 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946043AbXEAWPc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 18:15:32 -0400
Received: by ug-out-1314.google.com with SMTP id 44so136632uga
        for <git@vger.kernel.org>; Tue, 01 May 2007 15:15:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-disposition:cc:message-id:content-type:content-transfer-encoding;
        b=XPBnJ6RMt7UE2GjnPzbueJmadEfbvKzHyXkIF8XE+wDC+sUGct0ynrExGtiSTwZaq7YbPwxg9vuk0fbq5n3tijHuwfIbZFgL9SVqcmp60FGk35YZTCjyn/M7cYxdDdubWmhVpHis14XL3WMOBSaGP2PCs2EXlaGaYvMs9IA65bE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-disposition:cc:message-id:content-type:content-transfer-encoding;
        b=bMUAjNota8B9vOBMnmj4jMIHmRRBm2C/yKmbbkmn+XGDYeZD2GFGXhnEiC8e7hxQRKJBCc9Thov/Ti7aZxDrLgjucD9QnR2nvhjY4kSCBjh4k9LppfzmHsr0fCzXfrfr3iON2zi4lwKxFb0daMW7+qq38SXPbQs+XDS/75SwVWo=
Received: by 10.67.100.17 with SMTP id c17mr603229ugm.1178057731276;
        Tue, 01 May 2007 15:15:31 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id m1sm33722uge.2007.05.01.15.15.29;
        Tue, 01 May 2007 15:15:30 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45984>

OpenOffice.org is looking for a new SCM (Software Configuration 
Management) tool, or at least was on Friday, 19 Jan 2007;
see: http://blogs.sun.com/GullFOSS/entry/openoffice_org_scm

One of the SCMs considered is Git. One of others is Subversion.
There is a functional git tree with the entire OOo history for testing 
purposes that can be found at: http://go-oo.org/git.

What I am concerned about is some of git benchmark results at Git page 
on OpenOffice.org wiki:
  http://wiki.services.openoffice.org/wiki/Git#Comparison
Actually it is comparison with CVS and Subversion, although most 
benchmarks are done only for git.


In 'Size of data on the server' git has CVS beat hands down: 1.3G vs 
8.5G for sources, 591M vs 1.1G for third party. I think it is similar
for Subversion. I hope that repository is fully packed: IIRC the Mozilla
CVS repository import was about 0.6GB pack file, not 1.3GB.


The problem is with 'Size of checkout': to start working in repository
one needs 1.4G (sources) and 98M (third party) for CVS checkout (it is
1.5G for sources for Subversion checkout). Ordinary for distributed SCM
you would need size of repository + size of sources (working area), 
which is 2.8G for sources and 688M for third party stuff files you can 
hack on + the history]. This makes some prefer to go centralized SCM 
route, i.e. Subversion as replacement for CVS (+ CWS, ChildWorkSpace).

What might help here is splitting repository into current (e.g. from
OOo 2.0) and historical part, and / or using shallow clone. Implementing 
partial checkouts, i.e. checking out only part of working area (and 
using 'theirs' strategy for merging not-checked-out part for merges) 
would help. Splitting repository into submodules, and submodule
support -- it depends on organization of OOo sources, would certainly 
help for third party stuff repository.

'Checkout time' (which should be renamed to 'Initial checkout time'),
in which git also loses with 130 minutes (Linux, 2MBit DSL) [from 
go-oo.org], 100min (Linux, 2MBit DSL, Wireless, no proxy) [from 
go-oo.org] versus 117 minutes (Linux, 2MBit DSL), 26 minutes (Linux, 
2MBit DSL, with compression (-z 6)) for CVS, and  60 Minutes (Windows, 
34Mbit Line) for Subversion, would also be helped by the above.


What I'm really concerned about is branch switch and merging branches,
when one of the branches is an old one (e.g. unxsplash branch), which 
takes 3min (!) according to the benchmark. 13-25sec for commit is also 
bit long, but BRANCH SWITCHING which takes 3 MINUTES!? There is no 
comparison benchmark for CVS or Subversion, though...

Comparison / benchmark lacks some crucial info, like what computer was 
used (CPU, RAM, HDD), what filesystem was used, git version etc. It 
does have commands used for tests (benchmarks).

Could you confirm (or deny) those results? go-oo.org uses git 1.4.3.4;
was there some improvement or bugfix related to the speed of checkout?

-- 
Jakub Narebski
ShadeHawk on #git
Poland
