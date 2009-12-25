From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC PATCH 2/2] Improve transport helper exec failure reporting
Date: Fri, 25 Dec 2009 11:32:20 +0200
Message-ID: <20091225093220.GA8319@Knoppix>
References: <1261676971-3285-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1261676971-3285-3-git-send-email-ilari.liusvaara@elisanet.fi>
 <7vljgrebv2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 25 10:34:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NO6YX-000618-Kd
	for gcvg-git-2@lo.gmane.org; Fri, 25 Dec 2009 10:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbZLYJc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Dec 2009 04:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbZLYJc1
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Dec 2009 04:32:27 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:56447 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbZLYJc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2009 04:32:26 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 3CC498C14E;
	Fri, 25 Dec 2009 11:32:25 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A078E737858; Fri, 25 Dec 2009 11:32:25 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id ECCD9407D;
	Fri, 25 Dec 2009 11:32:21 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7vljgrebv2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135669>

On Thu, Dec 24, 2009 at 11:44:49PM -0800, Junio C Hamano wrote:
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:
> 
> Looks pretty straightforward, except that I have this nagging feeling that
> we should *not* be married to the idea of "'proc->git_cmd = 1' is merely a
> way to save you from typing 'git-' prefix in start_command(proc)".

That is already broken. If nothing previous broke it, then 1/2 of this
series did.

The immediate executable to run for 'git-foo' && git_cmd = 0: 'git-foo'.
The immediate executable to run for 'foo' && git_cmd = 1: 'git'(!).

And one wants exec status for 'git-remote-foo', NOT for 'git'. Thus,
git_cmd must be 0 (at least without additional flags or flag values).
 
> For example, we might later want to use different $PATH only when running
> a git subcommand, and telling run_command() explicitly that we are running
> a git thing would help if you don't add "git-" to the command line and
> drop "proc->git_cmd = 1" in the caller like your patch does.

Well, that would require new flag (or git_cmd field value) to mean do direct
exec with gitexecdir in $PATH. Otherwise, you would either break this piece
of code, or it would be already broken (depending on value of git_cmd).

-Ilari
