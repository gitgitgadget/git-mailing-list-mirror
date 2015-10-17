From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v2 2/4] stripspace: Use parse-options for command-line
 parsing
Date: Sat, 17 Oct 2015 12:31:35 +0200
Message-ID: <20151017103134.GD2468@distanz.ch>
References: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
 <1445008605-16534-3-git-send-email-tklauser@distanz.ch>
 <xmqqoafyg2sp.fsf@gitster.mtv.corp.google.com>
 <xmqqd1weg1s0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 12:31:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnOm5-0000gE-T1
	for gcvg-git-2@plane.gmane.org; Sat, 17 Oct 2015 12:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbbJQKbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2015 06:31:38 -0400
Received: from sym2.noone.org ([178.63.92.236]:54759 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbbJQKbh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2015 06:31:37 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3ndLHX4kT6zQWhr; Sat, 17 Oct 2015 12:31:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqd1weg1s0.fsf@gitster.mtv.corp.google.com>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279784>

On 2015-10-16 at 19:29:35 +0200, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> -	if (mode == INVAL)
> >> -		usage(usage_msg);
> >
> > When given "git stripspace -s blorg", we used to set mode to INVAL
> > and then showed the correct usage.  But we no longer have a check
> > that corresponds to the old INVAL thing, do we?  Perhaps check argc
> > to detect presence of an otherwise ignored non-option argument
> > immediately after parse_options() returns?
> 
> Perhaps like this.

Thanks. I'll fold it into v3.

> diff --git a/builtin/stripspace.c b/builtin/stripspace.c
> index ac1ab3d..a8b7a93 100644
> --- a/builtin/stripspace.c
> +++ b/builtin/stripspace.c
> @@ -40,8 +40,9 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
>  		OPT_END()
>  	};
>  
> -	argc = parse_options(argc, argv, prefix, options, stripspace_usage,
> -			     PARSE_OPT_KEEP_DASHDASH);
> +	argc = parse_options(argc, argv, prefix, options, stripspace_usage, 0);
> +	if (argc)
> +		usage_with_options(stripspace_usage, options);
>  
>  	if (mode == STRIP_COMMENTS || mode == COMMENT_LINES)
>  		git_config(git_default_config, NULL);
> 
