X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Adding glob support to remotes
Date: Wed, 22 Nov 2006 09:04:20 +0000
Message-ID: <200611220904.21850.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 22 Nov 2006 09:04:39 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LWtnsWUdrjD7Gbh57NuM844LlH8ml6vQrm1SgwwvGOK3A+2hGe79W1IIIwbuW+YT78wfwIHok8jagwD0CcxGxUhJ8+AORpoJYEF4Hh6mveTMrWCWufSq6ozEyBQKhM4ahKatt/8xSkJK63t/35l5jDAUXKBFz8J+Qkmmoa4ruaA=
User-Agent: KMail/1.9.5
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32072>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmo1v-000374-VA for gcvg-git@gmane.org; Wed, 22 Nov
 2006 10:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161991AbWKVJE2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 04:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161998AbWKVJE2
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 04:04:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:16223 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1161991AbWKVJE1
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 04:04:27 -0500
Received: by ug-out-1314.google.com with SMTP id 44so98633uga for
 <git@vger.kernel.org>; Wed, 22 Nov 2006 01:04:25 -0800 (PST)
Received: by 10.67.101.10 with SMTP id d10mr2688854ugm.1164186265613; Wed, 22
 Nov 2006 01:04:25 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id e33sm10443938ugd.2006.11.22.01.04.24; Wed, 22 Nov 2006 01:04:25
 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello,

I'm working on adding (basic) glob support to remote fetch definitions.  This 
is to allow you to write things like

[remote "origin"]
  fetch = refs/heads/*:refs/remotes/upstream/*

I started to add code to git-parse-remote.sh:canon_refs_list_for_fetch() to 
preprocess the reflist to catch lines with a "*" in them then use the remote 
pattern to filter the output of from "git-ls-remote -h", blah, blah, you get 
the idea...

However, git-ls-remote needs the name of the remote repository (of course), 
but that isn't directly available in git-parse-remote.sh.  Should I
 a) pass it as a parameter from git-fetch.sh right through each intermediate 
function
 b) create a global?
 c) change git-check-ref-format to allow "*" in the name, then put the 
git-ls-remote call in git-fetch instead.

I don't like to do (b) as it's nasty programming behaviour; however passing a 
parameter is fairly intrusive to the existing code.  Similarly (c) means I'm 
messing in places I suspect I shouldn't be (git-check-ref-format).

git-gods - what do I do?



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
