From: "Todd A. Jacobs" <nospam@codegnome.org>
Subject: git-archive ignores export-ignore
Date: Thu, 21 Jan 2010 14:13:12 -0800
Message-ID: <20100121221312.GB5307@penguin.codegnome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 22 01:40:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY7a2-0000ED-Qg
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 01:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638Ab0AVAku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 19:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753497Ab0AVAkt
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 19:40:49 -0500
Received: from que31.charter.net ([209.225.8.23]:34811 "EHLO que31.charter.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753396Ab0AVAkt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 19:40:49 -0500
X-Greylist: delayed 1303 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jan 2010 19:40:48 EST
Received: from imp10 ([10.20.200.15]) by mta11.charter.net
          (InterMail vM.7.09.02.04 201-2219-117-106-20090629) with ESMTP
          id <20100121221320.FHXI8038.mta11.charter.net@imp10>
          for <git@vger.kernel.org>; Thu, 21 Jan 2010 17:13:20 -0500
Received: from penguin.codegnome.org ([71.83.124.90])
	by imp10 with smtp.charter.net
	id YNDE1d00F1x8DgP05NDGlS; Thu, 21 Jan 2010 17:13:18 -0500
X-Authority-Analysis: v=1.0 c=1 a=GzaDmK-BbaUPtKP18Q0A:9
 a=l9-LKqgq6Eyi6LmBavUA:7 a=wOefQ1ML5RGuZstdt_zfRHPNg58A:4
Received: by penguin.codegnome.org (Postfix, from userid 1000)
	id 8CBAC37CB2; Thu, 21 Jan 2010 14:13:13 -0800 (PST)
Received: by penguin.codegnome.org (tmda-sendmail, from uid 1000);
	Thu, 21 Jan 2010 14:13:13 -0800
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Delivery-Agent: TMDA/1.1.12 (Macallan)
Mail-Followup-To: nospam@codegnome.org, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137707>

Using git 1.6.4.2, the manual page prophesies that:

    Files and directories with the attribute export-ignore won't be
    added to archive files. See gitattributes(5) for details.

However, various tools seem to be unhappy about this attribute. In
particular, checkout complains about invalid attributes:

    $ cat .gitattributes
    *.py export-subst
    *.html export-subst
    juniperxml.cfg export-ignore

    $ git checkout juniperxml.cfg
    export-ignore is not a valid attribute name: .gitattributes:3

It appears that git-archive doesn't seem to respect the attribute
either. Consider the following example:

    cd /tmp
    mkdir foo
    cd foo
    git init
    touch foo.sh
    echo '*sh' > .gitattributes
    git add foo.sh
    git add .gitattributes
    git commit -m test
    git archive HEAD
    pax_global_header00006660000000000000000000000064113261226070014512gustar00rootroot0000000000000052 comment=202d78e6a44c7f10bee2ad96a3b2adc80fc33468
    .gitattributes000066400000000000000000000000041132612260700137430ustar00rootroot00000000000000*sh
    foo.sh000066400000000000000000000000001132612260700121630ustar00rootroot00000000000000

In addition to whatever bugs there might be in reading and applying the
attributes correctly, it would seem that the man page could be a bit
clearer on how and where to apply the attributes.

Assuming PEBKAC for the moment, how can I get the behavior I'm
expecting?

-- 
"Oh, look: rocks!"
	-- Doctor Who, "Destiny of the Daleks"
