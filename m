From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v6 07/13] notes: implement 'git notes copy --stdin'
Date: Thu, 11 Mar 2010 11:30:41 +0100
Message-ID: <201003111130.42095.johan@herland.net>
References: <cover.1268229087.git.trast@student.ethz.ch>
 <a6795d8aa8dd21236cca0fc61e55d3d306465e62.1268229087.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 11 11:30:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpffH-00046f-Iw
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 11:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619Ab0CKKaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 05:30:46 -0500
Received: from smtp.getmail.no ([84.208.15.66]:52563 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754174Ab0CKKap (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 05:30:45 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KZ400G3G578RU10@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 11 Mar 2010 11:30:44 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KZ400FIC576A920@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 11 Mar 2010 11:30:44 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.3.11.102129
User-Agent: KMail/1.13.1 (Linux/2.6.32-ARCH; KDE/4.4.1; x86_64; ; )
In-reply-to: <a6795d8aa8dd21236cca0fc61e55d3d306465e62.1268229087.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141947>

On Wednesday 10 March 2010, Thomas Rast wrote:
> This implements a mass-copy command that takes a sequence of lines in
> the format
> 
>   <from-sha1> SP <to-sha1> [ SP <rest> ] LF
> 
> on stdin, and copies each <from-sha1>'s notes to the <to-sha1>.  The
> <rest> is ignored.  The intent, of course, is that this can read the
> same input that the 'post-rewrite' hook gets.
> 
> The copy_note() function is exposed for everyone's and in particular
> the next commit's use.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

Acked-by: Johan Herland <johan@herland.net>

> ---
> 
> Changes since v5
> * don't remove note we know doesn't exist

[...]

> diff --git a/notes.c b/notes.c
> index 0d4b892..b1b15e9 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -1189,3 +1189,22 @@ void format_display_notes(const unsigned char
> *object_sha1, format_note(display_notes_trees[i], object_sha1, sb,
>  			    output_encoding, flags);
>  }
> +
> +int copy_note(struct notes_tree *t,
> +	      const unsigned char *from_obj, const unsigned char *to_obj,
> +	      int force, combine_notes_fn combine_fn)
> +{
> +	const unsigned char *note = get_note(t, from_obj);
> +	const unsigned char *existing_note = get_note(t, to_obj);
> +
> +	if (!force && existing_note)
> +		return 1;
> +
> +	if (note)
> +		add_note(t, to_obj, note, combine_fn);
> +	else if (existing_note) {
> +		add_note(t, to_obj, null_sha1, combine_fn);
> +	}

You might want to lose the braces around the second add_note().


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
