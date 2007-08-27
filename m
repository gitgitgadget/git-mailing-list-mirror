From: Sam Vilain <sam@vilain.net>
Subject: Re: .gitignore, .gitattributes, .gitmodules, .gitprecious?, .gitacls?
 etc.
Date: Mon, 27 Aug 2007 14:51:52 +1200
Message-ID: <46D23C48.6060904@vilain.net>
References: <2646CA4BEA644C9E9089C4A1AC395250@ntdev.corp.microsoft.com><7v1wdqud0z.fsf@gitster.siamese.dyndns.org><52E107D8068148B795FB4279B6272B8E@ntdev.corp.microsoft.com><7vsl66svv4.fsf@gitster.siamese.dyndns.org><C22431BFCD8E403FA10C8E91DE8AC19A@ntdev.corp.microsoft.com> <7vhcmmpxed.fsf@gitster.siamese.dyndns.org> <B4A2AE9980774365B5D14B442A7A22F6@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 04:51:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPUhd-0004Fq-8T
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 04:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634AbXH0CvP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 22:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753567AbXH0CvP
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 22:51:15 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:46504 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662AbXH0CvO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 22:51:14 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 4BCA821CFA5; Mon, 27 Aug 2007 14:51:12 +1200 (NZST)
Received: from [203.97.235.49] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 0895821CFA2;
	Mon, 27 Aug 2007 14:51:06 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <B4A2AE9980774365B5D14B442A7A22F6@ntdev.corp.microsoft.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56758>

Dmitry Kakurin wrote:
>> A tree that has .gitattributes (and I am assuming in the longer
>> term you can use "ignore" and "precious" in .gitattributes
>> instead of using .gitignore) POINTS TO A BLOB already, so what
>> you are saying does not add anything to what we already have,
>> other than that you are renaming .gitattributes to "META ENTRY".
>
> Almost true! The difference is: META BLOBS are not created as files in
> the workspace (not during checkout, not ever).
> In order to edit it you'd have to use 'git meta' command.
> So once again, there is only one place to check for metadata - the index.

Can I just chime in here and express my distaste for this idea, on
several grounds, but the summary is that svn does it this way, so it
must be wrong.

These files which store metadata would be stored in a way that is "in
another dimension" to the project files, despite being a part of the
history.  That means that all tools built to deal with regular files and
directories will not be able to merge the changes to the attributes
without special support.  I think this is broken.

This is something I frequently run up against with people coming from
Subversion, which supports unversioned revision properties which can
change randomly and without trace, and per-file/directory properties
which are simply files which you can't refer to in the regular way, and
are interpreted in an application-specific way.

My question to these people, and my question to you is: why do these
files need to be served from another dimension, what value does it add?

You see, either way, their contents need to be processed in an
application-specific way.  Same thing with git's "commit properties" -
basically just RFC822.. headers used in the commit message.  People I
have talked to have described this as "more arbitrary" than conventions
for attributes which are structured.  However, when pressed I have yet
to hear a clear argument why this is the case.

As far as file properties goes, I still like Linus' idea of making these
files which are accessed by treating the file as a directory (eg
filename.txt/ACL, filename.txt/mime-type), and that approach could be
represented in git well.

Sam.
