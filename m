From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsimport: fix initial checkout
Date: Thu, 13 Mar 2008 16:15:17 -0700
Message-ID: <7vr6eew70a.fsf@gitster.siamese.dyndns.org>
References: <1205435378-10411-1-git-send-email-marcandre.lureau@gmail.com>
 <47D9A836.9010601@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc-Andre Lureau <marcandre.lureau@gmail.com>, git@vger.kernel.org
To: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Mar 14 00:16:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZwee-0004GZ-CD
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 00:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbYCMXP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 19:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbYCMXP1
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 19:15:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45459 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbYCMXP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 19:15:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D7E9B3FD9;
	Thu, 13 Mar 2008 19:15:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2A2DB3FD8; Thu, 13 Mar 2008 19:15:19 -0400 (EDT)
In-Reply-To: <47D9A836.9010601@catalyst.net.nz> (Martin Langhoff's message of
 "Fri, 14 Mar 2008 11:18:30 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77146>

Martin Langhoff <martin@catalyst.net.nz> writes:

> Marc-Andre Lureau wrote:
>> git-symbolic-ref HEAD returns master reference, even if the file does
>> not exists. That prevents the initial checkout and fails in
>> git-rev-parse.
>
> But you are patching the block that gets triggered on subsequent
> imports, this code does not deal with "initial checkout" unless
> something else is wrong. The line right above the open() is an else that
> has the block that matters.
>
>> The patch checks the existence of the reference file
>> before assuming an original branch exists. There might be better
>> solutions than checking file existence.
>
> There are indeed. If we need this patch -- then you can call git
> ref-parse right to see if you get a sha1.
>
>> -	unless ($last_branch) {
>> +	if (-f "$git_dir/$last_branch") {
>
> Note that the file won't exist there in any modern git. It will be in
> $git_dir/refs/heads/$last_branch. Did you test this patch?

Martin, it may not even be in $git_dir/refs/heads/$last_branch ;-)  The
refs can be packed.

By the way, doesn't cvsimport fail when your HEAD is detached with this
code?

I always have cvsimport update the pristine upstream branch and rebase my
work against it, so I never have the branch cvsimport updates checked
out, and  for meit seems to work wonderfully (well, at least as wonderful
as a workflow that involves any CVS in it could be).  I do not see a
reason why it should not to work similarly well when my HEAD is detached..
