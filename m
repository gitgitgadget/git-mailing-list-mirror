From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] sha1_file: add function to insert alternate object
 db
Date: Sun, 18 Jan 2009 16:32:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901181629590.3586@pacific.mpi-cbg.de>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com> <1232275999-14852-2-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 16:33:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZer-0004XB-Lz
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 16:33:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765438AbZARPca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 10:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765189AbZARPc3
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 10:32:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:57224 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764791AbZARPc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 10:32:28 -0500
Received: (qmail invoked by alias); 18 Jan 2009 15:32:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp033) with SMTP; 18 Jan 2009 16:32:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jr3NdcehjIxuOmKr0HN2UtciCLEs1z/KcnuKzg2
	hzvWCN6fLBHvLD
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232275999-14852-2-git-send-email-hjemli@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106226>

Hi,

On Sun, 18 Jan 2009, Lars Hjemli wrote:

> diff --git a/cache.h b/cache.h
> index 8e1af26..daa2d4e 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -724,6 +724,7 @@ extern struct alternate_object_database {
>  	char base[FLEX_ARRAY]; /* more */
>  } *alt_odb_list;
>  extern void prepare_alt_odb(void);
> +extern int add_alt_odb(const char *path);
>  extern void add_to_alternates_file(const char *reference);
>  typedef int alt_odb_fn(struct alternate_object_database *, void *);
>  extern void foreach_alt_odb(alt_odb_fn, void*);
> diff --git a/sha1_file.c b/sha1_file.c
> index f08493f..19f9725 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -356,6 +356,11 @@ static void link_alt_odb_entries(const char *alt, const char *ep, int sep,
>  	}
>  }
>  
> +int add_alt_odb(const char *path)
> +{
> +	return link_alt_odb_entry(path, strlen(path), NULL, 0);

This function can return the error message "object directory %s does not 
exist; check .git/objects/info/alternates."  Maybe you want to change 
that, even if the user you are introducing might not hit that code path.

Ciao,
Dscho
