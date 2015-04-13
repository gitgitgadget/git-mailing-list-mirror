From: "Macario, Gianpaolo" <Gianpaolo_Macario@mentor.com>
Subject: RE: Installing git binaries on a non-default directory (Ubuntu)
Date: Mon, 13 Apr 2015 11:10:51 +0000
Message-ID: <0CCD6BBA210ECA418BCD82271FCFD94C556A3CEA@EU-MBX-03.mgc.mentorg.com>
References: <loom.20150410T183218-536@post.gmane.org>
 <xmqq7ftg4l73.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 13:11:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhcGb-0001Kc-EV
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 13:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbbDMLK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 07:10:57 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:40874 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726AbbDMLK4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2015 07:10:56 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-03.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp 
	id 1YhcGT-0004rn-VO from Gianpaolo_Macario@mentor.com ; Mon, 13 Apr 2015 04:10:54 -0700
Received: from EU-MBX-03.mgc.mentorg.com ([169.254.2.235]) by
 SVR-IES-FEM-03.mgc.mentorg.com ([137.202.0.108]) with mapi id 14.03.0224.002;
 Mon, 13 Apr 2015 12:10:52 +0100
Thread-Topic: Installing git binaries on a non-default directory (Ubuntu)
Thread-Index: AQHQda/gsYmUdmNZKUu+3DsOHlJPk51KxQKA
In-Reply-To: <xmqq7ftg4l73.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.202.0.76]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267076>

Hello Juno,

> Gianpaolo Macario <gianpaolo_macario@mentor.com> writes:
> 
> > By some googling and after reading the git sources and the commit logs
> > I assumed that the `RUNTIME_PREFIX` option (see
> > <https://github.com/git/git/blob/master/exec_cmd.c>) was designed for
> > that purpose,
> 
> I do not think so.
> 
> The standard procedure to stage into a temporary with "make install"
> and then make a tarball is done by using DESTDIR, e.g. something like
> 
>   $ make DESTDIR=/var/tmp/gittt ...other args... install
>   $ tar zCf /var/tmp/gittt git-version.tar.gz

[Macario, Gianpaolo] Thanks for your reply.

Unfortunately it looks to me that the `--prefix=xxx` option provided to configure will be hardcoded to the path returned by 'git --exec-path', and I do not see how this may actually be made dependent on the directory where the binary tarball will be extracted.

How should I configure/make git to have `<install_path>/bin/git --exec-path` return a path which depends on `<install_path>` rather than what provided to `./configure` ?

I tried the following

    $ mkdir -p ~/tmp
    $ cd ~/tmp
    $ wget http://kernel.org/pub/software/scm/git/git-2.3.5.tar.gz
    $ tar -xvzf git-2.3.5.tar.gz
    $ cd git-2.3.5
    $ ./configure --prefix= \
    --with-curl --with-openssl --without-tcltk \
    CFLAGS="${CFLAGS} `pkg-config --static --libs libcurl`"
    $ make
    $ make DESTDIR=/var/tmp/gittt install
    $ cd /var/tmp/gittt
    $ tar -cvzf ~/git-install-2.3.5.tar.gz .
    $ cd
    $ rm -rf ~/tmp/git-2.3.5
    $ rm -rf /var/tmp/gittt

then extracted the tarball

    $ sudo mkdir -p /opt/tools
    $ sudo chown $USER /opt/tools
    $ cd /opt/tools
    $ tar -xvzf ~/git-install-2.3.5.tar.gz

This is the result when executing

    $ /opt/tools/bin/git --exec-path
    /libexec/git-core

I wanted to have it return `/opt/tools/libexec/git-core` instead.

If I do not specify any `--prefix=xxx` when running `./configure`, this defaults to `/usr/local` which is not good either.

Thanks in advance, and apologies if I am doing something stupid...

Gianpaolo
