From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Convert Content-Disposition filenames into qtext
Date: Sat, 07 Oct 2006 14:11:38 +0200
Organization: At home
Message-ID: <eg85ga$9g6$1@sea.gmane.org>
References: <20061006192006.GW20017@pasky.or.cz> <20061006193059.21334.qmail@web31807.mail.mud.yahoo.com> <7vk63ctq47.fsf@assigned-by-dhcp.cox.net> <eg7u5n$mt9$1@sea.gmane.org> <20061007114602.GX20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Oct 07 14:12:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWB1o-0004ML-4T
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 14:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWJGMLh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 08:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWJGMLh
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 08:11:37 -0400
Received: from main.gmane.org ([80.91.229.2]:16001 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751000AbWJGMLg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 08:11:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GWB1P-0004G9-KE
	for git@vger.kernel.org; Sat, 07 Oct 2006 14:11:15 +0200
Received: from host-81-190-22-223.torun.mm.pl ([81.190.22.223])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 14:11:15 +0200
Received: from jnareb by host-81-190-22-223.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Oct 2006 14:11:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-22-223.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28476>

Petr Baudis wrote:

> Dear diary, on Sat, Oct 07, 2006 at 12:06:31PM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...
>> >>>> +  $str =~ s/\r/\\r/g;
>> >>> 
>> >>> \r? Not \n?
>> >>
>> >> Yes, \r, not \n.
>> > 
>> > \r to \\r? Not to \\\r?
>> 
>> We want "\r" in suggested filename, not "\
>> " I think, so it is "\\r".
> 
> Oh, yes. Lubin wants. It looked sane until I've read it as you
> explicitly wrote it. ;-)
> 
> That's "obviously" wrong. In qtext, \r means just r, no special
> interpretation is done. So we indeed _would_ want "\
> ". Which is of course a nice trap for buggy browsers so in fact we
> obviously do not want that. I think it's not wort the potential problems
> to try to carry newlines in the header, so I would just replace that
> line with
> 
>       $str =~ s/[\n\r]/_/g;
> 
> as per Junio's suggestion.

Bu the way, using the following script:

-- >8 --
#!/usr/bin/perl

use strict;
use warnings;
use CGI qw(:standard :escapeHTML -nosticky);

binmode STDOUT, ':utf8';

our $cgi = new CGI;

print $cgi->header(
        -type => 'text/plain',
        -charset => 'utf-8',
        -content_disposition => 'inline; filename="test\".\\"test\\n.\\\n"');

print "TEST\n";
-- >8 --

I've checked that at least Mozilla 1.7.12 wants to using "\n"
in file name instead of literal eoln.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
