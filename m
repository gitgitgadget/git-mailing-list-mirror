From: nguyenhu@minatec.inpg.fr
Subject: Re: [PATCHv2] Possibility to read both from ~/.gitconfig and from
 $XDG_CONFIG_HOME/git/config
Date: Thu, 31 May 2012 10:46:34 +0200
Message-ID: <20120531104634.Horde.MtY_VHwdC4BPxy-qPK1XmXA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; DelSp=Yes
Cc: git@vger.kernel.org, Lucien KONG <Lucien.Kong@ensimag.imag.fr>,
	Valentin DUPERRAY <Valentin.Duperray@ensimag.imag.fr>,
	Thomas NGUY <Thomas.Nguy@ensimag.imag.fr>,
	Franck JONAS <Franck.Jonas@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 31 10:47:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa12e-00023J-9i
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 10:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757952Ab2EaIqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 04:46:39 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:34043 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757910Ab2EaIqh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 04:46:37 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 896051A02F5;
	Thu, 31 May 2012 10:46:34 +0200 (CEST)
Received: from wifi-029133.grenet.fr (wifi-029133.grenet.fr
 [130.190.29.133]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Thu, 31 May 2012 10:46:34 +0200
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198872>


Junio C Hamano <gitster@pobox.com> wrote:
> Is it just me who finds the above three lines extremely unreadable?
>
> Also can you give this patch a bit more sensible title?
> "Possibility to" does not tell us much---anything is possible if you
> change code after all.
>
> I see the patch does not touch the writing codepath, which is
> probably a good thing, but the log message should explicitly state
> that.

I will change that in my next version.

> I am not sure in what way $HOME/.gitconfig has "priority".
>
> Your proposed log message says that You read from $HOME/.gitconfig
> and then from $XDG_CONFIG_HOME/git/config, which means that any
> single-valued variable set in $HOME/.gitconfig will be overwritten
> by whatever is in $XDG_CONFIG_HOME/git/config, no?  That sounds like
> you are giving priority to the latter to me.

You are right. Git takes into account $HOME/.gitconfig if one variable  
is defined in both configuration files. I will explains that more  
clearly in documentation.

> The original that read from $HOME/.gitconfig was simple enough so
> having three copies of getenv("HOME") was perfectly fine, but as you
> are introduce this much complexity to to decide which two files to
> read from, the code added this patch needs to be refactored and
> three copies of the same logic need to be consolidated, I would have
> to say.

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> Shouldn't there be a helper function to get the path ~/.config/git/
> and then append config? You're already computing this path twice, and
> we'll need more instances of it if we want to give default values to
> core.excludesfile and core.attributesfile in this directory too.

I agree. I will write a function to get ~/.config/git/ and refactor code.
