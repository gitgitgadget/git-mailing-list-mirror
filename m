From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t7700: demonstrate mishandling of objects in packs with
 a .keep file
Date: Mon, 03 Nov 2008 16:02:41 -0600
Message-ID: <76IhmMdjmr4jA4xApPpvlZ4vfjtqEDsUaFal2mN5MHfI0MChFmsj5g@cipher.nrlssc.navy.mil>
References: <1S3xpaVP1Cy1Rei_ODwlXsBdu64BGiPve-lj_4fN6cA@cipher.nrlssc.navy.mil> <14536526.1225596838300.JavaMail.teamon@b301.teamon.com> <490ED3FE.8040103@op5.se> <RqVk2AkdyUcFTIGofSkQwl1GtBTXMYzMqaOQiAOmBXAyPDuWlQug-w@cipher.nrlssc.navy.mil> <490F5E2E.2050207@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: drafnel@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	nico@cam.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Nov 03 23:04:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx7Wt-0005y6-O4
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 23:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294AbYKCWC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 17:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753340AbYKCWC5
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 17:02:57 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59166 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbYKCWC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 17:02:57 -0500
Received: by mail.nrlssc.navy.mil id mA3M2gIx019132; Mon, 3 Nov 2008 16:02:42 -0600
In-Reply-To: <490F5E2E.2050207@op5.se>
X-OriginalArrivalTime: 03 Nov 2008 22:02:42.0282 (UTC) FILETIME=[E4E334A0:01C93DFF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100001>

Andreas Ericsson wrote:

> So long as "git repack -a" still creates a mega-pack, I'm fine with
> whatever.

I don't think it will after pack-objects is taught about .keep files, and
I don't think it will _now_ if all of your packs have .keep files.

'repack -a' will call pack-objects with either '--unpack=<packfile>' for
each pack file without a .keep file, or with '--unpacked --incremental' if
there are no pack files without .keep files.

In the first case, the modifications to pack-objects that I propose
will prevent objects that exist in local packs with .keep files
from being packed into the new pack.

In the second case, the --incremental option would have done the same thing.

So this inconsistency already existed, but will now be removed in favor of
honoring .keep files.

Mega-pack creation will become an "advanced operation" along the lines of:

    git rev-list --objects --all | git pack-objects

-brandon
