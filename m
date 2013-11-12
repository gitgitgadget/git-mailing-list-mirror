From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH v6 00/10] transport-helper: updates
Date: Tue, 12 Nov 2013 01:21:30 -0500
Message-ID: <5281C8EA.8030002@bbn.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com> <1384210507-26561-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 07:21:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg7M2-0003xX-8v
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 07:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062Ab3KLGVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 01:21:35 -0500
Received: from smtp.bbn.com ([128.33.0.80]:47573 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab3KLGVe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 01:21:34 -0500
Received: from socket.bbn.com ([192.1.120.102]:57720)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Vg7Lw-000MSf-Ft; Tue, 12 Nov 2013 01:21:32 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id D4FAE3FF72
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <1384210507-26561-2-git-send-email-felipe.contreras@gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237698>

On 2013-11-11 17:54, Felipe Contreras wrote:
> Hi,
> 
> Here are the patches that allow transport helpers to be completely transparent;
> renaming branches, deleting them, custom refspecs, --force, --dry-run,
> reporting forced update, everything works.
> 
> Small changes since v5:
> 
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 8ed41b4..4b76222 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -736,9 +736,10 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
>  		usage_with_options (fast_export_usage, options);
>  
>  	if (refspecs_list.nr) {
> -		const char *refspecs_str[refspecs_list.nr];
> +		const char **refspecs_str;
>  		int i;
>  
> +		refspecs_str = xmalloc(sizeof(*refspecs_str) * refspecs_list.nr);
>  		for (i = 0; i < refspecs_list.nr; i++)
>  			refspecs_str[i] = refspecs_list.items[i].string;
>  
> @@ -746,6 +747,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
>  		refspecs = parse_fetch_refspec(refspecs_nr, refspecs_str);
>  
>  		string_list_clear(&refspecs_list, 1);
> +		free(refspecs_str);
>  	}
>  
>  	if (use_done_feature)
> diff --git a/git-remote-testgit.sh b/git-remote-testgit.sh
> index 716aa4c..1c006a0 100755
> --- a/git-remote-testgit.sh
> +++ b/git-remote-testgit.sh
> @@ -15,6 +15,8 @@ test -z "$refspec" && prefix="refs"
>  
>  export GIT_DIR="$url/.git"
>  
> +force=
> +
>  mkdir -p "$dir"
>  
>  if test -z "$GIT_REMOTE_TESTGIT_NO_MARKS"

What about changing those two test-hg.sh tests to test_expect_success?

  http://article.gmane.org/gmane.comp.version-control.git/237606

Should those changes be squashed into the "transport-helper: don't
update refs in dry-run" and "transport-helper: add 'force' to 'export'
helpers" commits?  Or are those commits not really the appropriate place?

Thanks,
Richard
