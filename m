From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Tue, 3 Jun 2008 06:28:49 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806030627440.13507@racer.site.net>
References: <200806030314.03252.jnareb@gmail.com> <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org> <7v3anv5fy3.fsf@gitster.siamese.dyndns.org> <7vskvv3xmx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 07:31:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3P71-0001ma-AX
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 07:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537AbYFCF37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 01:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbYFCF37
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 01:29:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:43466 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755520AbYFCF36 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 01:29:58 -0400
Received: (qmail invoked by alias); 03 Jun 2008 05:29:55 -0000
Received: from unknown (EHLO none.local) [128.177.17.254]
  by mail.gmx.net (mp006) with SMTP; 03 Jun 2008 07:29:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195ZlMPDv95smfwXFDq0+nJEO3izkq6oDAwNwJJ+T
	15yMXEVPzNRVRu
X-X-Sender: gene099@racer.site.net
In-Reply-To: <7vskvv3xmx.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83616>

Hi,

On Mon, 2 Jun 2008, Junio C Hamano wrote:

> diff --git a/builtin-commit.c b/builtin-commit.c
> index b294c1f..1d8d208 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -883,10 +883,19 @@ static void add_parent(struct strbuf *sb, const unsigned char *sha1)
>  {
>  	struct object *obj = parse_object(sha1);
>  	const char *parent = sha1_to_hex(sha1);
> +	const char *cp;
> +
>  	if (!obj)
>  		die("Unable to find commit parent %s", parent);
>  	if (obj->type != OBJ_COMMIT)
>  		die("Parent %s isn't a proper commit", parent);
> +	cp = strstr(sb->buf, parent);
> +	if (cp &&
> +	    sb->buf + 8 <= cp && !memcmp(cp - 8, "\nparent ", 8) &&
> +	    cp[40] == '\n') {
> +		error("duplicate parent %s ignored", parent);
> +		return;
> +	}

Would it not be better (simpler, cleaner) to just use an object flag?

Ciao,
Dscho
