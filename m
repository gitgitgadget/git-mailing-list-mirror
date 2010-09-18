From: Miles Bader <miles@gnu.org>
Subject: git "smart http" server vs. http redirects
Date: Sat, 18 Sep 2010 13:33:48 +0900
Message-ID: <877hijvff7.fsf@catnip.gol.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 18 06:34:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owp7y-0000fP-B6
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 06:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599Ab0IREd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 00:33:57 -0400
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:57799 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab0IREd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 00:33:56 -0400
Received: from 218.231.154.125.eo.eaccess.ne.jp ([218.231.154.125] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	id 1Owp7Z-0002xv-Gj; Sat, 18 Sep 2010 13:33:53 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id C3C11DF8B; Sat, 18 Sep 2010 13:33:48 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156428>

The savannah.gnu.org admins are trying out the git "smart http" server,
but it doesn't seem to handle http redirects properly... should it?
Is this a bug with the git server?

The follow is from Sylvain Beucler;
> Hmmm, actually it works, but it doesn't support a HTTP redirect
> (namely git.sv.gnu.org -> git.savannah.gnu.org).
>
> $ git clone http://git.sv.gnu.org/r/freedink.git
> Initialized empty Git repository in /tmp/freedink/.git/
> error: RPC failed; result=22, HTTP code = 405
> ^C
>
> $ git clone http://git.savannah.gnu.org/r/freedink.git
> Initialized empty Git repository in /tmp/freedink/.git/
> remote: Counting objects: 5528, done.
> remote: Compressing objects:  11% (174/1578)

This is the response I get from git.sv.gnu.org manually:

  $ telnet git.sv.gnu.org http
  Trying 140.186.70.72...
  Connected to git.sv.gnu.org.
  Escape character is '^]'.
  GET /r/freedink.git HTTP/1.1
  Host: git.sv.gnu.org

  HTTP/1.1 301 Moved Permanently
  Date: Fri, 17 Sep 2010 06:03:27 GMT
  Server: Apache/2.2.9 (Debian) DAV/2 SVN/1.5.1 mod_python/3.2.10 Python/2.4.4 mod_wsgi/2.5
  Location: http://git.savannah.gnu.org/r/freedink.git
  Content-Length: 389
  Content-Type: elided-to-get-past-vger's-filter; charset=iso-8859-1

  <!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
  <html><head>
  <title>301 Moved Permanently</title>
  </head><body>
  <h1>Moved Permanently</h1>
  <p>The document has moved <a href="http://git.savannah.gnu.org/r/freedink.git">here</a>.</p>
  <hr>
  <address>Apache/2.2.9 (Debian) DAV/2 SVN/1.5.1 mod_python/3.2.10 Python/2.4.4 mod_wsgi/2.5 Server at git.sv.gnu.org Port 80</address>
  </body></html>
  Connection closed by foreign host.

Thanks,

-Miles

-- 
XML is like violence.  If it doesn't solve your problem, you're not
using enough of it.
