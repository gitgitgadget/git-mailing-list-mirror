X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git bug? + question
Date: Fri, 3 Nov 2006 18:15:49 +0100
Message-ID: <200611031815.49553.Josef.Weidendorfer@gmx.de>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <7v3b90gbfv.fsf@assigned-by-dhcp.cox.net> <20061103094655.GA16721@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 16:48:24 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.3
In-Reply-To: <20061103094655.GA16721@diana.vm.bytemark.co.uk>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30867>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg2Bk-000586-93 for gcvg-git@gmane.org; Fri, 03 Nov
 2006 17:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753366AbWKCQqh convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 11:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbWKCQqh
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 11:46:37 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:60641 "EHLO
 tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP id
 S1753366AbWKCQqg convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>);
 Fri, 3 Nov 2006 11:46:36 -0500
Received: from dhcp-3s-57.lrr.in.tum.de (dhcp-3s-57.lrr.in.tum.de
 [131.159.35.57]) by mail.in.tum.de (Postfix) with ESMTP id ECFFD239C; Fri,  3
 Nov 2006 17:42:48 +0100 (MET)
To: Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On Friday 03 November 2006 10:46, Karl Hasselstr=F6m wrote:
> Hmm. How about changing the meaning of "remote" slightly? Like this:

That's not good, as it changes existing config meaning.
But why not support fetch lines in [branch.*] sections?

Ie. instead of

>       [remote."gitster"]
>               url =3D gitster.example.com:/home/junio/git.git/
>               fetch =3D heads/master:remotes/gitster/master
>               fetch =3D heads/next:remotes/gitster/next
>       [branch."master"]
>               remote =3D gitster
>               merge =3D remotes/gitster/master
>       [branch."next"]
>               remote =3D gitster
>               merge =3D remotes/gitster/next

make your config look like

       [remote."gitster"]
               url =3D gitster.example.com:/home/junio/git.git/
       [branch."master"]
               remote =3D gitster
               fetch =3D heads/master:remotes/gitster/master
               merge =3D remotes/gitster/master
       [branch."next"]
               remote =3D gitster
               fetch =3D heads/next:remotes/gitster/next
               merge =3D remotes/gitster/next

A fetch line in [branch.*] means: Also fetch this refspec in
addition to the refspecs specified in the remote section.
Problem being that "git fetch gitster" does nothing anymore :-(

Other option: Introduce "fetchonly" line which ignores the original
fetch lines in the remote section.

       [remote."gitster"]
               url =3D gitster.example.com:/home/junio/git.git/
               fetch =3D heads/master:remotes/gitster/master
               fetch =3D heads/next:remotes/gitster/next
       [branch."master"]
               remote =3D gitster
               fetchonly =3D heads/master:remotes/gitster/master
               merge =3D remotes/gitster/master

