From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: Add colors to the prompt for status indicators
Date: Sun, 14 Nov 2010 20:50:10 +0000
Message-ID: <4CE04B82.1040804@pileofstuff.org>
References: <AANLkTi=ZdR4_reQgxL+xRaFE=SaqBYAWTrEuGEbLGynt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sebastien Douche <sdouche@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 21:50:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHjWr-0003qL-Ov
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 21:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544Ab0KNUuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 15:50:20 -0500
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:3545 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755492Ab0KNUuT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Nov 2010 15:50:19 -0500
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20101114205013.XXLV19887.mtaout02-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Sun, 14 Nov 2010 20:50:13 +0000
Received: from [192.168.1.6] (really [80.6.134.127])
          by aamtaout01-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20101114205013.WHRP20122.aamtaout01-winn.ispmail.ntl.com@[192.168.1.6]>;
          Sun, 14 Nov 2010 20:50:13 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Thunderbird/3.0.10
In-Reply-To: <AANLkTi=ZdR4_reQgxL+xRaFE=SaqBYAWTrEuGEbLGynt@mail.gmail.com>
X-Cloudmark-Analysis: v=1.1 cv=X0sWjjQ37bMP4yB/pNNinY3VxVB2n/hmdAjhihaCFGs= c=1 sm=0 a=mJMfpQbtWN4A:10 a=IkcTkHD0fZMA:10 a=2SemwIfTonzwo0BJ380A:9 a=VFkxS97Asmxec5W2dBMA:7 a=Y2v0mlQzwMinCzE-hiBofvhBkKcA:4 a=QEXdDO2ut3YA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161439>

Sorry for the delayed response to this one - I'm afraid it's the usual
work excuse :)

Non-printing characters need to be surrounded by \[ and \] for bash to
calculate line lengths correctly.  So far as I can tell, this has to be
in PS1 itself - bash doesn't recognise it if it's included in a script.

To see the problem, do this:

OLD_PS1="$PS1"
PS1="\033[0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0m>"

Then hold down any key - you should see some weird line-wrapping
behaviour a little way before the edge of your terminal.  To get your
old terminal back:

PS1="$OLD_PS1"

To see what happens when the "\[" characters are embedded in a script:

foo() {
 echo -e "\[\033[;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0m\]"
}
PS1='$(foo)>'

The "\[" and "\]" are represented literally in your terminal, and the
line-wrapping still occurs.

It's possible to work around this for a whole script:

foo() {
 echo -e "\033[;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0m"
}
PS1='\[$(foo)'\]>'

As a fan of colourful prompts, I'd be very happy if you found a way
around this for parts of a script.  But as a fan of fast prompts, I'd
prefer not to call __git_ps1 more than once :)

	- Andrew
