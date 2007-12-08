From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Calculate $commitsha1 in update() only when needed
Date: Sat, 08 Dec 2007 03:48:21 -0500
Message-ID: <20071208034821.8icn2cflr4ksc0kw@webmail.spamcop.net>
References: <20071208050745.29462.74137.stgit@dv.roinet.com>
	<7vtzmtwqff.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 09:48:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0vMZ-0005sn-RK
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 09:48:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172AbXLHIsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 03:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754728AbXLHIsX
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 03:48:23 -0500
Received: from c60.cesmail.net ([216.154.195.49]:62882 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753020AbXLHIsW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Dec 2007 03:48:22 -0500
Received: from unknown (HELO epsilon2) ([192.168.1.60])
  by c60.cesmail.net with ESMTP; 08 Dec 2007 03:48:21 -0500
Received: from pool-96-227-106-33.phlapa.east.verizon.net
	(pool-96-227-106-33.phlapa.east.verizon.net [96.227.106.33]) by
	webmail.spamcop.net (Horde MIME library) with HTTP; Sat, 08 Dec 2007
	03:48:21 -0500
In-Reply-To: <7vtzmtwqff.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67530>

Quoting Junio C Hamano <gitster@pobox.com>:

> Pavel Roskin <proski@gnu.org> writes:
>
>> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
>> index ecded3b..409b301 100755
>> --- a/git-cvsserver.perl
>> +++ b/git-cvsserver.perl
>> @@ -2427,9 +2427,6 @@ sub update
>>      # first lets get the commit list
>>      $ENV{GIT_DIR} = $self->{git_path};
>>
>> -    my $commitsha1 = `git rev-parse $self->{module}`;
>> -    chomp $commitsha1;
>> -
>>      my $commitinfo = `git cat-file commit $self->{module} 2>&1`;
>>      unless ( $commitinfo =~ /tree\s+[a-zA-Z0-9]{40}/ )
>>      {
>
> Hmm.  The first rev-parse could be squelched with 2>/dev/null and then
> you can check if it does not match [a-f0-9]{40} and die early before
> running "cat-file commit", can't you?

Yes, my impression is that the code in question can be improved a lot.

This is specifically the error message I'd like to see fixed in some  
way, as it's confusing to beginners trying to check out the module for  
the first time.

$ CVS_SERVER=/home/proski/bin/git-cvsserver cvs -d \
  :fork:/home/proski/src/qgit/.git co foo
fatal: ambiguous argument 'foo': unknown revision or path not in the  
working tree.
Use '--' to separate paths from revisions
Invalid module 'foo' at /home/proski/bin/git-cvsserver line 2437,  
<STDIN> line 15.
cvs [checkout aborted]: end of file from server (consult above  
messages if any)

It's possible that the message about "--" makes sense and it should  
actually be added in some spaces.

-- 
Regards,
Pavel Roskin
