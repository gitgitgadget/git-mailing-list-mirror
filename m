X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: bug: git-sh-setup should not be in $PATH
Date: Wed, 06 Dec 2006 17:03:43 +0100
Message-ID: <4576E9DF.5090709@xs4all.nl>
References: <el6c6o$oa7$1@sea.gmane.org> <200612061627.40359.jnareb@gmail.com> <4576E38F.1020404@xs4all.nl> <200612061656.55888.jnareb@gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 16:03:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <200612061656.55888.jnareb@gmail.com>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33480>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrzFH-0000GD-Am for gcvg-git@gmane.org; Wed, 06 Dec
 2006 17:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936332AbWLFQDh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 11:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936337AbWLFQDh
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 11:03:37 -0500
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:2669 "EHLO
 smtp-vbr11.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S936340AbWLFQDg (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 11:03:36 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr11.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kB6G3Xhw004795 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Wed, 6 Dec 2006 17:03:33 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski escreveu:
> The fact that I didn't understood what this part of patch is meant
> to do should be the big hint that this commit needs some longer commit
> message explaining purpose of such mess.
> 
> I still don't understand what this part do (and how come it is
> in configure.ac which should be _only_ about generating 
> config.mak.autogen Makefile configuration file and _not_ about
> generating Makefiles). You want what sequence of commands to work?
> 
>   $ $srcdir/configure --srcdir=$srcdir
>   $ make -D $srcdir
>   $ make -D $srcdir DESTDIR=$DESTDIR install

make -D doesn't exist.

This is about 

  mkdir git-build
  cd git-build
  $my_git_source/configure  
  make 

this _was_ actually documented in that one-line commit message, that
you found to be too short.

Since git does recursive makes, among others in 

 perl/ 
 Documentation/
 templates/
 contrib/
  
there should be Makefiles in said directories. Otherwise, every rule
in the toplevel Makefile saying


  $(MAKE) -C subdir/

will fail because $builddir/ does not have a Makefile in
$builddir/subdir.

The part you don't understand is a generic way of duplicating the
Makefiles from the git sources, while making sure that they work when
$srcdir != $builddir


Yes, if builddir != srcdir , then configure is about more than
generating config.mak.autogen


-- 
