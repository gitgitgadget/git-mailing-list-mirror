From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH] pretend_sha1_file(): Change return type from int to void
Date: Thu, 8 Oct 2015 09:45:26 +0200
Message-ID: <20151008074526.GD11304@distanz.ch>
References: <1444133704-29571-1-git-send-email-tklauser@distanz.ch>
 <632cbcf1dc9fa45ce71693a2cfae73e4@dscho.org>
 <20151006135101.GA11304@distanz.ch>
 <ef5b20ed42ea20b2891fc3998a81f339@dscho.org>
 <xmqqa8rutlu4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 09:45:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk5tO-0008HJ-9E
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 09:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092AbbJHHpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 03:45:31 -0400
Received: from sym2.noone.org ([178.63.92.236]:45199 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753037AbbJHHpa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 03:45:30 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3nWl201KZ6zQWhD; Thu,  8 Oct 2015 09:45:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqa8rutlu4.fsf@gitster.mtv.corp.google.com>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279219>

On 2015-10-07 at 23:22:59 +0200, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > As to the patch, I cannot speak for Junio, of course, but my
> > preference would be to keep the return type. Traditionally, functions
> > that can fail either die() or return an int; non-zero indicates an
> > error. In this case, it seems that we do not have any condition
> > (yet...) under which an error could occur. It does not seem very
> > unlikely that we may eventually have such conditions, though, hence my
> > preference.
> 
> Perhaps the attached is a better approach.
> 
> Even though the current implementation of "pretend" implementation
> does not, future generations are allowed to make pretend_sha1_file()
> return failure when appropriate.

For my original patch I didn't consider that pretend_sha1_file() might
return failure in the future. I was just confused by the fact that the
return value was seemingly useless (but now I realize that unused !=
useless ;-), sorry for the noise.

Please disregard my patch and apply yours instead, if you see fit.

> 
>  builtin/blame.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 203a981..fa24f8f 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2362,7 +2362,8 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
>  	convert_to_git(path, buf.buf, buf.len, &buf, 0);
>  	origin->file.ptr = buf.buf;
>  	origin->file.size = buf.len;
> -	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
> +	if (pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1))
> +		die("failed to create a fake commit for the working tree version.");
>  
>  	/*
>  	 * Read the current index, replace the path entry with
> 
