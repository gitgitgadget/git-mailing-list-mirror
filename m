Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B80220357
	for <e@80x24.org>; Fri, 14 Jul 2017 14:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754511AbdGNOor (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 10:44:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:64679 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754507AbdGNOoq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 10:44:46 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNZVG-1dYkqu2GGA-007BMo; Fri, 14
 Jul 2017 16:44:34 +0200
Date:   Fri, 14 Jul 2017 16:44:32 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v6 00/10] The final building block for a faster rebase -i
Message-ID: <cover.1500043436.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lcy9V+OyMM0UMckp8n+vxstnh3+8r57TIrAl+wFoASy/3LGDqsr
 pM/Ix/774zQ0DhiUHGv38SVJFGblD1S+pC6I0Xdv8+uHp7+jD3FH6uKlwGnIhpCHEK93RtH
 7UMK+45PjAXVP2avHMako8ZQgXOLnRp4DDoiKyLl4pMlpZ33pjuHOJVnsef3HOkRwi44W0a
 S5y/CP7LyzlFLnmTwgrbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ax0g/aP4h9U=:g4HftUehH/cj4Wh8WoeRqB
 7t9bO8MfyyiXCl1Y9u+1DdS34YOBiOgfF9xMr++AjotZMojXsqoLU4BmhrDCF+KxfLkWEqv0g
 gAsegwTBw+GTCoJIXIMMydpJ3h8dbniQL9DGDE2yRoJFSQ9b3KVnc80N2ktaOztO3EQe3lBvy
 Oq0pa+oncLBp01G9oClW1J7bovNwjKh1mQQxKrqi1O9lW1cHMaCJ06RtxWw9rRi2Q65nnp4EU
 j0JPSW/yHfdVRwKGIlbocG8eWAs7XEph3nTmzjTWICDqZWbIQtjOz6O+lPh/XIlNZLWRn01MF
 NLP25ZBchykPBmHVR4B6zmUX6oDsMYYRLX3ukSmnXuGBgd64YxuSVEp9U173dtcBR+hrF36q+
 5pzug/qAXixxqji1XgtvQ7k0nIKaHwIE1ftV0dzAShnbvJ/8G3KyKUb3iMMv/M63i0hFWWVPH
 0erp1kip9falQzgTpvd9hzX1h5YiQ/ouPyPUK2Qnkn6NkthQ+HCFHli7QG8o+RRPxvFNryfxl
 8LU4lW1P/u7vStNKuxw/U6I0OhUxKpaHI6zlemXA9WMQJrAFP/tDg2VlhySifakFzfzusikmt
 i0Ez+kKqLBd4dBLj05BtWjHQmS+UMv952XC636T/meWzIi20uhUuv3eFyIjSGg7f0B5inE6ST
 aMSqA1VWCWRCjwzy+NJ4Z/hYYYkchpxg+Q2QCubhaLxKD3t1tXicikz0PgI/4krBylvhTvyqV
 bFVz0HjQU9p0kF/wgXbewct9aAGy9jf8R3bfcYnjt10qZEMtXVaJPvfySi19WaoYDVxFS/yCk
 UTHAolewCEx9QWBsfptcCPpkkTYFrovG1sysrax4DJbQo0xreI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series reimplements the expensive pre- and post-processing of
the todo script in C.

And it concludes the work I did to accelerate rebase -i so far.

I am still unwilling to replace a compile-time safe way to pass the
options to the revision machinery by the alternative (which I am still
flabbergasted about) proposed by Junio. This will not change.

I know that we want to concentrate on bug fixes on `master`, but this
patch series will most likely take a couple of months to get there, anyway.
So I may just as well send this iteration now. It's also not like I haven't
contributed any bug fixes lately...

Changes since v5:

- replaced a get_sha1() call by a get_oid() call already.

- adjusted to hashmap API changes


Johannes Schindelin (10):
  t3415: verify that an empty instructionFormat is handled as before
  rebase -i: generate the script via rebase--helper
  rebase -i: remove useless indentation
  rebase -i: do not invent onelines when expanding/collapsing SHA-1s
  rebase -i: also expand/collapse the SHA-1s via the rebase--helper
  t3404: relax rebase.missingCommitsCheck tests
  rebase -i: check for missing commits in the rebase--helper
  rebase -i: skip unnecessary picks using the rebase--helper
  t3415: test fixup with wrapped oneline
  rebase -i: rearrange fixup/squash lines using the rebase--helper

 Documentation/git-rebase.txt  |  16 +-
 builtin/rebase--helper.c      |  29 ++-
 git-rebase--interactive.sh    | 373 ++++-------------------------
 sequencer.c                   | 531 ++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                   |   8 +
 t/t3404-rebase-interactive.sh |  22 +-
 t/t3415-rebase-autosquash.sh  |  28 ++-
 7 files changed, 647 insertions(+), 360 deletions(-)


base-commit: f3da2b79be9565779e4f76dc5812c68e156afdf0
Based-On: rebase--helper at https://github.com/dscho/git
Fetch-Base-Via: git fetch https://github.com/dscho/git rebase--helper
Published-As: https://github.com/dscho/git/releases/tag/rebase-i-extra-v6
Fetch-It-Via: git fetch https://github.com/dscho/git rebase-i-extra-v6

Interdiff vs v5:
 diff --git a/sequencer.c b/sequencer.c
 index 8713cc8d1d5..c54596f9699 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -2654,7 +2654,7 @@ int skip_unnecessary_picks(void)
  
  	if (!read_oneliner(&buf, rebase_path_onto(), 0))
  		return error(_("could not read 'onto'"));
 -	if (get_sha1(buf.buf, onto_oid.hash)) {
 +	if (get_oid(buf.buf, &onto_oid)) {
  		strbuf_release(&buf);
  		return error(_("need a HEAD to fixup"));
  	}
 @@ -2756,8 +2756,9 @@ struct subject2item_entry {
  	char subject[FLEX_ARRAY];
  };
  
 -static int subject2item_cmp(const struct subject2item_entry *a,
 -	const struct subject2item_entry *b, const void *key)
 +static int subject2item_cmp(const void *fndata,
 +			    const struct subject2item_entry *a,
 +			    const struct subject2item_entry *b, const void *key)
  {
  	return key ? strcmp(a->subject, key) : strcmp(a->subject, b->subject);
  }
 @@ -2802,7 +2803,7 @@ int rearrange_squash(void)
  	 * be moved to appear after the i'th.
  	 */
  	hashmap_init(&subject2item, (hashmap_cmp_fn) subject2item_cmp,
 -		     todo_list.nr);
 +		     NULL, todo_list.nr);
  	ALLOC_ARRAY(next, todo_list.nr);
  	ALLOC_ARRAY(tail, todo_list.nr);
  	ALLOC_ARRAY(subjects, todo_list.nr);
-- 
2.13.3.windows.1.13.gaf0c2223da0

