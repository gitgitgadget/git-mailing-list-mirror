From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] To make GIT-VERSION-FILE, search for git more widely
Date: Wed, 03 Jun 2009 22:18:53 -0700
Message-ID: <7vvdnc37b6.fsf@alter.siamese.dyndns.org>
References: <1241688129-31613-1-git-send-email-matthias.andree@gmx.de>
	<20090602195533.6117@nanako3.lavabit.com>
	<7v7hzufxcu.fsf@alter.siamese.dyndns.org>
	<200906022035.30081.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	"Matthias Andree" <matthias.andree@gmx.de>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jun 04 07:19:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MC5MJ-00009S-LV
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 07:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbZFDFSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 01:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbZFDFSw
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 01:18:52 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:58012 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbZFDFSv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 01:18:51 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090604051854.ZOCF20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Thu, 4 Jun 2009 01:18:54 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id zhJt1b0094aMwMQ04hJtRz; Thu, 04 Jun 2009 01:18:53 -0400
X-VR-Score: -300.00
X-Authority-Analysis: v=1.0 c=1 a=Sb75fb6s3KMA:10 a=5qu_ZHnkUusA:10
 a=A9qS8gIqAAAA:8 a=UQnXkbzPAAAA:8 a=2olAJ4NecTSz5Y1oWBMA:9
 a=1Q1N4x2HUhfCkCt2PwYA:7 a=7kiTax7FGgcYOCQ4XH6Po1zhGGwA:4 a=Kj4G0JfAssAA:10
 a=Q21-j9j7q-gA:10
X-CM-Score: 0.00
In-Reply-To: <200906022035.30081.j6t@kdbg.org> (Johannes Sixt's message of "Tue\, 2 Jun 2009 20\:35\:29 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120678>

Johannes Sixt <j6t@kdbg.org> writes:

> On Dienstag, 2. Juni 2009, Junio C Hamano wrote:
>> Nanako Shiraishi <nanako3@lavabit.com> writes:
>> > Junio, I think you forgot to take a follow-up action on this thread after
>> > sending this message.  The patch favors the git program in the current
>> > directory.
>>
>> Indeed, I did, and I think I am Ok with the patch.  Thanks for a
>> reminder.
>>
>> I thought there was an "simplicity" issue raised by J6t that was not
>> addressed, but after re-reading the thread I do not think it applies
>> (J6t?)
>
> Sorry, I don't recall anymore what I said; but since the thread petered out, I 
> use this patch in the repository where I share Matthias' 'sudo make install' 
> problem:
>
> Subject: [PATCH] version-gen: Use just built git if no other git is in PATH
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index 39cde78..4779313 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -3,6 +3,9 @@
>  GVF=GIT-VERSION-FILE
>  DEF_VER=v1.6.3.GIT
>  
> +# use git that was just compiled if there is no git elsewhere in PATH
> +PATH=$PATH:.
> +
>  LF='
>  '

I actually think this is much saner and cleaner (it certainly is smaller),
especially having seen Matthias's v4, which feels a tad overengineered.

I honestly do not understand why we need to bend backwards to cater to
"sudo".  Real men, when needing to do things as root, have always done
"su", and _if_ the environment is unsuited for the job, they can do:

	$ su
        # PATH=$PATH:/usr/local/bin make prefix=/usr/local install
