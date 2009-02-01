From: Johan Herland <johan@herland.net>
Subject: Re: [RFC PATCH 3/3] Support fetching from foreign VCSes
Date: Sun, 01 Feb 2009 03:20:28 +0100
Message-ID: <200902010320.28128.johan@herland.net>
References: <alpine.LNX.1.00.0901110335520.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Feb 01 04:22:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTSuZ-0005dK-9F
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 04:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104AbZBADUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 22:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752983AbZBADUu
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 22:20:50 -0500
Received: from mx.getmail.no ([84.208.15.66]:60908 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752890AbZBADUt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Jan 2009 22:20:49 -0500
X-Greylist: delayed 3602 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Jan 2009 22:20:49 EST
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KED00NUW7UK1D40@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 01 Feb 2009 03:20:46 +0100 (MET)
Received: from alpha.herland ([84.215.102.95]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KED00IZE7U4HVB0@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 01 Feb 2009 03:20:44 +0100 (MET)
X-PMX-Version: 5.5.0.356843, Antispam-Engine: 2.6.1.350677,
 Antispam-Data: 2009.2.1.20719
User-Agent: KMail/1.9.9
In-reply-to: <alpine.LNX.1.00.0901110335520.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107976>

On Sunday 11 January 2009, Daniel Barkalow wrote:
> This supports a useful subset of the usual fetch logic, mostly in the
> config file.

Hi,

I love the idea of this patch series, and have started working on a CVS 
backend for this. I have a question though...

> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
>  builtin-fetch.c |  135
> +++++++++++++++++++++++++++++++++++++++++++++++++++++- 1 files changed,
> 132 insertions(+), 3 deletions(-)
>
> diff --git a/builtin-fetch.c b/builtin-fetch.c
> index 7b46f8f..14e037e 100644
> --- a/builtin-fetch.c
> +++ b/builtin-fetch.c
> @@ -614,6 +614,136 @@ static void set_option(const char *name, const char
> *value) name, transport->url);
>  }
>
> +static struct ref *list_foreign(struct remote *remote)
> +{

[...]

> +}
> +
> +static int import_foreign(struct remote *remote, struct ref *refs)
> +{

[...]

> +}
> +
> +static int fetch_foreign(struct remote *remote)
> +{
> +	struct ref *remote_refs = list_foreign(remote);

We retrieve a list of all refs available at the given remote...

> +	struct ref *ref_map = NULL;
> +	struct ref *rm;
> +	struct ref **tail = &ref_map;
> +	struct branch *branch;
> +	int i;
> +
> +	int exit_code = import_foreign(remote, remote_refs);

...and then we start fetching _all_ the refs returned by list_foreign().

When I call "git fetch <vcs-remote> <ref>", I expect _only_ <ref> to be 
fetched from the remote, but it seems the above code doesn't even concern 
itself with the ref(s) specified on the "git fetch" command-line

I'm not even sure why list_foreign() should be called in this case (except, 
maybe, to verify the existence of <ref> before attempting to fetch it).

AFAICS list_foreign() is only needed by "git fetch" if <ref> contains a 
wildcard (like the default refspec: +refs/heads/*:refs/remotes/<remote>/*).

...or have I misunderstood something fundamental about how this is going to 
work?


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
