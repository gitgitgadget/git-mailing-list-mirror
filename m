X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 4/4] Show the branch type after the branch name for remotes
Date: Fri, 3 Nov 2006 09:33:40 +0100
Message-ID: <200611030833.42596.andyparkins@gmail.com>
References: <bec6ab7849e3fcacac23cca44a0ba93282af5fca.1162465753.git.andyparkins@gmail.com> <200611021111.32759.andyparkins@gmail.com> <7vy7qtl0bk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 08:34:00 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YLAUhVTNI61lcKci7U+nOoT4kzQ5RgYcyQxnYiNWx57SHKQJY8NaJATTf3tAZIITaDzX/2r3SRKw5gFPkYRqeQkCrtO2Ht33yEKkllkS9w8YId8evkZRbmWDkKMfGyXE3YMYLIW3kmNrIKDTqrBfdtSggwKu2bQTEPZgJxmkDXk=
User-Agent: KMail/1.9.5
In-Reply-To: <7vy7qtl0bk.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30796>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfuUs-0001VK-4O for gcvg-git@gmane.org; Fri, 03 Nov
 2006 09:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751803AbWKCIdr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 03:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbWKCIdr
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 03:33:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:30911 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1751352AbWKCIdr
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 03:33:47 -0500
Received: by ug-out-1314.google.com with SMTP id m3so349823ugc for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 00:33:45 -0800 (PST)
Received: by 10.67.97.7 with SMTP id z7mr2262583ugl.1162542825305; Fri, 03
 Nov 2006 00:33:45 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id m1sm602317uge.2006.11.03.00.33.44; Fri, 03 Nov 2006 00:33:45 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 November 03 02:40, Junio C Hamano wrote:
> Andy Parkins <andyparkins@gmail.com> writes:
> > Instead of prefixing the remote branches with "remotes/" suffix them with
> > "[read only]"
>
> This is a change in UI and while I understand why you want to
> say r/o instead of remotes/, I think this needs a bit more
> thought and discussion.  People should not be feeding the output
> of "git branch" Porcelainish to their scripts, but you'll never
> know...

I intentionally made this patch in such a way as to leave the original form 
available.  I haven't added a switch to show the original form, but it's 
there if it's needed.

The reason I thought it would be acceptable is that the output changed fairly 
significantly when git-branch went builtin.

Here's the original and my "git-branch -r" run on my git repository
$ git-branch -r
remotes/up/maint
remotes/up/master
remotes/up/next
remotes/up/pu
$ ./git-branch -r
  momentum/master
  up/maint
  up/master
  up/next
  up/pu

I've not touched the "-r" path, so this is the same as the unpatched builtin 
branch.  The "remotes/" prefix is removed in refs.c by for_each_remote_ref() 
with do_for_each_ref("refs/remotes/", fn, 13, cb_data); and the spaces are 
added because print_ref_list() has only one printing path and that always 
includes spaces.

For me personally, I find my git-branch output more useful because in it's 
unswitched form it shows me all branches.  However, I can easily put this 
behaviour under a switch or, and this would get my vote, put the original 
behaviour (i.e. show local branches only) under a switch.

Which would you like?  If any.

> By the way, does "git branch -r" (without any of your patches)
> even say "remotes/"?

I haven't touched the "-r" path, so that output should be unaffected.  As 
mentioned above, git-branch.sh did include "remotes/", new builtin branch 
does not, but does include "  " at the beginning of every line.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
