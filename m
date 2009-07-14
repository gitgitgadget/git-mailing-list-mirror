From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [ANNOUNCE] Stacked Git 0.15-rc1
Date: Tue, 14 Jul 2009 09:24:45 +0100
Message-ID: <b0943d9e0907140124u6e804ef2i5a17c23a44eda50f@mail.gmail.com>
References: <b0943d9e0907121540n4b9199e2re3152e71d84a0f5@mail.gmail.com>
	 <20090713133343.GA23946@skywalker>
	 <b0943d9e0907131007q18dbed72tc017be92ed23a61d@mail.gmail.com>
	 <20090713172017.GA29333@skywalker> <20090713174743.GB29333@skywalker>
	 <b0943d9e0907131506s329bc2c2qe35180ac783a52f3@mail.gmail.com>
	 <alpine.LFD.2.01.0907131555200.13838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karl Wiberg <kha@treskal.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 14 10:24:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQdJn-0007xr-M3
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 10:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbZGNIYs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2009 04:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbZGNIYs
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 04:24:48 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:43308 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbZGNIYr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 04:24:47 -0400
Received: by bwz28 with SMTP id 28so622211bwz.37
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 01:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sh2uKXKi2QmuO2Ywu1keLsaSFcJyopLz/CYuXeJZCfQ=;
        b=t8Ux6L/uwe/IiF0GmQRH3XQcH8Qfn4qKo9w7jz0HSoHGN3EEVSFnqihKFSluugVejc
         oru++Eumv0V/axuren3w8fEQawD+6leDqJeBWkYEB0RbbREHPjS91L6zNsMv9aPJLQ25
         ttSIUDtivERNrjgGCokBV39KtkO0LCpTExuk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jW+FNAH/5QUq4qr2R+R+fUpEJ5pS52KhDey9G7II1tc/TjzXBBskeAS8R9AoO1dJQ0
         1hJbFyAXwGw4+QpJLk2CCbjnWAago2a8EwUiu1qIWeZPAZlDHRDf/00g7u1/VNxXG+ou
         BD8DK9sH0tE1uFqlu+uuRYJS8Z1qPxcx3TGHI=
Received: by 10.223.108.211 with SMTP id g19mr2703990fap.39.1247559885190; 
	Tue, 14 Jul 2009 01:24:45 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0907131555200.13838@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123227>

2009/7/13 Linus Torvalds <torvalds@linux-foundation.org>:
> On Mon, 13 Jul 2009, Catalin Marinas wrote:
>>
>> =A0 =A0 =A0os.environ.setdefault('PAGER', config.get('stgit.pager'))
>> + =A0 =A0if os.environ.get('PAGER').startswith('less'):
>> + =A0 =A0 =A0 =A0os.environ.setdefault('LESS', '-FRSX')
>> =A0 =A0 =A0# FIXME: handle EDITOR the same way ?
>
> That's not very smart.
>
> First off, PAGER could easily be something like "/usr/local/bin/less"=
=2E
>
> Secondly, if it isn't less, so what? If it's not less, it won't care =
about
> the LESS environment variable.
>
> So just do an unconditional
>
> =A0 =A0 =A0 =A0os.environ.setdefault('LESS', '-FRSX')
>
> and it will (a) work better, (b) be simpler and more efficient.

Good point. Thanks. This is the new version:

diff --git a/stgit/config.py b/stgit/config.py
index f205e5b..4a6cb3b 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -37,7 +37,7 @@ class GitConfig:
         'stgit.keepoptimized':	'no',
         'stgit.extensions':	'.ancestor .current .patched',
         'stgit.shortnr': '5',
-        'stgit.pager':  'less -FRSX'
+        'stgit.pager':  'less'
         }

     __cache =3D None
@@ -121,6 +121,7 @@ def config_setup():
     global config

     os.environ.setdefault('PAGER', config.get('stgit.pager'))
+    os.environ.setdefault('LESS', '-FRSX')
     # FIXME: handle EDITOR the same way ?

 class ConfigOption:

--=20
Catalin
