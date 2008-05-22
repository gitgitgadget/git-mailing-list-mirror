From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make creation of pack/pack-*.keep obey the umask
Date: Wed, 21 May 2008 19:02:02 -0700
Message-ID: <7v1w3vxfj9.fsf@gitster.siamese.dyndns.org>
References: <20080507172548.GI24525@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 04:03:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jz096-0003wf-2m
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 04:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481AbYEVCCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 22:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754860AbYEVCCR
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 22:02:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47694 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754109AbYEVCCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 22:02:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EACAE39EE;
	Wed, 21 May 2008 22:02:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 12A7139E5; Wed, 21 May 2008 22:02:09 -0400 (EDT)
In-Reply-To: <20080507172548.GI24525@obsidianresearch.com> (Jason Gunthorpe's
 message of "Wed, 7 May 2008 11:25:48 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 195A682A-27A3-11DD-B22B-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82600>

Last night I was going through old mail-logs and found this , which I
think is still needed.  Does anybody see anything wrong with them?

Jason Gunthorpe <jgunthorpe@obsidianresearch.com> writes:

> Prevents git clone from complaining on shared repositories
>
> Initialized empty Git repository in /tmp/src/.git/
> cpio: objects/pack/pack-601efa4cfe63e081c0591b463549aeba3f7c6164.keep: Cannot open: Permission denied
> 3376 blocks
>
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>
> I'm uncertain if the keep files should be sticking around for so long,
> commit b8077709 makes it sounds like they are shorted lived lock
> files. In the case I have the keep file contains:
>
> fetch-pack 20810 on bertha1
>
> But, I don't see anything in fetch-pack to erase the keep file.. In
> any event making the file the same permissions as everything else
> can't hurt.
>
>  index-pack.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/index-pack.c b/index-pack.c
> index 9c0c278..eb19e98 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -707,7 +707,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
>  				 get_object_directory(), sha1_to_hex(sha1));
>  			keep_name = name;
>  		}
> -		keep_fd = open(keep_name, O_RDWR|O_CREAT|O_EXCL, 0600);
> +		keep_fd = open(keep_name, O_RDWR|O_CREAT|O_EXCL, 0666);
>  		if (keep_fd < 0) {
>  			if (errno != EEXIST)
>  				die("cannot write keep file");
> -- 
> 1.5.4.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
