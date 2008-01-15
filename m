From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] safecrlf: Add flag to convert_to_git() to disable safecrlf check
Date: Tue, 15 Jan 2008 22:41:53 +0100
Message-ID: <FF86F119-5BF4-4ED3-B6AD-BADFDC91301D@zib.de>
References: <004D2FB5-2CEA-4DB1-AF8D-D5ADEB0F0508@zib.de> <12003528401309-git-send-email-prohaska@zib.de> <7vk5mchsct.fsf@gitster.siamese.dyndns.org> <F825ADAF-036C-46FE-8E3D-540B9AA092A8@zib.de>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 22:42:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEtXe-0002mS-C2
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 22:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215AbYAOVlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 16:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754209AbYAOVlT
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 16:41:19 -0500
Received: from mailer.zib.de ([130.73.108.11]:50085 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668AbYAOVlT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 16:41:19 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0FLesIK019959;
	Tue, 15 Jan 2008 22:40:54 +0100 (CET)
Received: from [192.168.178.21] (brln-4db83608.pool.einsundeins.de [77.184.54.8])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0FLen52005754
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 15 Jan 2008 22:40:49 +0100 (MET)
In-Reply-To: <F825ADAF-036C-46FE-8E3D-540B9AA092A8@zib.de>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70565>


On Jan 15, 2008, at 9:52 PM, Steffen Prohaska wrote:

>> Of course, "git add" on the path will warn or fail with your
>> patch, but we may somehow want to be warned about the breakage
>> before "git add" on that path triggers it.  Perhaps we can have
>> a separate "check-work-tree" command that iterates over locally
>> modified work tree files and runs convert_to_git() with checking
>> enabled.
>
> We could certainly have such a command, yet the question remains
> when to call it.  Do you have in mind calling it when we enter
> the work tree, such that all files in the work tree will always
> be verified?  Running the check once during start up should be
> sufficient and we could switch it off for the remainder of the
> execution.
>
> We would certainly print all paths with an irreversible conversion
> and only die() afterwards if requested by core.safecrlf=true.
> All information would be printed at once in an ordered way.  This
> could be more user friendly than the current approach.
>
> I'll work on this.


What is the right way to iterate over the changed files?
Should I copy and adapt the following from wt-status.c?

static void wt_status_print_changed(struct wt_status *s)
{
     struct rev_info rev;
     init_revisions(&rev, "");
     setup_revisions(0, NULL, &rev, NULL);
     rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
     rev.diffopt.format_callback = wt_status_print_changed_cb;
     rev.diffopt.format_callback_data = s;
     wt_read_cache(s);
     run_diff_files(&rev, 0);
}

	Steffen
