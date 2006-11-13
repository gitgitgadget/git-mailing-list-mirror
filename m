X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: gitk broken or user error?
Date: Mon, 13 Nov 2006 14:28:07 -0800
Message-ID: <m27ixzgex4.fsf@ziti.local>
References: <m2irhkr467.fsf@ziti.local>
	<17752.60467.854884.206737@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 13 Nov 2006 22:28:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=ujFIPg1S9TjhedGYHAuFEs22FWwNBiYXoET7Ys9klOOa6j21ad8ZO/95eBAEEvDiHRN4mTDgqbluzuzXB/NUgLSiXkIqgy3zXFKjI5DeFi0d3cgvnDW/BZCuLITlijHpAJj5LoOfdpHIbqy27W0iqAbEMAcnK5xqthIamOsOthA=
In-Reply-To: <17752.60467.854884.206737@cargo.ozlabs.ibm.com> (Paul Mackerras's message of "Tue, 14 Nov 2006 09:05:39 +1100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31325>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjkI0-0001vc-Ed for gcvg-git@gmane.org; Mon, 13 Nov
 2006 23:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933082AbWKMW2O (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 17:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933051AbWKMW2O
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 17:28:14 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:16246 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S933082AbWKMW2M
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 17:28:12 -0500
Received: by nf-out-0910.google.com with SMTP id o25so31885nfa for
 <git@vger.kernel.org>; Mon, 13 Nov 2006 14:28:11 -0800 (PST)
Received: by 10.48.42.4 with SMTP id p4mr126630nfp.1163456890758; Mon, 13 Nov
 2006 14:28:10 -0800 (PST)
Received: from ziti.local ( [140.107.181.122]) by mx.google.com with ESMTP id
 l32sm268778nfa.2006.11.13.14.28.09; Mon, 13 Nov 2006 14:28:10 -0800 (PST)
To: Paul Mackerras <paulus@samba.org>
Sender: git-owner@vger.kernel.org

Paul Mackerras <paulus@samba.org> writes:
> Those lines are intended to enable the "Edit view" and "Delete view"
> entries in the View menu.  Those entries start out disabled and are
> supposed to be disabled when the "All files" view is displayed, and
> enabled when any other view is displayed.
>
> I suspect that under OSX, the menu gets an extra entry, or something,
> that throws off the numbering.  Instead of commenting out those lines,
> could you instead try changing the 2 and 3 to "Edit*" and "Delete*"
> instead?  If that works I'll do a patch to fix the problem properly.

I tried this patch:

diff --git a/gitk b/gitk
index ab383b3..e7ea4e2 100755
--- a/gitk
+++ b/gitk
@@ -6305,8 +6305,8 @@ if {$cmdline_files ne {} || $revtreeargs
     set viewargs(1) $revtreeargs
     set viewperm(1) 0
     addviewmenu 1
-    .bar.view entryconf 2 -state normal
-    .bar.view entryconf 3 -state normal
+    .bar.view entryconf "Edit*" -state normal
+    .bar.view entryconf "Delete*" -state normal
 }
 
 if {[info exists permviews]} {

And, yes, this allows gitk to load up and be useful.  So this is much
better than the current behavior.  However, if I try clicking on the
"All files" view in the view menu, I get an error box along these
lines:

    unknown option "-state"
    unknown option "-state"
        while executing
    ".bar.view entryconf 3 -state [expr {$n == 0? "disabled": "normal"}]"
        (procedure "showview" line 56)
        invoked from within
    "showview 0"
        (menu invoke)

Perhaps a similar fix is needed in other parts of the code.  

+ seth

