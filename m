From: Junio C Hamano <junkio@cox.net>
Subject: Re: apply-mbox claiming corrupt patch.
Date: Tue, 26 Sep 2006 22:02:08 -0700
Message-ID: <7vu02tj41b.fsf@assigned-by-dhcp.cox.net>
References: <20060927024628.GA29182@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 07:02:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSRYm-0002Lk-IO
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 07:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWI0FCM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 01:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965229AbWI0FCL
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 01:02:11 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:25026 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964780AbWI0FCK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 01:02:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927050209.UNVG6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Wed, 27 Sep 2006 01:02:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TH261V0081kojtg0000000
	Wed, 27 Sep 2006 01:02:06 -0400
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20060927024628.GA29182@redhat.com> (Dave Jones's message of
	"Tue, 26 Sep 2006 22:46:29 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27871>

Dave Jones <davej@redhat.com> writes:

> I tried to apply the mail below to my cpufreq.git tree on master.kernel.org,
> and got ..
>
> $ git-applymbox -k mbox
> 1 patch(es) to process.
>
> Applying '[CPUFREQ] Longhaul - Disable arbiter CLE266'
>
> fatal: corrupt patch at line 99

Like 99 (counting from where mailinfo splits proposed commit log
message and the patch body which is '---' line) is the line
after the closing brace "}" at the end of longhaul_cpu_init()
function.

> @@ -716,7 +739,7 @@ static int __init longhaul_cpu_init(stru
>  	return 0;
>  
>  err_acpi:
> -	printk(KERN_ERR PFX "No ACPI support for CPU frequency changes.\n");
> +	printk(KERN_ERR PFX "No ACPI support. No VT8601 or VT8623 northbridge. Aborting.\n");
>  	return -ENODEV;
>  }
>
>
> ----------------------------------------------------------------------
> Jestes kierowca? To poczytaj! >>> http://link.interia.pl/f199e

The hunk claims to have 7 preimage lines and 7 postimage lines,
so that empty line after the closing brace _is_ part of the
hunk.  And an empty context line is SP followed by LF.  But the
SP that should be at the beginning of that line does not exist.

In short, you have a corrupt patch.
