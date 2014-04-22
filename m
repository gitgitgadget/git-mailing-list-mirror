From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.0.0-rc0
Date: Tue, 22 Apr 2014 15:11:48 -0700
Message-ID: <20140422221148.GD15516@google.com>
References: <xmqqk3ambf9k.fsf@gitster.dls.corp.google.com>
 <475e137b5095e45c92a87a9969f58f0@74d39fa044aa309eaea14b9f57fe79c>
 <20140422185829.GB15516@google.com>
 <xmqq4n1l3yyf.fsf@gitster.dls.corp.google.com>
 <20140422210002.GC15516@google.com>
 <xmqqy4yx2gz9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 00:12:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wciuy-0008Eh-7o
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 00:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbaDVWLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 18:11:52 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:41042 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbaDVWLv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 18:11:51 -0400
Received: by mail-pb0-f44.google.com with SMTP id rp16so73223pbb.31
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 15:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8VY0no9tRRZ4n16wUuSAT7U/Ksor0lbIrKEKI/pkrk4=;
        b=qVGg1ghB/iOCsJhh0Si7lCg0FIm+7ATct0t2K2X637HDfcuVYUDX8HM1tG24Wn2uWv
         /emYCBMqnUmwgCTl+NX3PkwpXDRzPg3MlMQZlU0Vrnc48zmU4hjGTFu3jUUE5E3o6qvd
         fTsWn7YPtddB1IsEZ8cX478JKIjo3cYVUzVWSq+g8v5tJrBwagKbAmXwMihF3AN1uWZ5
         CgWYFZn7xVHfq3GiWUoY3uSdq8vvR2ba4GfpsLDG6JbKXi/akQmdOLKAbz/eE1awyA1t
         IOSptm1M32AYUfhdsPmLPDDhmy0goRGhe60xd3b700+778B0QXpCzPlK0zbBaUX9OJpf
         afpA==
X-Received: by 10.68.249.195 with SMTP id yw3mr12716107pbc.134.1398204711196;
        Tue, 22 Apr 2014 15:11:51 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id vb7sm87152951pbc.13.2014.04.22.15.11.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 22 Apr 2014 15:11:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqy4yx2gz9.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246793>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> The documentation says
>>
>> 	--prefix=<prefix>
>>
>> 		...
>>
>> 		Before Git 2.0, the default prefix was "" (no prefix).
>> 		This meant that ...
>>
>> which suggests that I can use --prefix="" to mean no prefix.  Perhaps
>> it needs a note to suggest using '--prefix ""' instead?
>
> Is there another --option that takes an arbitrary user string that
> could be an empty string (or will there be one in the future)?

In git in general, yes --- for example, 'git diff --src-prefix=""
HEAD^' tells "git diff" to leave off the usual c/ prefix in the
src filename it prints.

In git-svn, --trunk="" or --message="" might be meaningful, but not
nearly as much as --prefix="".

>                                                                 If
> that is the case, a better alternative might be to add an comment to
> say that those with older Getopt::Long may have to use --option ""
> instead of the --option="" form for any option whose value happens
> to be an empty string to work around the command parser bug.

Another possibility would be to require Perl 5.8.9 or newer.  It was
released in 2008.

diff --git i/git-svn.perl w/git-svn.perl
index 0a32372..ec7910d 100755
--- i/git-svn.perl
+++ w/git-svn.perl
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 # Copyright (C) 2006, Eric Wong <normalperson@yhbt.net>
 # License: GPL v2 or later
-use 5.008;
+use 5.008_009;
 use warnings;
 use strict;
 use vars qw/	$AUTHOR $VERSION
