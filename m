X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Rename detection at git log
Date: Mon, 20 Nov 2006 12:15:30 +0100
Organization: At home
Message-ID: <ejs2lp$2r4$1@sea.gmane.org>
References: <200611201157.23680.litvinov2004@gmail.com> <200611201022.10656.andyparkins@gmail.com> <7virha4cnm.fsf@assigned-by-dhcp.cox.net> <200611201101.04456.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 20 Nov 2006 11:14:58 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 59
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31904>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm76t-0001I9-Uu for gcvg-git@gmane.org; Mon, 20 Nov
 2006 12:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756722AbWKTLO3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 06:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756724AbWKTLO2
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 06:14:28 -0500
Received: from main.gmane.org ([80.91.229.2]:27599 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1756722AbWKTLO2 (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 06:14:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gm76V-0001CT-Ef for git@vger.kernel.org; Mon, 20 Nov 2006 12:14:23 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 12:14:23 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 20 Nov 2006
 12:14:23 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

> On Monday 2006 November 20 10:48, Junio C Hamano wrote:
>
>>  - Copies are only picked up from files that were changed in the
>>    same change (i.e. splitting major part of original file and
>>    moving it to somewhere else, while leaving a skelton in the
>>    original file).  "harder" is needed if the copy original was
>>    untouched, as you found out.
> 
> Yep; I understand that.  I also understand that it is done for performance 
> reasons.  However, since the typical copy will be one where the source 
> doesn't change at the same time, I am arguing that the non-hard copy 
> detection isn't much use.

I'm not sure about this. You usually both do pure renames (to reorganize
files, to give file a better name) and renames with modification, but
I don't think that copy without modification is very common. Usually you
copy a file because you take one file as template for the other, or you
split file, or you join files into one file.
 
>> The last one is a compromise between performance and thoroughness,
>> and the "harder" is one knob to tweak its behaviour.
> 
> I've been poking in tree-diff.c to see if I can understand why it it such a 
> performance hog.  I still haven't.  Each file is stored under its hash right?  
> So for copy detection why can't you just search for other files with the same 
> hash, which I presume is very fast (as it is the basis of what makes git so 
> fast)?

Copy and rename detection are done by comparing the contents, calculating
similarity. So to check if files A and B are copies (not necessary pure
copies) it is not enough to compare hashes.

That said, it should be fairly easy (if not that useful in true projects
as I understand it, as stated above) to add to copy detection detection of
pure copies by comparing hashes. Still, --find-copies-harder would be still
needed if the copy original was untouched, while copy itself was modified.

> I am probably misunderstanding git, but I guess that a copy isn't even needed 
> in the database because two files with the same hash in the working copy only 
> need storing once and then referencing twice.  So for a copy (again, with my 
> simple understanding of git) we'd have:
> 
>  commit1 -> tree1 -> fileA = fileA_hash
>     ^
>     |
>  commit2 -> tree2 -> fileA = fileA_hash
>                      fileB = fileB_hash
> 
> Doesn't that mean that copy detection is just a matter of searching the parent 
> commit trees for references to the same hash?

Think copy'n'change.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

