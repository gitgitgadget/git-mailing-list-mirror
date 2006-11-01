X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Restore a single file in the index back to HEAD
Date: Wed, 01 Nov 2006 12:22:01 +0100
Organization: At home
Message-ID: <eia008$aup$1@sea.gmane.org>
References: <200610261641.11239.andyparkins@gmail.com> <20061027073834.GC29057@spearce.org> <4541BE8E.5050605@op5.se> <20061027081545.GF29057@spearce.org> <81b0412b0610270245w6c29b3c3va7967991f53db298@mail.gmail.com> <4541D670.6000900@op5.se> <7vac3igjpd.fsf@assigned-by-dhcp.cox.net> <fcaeb9bf0610312358g1176e4d8q8962b08c2e8ff2c6@mail.gmail.com> <7vpsc78ua3.fsf@assigned-by-dhcp.cox.net> <7vvelz7eg2.fsf@assigned-by-dhcp.cox.net> <fcaeb9bf0611010109t6281a120qeed21e0d3b29ad0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 1 Nov 2006 11:22:26 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 38
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30632>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfEAp-0004Zf-Hg for gcvg-git@gmane.org; Wed, 01 Nov
 2006 12:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946799AbWKALWT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 06:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946794AbWKALWT
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 06:22:19 -0500
Received: from main.gmane.org ([80.91.229.2]:23726 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1946799AbWKALWS (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 06:22:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GfEAZ-0004Xb-Sh for git@vger.kernel.org; Wed, 01 Nov 2006 12:22:07 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 01 Nov 2006 12:22:07 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 01 Nov 2006
 12:22:07 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Nguyen Thai Ngoc Duy wrote:

> On 11/1/06, Junio C Hamano <junkio@cox.net> wrote:

>> I think at the UI level, the most appropriate place would be
>> "git reset".  Checkout is a Porcelainish that is primarily about
>> working tree and it updates the index as a side effect (from the
>> UI point of view); you can update the working tree without
>> modifying index or you can update both index and the working
>> tree, but updating only index and not working tree does not
>> belong there.
> 
> Then perhaps git-reset should do "co HEAD path" too if --index is not
specified?
> To sum up:
>  - git reset HEAD path -> git checkout HEAD path
>  - git reset --index HEAD path -> git-ls-files HEAD path|git
> update-index --index-info
>  - git reset HEAD (without path) -> the current behaviour
> 
> Because  <commit-ish>  may be missing, there is some ambiguation here.

Currently "git reset --soft <commit-ish>" updates current head only, 
"git reset <commit-ish>" is "git reset --mixed <commit-ish>" and updates
head and index, and "git reset --hard <commit-ish>" updates head, index
and working tree.

The same should be the case for "git reset [--soft|--mixed|--hard]
[<commit-ish>] [--] [paths...]", with the exception that it wouldn't
never update current head. (So --soft with pathspec wouldn't make sense).

On the other hand git-reset is mainly about resetting current head,
so perhaps git-reset isn't the best place to update fragments of index
from HEAD branch.
-- 
Jakub Narebski
ShadeHawk on #git
Poland
