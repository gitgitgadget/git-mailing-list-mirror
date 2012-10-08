From: Simon Oosthoek <soosthoek@nieuwland.nl>
Subject: Re: [PATCH] Add __git_ps1_pc to use as PROMPT_COMMAND
Date: Mon, 08 Oct 2012 17:00:39 +0200
Message-ID: <5072EA97.3060503@nieuwland.nl>
References: <5064140E.50007@drmicha.warpmail.net> <50658C9B.6030809@nieuwland.nl> <7vipaym3ks.fsf@alter.siamese.dyndns.org> <50695ECE.5010101@nieuwland.nl> <7v626udse6.fsf@alter.siamese.dyndns.org> <7v4nmec8fi.fsf@alter.siamese.dyndns.org> <5069EE8D.6050200@nieuwland.nl> <7vr4piaryi.fsf@alter.siamese.dyndns.org> <506A0366.6030009@xs4all.nl> <7va9w5c31w.fsf@alter.siamese.dyndns.org> <506A99DE.7080503@drmicha.warpmail.net> <7vhaqcajvt.fsf@alter.siamese.dyndns.org> <506B4598.1020206@xs4all.nl> <7v8vbo7hmd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Simon Oosthoek <s.oosthoek@xs4all.nl>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	schwab@linux-m68k.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 17:01:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLEpQ-0003HR-G3
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 17:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506Ab2JHPA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 11:00:59 -0400
Received: from mail.nieuwland.nl ([87.251.35.136]:34946 "HELO nieuwland.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750841Ab2JHPA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 11:00:57 -0400
Received: (qmail 15347 invoked by uid 453); 8 Oct 2012 15:00:49 -0000
X-Virus-Checked: Checked by ClamAV on nieuwland.nl
Received: from Unknown (HELO [192.168.216.232]) (192.168.216.232)
  (smtp-auth username soosthoek, mechanism plain)
  by nieuwland.nl (qpsmtpd/0.83) with (AES256-SHA encrypted) ESMTPSA; Mon, 08 Oct 2012 17:00:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <7v8vbo7hmd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207230>

Hi Junio

I hope you found my patches, if not, I'll try to send them out again. 
(Unfortunately my current mail setup is a mess and I need time to figure 
out what to fix...)

As for the zsh support, I found out a little bit more.
ZSH doesn't have a variable like PROMPT_COMMAND in bash. The precmd name 
is a function the user has to define herself to have it called before 
the prompt is shown. Functionally this is almost, but not quite, the 
same as PROMPT_COMMAND. The subtle difference is that with 
PROMPT_COMMAND you can use parameters to customize the prompt, so in 
bash you can say:

PROMPT_COMMAND="__git_ps1 '\u@\[\e[1;34m\]\h\[\e[0m\]:\w' '\\\$ '"

where in zsh, if you want the status in the prompt, you can either use 
$(__git_ps1 "(%s)") or something like it in setting the PS1 (and forget 
about the color hints!) or you can copy the __git_ps1 function and 
modify and rename it as precmd to set PS1 via that function. Obviously 
it is probably even more complicated, but I'd have to try it to be certain.

An alternative way might be to set special variables from __git_set_vars 
function which may be used in a custom precmd to set the prompt.

e.g. say __git_set_vars sets __GIT_VAR_STATE=dirty|stage|clean

in precmd you could do
case $__GIT_VAR_STATE in
(dirty) PS1="$PS1 files modified in __GIT_VAR_BRANCHNAME"
;;
(stage) PS1="$PS1 files staged in __GIT_VAR_BRANCHNAME"
;;
(clean) PS1="$PS1 __GIT_VAR_BRANCHNAME clean"
;;
esac

(more or less of course)..

In that way it would be possible to add the colors relatively easily 
based on the state of the tree in a custom precmd function of zsh.

/Simon
