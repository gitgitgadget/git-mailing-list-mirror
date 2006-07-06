From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH 1/3] configure: Add test for Perl
Date: Thu, 6 Jul 2006 17:27:56 +0300
Message-ID: <20060706172756.a42f1627.tihirvon@gmail.com>
References: <20060706124025.G325584e9@leonov.stosberg.net>
	<20060706161011.ccc2ea1c.tihirvon@gmail.com>
	<E1FyUNT-0007Ko-JR@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: dennis@stosberg.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 06 16:29:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyUpn-0004ov-Ob
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 16:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWGFO2A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 10:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbWGFO2A
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 10:28:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:5694 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030292AbWGFO17 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jul 2006 10:27:59 -0400
Received: by nf-out-0910.google.com with SMTP id y25so218818nfb
        for <git@vger.kernel.org>; Thu, 06 Jul 2006 07:27:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=XLzZPjAYyuz+lfihq5Pr7XfarhUcV4JLb0MgxYZO1CnsQgyZah4RMikaZ8uJBTp1wPB+a/4QIYHFT/JPZkNI3SOwk2jWeASdYqBr+bXtavKYekQgyyCJywVMf60TA5LzFDhTiH2cAesn6+nSj53tLpiqclpCzM4GUXLCqU8+KXI=
Received: by 10.49.43.12 with SMTP id v12mr509230nfj;
        Thu, 06 Jul 2006 07:27:58 -0700 (PDT)
Received: from garlic.home.net ( [82.128.203.109])
        by mx.gmail.com with ESMTP id o45sm4655465nfa.2006.07.06.07.27.57;
        Thu, 06 Jul 2006 07:27:57 -0700 (PDT)
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1FyUNT-0007Ko-JR@moooo.ath.cx>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.19; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23392>

Matthias Lederhofer <matled@gmx.net> wrote:

> This will not work with spaces in $PATH. I'd do something like this if
> cut is portable (I have only freebsd and linux to test):

This works at least with SunOS /bin/sh, dash, posh and bash.

path_find()
{
        if test -x "$1"
        then
                echo "$1"
                return 0
        fi
	_ifs="$IFS"
	IFS=:
        for i in $PATH
        do
                if test -x "$i/$1"
                then
			IFS="$_ifs"
                        echo "$i/$1"
                        return 0
                fi
        done
	IFS="$_ifs"
        return 1
}

> Is there any reason to check the current directory first? "which"
> doesn't do it for me and without ./ in the front it does not work
> (without . is not in $PATH).

It is not needed but might be useful if PERL is user configurable
variable and can contain either full path or basename. For example this
code

    test "$PROG" || PROG=prog
    PROG=`path_find "$PROG"`

works with these cases

    $ PROG=/usr/bin/program ./configure
    $ PROG=program-1.2 ./configure

-- 
http://onion.dynserv.net/~timo/
