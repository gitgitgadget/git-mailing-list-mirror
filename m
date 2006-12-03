X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 03 Dec 2006 23:49:03 +0100
Organization: At home
Message-ID: <ekvk8s$c3d$1@sea.gmane.org>
References: <20061130170625.GH18810@admingilde.org> <200612012306.41410.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org> <200612012355.03493.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612011510290.3695@woody.osdl.org> <4570AF8F.1000801@stephan-feder.de> <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org> <200612020036.08826.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612011540010.3695@woody.osdl.org> <20061203221630.GA940MdfPADPa@greensroom.kotnet.org> <Pine.LNX.4.64.0612031421030.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 3 Dec 2006 22:49:34 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 44
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33148>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr09H-0007bQ-9G for gcvg-git@gmane.org; Sun, 03 Dec
 2006 23:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759841AbWLCWtY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 17:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760136AbWLCWtY
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 17:49:24 -0500
Received: from main.gmane.org ([80.91.229.2]:53122 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1759841AbWLCWtX (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 17:49:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gr091-0005cC-LS for git@vger.kernel.org; Sun, 03 Dec 2006 23:49:11 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 03 Dec 2006 23:49:11 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 03 Dec 2006
 23:49:11 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:

> On Sun, 3 Dec 2006, Sven Verdoolaege wrote:
>> 
>> On Fri, Dec 01, 2006 at 03:30:32PM -0800, Linus Torvalds wrote:
>>> The only thing that a submodule must NOT be allowed to do on its own is 
>>> pruning (and it's distant cousin "git repack -d").
>> 
>> How are you going to enforce this if the submodule isn't supposed
>> to know that it is being used as a submodule ?
> 
> Note that there's actually two "submodules":
> 
>  - there's the submodule "project" itself.
> 
>    This one must be totally unaware of the supermodule, because this one 
>    might be cloned and copied _independently_ of the supermodule.
> 
>  - there's the PARTICULAR CHECKED-OUT COPY of the submodule that is 
>    actually checked out in a supermodule.
> 
>    This is just a specific _instance_ of the particular submodule.
> 
> So a particular instance of a submodule might be "aware" of the fact that 
> it's a submodule of a supermodule. For example, the "awareness" migth be 
> as simple as just a magic flag file inside it's .git/ directory. And that 
> awareness would be what simply disabled pruning or "repack -d" within that 
> particular instance.

If we use objects/info/alternates (or equivalent, e.g. objects/info/modules,
or modules file) in superproject to refer to submodule repository object
database (so superproject has access to all the objects including
submodule), I'd prefer to have in submodule objects/info/borrowers file,
which would point to superproject (and to other repositories which have
submodule as one of alternate object databases) for git-prune and friends
to check which parts are truly unreachable.

This would be generic solution to the problem with alternates, not only
specific to submodule support.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

