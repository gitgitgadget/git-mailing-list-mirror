From: Matthias Kestenholz <lists@irregular.ch>
Subject: Re: Bug encountered while comitting
Date: Sat, 25 Mar 2006 11:23:15 +0100
Message-ID: <20060325102314.GA3825@spinlock.ch>
References: <20060324183951.GA23193@spinlock.ch> <7vacbfzc3u.fsf@assigned-by-dhcp.cox.net> <20060325011527.GA23600@spinlock.ch> <7vwtejxd3u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 25 11:23:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN5vr-0006Ne-0k
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 11:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWCYKXk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 05:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWCYKXk
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 05:23:40 -0500
Received: from mail20.bluewin.ch ([195.186.19.65]:44487 "EHLO
	mail20.bluewin.ch") by vger.kernel.org with ESMTP id S1750809AbWCYKXk
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 05:23:40 -0500
Received: from spinlock.ch (83.77.185.119) by mail20.bluewin.ch (Bluewin 7.2.071)
        id 441EA2F900120C11; Sat, 25 Mar 2006 10:23:25 +0000
Received: (nullmailer pid 10688 invoked by uid 1000);
	Sat, 25 Mar 2006 10:23:15 -0000
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vwtejxd3u.fsf@assigned-by-dhcp.cox.net>
X-Editor: Vim http://www.vim.org/
X-Operating-System: GNU/Linux 2.6.16-rc6 (i686)
X-GPG-Fingerprint: 249B 3CE7 E6AE 4A1F F24A  DC44 B546 3304 690B 13F9
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17972>

* Junio C Hamano (junkio@cox.net) wrote:
> You are right.  commit-tree does not seem to check if it
> successfully wrote the commit object.  How about this?
> 
> -- >8 --
> diff --git a/commit-tree.c b/commit-tree.c
> index 88871b0..16c1787 100644
> --- a/commit-tree.c
> +++ b/commit-tree.c
> @@ -125,7 +125,10 @@ int main(int argc, char **argv)
>  	while (fgets(comment, sizeof(comment), stdin) != NULL)
>  		add_buffer(&buffer, &size, "%s", comment);
>  
> -	write_sha1_file(buffer, size, "commit", commit_sha1);
> -	printf("%s\n", sha1_to_hex(commit_sha1));
> -	return 0;
> +	if (!write_sha1_file(buffer, size, "commit", commit_sha1)) {
> +		printf("%s\n", sha1_to_hex(commit_sha1));
> +		return 0;
> +	}
> +	else
> +		return 1;
>  }

This patch fixes the problem I was encountering (git-update-ref is
not executed anymore).

Thank you all for this really great tool!


-- 
:wq
