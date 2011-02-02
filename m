From: =?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg==?= <asedeno@MIT.EDU>
Subject: Re: [PATCH (version C) 1/2] gitweb: Prepare for splitting gitweb
Date: Wed, 02 Feb 2011 14:08:12 -0500
Message-ID: <4D49AB9C.2050307@mit.edu>
References: <1296579016-13356-1-git-send-email-jnareb@gmail.com> <1296579016-13356-4-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 02 20:08:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pki44-0002aL-5P
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 20:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924Ab1BBTIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 14:08:23 -0500
Received: from DMZ-MAILSEC-SCANNER-3.MIT.EDU ([18.9.25.14]:45982 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754637Ab1BBTIW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Feb 2011 14:08:22 -0500
X-AuditID: 1209190e-b7b3bae000000a71-36-4d49aba536bc
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-3.mit.edu (Symantec Brightmail Gateway) with SMTP id 3C.58.02673.5ABA94D4; Wed,  2 Feb 2011 14:08:21 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id p12J8LUx007777;
	Wed, 2 Feb 2011 14:08:21 -0500
Received: from darkmatter.mit.edu (DARKMATTER.MIT.EDU [18.238.2.175])
	(authenticated bits=0)
        (User authenticated as smtp/darkmatter.mit.edu@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p12J8J5b007563
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 2 Feb 2011 14:08:20 -0500 (EST)
Received: by darkmatter.mit.edu (Postfix, from userid 108)
	id 41CD314C013; Wed,  2 Feb 2011 14:08:19 -0500 (EST)
Received: from [18.238.2.136] (JABUN.MIT.EDU [18.238.2.136])
	by darkmatter.mit.edu (Postfix) with ESMTPSA id 220C214C012;
	Wed,  2 Feb 2011 14:08:19 -0500 (EST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <1296579016-13356-4-git-send-email-jnareb@gmail.com>
X-Enigmail-Version: 1.1.1
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165926>

On 2/1/2011 11:50 AM, Jakub Narebski wrote:
> Prepare gitweb for being split into modules that would be installed
> in gitweblibdir, by default alongside gitweb in 'lib/' subdirectory.
> 
> Gitweb would search first in 'lib/' subdirectory from where it is
> installed, via
> 
>   use lib __DIR__.'/lib';
> 
> (This allow for tests to work with source version of gitweb without
> changes.)  Then it searches in $(gitweblibdir) directory (set during
> build time), by default "$(gitwebdir)/lib", via
> 
>   use lib "++GITWEBLIBDIR++";
> 
> "++GITWEBLIBDIR++" is set to appropriate value during build time
> (generating gitweb.cgi).  This allows to select where to install
> gitweb modules via 'gitweblibdir' build time configuration variable

I would personally prefer to see this path taken, as it seems the most
flexible and would fulfill a use case I have.

I maintain a build of git in an AFS volume at MIT. One of its uses is
symlinking to the current gitweb.cgi to instantly deploy a gitweb in a
shared hosting environment (example: http://git.scripts.mit.edu/).

__DIR__ would point to the directory containing a user symlink to
gitweb, which would allow users to add their own libraries, while
++GITWEBLIBDIR++ would allow the standard gitweb libraries to be hosted
at a common path without placing additional burdens on the user at
upgrade time.

-Alejandro
