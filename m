From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 8/9] gitweb: True fix: Support for the standard mime.types map in gitweb
Date: Tue, 15 Aug 2006 18:43:29 +0200
Organization: At home
Message-ID: <ebsthv$3gt$2@sea.gmane.org>
References: <200608140202.46160.jnareb@gmail.com> <200608140216.34150.jnareb@gmail.com> <7vlkpqbzxx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 15 18:43:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD20g-00013i-Np
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 18:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbWHOQnT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 12:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWHOQnT
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 12:43:19 -0400
Received: from main.gmane.org ([80.91.229.2]:16822 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030380AbWHOQnS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Aug 2006 12:43:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GD20K-0000y3-Lp
	for git@vger.kernel.org; Tue, 15 Aug 2006 18:43:01 +0200
Received: from host-81-190-28-152.torun.mm.pl ([81.190.28.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 18:43:00 +0200
Received: from jnareb by host-81-190-28-152.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 18:43:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-28-152.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25464>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> True fix for error in mimetype_guess, error introduced in original commit
>> 2d00737489b8c61ed616b261c7c9bd314e2b0b41 and later fixed temporarily
>> by commenting out the line that caused error in commit
>> 57bd4d3523efecf60197040cad34154aff4ddf80.
>>
>> Gitweb now supports mime.types map $mimetypes_file relative to project.
> 
> Care to explain what that commenting out was about?
> 
>>      if ($mimetypes_file) {
>>              my $file = $mimetypes_file;
>> -            #$file =~ m#^/# or $file = "$projectroot/$path/$file";
>> +            if ($file !~ m!^/!) { # if it is relative path
>> +                    # it is relative to project
>> +                    $file = "$projectroot/$project/$file";
>> +            }
>>              $mime = mimetype_guess_file($filename, $file);
> 
> Are $project and $file always defined when we take this new
> codepath?
 
$project is defined always in the "input validation and dispatch" part.

"my $file = $mimetypes_file;", and only if $mimetypes_file is true
(so it must be defined). $mimetypes_file is undef by default, and it
is one of the configuration variables which are not set from Makefile
in "make gitweb/gitweb.cgi".

$path was never defined; I guess that was copy'n'paste error, copying
from other subroutine that used $path as one of arguments.


I don't know why I didn't fix this error correctly, only patched it up
the first time...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
