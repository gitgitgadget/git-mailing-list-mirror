From: Derek Fawcus <dfawcus@cisco.com>
Subject: git-svn - failed to clone repository
Date: Wed, 23 Jul 2008 17:06:59 +0100
Message-ID: <20080723160659.GB6705@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 18:18:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLh2o-0000YD-LX
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 18:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409AbYGWQR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 12:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbYGWQR1
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 12:17:27 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:37661 "EHLO
	ams-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbYGWQR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 12:17:26 -0400
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jul 2008 12:17:26 EDT
X-IronPort-AV: E=Sophos;i="4.31,239,1215388800"; 
   d="scan'208";a="15183479"
Received: from ams-dkim-1.cisco.com ([144.254.224.138])
  by ams-iport-1.cisco.com with ESMTP; 23 Jul 2008 16:07:32 +0000
Received: from ams-core-1.cisco.com (ams-core-1.cisco.com [144.254.224.150])
	by ams-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id m6NG7WtR032257
	for <git@vger.kernel.org>; Wed, 23 Jul 2008 18:07:32 +0200
Received: from edi-view2.cisco.com (edi-view2.cisco.com [64.103.71.156])
	by ams-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id m6NG7Vik025481
	for <git@vger.kernel.org>; Wed, 23 Jul 2008 16:07:32 GMT
Received: from dfawcus-laptop (localhost [127.0.0.1]) by edi-view2.cisco.com (8.11.2/CISCO.WS.1.2) with ESMTP id m6NG7VX22322 for <git@vger.kernel.org>; Wed, 23 Jul 2008 17:07:31 +0100 (BST)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.3i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; l=1437; t=1216829252; x=1217693252;
	c=relaxed/simple; s=amsdkim1002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dfawcus@cisco.com;
	z=From:=20Derek=20Fawcus=20<dfawcus@cisco.com>
	|Subject:=20git-svn=20-=20failed=20to=20clone=20repository
	|Sender:=20;
	bh=59VjxQTYU+qRsyjRqepCgJIKDj6zP0tf+l0awevfIs0=;
	b=t/bAKOeXL0Bd3Y1dH7CDxTiP6YqnfAQQm86/29aETlkqhh+yhYHQq3O6Pu
	ce3yGSFJcazFMVf4QVzxSieFsPgQTfdi7uxaqsPpfh/CNeA6a1E+DshrDdib
	wgfLGmQ+6m;
Authentication-Results: ams-dkim-1; header.From=dfawcus@cisco.com; dkim=pass (
	sig from cisco.com/amsdkim1002 verified; ); 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89699>

I tried to create a clone of an svn repository,  and it gave
up part way through with the following error:

  Incomplete data: Delta source ended unexpectedly at /usr/bin/git-svn line 3858

Looking at the source,  this is the call '$reporter->finish-report($pool)'
near the end of gs_do_update.

This is using git 1.5.6 from the etch backports repository.

The repository in question was cocotron,  the command being:

  git svn clone http://cocotron.googlecode.com/svn -t tags -b branches -T trunk

It seemed to fail at revision 91,  the last couple of lines of the command output being:

r90 = <hex I can't be bothered to type unless required> (trunk)
        M    Foundation/NSStream/NSFileHandle.m

then followed by the above error.  Looking at the actual revision
page (http://code.google.com/p/cocotron/source/detail?r=91)

the only thing that stands out as odd is one file claims to be 'too large to diff'.
It's ~900k and if one grabs and diffs by hand,  the output is only ~70 lines.

So - is this at all related to the 'known bug' mentioned earlier - stopped on
line 3856 when using line ending mapping (I'm not using such),  or is this
something else?

Last,  assuming I was to simply grab and apply this changeset by hand,
what would I need to do to fix up metadata so that git-svn could continue
importing the history?  There are about 200 changesets in the whole repository.

Thanks,

DF
