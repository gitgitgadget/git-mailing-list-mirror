From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-gui: remove .git/CHERRY_PICK_HEAD after
 committing
Date: Sat, 18 Aug 2012 13:28:12 -0700
Message-ID: <7vobm8rllv.fsf@alter.siamese.dyndns.org>
References: <1345280851-6626-1-git-send-email-bbolli@ewanet.ch>
 <1345280851-6626-2-git-send-email-bbolli@ewanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Beat Bolli <bbolli@ewanet.ch>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Aug 18 22:28:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2pd8-0003bs-22
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 22:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763Ab2HRU2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 16:28:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37396 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108Ab2HRU2O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 16:28:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D19395D5;
	Sat, 18 Aug 2012 16:28:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YUEUDIh7K9GBq0XlTBVUEHUkhVk=; b=RTrXUO
	ItL/go8pfs4kd21CQgUCfNjda5FIx+3jFL4iHacbET5ZmWAaZwUgduCFBAMPhDNE
	GInKymgoZU2+/dinimzrAPb63kx31ncH8CV6JQ8Ioc2Xw60Y9EuU1uKT44DapXJA
	afjX3rUJTlDvEfahqz6SAPuJJm9pKMlaNMxuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eX2YINcufd9meLjr5JjPoFrT6UBZW6nZ
	7IOwirvThnMqvZPZsqDFj/eQ/iynBh6jydoj7iitNX9pn18rPKyD56o7KhD1c+Lb
	oTwc3C+PsDrtCH30VGGbVnOkFdUg2DDQ0kCex3Cb2ttj36PtMlGNYLk2HMsjDqtY
	WHirJkctu/4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BA2A95D4;
	Sat, 18 Aug 2012 16:28:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C384795D2; Sat, 18 Aug 2012
 16:28:13 -0400 (EDT)
In-Reply-To: <1345280851-6626-2-git-send-email-bbolli@ewanet.ch> (Beat
 Bolli's message of "Sat, 18 Aug 2012 11:07:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C2F8D12-E973-11E1-BAE3-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203694>

Beat Bolli <bbolli@ewanet.ch> writes:

> Adding __git_ps1() to one's bash prompt displays various repo status
> info after each command. After committing a git cherry-pick -n using
> git-gui, the prompt still contains the "|CHERRY-PICKING" flag.
>
> Delete the file causing this flag when cleaning up.
>
> Signed-off-by: Beat Bolli <bbolli@ewanet.ch>
> ---
>  git-gui/lib/commit.tcl |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
> index 78c5eeb..864b687 100644
> --- a/git-gui/lib/commit.tcl
> +++ b/git-gui/lib/commit.tcl
> @@ -409,6 +409,7 @@ A rescan will be automatically started now.
>  	catch {file delete [gitdir MERGE_MSG]}
>  	catch {file delete [gitdir SQUASH_MSG]}
>  	catch {file delete [gitdir GITGUI_MSG]}
> +	catch {file delete [gitdir CHERRY_PICK_HEAD]}
>  
>  	# -- Let rerere do its thing.
>  	#

It makes me wonder if the above sequence of file delete should all
be removed and use "git commit" instead of "git commit-tree" in the
implementation of this Tcl procedure instead.

Pat?
