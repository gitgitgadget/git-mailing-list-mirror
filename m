From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] hash: Remove useless init_hash()
Date: Tue, 27 Jul 2010 03:30:00 -0700 (PDT)
Message-ID: <m3fwz5kykn.fsf@localhost.localdomain>
References: <1280208970-23394-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 12:30:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdhQK-0000sw-5N
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 12:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053Ab0G0KaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 06:30:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36672 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755772Ab0G0KaE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 06:30:04 -0400
Received: by bwz1 with SMTP id 1so3227053bwz.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 03:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=0hxF5fMo60gbf3RE/AZwtZXO0+MXVSkOnkJl2rODZj0=;
        b=CqdQPTGShsbgDB3sljmDHl2uAyQOb8Ty46XNiMEkOm5X3e8u+GywDo/IIQNnp5YUS0
         uKp7+O3fg/Dne2iJ2UXaZSsljYANGimXXWHtp7NYRapXhUma7nI4q+ErKPJ4M8SEL2BP
         AWKddDwzaQR8Z5jdsjdWY7njP2LWPzrYB+Ru0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=LuaSYbYJgIb354V8+MPTL5EZID/Hq7irLUPkodGQMtlX2fyMsXAmb50lJJLskZlH3E
         rOrKAXPIhNp8vbp+f58N+XyDWk2D6BWW+7itz1aiDD/+k+clscM70oLcxdTQ+h6K6oL6
         tkhw2AxFKiXy0aBks+O3kwm+jeBUaKcNx78yo=
Received: by 10.204.160.90 with SMTP id m26mr6628673bkx.45.1280226601393;
        Tue, 27 Jul 2010 03:30:01 -0700 (PDT)
Received: from localhost.localdomain (abwn25.neoplus.adsl.tpnet.pl [83.8.237.25])
        by mx.google.com with ESMTPS id o20sm3672856bkw.3.2010.07.27.03.29.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 03:30:00 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o6RATSW6027626;
	Tue, 27 Jul 2010 12:29:38 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o6RATDOu027616;
	Tue, 27 Jul 2010 12:29:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1280208970-23394-1-git-send-email-bebarino@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151929>

Stephen Boyd <bebarino@gmail.com> writes:

> init_hash() is essentially a memset() so just use that.
> 
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
[...]

Encapsulation is good.

> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index df41be5..b355520 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -382,7 +382,7 @@ static int find_exact_renames(void)
>  	int i;
>  	struct hash_table file_table;
>  
> -	init_hash(&file_table);
> +	memset(&file_table, 0, sizeof(file_table));

This is IMHO slightly less readable, and doesn't protect against
changes in implementation.

>  	for (i = 0; i < rename_src_nr; i++)
>  		insert_file_table(&file_table, -1, i, rename_src[i].one);
>  
> diff --git a/hash.h b/hash.h
> index 69e33a4..418be24 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -33,11 +33,4 @@ extern void **insert_hash(unsigned int hash, void *ptr, struct hash_table *table
>  extern int for_each_hash(const struct hash_table *table, int (*fn)(void *));
>  extern void free_hash(struct hash_table *table);
>  
> -static inline void init_hash(struct hash_table *table)
> -{
> -	table->size = 0;
> -	table->nr = 0;
> -	table->array = NULL;
> -}

*This* could be replaced by memset.

> -
>  #endif
> -- 
> 1.7.2.19.g9a302
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
