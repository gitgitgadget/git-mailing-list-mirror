From: demerphq <demerphq@gmail.com>
Subject: Very slow clone time over http
Date: Fri, 19 Dec 2008 23:33:08 +0100
Message-ID: <9b18b3110812191433l4eb70ccdw8693037045823aef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 23:34:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDnvd-0004dn-Vu
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 23:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbYLSWdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 17:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753567AbYLSWdN
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 17:33:13 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:10390 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366AbYLSWdL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 17:33:11 -0500
Received: by qw-out-2122.google.com with SMTP id 3so365019qwe.37
        for <git@vger.kernel.org>; Fri, 19 Dec 2008 14:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=uGA0vH2eUKc3B1zcBeufc4i8Neb9G3HcohfGgWPW8Xo=;
        b=lf8h+B8Yb70vXjKMcp9Pl+CTqinoWZ0lTNrhK3ajnBrKlArQTA+naVy7ZN95EvBth7
         UDkK7iWJ5A2c+fBxP/FkvgdjJ01zVPI1htf51BEXadMxZpHfW2PhZdCaMo8qy5DJ1lel
         9pXjXUXvLX4X2xYWbwNSap82i/OGkBb1dadmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=d5FL16LVOCmOthdXua+TmuakVE6vdPlcGcp9nvMb4AbT7dgBp/pDHUNoK9SfqhZSc5
         zWVizJ0BUA+biq3twGAmqh28R3Avi2bA9M9mlRYA3AKpLmaV2BaPSrcXtCBFIDPmZS9p
         JrH4d2OlP/GpEC4Fqt2z5QdZknNaja7wUX3MQ=
Received: by 10.214.182.2 with SMTP id e2mr4745208qaf.204.1229725988470;
        Fri, 19 Dec 2008 14:33:08 -0800 (PST)
Received: by 10.214.241.11 with HTTP; Fri, 19 Dec 2008 14:33:08 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103594>

Hi,

I've been working on the migration of the perl5 repositories from
perforce to git, which is soon to be officially released.

We have set up a server with http/git/ssh access, and we had hoped
also rsync access.

However, it appears that clone using the rsync:// protocol is broken,
and now we are discovering that http cloning is extremely slow. I
reported our experiences with rsync in a previous mail, and now im
reporting the http performance issue.

When we strace the clone we observe (to quote our sysadmin):

"git seems to be stuck for 10 minutes after downloading"
"no output, strace shows it's having sex with the memory allocator"
"sex with memory allocator" ==> loads of memory allocation/dealoccation

A provisional release of the conversion is available at

   http://dromedary.booking.com/perl.git

We are using git 1.6.0.5 on another more or less equivalent host, with
the same problems, and dromedary is using git version
1.6.0.4.724.ga0d3a. However we believe that the problem is actually on
the client side. The pack download itself appears to be quite fast,
however there is an extremely long pause (minutes) after which a HUGE
amount of essentially imcomprehensible output is generated about
walking packs or some such.

Timing a clone via http gets us number like:

real    7m42.459s
user    3m42.154s
sys     0m12.641s

Wheras using the git:// protocol gets us times like:

real    4m6.162s
user    0m43.595s
sys     0m4.852s

The client these numbers are from is git version 1.6.0.3.

So it take approximately twice the time via http as it does via git.
This seems somewhat strange. Is there anything we can do to improve
this? Repack? Anything like that?

A post about the github system suggests that this is not an isolated problem.

   http://github.com/blog/92-http-cloning

if there is anything we can do to help resolve this issue please let us know.

cheers,
Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
