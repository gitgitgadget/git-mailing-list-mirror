From: Pat Thoyts <patthoyts@googlemail.com>
Subject: Re: [GITK PATCH 2/3] gitk: support path filters even in 
	subdirectories
Date: Thu, 25 Feb 2010 01:51:31 +0000
Message-ID: <a5b261831002241751v5294af48rac8b5f52ba6cb045@mail.gmail.com>
References: <f579dd581002200847o340a3eb9l50d0f1329d4e2c23@mail.gmail.com>
	 <alpine.DEB.1.00.1002201847290.20986@pacific.mpi-cbg.de>
	 <a5b261831002200948v3c01708dv3e42d08d42e3119@mail.gmail.com>
	 <alpine.DEB.1.00.1002201920350.20986@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.1002231748320.3980@intel-tinevez-2-302>
	 <alpine.DEB.1.00.1002231810020.3980@intel-tinevez-2-302>
	 <f579dd581002231137t71bb034fl429fd03a2c0d681c@mail.gmail.com>
	 <alpine.DEB.1.00.1002232122110.3980@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kirill <kirillathome@gmail.com>, Paul Mackerras <paulus@samba.org>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 25 02:51:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkSt9-00089e-5T
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 02:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758727Ab0BYBve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 20:51:34 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46930 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199Ab0BYBvd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 20:51:33 -0500
Received: by wya21 with SMTP id 21so1546555wya.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 17:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=KQ8jRQ9AdhGhnTfMOx6O8xIwaWOLUiWO2aVIf6tQcUc=;
        b=nkjucBFThw7gy5tnY8Jb8MGwvj4UFndtTZKtQxryXHTXCzCNKoJuwhSIXTo6qpvnWR
         Y1SNUTvjt+2/UwJRfqqHaGu/34lqQ0QS+TpppStewqFfg/D1DQJ9U1OnNlr28kG7pu+U
         Rc4ym6Pk2ZqAko0YPuxjvQKLXI01SSH3x0XBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ZOqHZIqKhG1FMEndLOOdFIaGwh611lIKaWhNPqeKN4ZpLktUB4AT/r2MH0+ysbZkHw
         H38iVKNF+LtW49uc+MUhuOiMa2gT7yMNyDMCkxO9zmI06+JxKwosql9ldrfZdfeJdHSW
         0BRYndTM4NQ/OtbNxFFInBsQPyNBOARiF2aC0=
Received: by 10.216.86.7 with SMTP id v7mr295965wee.137.1267062691864; Wed, 24 
	Feb 2010 17:51:31 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002232122110.3980@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141020>

On 23 February 2010 20:22, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 23 Feb 2010, Kirill wrote:
>
>> I believe the fact that pathprefix is set only under several conditions,
>> the invocation without arguments is broken.
>
> You are absolutely correct!
>
> Will fix and push to work/gitk-dashdash-dot,
> Dscho

This doesn't seem to work for me. We are trying to have the file tree
window display filenames when 'gitk -- .' is used and with your patch
this isn't happening when I apply this to gitk. I broke out the
path_filter function into a separate test to play with it a bit. It
seems this function is trying to match a path prefix to the provided
file name so here is a test script with three implementations. The
original, dscho's new one (git rev-parse --show-prefix returns an
empty string when run in the toplevel directory so I force the
'pathprefix' variable for the tests).

With this script I get the following results:
C:\src\gitk>tclsh told.tcl
original-2 failed . gitk expected 1 got 0
original-3 failed ./ gitk expected 1 got 0
original-5 failed ./po po/de.po expected 1 got 0
dscho-2 failed . gitk expected 1 got 0
dscho-3 failed ./ gitk expected 1 got 0
dscho-5 failed ./po po/de.po expected 1 got 0

So it looks like a simple string match on a normalized path works ok.
[file normalize $name] doesn't require the target file to exists btw.

--- test script begins ---

proc path_filter_orig {filter name} {
    foreach p $filter {
        set l [string length $p]
	if {[string index $p end] eq "/"} {
	    if {[string compare -length $l $p $name] == 0} {
		return 1
	    }
	} else {
	    if {[string compare -length $l $p $name] == 0 &&
		([string length $name] == $l ||
		 [string index $name $l] eq "/")} {
		return 1
	    }
	}
    }
    return 0
}

proc path_filter_dscho {filter name} {
    set pathprefix ""
    foreach p $filter {
        if {$p == "."} {
            set p $pathprefix
        } else {
            set p $pathprefix$p
        }
        set l [string length $p]
	if {[string index $p end] eq "/"} {
	    if {[string compare -length $l $p $name] == 0} {
		return 1
	    }
	} else {
	    if {[string compare -length $l $p $name] == 0 &&
		([string length $name] == $l ||
		 [string index $name $l] eq "/")} {
		return 1
	    }
	}
    }
    return 0
}

proc path_filter {filter name} {
    set name [file normalize $name]
    foreach p $filter {
        set p [file normalize $p]
        if {[string equal $p $name] || [string match $p* $name]} {
            return 1
        }
    }
    return 0
}

set tests {
    1  ""   gitk   0
    2  .    gitk   1
    3  ./   gitk   1
    4  po   po/de.po  1
    5  ./po po/de.po 1
    6  po   gitk   0
    7  po   a/b    0
    8  a    a/b/c  1
}

foreach {id filter name result} $tests {
    set testresult [path_filter_orig $filter $name]
    if {$testresult != $result} {
        puts "original-$id failed $filter $name expected $result got
$testresult"
    }
}

foreach {id filter name result} $tests {
    set testresult [path_filter_dscho $filter $name]
    if {$testresult != $result} {
        puts "dscho-$id failed $filter $name expected $result got $testresult"
    }
}

foreach {id filter name result} $tests {
    set testresult [path_filter $filter $name]
    if {$testresult != $result} {
        puts "new-$id failed $filter $name expected $result got $testresult"
    }
}
