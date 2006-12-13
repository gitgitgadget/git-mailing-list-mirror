X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] merge-recursive: add/add really is modify/modify with an empty base
Date: Wed, 13 Dec 2006 22:01:21 +0000
Message-ID: <b0943d9e0612131401s6cde6d0du5e3c6d2e34bfbbb2@mail.gmail.com>
References: <20061207101707.GA19139@spearce.org>
	 <Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0612122347590.2807@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vvekgog0r.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0612130402300.2807@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vvekgl2z2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 22:01:31 +0000 (UTC)
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MtUiSbdTdMRmF81QiWIjQjaRXAefCrdkCi5MzqdwIXMroD2LIGDrehgxK0LeRqUXjmzDPih9xAZ9sKbgLUbX1wF7/rOwkV2WPhruvNf2h4zd3XR7YHIQNA1qtY2Lgw4Z07elMcAbo6GGbDFlXm/sSdaMHnvq/neJ1E5e6XJRdzs=
In-Reply-To: <7vvekgl2z2.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34235>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GucAJ-00050e-3K for gcvg-git@gmane.org; Wed, 13 Dec
 2006 23:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751225AbWLMWBX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 17:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbWLMWBX
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 17:01:23 -0500
Received: from nz-out-0506.google.com ([64.233.162.229]:29074 "EHLO
 nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751225AbWLMWBW (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec
 2006 17:01:22 -0500
Received: by nz-out-0506.google.com with SMTP id s1so160680nze for
 <git@vger.kernel.org>; Wed, 13 Dec 2006 14:01:21 -0800 (PST)
Received: by 10.65.59.20 with SMTP id m20mr179311qbk.1166047281381; Wed, 13
 Dec 2006 14:01:21 -0800 (PST)
Received: by 10.65.126.2 with HTTP; Wed, 13 Dec 2006 14:01:21 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 13/12/06, Junio C Hamano <junkio@cox.net> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Unify the handling for cases C (add/add) and D (modify/modify).
> >
> >       On Tue, 12 Dec 2006, Junio C Hamano wrote:
> >
> >       > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >       >
> >       > > How about this: if there is an add/add conflict, we treat it
> >       > > as if there _was_ an empty file, and we let the shiny new
> >       > > xdl_merge() find the _true_ conflicts, _instead of_ removing
> >       > > the file from the index, adding both files with different
> >       > > "~blabla" markers appended to their file names to the working
> >       > > directory.

What is this new xdl_merge()? Is it a better replacement for diff3? In
this situation diff3 would actually show two confict parts, each of
them being the full file, with an empty ancestor.

> This fixes the behaviour in "both branches add the path
> differently" case.  Previously merge-recursive did not create
> the working tree file, but now it does just like merge-resolve.
>
> Although I would feel very happy about this change, Catalin
> might want to be informed about potential interaction this
> change might have with his commit 8d41555 in StGIT.

I don't think it affects StGIT. Previously, "git-read-tree -m" left a
file in the tree in this conflict situation. When I switched to
git-merge-recursive (to handle renames better), I noticed that the
file was no longer there and my merge algorithm failed. It now checks
whether the file is missing and it generates one.

The way StGIT handle any conflicts is not to leave the index in a
state with multiple stages per file. When I push a patch that is
causing an add/add situation, I want a version of the file to be added
to the index (usually the one already in the tree, not in the patch
being pushed) so that a "stg status" won't show like the patch is
removing that file.

-- 
