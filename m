From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git build failure with libssl (OpenSSL) in custom directory
Date: Thu, 18 Nov 2010 12:24:47 -0600
Message-ID: <20101118182447.GF16610@burratino>
References: <AANLkTikQC9hncPZkeScWi7OsWw+Optbvxaygyn1p7_sN@mail.gmail.com>
 <20101118174921.GD16610@burratino>
 <AANLkTikZBcmbFoCmqT-eorGm3R0YYjkzotc414w_PHyd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Buitinck <larsmans@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 19:25:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ9Aw-000835-6T
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 19:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758408Ab0KRSZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 13:25:33 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55422 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757963Ab0KRSZd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 13:25:33 -0500
Received: by fxm10 with SMTP id 10so193899fxm.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 10:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ToUvTr3lWOYUlLgqa/jbx5uV7I+ehukgIG36lovu0mo=;
        b=K1GBUkuDCAGpKUP0B98CQ9g4ZusOH3u9pVRL0EF+fygzg/bn1SrbvO3WSoLwmVIi65
         ojjpyUySKN+D6mGBb+DLoGWJTHgVPX62R99xlOf/xdLogcULBD1UbcMu5ayqaIeC4G8r
         riMNekPOlVUHz+iYPAs5FbUYevXi3RCsCFcpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TXAFIzYhlslEmxvWU2l546Z7RXf+QH/NDE9RoHNdO4licT2xRBKPp07KmYprAY3bsn
         6q7Wu+NR44JiClPiVcu7DqFIV/NLm6qCAKgJCgjdgR7f/VKdzkxN+Ba/MdWRuQnUadTZ
         mmBN/TnMD/g4sug8jbj+mFzBjE/OPc8PCkAQ4=
Received: by 10.223.74.11 with SMTP id s11mr458549faj.11.1290104731709;
        Thu, 18 Nov 2010 10:25:31 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id y13sm246287fah.26.2010.11.18.10.25.30
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 10:25:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikZBcmbFoCmqT-eorGm3R0YYjkzotc414w_PHyd@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161701>

Lars Buitinck wrote:

> Yes, that works fine with LDFLAGS= in the Makefile. Is this just a
> lack of Makefile-fu on my part?

In general, "make" likes to get its variable assignments on the
command line rather than from the environment.  This way, Makefile
authors do not have to worry about keeping variable names in a
tightly reined namespace.

On the other hand, it can be convenient to set up the environment
with flags that would be used for multiple builds.  Different
projects deal with that differently:

./configure takes certain values (including LDFLAGS) from the
environment in autotools-using projects.  ./configure --help=short
lists them.

The Linux kernel build system has a separate (namespaced) set of
variables it reads from the environment.  Example: exporting
KBUILD_OUTPUT=$HOME/.cache/linux-2.6 in .profile would save me from
typing "make O=$HOME/.cache/linux-2.6" every time I build the kernel.
They are documented in Documentation/kbuild/kbuild.txt.

Git reads settings from a config.mak file in the toplevel of the
git source tree.  So one can set

	LDFLAGS = -L$(HOME)/opt/git/lib

there and it will be used for all builds.
