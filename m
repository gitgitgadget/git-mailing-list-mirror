Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E13D11F404
	for <e@80x24.org>; Mon,  9 Apr 2018 16:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753304AbeDIQti (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 12:49:38 -0400
Received: from avasout04.plus.net ([212.159.14.19]:57618 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753097AbeDIQth (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 12:49:37 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id 5Zz5fKoiZsD7b5Zz6fLGtO; Mon, 09 Apr 2018 17:49:36 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=VGFLaOeXIzmMvh2IZ_kA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: What's cooking in git.git (Apr 2018, #01; Mon, 9)
To:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com>
 <98394864-ece6-5112-0274-b2399087f207@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <bba6e3ba-ab28-8cda-eab3-91ec3591bcb5@ramsayjones.plus.com>
Date:   Mon, 9 Apr 2018 17:49:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <98394864-ece6-5112-0274-b2399087f207@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGN9vtxsrIa9cdY3ZUtH681rKC2se0djFQLih6KQopbgTz/Y7b4gr/1LX3TlYq6BxbxpRo1IFC6ohs8gM5SwdfQmE/nSAoTzPEDZ6ijpGi9ULAjtRTUQ
 gnkValESrVJ5aGg1p1kBm2DOk8oDq0hnJ7WbSt4u9u8K28qcHPgvcnhSEDaKjLi7SrorX2dyM/oqrA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 09/04/18 14:37, Derrick Stolee wrote:
> On 4/9/2018 6:21 AM, Junio C Hamano wrote:
>> * ds/commit-graph (2018-04-02) 16 commits
>>   - commit-graph: implement "--additive" option
>>   - commit-graph: build graph from starting commits
>>   - commit-graph: read only from specific pack-indexes
>>   - commit: integrate commit graph with commit parsing
>>   - commit-graph: close under reachability
>>   - commit-graph: add core.commitGraph setting
>>   - commit-graph: implement git commit-graph read
>>   - commit-graph: implement git-commit-graph write
>>   - commit-graph: implement write_commit_graph()
>>   - commit-graph: create git-commit-graph builtin
>>   - graph: add commit graph design document
>>   - commit-graph: add format document
>>   - csum-file: refactor finalize_hashfile() method
>>   - csum-file: rename hashclose() to finalize_hashfile()
>>   - Merge branch 'jk/cached-commit-buffer' into HEAD
>>   - Merge branch 'jt/binsearch-with-fanout' into HEAD
>>   (this branch is used by ds/lazy-load-trees.)
>>
>>   Precompute and store information necessary for ancestry traversal
>>   in a separate file to optimize graph walking.
>>
>>   Ready???
>>   It seems that this topic is getting there.
> 
> I think this patch is ready to go, barring the edit of "--additive" to "--append" in the final commit message and squashing following diff into "commit-graph: implement git commit-graph read":
> 
> @@ -31,7 +31,7 @@ static struct opts_commit_graph {
> 
>  static int graph_read(int argc, const char **argv)
>  {
> -       struct commit_graph *graph = 0;
> +       struct commit_graph *graph = NULL;
>         char *graph_name;
> 
>         static struct option builtin_commit_graph_read_options[] = {
> 

Also, it seems that the 'static' keyword has been dropped from the
declaration of 'commit_graph' (commit-graph.c #183) again:

  $ diff nsp-out psp-out
  18a19
  >     SP chdir-notify.c
  23a25,26
  >     SP commit-graph.c
  > commit-graph.c:183:21: warning: symbol 'commit_graph' was not declared. Should it be static?
  66a70
  >     SP json-writer.c
  209a214,215
  >     SP builtin/commit-graph.c
  > builtin/commit-graph.c:34:38: warning: Using plain integer as NULL pointer
  299d304
  < fast-import.c:303:40: warning: Using plain integer as NULL pointer
  312a318
  >     SP t/helper/test-json-writer.c
  315a322
  >     SP t/helper/test-print-larger-than-ssize.c
  $ 

ATB,
Ramsay Jones

