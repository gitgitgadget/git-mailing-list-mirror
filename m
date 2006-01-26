From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: 5c7d3c95 broke 026351a
Date: Thu, 26 Jan 2006 14:45:22 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060126134521.GA11570@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 26 14:45:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F27Rc-0007f2-9x
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 14:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWAZNpY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 08:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWAZNpY
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 08:45:24 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:65192 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751340AbWAZNpX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 08:45:23 -0500
Received: from juno.informatik.uni-freiburg.de ([132.230.151.45])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1F27RC-0003B0-5V
	for git@vger.kernel.org; Thu, 26 Jan 2006 14:45:22 +0100
Received: from juno.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11) with ESMTP id k0QDjM5G011881
	for <git@vger.kernel.org>; Thu, 26 Jan 2006 14:45:22 +0100 (MET)
Received: (from zeisberg@localhost)
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11/Submit) id k0QDjMXf011880
	for git@vger.kernel.org; Thu, 26 Jan 2006 14:45:22 +0100 (MET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15165>

Hello,


zeisberger@io:~$ VN=$(nonexistentcmd) || echo lala
bash: nonexistentcmd: command not found
lala

uzeisberger@io:~$ VN=$(nonexistentcmd | sed 's/-/./g') || echo lala
bash: nonexistentcmd: command not found

The reason is (from bash(1)):

	The return status of a pipeline is the exit status of the last
	command, unless the pipefail option is enabled.

and the sed command is fine.

pipefail is not portable, i.e. Solaris' sh doesn't support it.

I'd suggest:

	if VN=$(git-describe --abbrev=4 HEAD 2>/dev/null); then
		VN=$(echo "$VN" | sed 's/-/./g');
	else
		VN=$(cat version) || VN="$DEF_VER";
	fi

This works with Solaris' sh and bash.

Best regards
Uwe

-- 
Uwe Zeisberger

exit vi, lesson V:
o : q ! CTRL-V <CR> <Esc> " d d d @ d
