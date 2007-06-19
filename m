From: Bill Lear <rael@zopyra.com>
Subject: Re: Errors building git-1.5.2.2 on 64-bit Centos 5
Date: Tue, 19 Jun 2007 11:16:26 -0500
Message-ID: <18040.346.208040.842060@lisa.zopyra.com>
References: <18039.52754.563688.907038@lisa.zopyra.com>
	<Pine.LNX.4.64.0706191359160.4059@racer.site>
	<20070619132456.GA15023@fiberbit.xs4all.nl>
	<18039.57099.57602.28299@lisa.zopyra.com>
	<20070619143000.GA15352@fiberbit.xs4all.nl>
	<18039.60598.264803.940960@lisa.zopyra.com>
	<86k5u0q8q9.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jun 19 18:17:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0gO4-0006Kn-1c
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 18:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755767AbXFSQQj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 12:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755798AbXFSQQj
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 12:16:39 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60280 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755763AbXFSQQi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 12:16:38 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l5JGGXU07214;
	Tue, 19 Jun 2007 11:16:33 -0500
In-Reply-To: <86k5u0q8q9.fsf@lola.quinscape.zz>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50493>

On Tuesday, June 19, 2007 at 17:12:14 (+0200) David Kastrup writes:
>Bill Lear <rael@zopyra.com> writes:
>>...
>> However, I still get this:
>>
>> install -d -m755 '/opt/git-1.5.2.2/share//git-core/templates/'
>                                         ^^^
>> (cd blt && tar cf - .) | \
>> 	(cd '/opt/git-1.5.2.2/share//git-core/templates/' && tar xf -)
>                                   ^^^
>> tar: This does not look like a tar archive
>> tar: Skipping to next header
>> tar: Archive contains obsolescent base-64 headers
>> tar: Error exit delayed from previous errors
>>
>> So, I did a make -k and it worked ok, aside from this error.
>>
>> I copied this line:
>>
>> (cd blt && tar cf - .) | \
>> 	(cd '/opt/git-1.5.2.2/share//git-core/templates/' && tar xf -)
>                                   ^^^
>> into a file, chmod +x'd that file, and cd'd into templates and ran
>> the script.  I got the same error.  I then tried running it by
>> hand from the command line:
>>
>> % cd templates
>> % (cd blt && tar cf - .) | (cd /opt/git-1.5.2.2/share/git-core/templates
>>                                                     ^^^
>> && tar xf -)
>>
>> and it worked fine.
>
>Not sure whether this is the problem: either cd does not understasnd
>the double slashes, or your shell used for scripts has modified cd to
>output some stuff when it is working (people sometimes imprudently
>make shell functions or aliases for this).
>
>Try writing something like
>
>type cd
>
>in a script file and see what output you get.

% echo 'type cd' > foo
% chmod +x foo
% ./foo
cd is a shell builtin
% bash --version
GNU bash, version 3.1.17(1)-release (x86_64-redhat-linux-gnu)
Copyright (C) 2005 Free Software Foundation, Inc.

I also tried using the double-slash on the command line.  It worked
fine.  I tried a single slash from the script and it did not work.

% cd templates
% cat foo
set -x
type tar
type cd
(cd blt && tar cf - .) | (cd /opt/git-1.5.2.2/share/git-core/templates && tar xf -)
% ./foo
++ type tar
tar is /bin/tar
++ type cd
cd is a shell builtin
++ cd blt
++ tar cf - .
++ cd /opt/git-1.5.2.2/share/git-core/templates
++ tar xf -
tar: This does not look like a tar archive
tar: Skipping to next header
tar: Archive contains obsolescent base-64 headers
tar: Error exit delayed from previous errors


Bill
