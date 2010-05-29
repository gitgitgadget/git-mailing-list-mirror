From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] Add cpp macro implementation of treaps
Date: Sat, 29 May 2010 02:18:12 -0500
Message-ID: <20100529071811.GA6648@progeny.tock>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
 <1274650832-7411-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Jason Evans <jasone@canonware.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 29 09:17:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIGIu-0006YG-Pv
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 09:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722Ab0E2HRv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 May 2010 03:17:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47571 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab0E2HRu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 03:17:50 -0400
Received: by iwn6 with SMTP id 6so170769iwn.19
        for <git@vger.kernel.org>; Sat, 29 May 2010 00:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=STKAzuqzGKcfMIWXuA4yb1QOew00FZb8eKuNr/FRDKk=;
        b=fAzoPO/jYrE8m2Z8I7jdEv+VwHxrqCAMQBHUkVGFnxJXPsefieYPNakUT0buatzuHD
         KC8Orvy5jps/3+XTyybV/Cud8Y6BhDZApODvO0ePbZyqEFR0fdtEvaCE1iGlcmJDx9TI
         4kqZefEwK+LPTwtWnEqsn60cOmvNQrAgPjfYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=taEa98dx5KF92nqK0IbHXoME2R9SYpJmmjiHOl32/6QPQYaZGsGEuZxQOGJed+0+ba
         MzgY3AXQzEAKMIvhTj8Dj4jgT3j3HDLhAMR9IlfduSkEBEpZD/L+ricAX9djS1Ndik7u
         1ZZwSmgHNJx1NGaLyjQF/6ZzzwfbUqVQ1km2s=
Received: by 10.231.126.79 with SMTP id b15mr1746913ibs.80.1275117469062;
        Sat, 29 May 2010 00:17:49 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d9sm14725706ibl.22.2010.05.29.00.17.47
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 29 May 2010 00:17:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1274650832-7411-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147958>

Hi Ram,

Ramkumar Ramachandra wrote:

> Taken directly
> from David Michael Barr's svn-dump-fast-export repository.

More details:

  From: Jason Evans <jasone@canonware.com>

  Treaps provide a memory-efficient binary search tree structure.
  Insertion/deletion/search are about as about as fast in the average
  case as red-black trees and the chances of worst-case behavior are
  vanishingly small, thanks to (pseudo-)randomness.  That is a small
  price to pay, given that treaps are much simpler to implement.

  [db: Altered to reference nodes by offset from a common base pointer]
  [db: Bob Jenkins' hashing implementation dropped for Knuth's]
  [db: Methods unnecessary for search and insert dropped]

  Signed-off-by: David Barr <david.barr@cordelta.com>
  Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

I stole most of the description from [1].

> --- /dev/null
> +++ b/vcs-svn/trp.h
> @@ -0,0 +1,221 @@
> +/*******************************************************************=
***********
> + *
> + * cpp macro implementation of treaps.
> + *
> + * Usage:
> + *
> + *   #include <trp.h>
> + *   trp(...)
> + *   trp_gen(...)
> + *   ...
> + *
> + *******************************************************************=
***********/

I don=E2=80=99t know if style nitpicking is welcome here, given that th=
e
code comes from elsewhere.  Should we be trying to keep the code
close to Jason=E2=80=99s version (and sending patches upstream as neede=
d),
or is that not worth the trouble?

If style nitpicking were appropriate, I would say that comments in
C code written specifically for git should look like this:

   /*
    * cpp macro implementation of treaps.
   [...]
    */

Okay. :)

> +
> +#ifndef TRP_H_
> +#define	TRP_H_
> +
> +#include <stdint.h>

#include "../git-compat-util.h" would be more portable.

> +/* Pointer/Offset conversion */
> +#define trpn_pointer(a_base, a_offset)					\
> +    (a_base##_pointer(a_offset))
> +#define trpn_offset(a_base, a_pointer)				        \
> +    (a_base##_offset(a_pointer))

These are defined in obj_pool.h?  Maybe this would be easier to
understand if the patch to add that file came sooner in the series.

> +/* Priority accessors. */
> +#define	trp_prio_get(a_type, a_field, a_node)				\
> +    (2654435761*(uint32_t)(uintptr_t)(a_node))

Where does this magic number come from?  (I assume Knuth, but it
would be nice to include a reference or explanation.)

> +/*
> + * The trp_gen() macro generates a type-specific treap implementatio=
n,
> + * based on the above cpp macros.
[...]
> + * Assuming the following setup:
> + *
> + *   typedef struct ex_node_s ex_node_t;
> + *   struct ex_node_s {
> + *       trp_node(ex_node_t) ex_link;
> + *   };
> + *   typedef trp(ex_node_t) ex_t;
> + *   static ex_node_t ex_base[MAX_NODES];
> + *   trp_gen(static, ex_, ex_t, ex_node_t, ex_link, ex_base, ex_cmp)
> + *
> + * The following API is generated:
> + *
> + *   static void
> + *   ex_new(ex_t *treap);
> + *       Description: Initialize a treap structure.
> + *       Args:
> + *         treap: Pointer to an uninitialized treap object.
> + *
> + *   static ex_node_t *
> + *   ex_psearch(ex_t *treap, ex_node_t *key);
> + *       Description: Search for node that matches key.  If no match=
 is found,
> + *                    return what would be key's successor/predecess=
or, were
> + *                    key in treap.
> + *       Args:
> + *         treap: Pointer to a initialized treap object.
> + *         key  : Search key.
> + *       Ret: Node in treap that matches key, or if no match, hypoth=
etical
> + *            node's successor/predecessor (NULL if no successor/pre=
decessor).
[...]

Neat.  Maybe this description should go in a file in
Documentation/technical, to make trp.h itself a little less daunting.

Also: http://www.canonware.com/trp/ seems to provide a test program;
do you think it would make sense to include it as well?

Thanks,
Jonathan

[1] http://t-t-travails.blogspot.com/2008/07/treaps-versus-red-black-tr=
ees.html
