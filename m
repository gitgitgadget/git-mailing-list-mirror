Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEB2C1F464
	for <e@80x24.org>; Mon, 30 Sep 2019 09:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfI3J5t (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 05:57:49 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54950 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfI3J5t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 05:57:49 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5BE031F463;
        Mon, 30 Sep 2019 09:57:49 +0000 (UTC)
Date:   Mon, 30 Sep 2019 09:57:49 +0000
From:   Eric Wong <e@80x24.org>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH v2 07/19] hashmap_get takes "const struct hashmap_entry *"
Message-ID: <20190930095749.GA24511@dcvr>
References: <20190924010324.22619-1-e@80x24.org>
 <20190924010324.22619-8-e@80x24.org>
 <9dc71ed0-617c-84e8-b7fc-0766f4d83695@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9dc71ed0-617c-84e8-b7fc-0766f4d83695@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> wrote:
> On 9/23/2019 9:03 PM, Eric Wong wrote:
> > This is less error-prone than "const void *" as the compiler
> > now detects invalid types being passed.
> [snip]
> > diff --git a/hashmap.h b/hashmap.h
> > index 40bcc64289..2a4b4a3954 100644
> > --- a/hashmap.h
> > +++ b/hashmap.h
> > @@ -74,7 +74,8 @@
> >   *             e->key = key;
> >   *
> >   *             flags |= COMPARE_VALUE;
> > - *             printf("%sfound\n", hashmap_get(&map, e, NULL) ? "" : "not ");
> > + *             printf("%sfound\n",
> > + *                    hashmap_get(&map, &e->ent, NULL) ? "" : "not ");
> >   *             free(e);
> >   *         }
> >   *
> > @@ -84,7 +85,8 @@
> >   *             k.key = key;
> >   *
> >   *             flags |= COMPARE_VALUE;
> > - *             printf("%sfound\n", hashmap_get(&map, &k, value) ? "" : "not ");
> > + *             printf("%sfound\n",
> > + *                    hashmap_get(&map, &k->ent, value) ? "" : "not ");
> >   *         }
> >   *
> >   *         if (!strcmp("end", action)) {
> > @@ -286,7 +288,7 @@ static inline unsigned int hashmap_get_size(struct hashmap *map)
> >   * If an entry with matching hash code is found, `key` and `keydata` are passed
> >   * to `hashmap_cmp_fn` to decide whether the entry matches the key.
> >   */
> > -void *hashmap_get(const struct hashmap *map, const void *key,
> > +void *hashmap_get(const struct hashmap *map, const struct hashmap_entry *key,
> >  			 const void *keydata);
> 
> super-nit: the whitespace before the second line is "\t\t\t " but should be
> "\t\t  ".

Huh?  Do you mean the "const void *keydata);" line?
That's context and unchanged from before.  Thanks.
