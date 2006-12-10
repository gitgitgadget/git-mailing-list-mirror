X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file permission bits)
Date: Sun, 10 Dec 2006 13:35:17 -0500
Message-ID: <19476830-E30A-42B7-AD9B-4C417D830C8E@mac.com>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com> <elh91b$v6r$1@sea.gmane.org> <A52817B6-0265-4164-8E5D-334AF92DC267@mac.com> <200612101926.33307.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 18:35:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612101926.33307.jnareb@gmail.com>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.5446:2.3.11,1.2.37,4.0.164 definitions=2006-12-10_01:2006-12-08,2006-12-08,2006-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=3.1.0-0611300000 definitions=main-0612100009
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33914>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtTWK-0003NV-7U for gcvg-git@gmane.org; Sun, 10 Dec
 2006 19:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762333AbWLJSfY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 13:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762336AbWLJSfY
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 13:35:24 -0500
Received: from smtpout.mac.com ([17.250.248.183]:59769 "EHLO smtpout.mac.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762333AbWLJSfY
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 13:35:24 -0500
Received: from mac.com (smtpin01-en2 [10.13.10.146]) by smtpout.mac.com
 (Xserve/8.12.11/smtpout13/MantshX 4.0) with ESMTP id kBAIZMd9027708; Sun, 10
 Dec 2006 10:35:22 -0800 (PST)
Received: from [10.0.7.253] (hc6524e82.dhcp.vt.edu [198.82.78.130])
 (authenticated bits=0) by mac.com (Xserve/smtpin01/MantshX 4.0) with ESMTP id
 kBAIZImn023883 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
 Sun, 10 Dec 2006 10:35:20 -0800 (PST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Dec 10, 2006, at 13:26:32, Jakub Narebski wrote:
> The idea is to not store /etc in git directly, but use import/ 
> export scripts, which for example saves permissions and ownership  
> in some file also tracked by git on import, and restores correct  
> permissions on export. That is what I remember from this  
> discussion. This of course means that you would have to write your  
> own porcelain...
>
> What about mentioned in other email IsiSetup?

The real problem I have with that is you literally have to duplicate  
all sorts of functionality.  I want to run "foo-status" in /etc and  
get something useful, but if /etc is not a git directory in and of  
itself then you have to duplicate most of "git-status" anyways.  And  
the same applies to all the other commands.  From what I can see of  
IsiSetup the tools for checking out, merging, modifying, cloning, etc  
are all much more limited and immature than the ones available  
through GIT/cogito, and I would be loathe to discard all that extra  
functionality and duplicate a few thousand lines of code in the name  
of "concept purity".

GIT already has _some_ idea about file permissions, it just discards  
most of the data before writing to disk.  Of course, adding POSIX  
ACLs and user-extended-attributes requires a new data format, but  
those are very similar to filesystem permissions; they differ only in  
amount of data stored, not in purpose.

Import/export scripts literally require wrapping every single GIT  
command with a script that changes directory a few times, reads from  
a different checked-out tree, and permutes some extended-attribute  
data slightly before storing it in the underlying GIT tree.  Even  
without adding any new functionality whatsoever that doubles the  
amount of code just for finding your repository and checking command- 
line arguments, and that's a crazy trade-off to make in any situation.

Cheers,
Kyle Moffett
