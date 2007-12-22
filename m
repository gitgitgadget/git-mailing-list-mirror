From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Make git send-email accept $EDITOR with arguments
Date: Fri, 21 Dec 2007 17:05:06 -0800
Message-ID: <7vr6hf35fh.fsf@gitster.siamese.dyndns.org>
References: <7vd4sz4uii.fsf@gitster.siamese.dyndns.org>
	<1198284052-20590-1-git-send-email-hendeby@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, luciano@eurotux.com, git@vger.kernel.org
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 22 02:05:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5soG-0005Yl-7z
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 02:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbXLVBFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 20:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbXLVBFR
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 20:05:17 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62458 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbXLVBFP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 20:05:15 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CBDC05D20;
	Fri, 21 Dec 2007 20:05:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B7B05D02;
	Fri, 21 Dec 2007 20:05:08 -0500 (EST)
In-Reply-To: <1198284052-20590-1-git-send-email-hendeby@isy.liu.se> (Gustaf
	Hendeby's message of "Sat, 22 Dec 2007 01:40:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69115>

Gustaf Hendeby <hendeby@isy.liu.se> writes:

> Currently git send-email does not accept $EDITOR with arguments, eg,
> emacs -nw, when starting an editor to produce a cover letter.  This
> patch changes this by letting the shell handle the option parsing.
>
> Signed-off-by:  Gustaf Hendeby <hendeby@isy.liu.se>
> ---
>
> This is based on Junio's suggestion on most readable and compatible
> solution.  I'm not sure if it is identical to the C solution for git
> tag, but it seems to be a reasonable solution.
>
>  git-send-email.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 248d035..e47994a 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -400,7 +400,7 @@ EOT
>  	close(C);
>  
>  	my $editor = $ENV{GIT_EDITOR} || $repo->config("core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
> -	system($editor, $compose_filename);
> +	system('sh', '-c', '$0 $@', $editor, $compose_filename);
>  
>  	open(C2,">",$compose_filename . ".final")
>  		or die "Failed to open $compose_filename.final : " . $!;
> -- 
> 1.5.4.rc1.16.gc817f

Thanks.  Has this been tested?  IOW, did you compose this
message with this patch?
