From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Getting version output for a file.
Date: Wed, 11 Jul 2007 15:48:51 -0400
Message-ID: <A084830C-F1CD-4EDC-A13D-573DFC68DF77@silverinsanity.com>
References: <86abu3dv9o.fsf@lola.quinscape.zz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jul 11 21:49:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8iBl-0004Pd-Gs
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 21:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932792AbXGKTs7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 15:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932660AbXGKTs7
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 15:48:59 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:49590 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099AbXGKTs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 15:48:58 -0400
Received: from [192.168.1.3] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 1618E1FFC003;
	Wed, 11 Jul 2007 19:48:56 +0000 (UTC)
In-Reply-To: <86abu3dv9o.fsf@lola.quinscape.zz>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52195>

I don't know lisp very well, and elisp not at all, but I can help you  
with what command lines would give you the results you might want.

On Jul 11, 2007, at 7:39 AM, David Kastrup wrote:

> (vc-git-previous-version FILE REV)
> Return the version number immediately preceding REV for FILE,
> or nil if there is no previous version.

If you want the last revision where the file was altered, you could  
easily use

git rev-list -2 $current_rev -- $file | tail -1

The result would be a SHA-1 of the next commit where the file was  
altered.

> (vc-git-next-version FILE REV)
> Return the version number immediately following REV for FILE,
> or nil if there is no previous version.

This is a little more problematic as git doesn't have forward links  
in it's history.  If you have a ref to start with (HEAD is a good one  
to use, if you don't have anything else) you could use a similar  
command to the above

git rev-list $ref -- $file | grep -C1 -m1 $current_rev | head -1

If you don't have a ref to start from, you could use --all, but that  
may not be what the user expects.

If you want a human readable name for either you could use name-rev.   
(Add "| git name-rev --stdin" to the end of the above.)  It places a  
human readable name after the SHA-1 in parentheses.  (example:  
"54dadbdb29668fbd51effefd0a0c65d915f5422b (master~3)")

~~ Brian
