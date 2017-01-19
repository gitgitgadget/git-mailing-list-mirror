Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70D1020A17
	for <e@80x24.org>; Thu, 19 Jan 2017 13:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbdASNbK (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 08:31:10 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:43642 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752624AbdASNbI (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Jan 2017 08:31:08 -0500
X-AuditID: 12074412-5ddff700000009b5-fd-5880bf6f0691
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id A9.30.02485.F6FB0885; Thu, 19 Jan 2017 08:30:23 -0500 (EST)
Received: from [192.168.69.190] (p57906036.dip0.t-ipconnect.de [87.144.96.54])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v0JDULTG029133
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 19 Jan 2017 08:30:22 -0500
Subject: Re: The design of refs backends, linked worktrees and submodules
To:     Duy Nguyen <pclouds@gmail.com>
References: <CACsJy8CHoroX2k9GqOFmXkvvPCPN4SBeCg+6aC2WSWNSKVmWQw@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <341999fc-4496-b974-c117-c18a2fca1358@alum.mit.edu>
Date:   Thu, 19 Jan 2017 14:30:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CHoroX2k9GqOFmXkvvPCPN4SBeCg+6aC2WSWNSKVmWQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqJu/vyHCYMJceYuuK91MFt1T3jI6
        MHnsnHWX3ePzJrkApigum5TUnMyy1CJ9uwSujAmzHrIWzDauOLDzB3MD4y/NLkZODgkBE4lj
        36cxdzFycQgJXGaUuD5xJROEc45JYtOOD+wgVcICnhJ/NneC2SICShJvOrYxg9hCAgESDVfO
        sIHYzAJaEpt/fgOrYRPQlVjU08wEYvMK2Euc7GsEq2ERUJU4faWFEcQWFQiRmLPwASNEjaDE
        yZlPWEBsToFAiQsrr7JCzFSX+DPvEjOELS+x/e0c5gmM/LOQtMxCUjYLSdkCRuZVjHKJOaW5
        urmJmTnFqcm6xcmJeXmpRbpmermZJXqpKaWbGCEBKbSDcf1JuUOMAhyMSjy8HUX1EUKsiWXF
        lbmHGCU5mJREee0tGyKE+JLyUyozEosz4otKc1KLDzFKcDArifDa7AXK8aYkVlalFuXDpKQ5
        WJTEeX8uVvcTEkhPLEnNTk0tSC2CycpwcChJ8PLtA2oULEpNT61Iy8wpQUgzcXCCDOcBGl4F
        UsNbXJCYW5yZDpE/xagoJc6bAbJVACSRUZoH1wtLGK8YxYFeEeadA9LOA0w2cN2vgAYzAQ22
        Uq4HGVySiJCSamCU+i76Z8Pja9+Tsjs+PNy+Jvit5nv25RO4K+etLv31R9HrTMRHyUXbV/o2
        ifyx0Uo5FRqwfOJlPY4nGyVEdwWG5Hx6IbB79YdHvmv0XVqXO3Rm7flj9fvZuhUtIYZMPFX/
        brAnb2lbImSoVHGpLpLpMbtemg+zQ856Rz0jzUNrLbbJpEser85QYinOSDTUYi4qTgQAlwjH
        WfMCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/19/2017 12:55 PM, Duy Nguyen wrote:
> I've started working on fixing the "git gc" issue with multiple
> worktrees, which brings me back to this. Just some thoughts. Comments
> are really appreciated.
> 
> In the current code, files backend has special cases for both
> submodules (explicitly) and linked worktrees (hidden behind git_path).

There is another terrible hack also needed to implement linked
worktrees, namely that the `refs/bisect/` hierarchy is manually inserted
into the `ref_cache`, because otherwise it wouldn't be noticed when
iterating over loose references via `readdir()`.

Other similar hacks would be required if other reference subtrees are
declared to be per-worktree.

> But if a backend has to handle this stuff, all future backends have to
> too. Which does not sound great. Imagine we have "something" in
> addition to worktrees and submodules in future, then all backends have
> to learn about it.

Agreed, the status quo is not pretty.

I kindof think that it would have been a better design to store the
references for all linked worktrees in the main repository's ref-store.
For example, the "bisect" refs for a worktree named "<name>" could have
been stored under "refs/worktrees/<name>/bisect/*". Then either:

* teach the associated tools to read/write references there directly
(probably with DWIM rules to make command-line use easier), or
* treat these references as if they were actually at a standard place
like `refs/worktree/bisect/*`; i.e., users would need to know that they
were per-worktree references, but wouldn't need to worry about the true
locations, or
* treat these references as if they were actually in their traditional
locations (though it is not obvious how this scheme could be expanded to
cover new per-worktree references).

> So how about we move worktree and submodule support back to front-end?
> 
> The backend deals with refs, period. The file-based backend will be
> given a directory where refs live in and it work on that. Backends do
> not use git_path(). Backends do not care about $GIT_DIR. Access to odb
> (e.g. sha-1 validation) if needed is abstracted out via a set of
> callbacks. This allows submodules to give access to submodule's
> separate odb. And it's getting close to the "struct repository"
> mentioned somewhere in refs "TODO" comments, even though we are
> nowhere close to introducing that struct.

This is a topic that I have thought a lot about. I definitely like this
direction. In fact I've dabbled around with some first steps; see branch
`submodule-hash` in my fork on GitHub [1]. That branch associates a
`ref_store` more closely with the directory where the references are
stored, as opposed to having a 1:1 relationship between `ref_store`s and
submodules.

I would like to see the separation of a concept "iterate over all
reachability roots" that is independent of other ref iteration. Then it
wouldn't have to include reference names, except basically for use in
error messages. So for linked worktrees, in place of the reference name
it might emit a string like "<worktree>:<refname>". (Of course it would
get its information by iterating over all of the linked reference stores
using their reference iteration APIs.)

> For that to work, I'll probably need to add a "composite" ref_store
> that combines two file-based backends (for per-repo and per-worktree
> refs) to represent a unified ref store. I think your work on ref
> iterator makes way for that. A bit worried about transactions though,
> because I think per-repo and per-worktree updates will be separated in
> two transactions. But that's probably ok because future backends, like
> lmdb, will have to go through the same route anyway.

Yes, that was the main motivation for the ref-iterator work.

Regarding transactions, the commit pointed at by branch
`split-transaction` in my fork shows how I think the
`transaction_commit()` method could be split into two parts,
`transaction_prepare()` and `transaction_finish()`. The idea would be
that the driver function, `ref_transaction_commit()`, calls
`transaction_prepare()` for each `ref_store` involved in the
transaction, passing each one the reference updates for references that
live in that reference store. Those methods would verify that the part
of the transaction that lives in that ref-store "should" go through,
without actually committing anything. Then `transaction_finish()` would
be called on each ref store, and that method would commit the updates.
You probably couldn't get a bulletproof kind of compound transaction out
of this (e.g., if the computer's power goes out, one `ref_store`'s
updates might be committed but another one's not). But it would probably
be good enough to cover everyday reasons for transaction failures, like
pre-checksums not matching up.

Let me braindump some more information about this topic. A files backend
for a repository (ignoring submodules for the moment) currently consists
of five interacting parts, each of which looks a lot like a ref-store
itself:

* A loose reference ref-store for the main repo
* A loose reference ref-store for the per-subtree references
* A ref_cache in front of the two loose reference stores
* A packed ref-store
* A second ref_cache in front of the packed ref-store

But these ref-stores are currently coupled very tightly and have
peculiarities:

* The caching code is tightly coupled to the ref-store behind it.
* It is hard to imagine a packed refs-store that doesn't have some kind
of caching in front of it.
* There are tricky ordering constraints between writes to packed and
loose references to avoid races.
* The packed ref-store can't store symbolic refs, nor can it store
reflogs. It currently relies on the loose ref-store for those things.
* There is no packed-refs ref-store associated with per-worktree refs.
* Packed references are currently locked via `*.lock` files located near
the corresponding loose references.
* There are constraints that span refstores. For example, you aren't
allowed to create a packed ref that D/F conflicts with a loose ref or
vice versa.
* Symrefs, which are loose, can point at packed references.

I've taken some stabs at picking these apart into separate ref stores,
but haven't had time to make very satisfying progress. By the time of
GitMerge I might have a better feeling for whether I can devote some
time to this project.

Michael

[1] https://github.com/mhagger/git

