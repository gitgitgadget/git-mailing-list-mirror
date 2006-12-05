X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 05 Dec 2006 12:09:02 +0100
Organization: At home
Message-ID: <el3jsh$i62$1@sea.gmane.org>
References: <Pine.LNX.4.64.0612041234390.3476@woody.osdl.org> <e7bda7770612041336s73e677ebh758b030f9f75c1d8@mail.gmail.com> <45754D27.9070701@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 5 Dec 2006 11:07:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 63
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33338>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrY8n-0005PJ-S9 for gcvg-git@gmane.org; Tue, 05 Dec
 2006 12:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759947AbWLELHI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 06:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759949AbWLELHI
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 06:07:08 -0500
Received: from main.gmane.org ([80.91.229.2]:41371 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1759947AbWLELHF
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 06:07:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrY8e-0006kV-P6 for git@vger.kernel.org; Tue, 05 Dec 2006 12:07:04 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 12:07:04 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 05 Dec 2006
 12:07:04 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andreas Ericsson wrote:

> Torgil Svensson wrote:
>> On 12/4/06, Linus Torvalds <torvalds@osdl.org> wrote:
>>>
>>> So yeah, it's a bit hacky, but for the reasons I've tried to outline, I
>>> actually think that users _want_ hacky. Exactly because "deep 
>>> integration"
>>> ends up having so many _bad_ features, so it's better to have a thin and
>>> simple layer that you can actually see past if you want to.
>> 
>> Thin and simple sounds very good. Let's try it with an example. Lets
>> say we have one apllication App1 and three librarys (Lib1, Lib2, Lib3)
>> with the following dependency-graph:
>> 
>>        App1
>>        /  \
>>       /    \
>>   Lib1   Lib2
>>       \    /
>>        \  /
>>        Lib3 (don't really needed for this example but looks nice)
>> 
>> All components can be used individually and have their own upstream,
>> maintainer etc.
>> 
>> To compile App1 however, I need some files from both Lib1 and Lib2
>> specifying it's API. To satisfy these dependencies, It sounds
>> reasonable to link Lib2 and Lib3 submodules from App1. In your
>> concept, can I construct a modules file to fetch the API files and
>> their history without checking out the whole Lib1 and Lib2 source?
> 
> I think not. Then it wouldn't be a submodule anymore, but just some 
> random sources from an upstream project. Not that it's an uncommon 
> workflow or anything, but it's sort of akin to just importing the SHA1 
> implementation (a few source-files with no real interest in the history 
> of those source-files) from openssl into a different project rather than 
> actually using the entire openssl lib (which would be nice to have as a 
> submodule).

Note that this is what partial checkouts (another great idea nobody
implemented yet[*1*]; you can do partial checkout but there is no UI for
this, and working with partial checkouts is bit hard) is about, although it
would buy you only working area space, and not repository (object database
storage) space.

For now, you can imitate this by having in in Lib1 and Lib2 the 'includes'
branch which would contain only the API (and which you would have to keep
up to date with 'master', but it should be fairly easy: just merge changes
into 'includes', perhaps with help of git-rerere, or [nonexisting]
git-rerere2).

[*1*] Although with our track[*2*] I guess it is reasonable to think it
would get implemented soon.
[*2*] Out of four "great ideas": shallow clone / sparse clone, submodules
support, lazy clone / remote alternates, two are in example-implementation
(submodules support) and beta work (shallow clone is in 'next').

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

