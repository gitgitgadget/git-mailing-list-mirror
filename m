From: "Lars Hjemli" <hjemli@gmail.com>
Subject: cgit vs. gitweb
Date: Mon, 25 Dec 2006 18:21:47 +0100
Message-ID: <8c5c35580612250921o765e141cq27f81b06364d0a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_76240_23003347.1167067307082"
X-From: git-owner@vger.kernel.org Mon Dec 25 18:22:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GytWX-0002G3-Qg
	for gcvg-git@gmane.org; Mon, 25 Dec 2006 18:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbWLYRVt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 12:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbWLYRVt
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 12:21:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:1351 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbWLYRVt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 12:21:49 -0500
Received: by nf-out-0910.google.com with SMTP id o25so4535261nfa
        for <git@vger.kernel.org>; Mon, 25 Dec 2006 09:21:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=oRemtjh6rjo+T+lvFyoBOSuKiHTBG/WrbPI9yt7pgs6Zl+YsGtYr2I3lqgUfPMjyNehI/eY0ukfZHfsVbQBWGOWTf2ZYqdgiWnXYW3dl31vSCi+bF0UNUThfqx5X8PwKYpm/4rI+IpGfrQNa3xOGJXTdqM7HI9F3xP7KeiA4fjE=
Received: by 10.82.183.19 with SMTP id g19mr184212buf.1167067307132;
        Mon, 25 Dec 2006 09:21:47 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Mon, 25 Dec 2006 09:21:47 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35390>

------=_Part_76240_23003347.1167067307082
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

I wanted to compare cgit against gitweb to see the effect of using
libgit and internal caching. So I ran the attached scripts against
http://hjemli.net/git/ and http://hjemli.net/cgi-bin/gitweb.cgi as a
very simplistic benchmark.

The scripts forks a number of similar child processes (specified by
$1) and then uses curl(1) to request the first log page of three
repositories $2 times. This is an attempt to simulate concurrent
requests for different pages/repositories (I chose the log-pages since
they're pretty similar in cgit and gitweb, both showing info for 100
commits).

The numbers are the average of three runs, executed from another box
on my subnet. To avoid a roundtrip to my ISP, the pages are accessed
by a local hostname.

So, here's the results, as measured by time(1):

fork count|cached uncached gitweb.cgi
---- -----+------ -------- ----------
   0    10|  0.28     0.46      15.33
   1    10|  0.56     0.77      29.72
  10    10|  2.77     4.22     166.40

fork: number of child processes
count: number of loop iterations, each requesting 3 different log-pages
cached: results for cgit with caching enabled
uncached: results for cgit with caching disabled
gitweb.cgi: results for gitweb

If ((fork+1) * count * 3) is taken as a rough estimate of the total
number of page requests, then requests/second looks like this:

 req| cached uncached gitweb.cgi
----+------- -------- ----------
  30| 107.14    65.22       1.96
  60| 107.14    77.92       2.01
 330| 119.13    78.20       1.98


-- 
larsh

ps: server is an AMD Athlon XP2600, running at ~2Ghz with 512MB ram

------=_Part_76240_23003347.1167067307082
Content-Type: application/x-sh; name=cgit.sh
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ew54kjvh
Content-Disposition: attachment; filename="cgit.sh"

IyEvYmluL3NoCgplY2hvICJzdGFydCBjZ2l0IHRlc3QgKHBpZD0kJCwgZm9yaz0kMSwgY291bnQ9
JDIpIgoKZm9yICgoYT0wOyAkYTwkMTsgYT0kYSsxKSkKZG8KICAuL2NnaXQuc2ggMCAkKCgkMioy
KSkgJgpkb25lCgoKZm9yICgoYT0wOyAkYTwkMjsgYT0kYSsxKSkKZG8KICBjdXJsIC1zIC1TIGh0
dHA6Ly9ib3gxL2dpdC9jZ2l0L2xvZy8/aD1tYXN0ZXIgPiAvZGV2L251bGwKICBjdXJsIC1zIC1T
IGh0dHA6Ly9ib3gxL2dpdC9naXQvbG9nLz9oPW1hc3RlciA+IC9kZXYvbnVsbAogIGN1cmwgLXMg
LVMgaHR0cDovL2JveDEvZ2l0L2xpbnV4LTIuNi4xOS9sb2cvP2g9bWFzdGVyID4gL2Rldi9udWxs
CmRvbmUKCmVjaG8gInRlc3QgZG9uZSAocGlkPSQkKSIK
------=_Part_76240_23003347.1167067307082
Content-Type: application/x-sh; name=gitweb.sh
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ew54ksvf
Content-Disposition: attachment; filename="gitweb.sh"

IyEvYmluL3NoCgplY2hvICJzdGFydCBnaXR3ZWIgdGVzdCAocGlkPSQkLCBmb3JrPSQxLCBjb3Vu
dD0kMikiCgpmb3IgKChhPTA7ICRhPCQxOyBhPSRhKzEpKQpkbwogIC4vZ2l0d2ViLnNoIDAgJCgo
JDIqMikpICYKZG9uZQoKCmZvciAoKGE9MDsgJGE8JDI7IGE9JGErMSkpCmRvCiAgY3VybCAtcyAt
UyAiaHR0cDovL2JveDEvY2dpLWJpbi9naXR3ZWIuY2dpP3A9Y2dpdDthPXNob3J0bG9nIiA+IC9k
ZXYvbnVsbAogIGN1cmwgLXMgLVMgImh0dHA6Ly9ib3gxL2NnaS1iaW4vZ2l0d2ViLmNnaT9wPWdp
dDthPXNob3J0bG9nIiA+IC9kZXYvbnVsbAogIGN1cmwgLXMgLVMgImh0dHA6Ly9ib3gxL2NnaS1i
aW4vZ2l0d2ViLmNnaT9wPWxpbnV4LTIuNi4xOTthPXNob3J0bG9nIiA+IC9kZXYvbnVsbApkb25l
CgplY2hvICJ0ZXN0IGRvbmUgKHBpZD0kJCkiCg==
------=_Part_76240_23003347.1167067307082--
