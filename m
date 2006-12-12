X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file permission bits)
Date: Tue, 12 Dec 2006 15:53:36 +0000
Message-ID: <200612121553.37499.andyparkins@gmail.com>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com> <Pine.LNX.4.64.0612111837210.20138@iabervon.org> <8900B938-1360-4A67-AB15-C9E84255107B@mac.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 15:53:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dub9UpTJxtim3nqJt5S89EcoNvY/NM8OH3hCzP0q5PrtJsX329NQRfzP36vIjmTVDW3FNRJgDqfC7cwogIhkV9pQpU3GzQukMjxTyjKGUlbZ/tf4EHcuDg0yQug1jVEk1KCABAbkDboOBXAFU0oCKKcGoeWSkQpxz3Ib9OOksgY=
User-Agent: KMail/1.9.5
In-Reply-To: <8900B938-1360-4A67-AB15-C9E84255107B@mac.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34105>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu9x5-0006U5-GE for gcvg-git@gmane.org; Tue, 12 Dec
 2006 16:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751474AbWLLPxo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 10:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWLLPxo
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 10:53:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:5836 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751474AbWLLPxn (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 10:53:43 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1703422uga for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 07:53:41 -0800 (PST)
Received: by 10.66.248.5 with SMTP id v5mr11947868ugh.1165938821185; Tue, 12
 Dec 2006 07:53:41 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id x37sm6972735ugc.2006.12.12.07.53.40; Tue, 12 Dec 2006 07:53:40 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Tuesday 2006 December 12 13:49, Kyle Moffett wrote:

> Hmm, ok.  It would seem to be a reasonable requirement that if you
> want to change any of the "preserve_*_attributes" config options you
> need to blow away and recreate your index, no?  I would probably
> change the underlying index format pretty completely and stick a new
> version tag inside it.

I wonder if git's skill at managing content is the answer?  Rather than mess 
around with git's internals, the index, or the object database; how about 
simply having a pre-commit script that writes out a file that looks like:

-rw-r--r--  andyp andyp CHANGES
-rw-r--r--  andyp andyp COPYING
-rw-rw-r--  andyp andyp CREDITS
-rw-r--r--  andyp andyp Configure
-rw-rw-r--  andyp andyp Makefile
-rw-r--r--  andyp andyp README

If /that/ file were stored in the repository and you had a script that could 
read that file and apply the permissions after a checkout you'd have what you 
want.

If the permissions of a file changed but the content didn't, then 
this ".gitpermissions" file would have changed content but the file itself 
would remain the same.  If the content changed but not the permissions 
then ".gitpermissions" would be untouched.

Assuming that you're allowed to mess with the index in pre-commit (I haven't 
checked), one half of it can be automatic.  I suppose you could also plead 
for a post-checkout hook to apply those permissions and the whole lot would 
be transparent.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
