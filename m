From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [git-users] Problem using detached worktrees with commands implemented in scripts
Date: Wed, 16 Oct 2013 23:39:25 +0100
Organization: OPDS
Message-ID: <29AA597BEBC146B09E8B370949EC2CE9@PhilipOakley>
References: <201310162003.r9GK3UYj014414@freeze.ariadne.com> <xmqqeh7k51vg.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 17 00:39:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWZkT-0003Cg-7m
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 00:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761392Ab3JPWjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 18:39:18 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:35887 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760936Ab3JPWjQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Oct 2013 18:39:16 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvIVAGQUX1JOl3+a/2dsb2JhbABaDoJ5iXG1BwQCAgEBgRwXdGkBAYEfAQEUAQQBAQQBCAEBLh4BASELAgMFAgEDFQwlFAEEGgYHFwYTCAIBAgMBCYUvBwGCFhkKv1aOCCZKWYMmgQYDiQSGEppwgWZ/QDuBNA
X-IPAS-Result: AvIVAGQUX1JOl3+a/2dsb2JhbABaDoJ5iXG1BwQCAgEBgRwXdGkBAYEfAQEUAQQBAQQBCAEBLh4BASELAgMFAgEDFQwlFAEEGgYHFwYTCAIBAgMBCYUvBwGCFhkKv1aOCCZKWYMmgQYDiQSGEppwgWZ/QDuBNA
X-IronPort-AV: E=Sophos;i="4.93,509,1378854000"; 
   d="scan'208";a="591316769"
Received: from host-78-151-127-154.as13285.net (HELO PhilipOakley) ([78.151.127.154])
  by out1.ip06ir2.opaltelecom.net with SMTP; 16 Oct 2013 23:39:14 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236280>

From: "Junio C Hamano" <gitster@pobox.com>
> worley@alum.mit.edu (Dale R. Worley) writes:
>
>> In general, Git commands on a repository with a detached worktree can
>> be executed by cd'ing into the directory containing the .git
>> directory, ...
>
> Eh?  News to me; it might happened to have appeared to work by
> accident, but that is not by design.

I think it is this part in Dale's original email

"However, this approach does not work with "git filter-branch", which
objects with "You need to run this command from the toplevel of the
working tree."

that is the problem Dale has seen. IIRC there are a few commands that do 
require to be run from the toplevel ('git bisect' I think is another), 
and the detection process for 'toplevel' may not work properly when in a 
separated work-tree environment.

Perhaps something to consider.

Philip

>
> IIRC, the intended use pattern (i.e. the change that introduced
> GIT_DIR and GIT_WORK_TREE environment variables was designed to
> support) for such a working tree is to:
>
> - export GIT_DIR that points at the correct .git directory;
>
> - export GIT_WORK_TREE that points at the correct top-level of such
>   a working tree; and then
>
> - run the commands anywhere in the working tree, as if you did not
>   export these two environment variables and instead had the .git
>   directory at the usual place in the working tree.
>
> It _is_ possible that we may have broken this canonical use pattern
> over time with more recent updates; I do not think we have extensive
> test coverage for "detached worktree" use case in the first place.
>
>> Does anyone have any feedback on this?
>
> Not exporting GIT_DIR variable in sh-setup was done not by accident
> but as a very deliberate design choice, IIRC.
> --
