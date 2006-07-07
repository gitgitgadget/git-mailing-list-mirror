From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff.c: respect diff.renames config option
Date: Fri, 07 Jul 2006 03:22:35 -0700
Message-ID: <7v7j2p3eac.fsf@assigned-by-dhcp.cox.net>
References: <11522670452824-git-send-email-normalperson@yhbt.net>
	<11522670473116-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 12:22:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FynTs-0004MV-SU
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 12:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWGGKWh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 06:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWGGKWh
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 06:22:37 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:10151 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932118AbWGGKWh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 06:22:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060707102236.NHDD22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Jul 2006 06:22:36 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <11522670473116-git-send-email-normalperson@yhbt.net> (Eric
	Wong's message of "Fri, 07 Jul 2006 03:10:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23420>

Eric Wong <normalperson@yhbt.net> writes:

> diff.renames is mentioned several times in the documentation,
> but to my surprise it didn't do anything before this patch.

I am really reluctant to do this at this low-level, especially
since there is no way to defeat the settings from the command
line.

> @@ -120,6 +121,16 @@ int git_diff_config(const char *var, con
>  			diff_use_color_default = git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "diff.renames")) {
> +		if (!value)
> +			diff_detect_rename_default = DIFF_DETECT_RENAME;
> +		else if (!strcasecmp(value, "copies") ||
> +			 !strcasecmp(value, "copy"))
> +			diff_detect_rename_default = DIFF_DETECT_COPY;
> +		else
> +			diff_detect_rename_default = git_config_bool(var,value);
> +		return 0;
> +	}

I suspect this works only because DIFF_DETECT_RENAME happens to
be 1?
