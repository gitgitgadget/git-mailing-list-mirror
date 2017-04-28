Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 492971FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 09:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424440AbdD1J7p (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 05:59:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:56647 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424383AbdD1J7o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 05:59:44 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDm4o-1dK1GX0LWg-00H70D; Fri, 28
 Apr 2017 11:59:39 +0200
Date:   Fri, 28 Apr 2017 11:59:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 11/26] cat-file: fix memory leak
In-Reply-To: <xmqqo9vimldf.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704281155520.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <a1381df96c940f1edf5b7fb0c49abfc7b12b72fa.1493237937.git.johannes.schindelin@gmx.de> <xmqqo9vimldf.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kuuJAowA6Zyu9iaO73JpSzzXZakGEYaiBNR8Xg6j8qCgOo57pZU
 1THYNTCwmbrJ4xX2+3k+SrCEyT5lDpFfSwHugSXzWNY/3pSm6NkGXA97unB1wwvCegU8yoL
 eMB1+NXRzDKiDlIr0TIg9zJcelr3H9iTm3ws+8pBaGBdGIVIvIMD/sZrU0e3Ut6nje3j8qL
 SzDYU3/HRKxsivJu6dmgA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Dnw+cyXqdCs=:oBdOcV3Wmhi2FlmNkfPEZw
 wPHDkDtBl5w8ZJW5zzWrNIMECR3HYngeMh0jm2martsmZb2RaoSWGbjl+llzHHjXWgXA6CRJt
 FJiAZjTcK54vTKNUPHoIeKDBnSjBrr49PkgmXnB7Z6MIJARRlCcJaO7bAyEKeQ1sKU9iSDfwz
 Mia0uZozk29UWb/UFZaiGSe7WnsMJEw/AOOWmGKfOciRQljRw3NQVfFTGtOex6g6aeVgpq68D
 +l9q0cBdsrOrWnDaVTEo7pziZzBwCkjUbwN2//JBa9sqgr3pPpL+MCqr4MqzizNXLuZR2UPVf
 UrA2xuZOivEpBRsrkfVt+jBYh7KZBw0NOhTKsDm80ERnDk0l1A6iIJzUW/WkKiSySKgaqSLDY
 qar32FU2rs3MJcJNDxTOuXShl52ehFkjOAzz+zBHD2ZOPb0mMgdv8ZzxkrQVfMmypIUL8zrEp
 M6DbFC9C/wy9nkjeTLdhUrEJ03CwuY3AnZ1SY+8lAnhpRMEbQRBYpZb4svYC/bVyfnHEo63Fa
 UJfbuDrjXo+qzipx2WyMnqG9twKy7n9UP9jrf24mZj4IT7JuMOq64O2kJm0/vePNG500qc4jG
 66IW+Fq3KkMloW72MaOJLFvRRnZ8KaMIIA5gy7dsiQEoe6228cuQU4beKzYGLjGDigfQXRy3U
 WHCZ8Gb1dK2DQDyQBJ5au8sYGn15LmHHw7EV5gr37h2H+iFTVGSJgrNDzTgUZXVCxk1QZ6V+S
 dSq6EAUbpozdeObwa5FcGE5D+ia8/IhH2lbfyCKKoXe4zryig2VQdLzapWvNBHj7WvqRuLSMF
 U4fJYGQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 26 Apr 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Discovered by Coverity.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/cat-file.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index 1890d7a6390..9af863e7915 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -165,6 +165,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
> >  		die("git cat-file %s: bad file", obj_name);
> >  
> >  	write_or_die(1, buf, size);
> > +	free(buf);
> >  	return 0;
> >  }
> 
> This is a border-line "Meh".  Just like we do not free resources
> immediately before calling die(), we can leave this as-is as the
> only thing that happens after this is a return from cmd_cat_file()
> back to main() that exits.

If you are mostly concerned about the status quo, that is true.

I am a lot more concerned with future changes, where we may easily decide
that it is time to move a file-local function out of its hiding place and
make it more usable.

From that perspective, it is one thing to have a blatant memory leak in a
cmd_*() function, and it is an entirely different matter to have such a
leak in a function that happens to be called only from cmd_*() functions:
somebody familiar enough with Git's coding conventions (such as myself)
will *expect* cmd_*() to have leaks left and right and pay attention when
libifying that code, but be a lot less concerned about such leaks in other
functions.

And of course this concerns me more than you, as I am still trying to
drive forward the effort to convert more scripts into builtins.

So on my own behalf: thank you for accepting this patch.

Ciao,
Dscho
