From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Installing on AIX fails
Date: Thu, 3 Jun 2010 12:32:11 -0300
Message-ID: <AANLkTinKjEBkn-9ajO4QXyHqY0EOQBGPRgNREaC_p_vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 03 17:32:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKCP4-0006R7-0Z
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 17:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756469Ab0FCPcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 11:32:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48205 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756407Ab0FCPcM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 11:32:12 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so191387fxm.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 08:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=l3RTBrjI82hvYH0cHxDi5uRIqI3Kp7ub323zqEwaye4=;
        b=c2GxCBDQhpfs/scYWfPCCGhr0mLPXwi1BH5rtLAjhJQ5sn1K8Ac6oU+/Sye8buenm/
         Tl0w81JLyAleX89E/uv5zPKgHjg7Z/ygiBsRzDtNkWARXJKozO+U+xUpSSpkoF4efiNF
         118AQAf4XsudsRQcXIFQTlIGccH+ODd52DdGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=WK/mYPrhA7Zv0rIS/lisH9AKgeN/cl8nVXPwUiAGdVKaHBRVQVKygSnxP9AIXpvUcB
         FAGKeRfTheNJdpc5v/M86N7FaHaFMVP0r6bgsziyB1sVaNhmk9QpOYjbLxplx/fezOLs
         hGS8yewi+y+CQxgFd8Z0QDfaZuVOBpRsCJCOY=
Received: by 10.204.74.22 with SMTP id s22mr2982743bkj.127.1275579131312; Thu, 
	03 Jun 2010 08:32:11 -0700 (PDT)
Received: by 10.204.18.207 with HTTP; Thu, 3 Jun 2010 08:32:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148335>

Hi all,

I was trying to install git in a development and testing server we
have. The first problem was that AIX 'make' tool does NOT support
conditionals in makefiles, and display errors such...


[...]
"Makefile", line 1003: make: Dependency line needs colon or double
colon operator.
"Makefile", line 1007: make: Dependency line needs colon or double
colon operator.
"Makefile", line 1009: make: Dependency line needs colon or double
colon operator.
"Makefile", line 1011: make: Dependency line needs colon or double
colon operator.
[...]


... until I get stucked. Well, I solved this by just using GNU make,
then I compile:


$ /usr/linux/bin/make prefix=$HOME/apps/ NO_OPENSSL=1 NO_TCLTK=1
NO_EXPAT=1 PYTHON_PATH=/usr/local/bin/python


and it all works, with angels singing and everything... a testing repo
works fine for a test drive without installing, excepting 'git log'
that just don't display anything.
Now, when I feel good to install it...


$ /usr/linux/bin/make prefix=$HOME/apps/ NO_OPENSSL=1 NO_TCLTK=1
NO_EXPAT=1 PYTHON_PATH=/usr/local/bin/python install

[...]
install -d -m 755 '/myhomedir/apps/bin'
getopt: illegal option -- d
Usage: install [-c dira] [-f dirb] [-i] [-m] [-M mode] [-O owner]
               [-G group] [-S] [-n dirc] [-o] [-s] file [dirx ...]
make: *** [install] Error 2



Now the installing process fails because of the AIX 'install' tool and
I wonder, can I patch/configure the installing process for AIX? May be
a set of utils for building in such systems would help some people.

PD: If you don't understand me please let me know it and I will try
again : )  My english could be horrible since I'm Argentinian.

PD2: I don't know if AIX python path is always /usr/local/bin/python,
but I've seen that git Makefiles set /usr/local/bin/python for FreeBSD
only:

git_remote_helpers/Makefile:
ifndef PYTHON_PATH
        ifeq ($(uname_S),FreeBSD)
                PYTHON_PATH = /usr/local/bin/python
        else
                PYTHON_PATH = /usr/bin/python
        endif
endif

I think 'test' the file is a good way for auto-configuration.

Cheers,
Dario
