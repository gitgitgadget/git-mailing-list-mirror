X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file permission bits)
Date: Sun, 10 Dec 2006 19:18:26 +0100
Organization: At home
Message-ID: <elhit4$tr3$2@sea.gmane.org>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com> <457C1E8E.4080407@garzik.org> <elh91b$v6r$1@sea.gmane.org> <A52817B6-0265-4164-8E5D-334AF92DC267@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 10 Dec 2006 18:16:49 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 37
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33911>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtTE9-0001Tr-VS for gcvg-git@gmane.org; Sun, 10 Dec
 2006 19:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762307AbWLJSQd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 13:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762327AbWLJSQd
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 13:16:33 -0500
Received: from main.gmane.org ([80.91.229.2]:36941 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762307AbWLJSQc
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 13:16:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GtTDk-0000Yw-3B for git@vger.kernel.org; Sun, 10 Dec 2006 19:16:16 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 19:16:16 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 10 Dec 2006
 19:16:16 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Kyle Moffett wrote:

> On Dec 10, 2006, at 10:30:00, Jakub Narebski wrote:
>> Jeff Garzik wrote:
>>>
>>> I actively use git to version, store and distribute an exim mail  
>>> configuration across six servers.  So far my solution has been a  
>>> 'fix perms' script, or using the file perm checking capabilities  
>>> of cfengine.
>>
>> Fix perms' script used on a checkout hook is a best idea I think.
> 
> Hmm, unfortunately that has problems with security-related race  
> conditions when used directly for /etc.  Think about what happens  
> with "/etc/shadow" in that case, for example.  (/etc/.git is of  
> course 0700)  I'm sure there are others where non-root daemons get  
> unhappy when they get an inotify event and their config files have  
> suddenly become root:root:0600.  I also want to be able to "cd /etc  
> && git status" to see what changed after running "apt-get update" or  
> maybe fiddling in SWAT or webmin, so a makefile which installs into / 
> etc won't quite solve it either.  It would also be nice to see when  
> things change the permissions on files in /etc, or even bind-mount an  
> append-only volume over /etc/.git/objects to provide additional data  
> security.

The idea is to not store /etc in git directly, but use import/export
scripts, which for example saves permissions and ownership in some
file also tracked by git on import, and restores correct permissions
on export. That is what I remember from this discussion. This of course
means that you would have to write your own porcelain...

What about mentioned in other email IsiSetup?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

