From: Jing Xue <jingxue@digizenstudio.com>
Subject: .git/info/exclude w/ CFLF fails in cygwin
Date: Fri, 7 Sep 2007 21:01:39 -0400
Message-ID: <20070908010139.GA5501@falcon.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 08 03:01:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITohv-00012Y-OL
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 03:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbXIHBBs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 21:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbXIHBBs
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 21:01:48 -0400
Received: from k2smtpout02-01.prod.mesa1.secureserver.net ([64.202.189.90]:41276
	"HELO k2smtpout02-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750843AbXIHBBr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 21:01:47 -0400
Received: (qmail 12907 invoked from network); 8 Sep 2007 01:01:46 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout02-01.prod.mesa1.secureserver.net (64.202.189.90) with ESMTP; 08 Sep 2007 01:01:46 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 5FD55100A0B
	for <git@vger.kernel.org>; Sat,  8 Sep 2007 01:01:46 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xbNqR3lYN+Qy for <git@vger.kernel.org>;
	Fri,  7 Sep 2007 21:01:40 -0400 (EDT)
Received: from falcon (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 6C4C7100587
	for <git@vger.kernel.org>; Fri,  7 Sep 2007 21:01:40 -0400 (EDT)
Received: by falcon (Postfix, from userid 1000)
	id 6488C7B520; Fri,  7 Sep 2007 21:01:39 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58095>

(1.5.3.1 in cygwin, Win XP)
I have cygwin configured to operate in the DOS/text mode, which means
cygwin translates LF to CRLF when writing a file, and CRLF to LF when
reading.  Unfortunately cygwin's fstat() implementation doesn't take the
mode into account when reporting stat.st_size, presumably for the sake
of performance, while read() does actually do the conversion.

That causes the function add_excludes_from_file_1() in dir.c to reject a
.git/info/exclude file with CRLF ending, because the size actually read
is not the same as the size reported by fstat().

The simplest fix I have found is to explicitly open the exclude file in
binary mode, because the rest of the exclude file parsing code actually
deals with CRLF quite fine.

I would submit a patch but I am not sure if this is the appropriate fix.

By the way, parsing .git/config with CRLF in the same environment works
fine because the code reads the file by byte and doesn't do any size
validation.

Any thoughts?
-- 
Jing Xue
