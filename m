From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 5/7] http: init and cleanup separately from http-walker
Date: Sun, 21 Feb 2010 11:38:20 +0100
Message-ID: <20100221103820.GA5166@localhost>
References: <1266721708-1060-1-git-send-email-rctay89@gmail.com>
 <1266721708-1060-6-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Mike Hommey <mh@glandium.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 13:09:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj9Cq-0006Fn-0K
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 11:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444Ab0BUKi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2010 05:38:27 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:45475 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755040Ab0BUKi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 05:38:26 -0500
Received: by fxm5 with SMTP id 5so1540231fxm.29
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 02:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=xeUBEjqgG5E3X3BknAQbu43vI5IWSjsR1MxW1KAHHzU=;
        b=H2k9pkF2Si99Sy+04s3ZWw9LRqJBnuoCvIOkOHiFMrYbB8I1Jd9bs1HvfjXTeYNk2C
         x+l3qx/UlMCup/kclIfpEagAVA9kKDrkXdDw9bRffoC5Ih9r5bgpi8FzBsf+XqtgHWkj
         xsO+kF7jgyZXukNAo7/1+lUTbbcslQmjBQ+U8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=aHeCgDuaCZXOXShKzp+tZXSvfzNMaUFq+aPIpm1IUNF4iKZ8oR/MS87QJd4m+0KILk
         0sj/XTT1LykeGfe3yizFws8NE3QWFDho53/j8aW9iFKrFX1scftnEomsIKba967oDL7/
         zw48NeVX6+iZnZrloq0VZTJidCMZU84Q5QOQk=
Received: by 10.102.255.25 with SMTP id c25mr1538888mui.80.1266748704692;
        Sun, 21 Feb 2010 02:38:24 -0800 (PST)
Received: from darc.lan (p549A7DE9.dip.t-dialin.net [84.154.125.233])
        by mx.google.com with ESMTPS id n10sm9694814mue.14.2010.02.21.02.38.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Feb 2010 02:38:23 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1Nj9Ce-0001nE-Ho; Sun, 21 Feb 2010 11:38:20 +0100
Content-Disposition: inline
In-Reply-To: <1266721708-1060-6-git-send-email-rctay89@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140610>

On Sun, Feb 21, 2010 at 11:08:26AM +0800, Tay Ray Chuan wrote:
> diff --git a/http-fetch.c b/http-fetch.c
[...]
> @@ -69,7 +70,8 @@ int main(int argc, const char **argv)
>  		url = rewritten_url;
>  	}
>  
> -	walker = get_http_walker(url, NULL);
> +	http_init(NULL);
> +	walker = get_http_walker(url);
>  	walker->get_tree = get_tree;
>  	walker->get_history = get_history;
>  	walker->get_all = get_all;

You changed the order of get_http_walker and http_init. But

        add_fill_function(walker, (int (*)(void *)) fill_active_slot);

already deals with curl functionality. So even though I think it technically
doesn't break, I would prefer if this dependency were still expressed in the
code.

> @@ -88,6 +90,7 @@ int main(int argc, const char **argv)
>  "status code.  Suggest running 'git fsck'.\n");
>  	}
>  
> +	http_cleanup();
>  	walker_free(walker);
>  
>  	free(rewritten_url);

Same as above.

Otherwise the series looks good to me.

Liked-by: Clemens Buchacher <drizzd@aon.at>

Clemens
