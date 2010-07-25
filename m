From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: [bash-completion] syntax error near unexpected token '<' on line
 123 in bash_completion.d/git
Date: Sun, 25 Jul 2010 21:01:48 +0100
Message-ID: <4C4C982C.20904@pileofstuff.org>
References: <1280056320.7883.9.camel@soho.example.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: solsTiCe d'Hiver <solstice.dhiver@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 22:50:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od89i-0004BB-5r
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 22:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038Ab0GYUu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 16:50:27 -0400
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:23040 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750788Ab0GYUu1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jul 2010 16:50:27 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100725200154.GIVY3075.mtaout03-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Sun, 25 Jul 2010 21:01:54 +0100
Received: from [192.168.1.6] (really [80.6.134.127])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100725200154.BTRA1586.aamtaout02-winn.ispmail.ntl.com@[192.168.1.6]>;
          Sun, 25 Jul 2010 21:01:54 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100528 Thunderbird/3.0.5
In-Reply-To: <1280056320.7883.9.camel@soho.example.org>
X-Cloudmark-Analysis: v=1.1 cv=3ENABmdyEd/Fm7fR7+mZIuMDn6+IErAeEhlfWBImZFk= c=1 sm=0 a=1U7auHjJ3WkA:10 a=IkcTkHD0fZMA:10 a=VBP8Kj18YuQ6y_MB0e4A:9 a=8R1a0_piPpQjgJNIB-lVanUtHm8A:4 a=QEXdDO2ut3YA:10 a=wognzvLQ2SxYz4XV:21 a=vQEgQkYW2wM8nD0E:21 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151793>

"< <()" is indeed correct here: the first "<" is a normal shell
redirect, and the "<()" creates a sub-shell to read input from.  This
was the least messy way I could find to read variables into a shell.  "<
$()" won't do the job, and a normal pipe won't either:

$ FOO=parent ; echo child | { read ; FOO="$REPLY" ; } ; echo $FOO
parent
$ FOO=parent ; { read ; FOO="$REPLY" ; } < $( echo child ) ; echo $FOO
bash: child: No such file or directory
parent
$ FOO=parent ; { read ; FOO="$REPLY" ; } < <( echo child ) ; echo $FOO
child


Is "syntax error near unexpected token '<' on line 123" the complete
text of the error message you get?  bash 4.1.5 always prepends "bash: "
to such errors for me:

$ while false ; do echo foo ; done < ;
bash: syntax error near unexpected token `;'

If this is the complete error text, then I suspect you may have somehow
got bash completion in a non-bash shell.  Could you add this on line 98
and let me know what it says:

echo $BASH_VERSION $BASHOPTS

If it really is bash, $BASHOPTS might help me to replicate this problem
(or I might have to read the man page some more).

	- Andrew
