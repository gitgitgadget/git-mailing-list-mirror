From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] add: warn when -u or -A is used without filepattern
Date: Sun, 27 Jan 2013 04:22:26 -0800
Message-ID: <20130127122226.GB7670@elie.Belkin>
References: <vpq1uddoedj.fsf@grenoble-inp.fr>
 <1359110978-20054-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Jan 27 13:22:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzRG9-0004t6-RD
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 13:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756651Ab3A0MWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 07:22:33 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:37410 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756639Ab3A0MWc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 07:22:32 -0500
Received: by mail-pb0-f49.google.com with SMTP id xa12so972580pbc.8
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 04:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Yj5TXOLG/RVaSvA03AGfwA9cWep3N8ilKYhJZQ1GZs4=;
        b=y+mpjEIr4zWgUHVVMF8SfUKfzV3a3clR20OLPRerVAAAR688jkBNyBfVes1AhuTaag
         jC5Sbo5HrqG4bGslAN/Eliyj95M1Glr4pDcOF+CsFUll1LeqeZavPZRqy6N16f5tplaG
         gl4mhqZrkq5z08Mien16s0nVhgfH7nz+wsgA69c1H3CiXqhHEB6+/B9EeQsYnZh4HkJL
         qVmAmX/fjodLqdgwcX/G0C5OIx8md2r/Ku2aFYeEXSt0+QIFExP7uDjdG79mivV91dSl
         NfDzt5RG7WWuQW1sjloEzvCM5ICnKOJpzclahLjIeIGGVP1DnW2Ybl2g9G3NQfUPH9T+
         eSJA==
X-Received: by 10.68.230.103 with SMTP id sx7mr29458741pbc.19.1359289351728;
        Sun, 27 Jan 2013 04:22:31 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id na7sm4299835pbc.48.2013.01.27.04.22.29
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 04:22:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359110978-20054-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214694>

Hi Matthieu,

Matthieu Moy wrote:

> --- a/builtin/add.c
> +++ b/builtin/add.c
[...]
> @@ -392,8 +420,14 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  		die(_("-A and -u are mutually incompatible"));
>  	if (!show_only && ignore_missing)
>  		die(_("Option --ignore-missing can only be used together with --dry-run"));
> -	if ((addremove || take_worktree_changes) && !argc) {
> +	if (addremove)
> +		option_with_implicit_dot = "--all";
> +	if (take_worktree_changes)
> +		option_with_implicit_dot = "--update";

I agree with Junio that these are most often spelled as "-A" and "-u".

> +	if (option_with_implicit_dot && !argc) {
>  		static const char *here[2] = { ".", NULL };
> +		if (prefix)
> +			warn_pathless_add(option_with_implicit_dot);

For what it's worth, with or without s/--all/-A/ and s/--update/-u/,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.  If someone wants to preserve the spelling of the option name
passed by the user, that can happen as a patch on top.
