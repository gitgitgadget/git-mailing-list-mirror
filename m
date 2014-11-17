From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 02/22] untracked cache: record .gitignore information
 and dir hierarchy
Date: Mon, 17 Nov 2014 15:35:28 -0500
Organization: Twitter
Message-ID: <1416256528.9065.14.camel@leckie>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
	 <1415439595-469-1-git-send-email-pclouds@gmail.com>
	 <1415439595-469-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 21:35:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqT1N-000826-Ej
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 21:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbaKQUfd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Nov 2014 15:35:33 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:41396 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbaKQUfc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 15:35:32 -0500
Received: by mail-qa0-f53.google.com with SMTP id n8so14993180qaq.40
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 12:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=YuPLzV7FakBDwni7blHf8G5NX1JeCDOCn9DHSjk159g=;
        b=WdMXd3rWDwXz3iMrkAguqdy5Grmnm07lw110b1MJrjUtMyj9oH1MMZUKrBNovfBsef
         wQWALjt/DGM/1rMliv6709MwYybfNtUoqYmmu0VyDcEUiyaFfiOr5MPVwtW6dvnCpLwL
         44B0mTiALfVXzWXgd7LMfd8DpDgzt7HCjQrgAvWTCRe1TUcde0OPmMsck+cIR+WLKbyk
         6lSg79U5JxicTdB5q9zMqv9Z2/bXSWyuYNzjqx5dEIYi7WoyYCSLUtIg3E5TctIPPxRO
         rAl/o4Mm3uoWOf+S/sDVa83tS4D6TsbaQ1cJ3RCL3iTLGNX617rTk3pI4zQ/ePGtGFfb
         NRMg==
X-Gm-Message-State: ALoCoQnWMbL0Mk8z7FE8WTf4Admv1gZ2WKgjbiTbafNb74+wKVvaGGS6OTpSjVJCi35OfRZQLvMk
X-Received: by 10.224.73.202 with SMTP id r10mr37834494qaj.58.1416256531890;
        Mon, 17 Nov 2014 12:35:31 -0800 (PST)
Received: from [172.18.25.176] ([8.25.196.25])
        by mx.google.com with ESMTPSA id b20sm5772139qaw.3.2014.11.17.12.35.30
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 12:35:31 -0800 (PST)
In-Reply-To: <1415439595-469-3-git-send-email-pclouds@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2014-11-08 at 16:39 +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy wrote:
> +	d =3D xmalloc(sizeof(*d) + len);
> +	memset(d, 0, sizeof(*d) + len);
>+	memcpy(d->name, name, len);

calloc instead of malloc+memset?  But do we really need this memset to
include name if we're about to use a memcpy? Couldn't we just add a
trailing zero?

> + *   - The list of files and directories of the direction in questio=
n

s/direction/directory/

> +struct untracked_cache_dir {
> +	struct untracked_cache_dir **dirs;
> +	char **untracked;
> +	struct stat_data stat_data;
> +	unsigned int untracked_alloc, dirs_nr, dirs_alloc;
> +	unsigned int untracked_nr;
> +	unsigned int check_only : 1;
> +	/* null SHA-1 means this directory does not have .gitignore */
> +	unsigned char exclude_sha1[20];
> +	char name[1];

=46or consistency, should this be char name[FLEX_ARRAY]? (this will ent=
ail
some changes when allocating these, of course)
