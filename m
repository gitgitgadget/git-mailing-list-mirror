From: Mike Hommey <mh@glandium.org>
Subject: Should copy/rename detection consider file overwrites?
Date: Fri, 23 Jan 2015 10:29:08 +0900
Message-ID: <20150123012908.GA8558@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 23 02:29:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YET3t-0005Ij-6q
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 02:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbbAWB3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 20:29:18 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:48936 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751713AbbAWB3R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 20:29:17 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YET3c-0002K8-6p
	for git@vger.kernel.org; Fri, 23 Jan 2015 10:29:08 +0900
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262898>

Hi,

While fooling around with copy/rename detection, I noticed that it
doesn't detect the case where you copy or rename a file on top of
another:

$ git init
$ (echo foo; echo bar) > foo
$ git add foo
$ git commit -m foo
$ echo 0 > bar
$ git add bar
$ git commit -m bar
$ git mv -f foo bar
$ git commit -m foobar
$ git log --oneline --reverse
7dc2765 foo
b0c837d bar
88caeba foobar
$ git blame -s -C -C bar
88caebab 1) foo
88caebab 2) bar

I can see how this is not trivially representable in e.g. git diff-tree,
but shouldn't at least blame try to tell that those lines actually come
from 7dc2765?

Mike
