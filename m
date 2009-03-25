From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] Add option for using a foreign VCS
Date: Tue, 24 Mar 2009 23:49:38 -0700
Message-ID: <7v1vsm9jwd.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0903242303330.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 07:51:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmMxI-0001Wo-FQ
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 07:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755656AbZCYGtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 02:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754928AbZCYGtq
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 02:49:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37942 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000AbZCYGtq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 02:49:46 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A3AABA4D80;
	Wed, 25 Mar 2009 02:49:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 22F79A4D7E; Wed,
 25 Mar 2009 02:49:39 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0903242303330.19665@iabervon.org> (Daniel
 Barkalow's message of "Tue, 24 Mar 2009 23:04:12 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1F1DCFCE-1909-11DE-9D9C-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114571>

Daniel Barkalow <barkalow@iabervon.org> writes:

> This simply configures the remote to use a transport that doesn't have
> any methods at all and is therefore unable to do anything yet.
>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
>  Documentation/config.txt |    4 ++++
>  remote.c                 |    2 ++
>  remote.h                 |    2 ++
>  transport.c              |    3 ++-
>  4 files changed, 10 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 089569a..14b0e07 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1305,6 +1305,10 @@ remote.<name>.tagopt::
>  	Setting this value to \--no-tags disables automatic tag following when
>  	fetching from remote <name>
>  
> +remote.<name>.vcs::
> +	Setting this to a value <vcs> will cause git to interact with
> +	the remote with the git-vcs-<vcs> helper.
> +

Nice.

> diff --git a/remote.h b/remote.h
> index de3d21b..e77dc1b 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -11,6 +11,8 @@ struct remote {
>  	const char *name;
>  	int origin;
>  
> +	const char *foreign_vcs;
> +
>  	const char **url;
>  	int url_nr;
>  	int url_alloc;

What are these extra blank lines for?  Isn't it pretty much part of the
URL group that immediately follows it?

> diff --git a/transport.c b/transport.c
> index 26c578e..8a37db5 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -939,7 +939,8 @@ struct transport *transport_get(struct remote *remote, const char *url)
>  	ret->remote = remote;
>  	ret->url = url;
>  
> -	if (!prefixcmp(url, "rsync:")) {
> +	if (remote && remote->foreign_vcs) {
> +	} else if (!prefixcmp(url, "rsync:")) {

	if (...) {
        	; /* empty */
	} else ...

>  		ret->get_refs_list = get_refs_via_rsync;
>  		ret->fetch = fetch_objs_via_rsync;
>  		ret->push = rsync_transport_push;
> -- 
> 1.6.2.1.476.g9bf04b
