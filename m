X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Restore a single file in the index back to HEAD
Date: Fri, 27 Oct 2006 08:27:15 +0100
Message-ID: <200610270827.17659.andyparkins@gmail.com>
References: <200610261641.11239.andyparkins@gmail.com> <81b0412b0610260842x52413570k3971bcdc54b3ccb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 07:27:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gawnOAJU67X+yXUAcRQh1O/6CY8aQiE2fR960bJitftN5V4uXIJ9DjvFsukOMdeyOhhZbgKXff58y6FUOGopzfTphCNshLUOagS2qIn/Gje7AGpB38zrx5lh6zdAeDWKC33rWv5ZGFjw5uRfWCsweN3Kp8EwPknjjVy2OPDUr7Y=
User-Agent: KMail/1.9.5
In-Reply-To: <81b0412b0610260842x52413570k3971bcdc54b3ccb5@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30297>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdM7i-0007WT-EJ for gcvg-git@gmane.org; Fri, 27 Oct
 2006 09:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946163AbWJ0H1X (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 03:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946170AbWJ0H1X
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 03:27:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:56733 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1946163AbWJ0H1W
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 03:27:22 -0400
Received: by ug-out-1314.google.com with SMTP id 32so616054ugm for
 <git@vger.kernel.org>; Fri, 27 Oct 2006 00:27:20 -0700 (PDT)
Received: by 10.66.224.19 with SMTP id w19mr4462118ugg; Fri, 27 Oct 2006
 00:27:20 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id b35sm164414ugd.2006.10.27.00.27.20; Fri, 27 Oct 2006 00:27:20 -0700
 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 October 26 16:42, Alex Riesen wrote:

Thanks for your suggestion.

> Use "git checkout HEAD oops/file1"

This returned:

"git checkout: updating paths is incompatible with switching branches/forcing
Did you intend to checkout 'oops/file1' which can not be resolved as commit?"

I'm not sure that checkout will do what I want anyway because it would 
overwrite the working directory copy of oops/file1.  I want to keep the 
changes but reset the index to have oops/file1 from HEAD.

Maybe I need to say a little more about what I'm trying to do:

I converted a subversion repository to git.  In that repository I maintained 
my own set of patches in one branch against an upstream branch; I'm now using 
git-cherry-pick to pull a subset of those patches onto a new branch against 
the upstream head.  This is all working fine.  The problem is that I've come 
across a patch that should rightly be two patches instead of one.  

So, I cherry-pick a patch, which updates the working directory and index, 
leaving me with...

# On branch refs/heads/newmaster
# Updated but not checked in:
#   (will commit)
#
#   modified:   oops/file1 
#   modified:   good/file2
#   modified:   good/file3
#   modified:   good/file4

Instead, what I would like is

# On branch refs/heads/newmaster
# Updated but not checked in:
#   (will commit)
#
#   modified:   good/file2
#   modified:   good/file3
#   modified:   good/file4
#
# On branch refs/heads/newmaster
# Changed but not updated:
#   (use git-update-index to mark for commit)
#
#   modified:   oops/file1 

I've actually found a way around the problem.  I do git-reset HEAD, which 
restores the index entirely but leaves the working directory.  Then I 
git-update-index the good/* set.  However, it led me to wonder what the 
inverse of git-update-index is.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
