From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 1/2] sequencer: trivial fix
Date: Tue, 28 May 2013 07:00:14 -0400
Message-ID: <20130528110014.GA1264@hmsreliant.think-freely.org>
References: <1369673539-28692-1-git-send-email-felipe.contreras@gmail.com>
 <1369673539-28692-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 13:00:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhHdp-0005qK-63
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 13:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758713Ab3E1LA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 07:00:28 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:47570 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757782Ab3E1LAY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 07:00:24 -0400
Received: from 99-127-245-201.lightspeed.rlghnc.sbcglobal.net ([99.127.245.201] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1UhHdY-0004vQ-EQ; Tue, 28 May 2013 07:00:22 -0400
Content-Disposition: inline
In-Reply-To: <1369673539-28692-2-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225628>

On Mon, May 27, 2013 at 11:52:18AM -0500, Felipe Contreras wrote:
> We should free objects before leaving.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  sequencer.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index ab6f8a7..7eeae2f 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -626,12 +626,15 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>  		rerere(opts->allow_rerere_auto);
>  	} else {
>  		int allow = allow_empty(opts, commit);
> -		if (allow < 0)
> -			return allow;
> +		if (allow < 0) {
> +			res = allow;
> +			goto leave;
> +		}
>  		if (!opts->no_commit)
>  			res = run_git_commit(defmsg, opts, allow);
>  	}
>  
> +leave:
>  	free_message(&msg);
>  	free(defmsg);
>  
> -- 
> 1.8.3.rc3.312.g47657de
> 
> 
Acked-by: Neil Horman <nhorman@tuxdriver.com>
