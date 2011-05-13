From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/8] revert: Make "commit" and "me" local variables
Date: Fri, 13 May 2011 17:40:49 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1105131715240.6881@iabervon.org>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com> <1305100822-20470-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 23:40:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QL06S-000614-Fz
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 23:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756605Ab1EMVkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 17:40:51 -0400
Received: from iabervon.org ([66.92.72.58]:35498 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978Ab1EMVku (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 17:40:50 -0400
Received: (qmail 17772 invoked by uid 1000); 13 May 2011 21:40:49 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 May 2011 21:40:49 -0000
In-Reply-To: <1305100822-20470-3-git-send-email-artagnon@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173568>

On Wed, 11 May 2011, Ramkumar Ramachandra wrote:

> @@ -583,10 +589,12 @@ static int read_and_refresh_cache(const char *me)
>  static int revert_or_cherry_pick(int argc, const char **argv)
>  {
>  	struct rev_info revs;
> +	struct commit *commit;
> +	const char *me;
>  	int res;
>  
>  	git_config(git_default_config, NULL);
> -	me = action == REVERT ? "revert" : "cherry-pick";
> +	me = (action == REVERT ? "revert" : "cherry-pick");
>  	setenv(GIT_REFLOG_ACTION, me, 0);
>  	parse_args(argc, argv);

Later in the series, you remove everything related to "me" that you add 
here, having modified it once in the middle. Just go to

	setenv(GIT_REFLOG_ACTION, action == REVERT ? "revert" : "cherry-pick");

and remove "me" from this function in this patch. For that matter, 
squashing together the "opts" patch and this one would probably make them 
make more sense: there's not much benefit to getting rid of some globals 
when other globals remain that matter for the same reason. It also fixes 
the annoyance that each place you introduce "me" in this patch needs to be 
changed later in the series.

	-Daniel
*This .sig left intentionally blank*
