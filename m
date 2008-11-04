From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] t7700: demonstrate mishandling of objects in packs with
 a .keep file
Date: Tue, 04 Nov 2008 20:25:44 +0100
Message-ID: <4910A1B8.8070506@op5.se>
References: <1S3xpaVP1Cy1Rei_ODwlXsBdu64BGiPve-lj_4fN6cA@cipher.nrlssc.navy.mil> <14536526.1225596838300.JavaMail.teamon@b301.teamon.com> <490ED3FE.8040103@op5.se> <RqVk2AkdyUcFTIGofSkQwl1GtBTXMYzMqaOQiAOmBXAyPDuWlQug-w@cipher.nrlssc.navy.mil> <490F5E2E.2050207@op5.se> <76IhmMdjmr4jA4xApPpvlZ4vfjtqEDsUaFal2mN5MHfI0MChFmsj5g@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: drafnel@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	nico@cam.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Nov 04 20:27:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxRYu-0003gO-4q
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 20:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbYKDT0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 14:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752472AbYKDT0W
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 14:26:22 -0500
Received: from mail.op5.se ([193.201.96.20]:46034 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752644AbYKDT0V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 14:26:21 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id CD6CF1B80136;
	Tue,  4 Nov 2008 20:21:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.921
X-Spam-Level: 
X-Spam-Status: No, score=-2.921 tagged_above=-10 required=6.6
	tests=[AWL=-0.422, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zeyfti0NkOud; Tue,  4 Nov 2008 20:21:20 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.22])
	by mail.op5.se (Postfix) with ESMTP id 977E11B800B1;
	Tue,  4 Nov 2008 20:21:17 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <76IhmMdjmr4jA4xApPpvlZ4vfjtqEDsUaFal2mN5MHfI0MChFmsj5g@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100097>

Brandon Casey wrote:
> Andreas Ericsson wrote:
> 
>> So long as "git repack -a" still creates a mega-pack, I'm fine with
>> whatever.
> 
> I don't think it will after pack-objects is taught about .keep files, and

In that case you're almost certainly breaking something.

> I don't think it will _now_ if all of your packs have .keep files.
> 

It should, by copying the objects from the .keep-marked packfiles. Otherwise
either repack or the repack docs are in error.

> 'repack -a' will call pack-objects with either '--unpack=<packfile>' for
> each pack file without a .keep file, or with '--unpacked --incremental' if
> there are no pack files without .keep files.
> 
> In the first case, the modifications to pack-objects that I propose
> will prevent objects that exist in local packs with .keep files
> from being packed into the new pack.
> 
> In the second case, the --incremental option would have done the same thing.
> 
> So this inconsistency already existed, but will now be removed in favor of
> honoring .keep files.
> 

That means the nifty hack of incrementally and sometimes fully repack the
odb to speed up cloning over dumb protocols no longer works properly, then.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
